Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4798BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E7120678
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfIMQDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:03:41 -0400
Received: from foss.arm.com ([217.140.110.172]:46202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfIMQDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:03:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DC281000;
        Fri, 13 Sep 2019 09:03:40 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22B93F67D;
        Fri, 13 Sep 2019 09:03:38 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panfrost: Prevent race when handling page fault
Date:   Fri, 13 Sep 2019 17:03:10 +0100
Message-Id: <20190913160310.50444-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling a GPU page fault addr_to_drm_mm_node() is used to
translate the GPU address to a buffer object. However it is possible for
the buffer object to be freed after the function has returned resulting
in a use-after-free of the BO.

Change addr_to_drm_mm_node to return the panfrost_gem_object with an
extra reference on it, preventing the BO from being freed until after
the page fault has been handled.

Signed-off-by: Steven Price <steven.price@arm.com>
---
Changes since v1:
 * Hold the mm_lock around drm_mm_for_each_node()

I've also posted a new IGT test for this:
https://patchwork.freedesktop.org/patch/330513/

 drivers/gpu/drm/panfrost/panfrost_mmu.c | 55 ++++++++++++++++---------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 842bdd7cf6be..b6b281896ed6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -392,28 +392,40 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
 	free_io_pgtable_ops(mmu->pgtbl_ops);
 }
 
-static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
+static struct panfrost_gem_object *
+addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
 {
-	struct drm_mm_node *node = NULL;
+	struct panfrost_gem_object *bo = NULL;
+	struct panfrost_file_priv *priv;
+	struct drm_mm_node *node;
 	u64 offset = addr >> PAGE_SHIFT;
 	struct panfrost_mmu *mmu;
 
 	spin_lock(&pfdev->as_lock);
 	list_for_each_entry(mmu, &pfdev->as_lru_list, list) {
-		struct panfrost_file_priv *priv;
-		if (as != mmu->as)
-			continue;
+		if (as == mmu->as)
+			break;
+	}
+	if (as != mmu->as)
+		goto out;
+
+	priv = container_of(mmu, struct panfrost_file_priv, mmu);
 
-		priv = container_of(mmu, struct panfrost_file_priv, mmu);
-		drm_mm_for_each_node(node, &priv->mm) {
-			if (offset >= node->start && offset < (node->start + node->size))
-				goto out;
+	spin_lock(&priv->mm_lock);
+
+	drm_mm_for_each_node(node, &priv->mm) {
+		if (offset >= node->start &&
+				offset < (node->start + node->size)) {
+			bo = drm_mm_node_to_panfrost_bo(node);
+			drm_gem_object_get(&bo->base.base);
+			break;
 		}
 	}
 
+	spin_unlock(&priv->mm_lock);
 out:
 	spin_unlock(&pfdev->as_lock);
-	return node;
+	return bo;
 }
 
 #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
@@ -421,29 +433,28 @@ static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, in
 int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
 {
 	int ret, i;
-	struct drm_mm_node *node;
 	struct panfrost_gem_object *bo;
 	struct address_space *mapping;
 	pgoff_t page_offset;
 	struct sg_table *sgt;
 	struct page **pages;
 
-	node = addr_to_drm_mm_node(pfdev, as, addr);
-	if (!node)
+	bo = addr_to_drm_mm_node(pfdev, as, addr);
+	if (!bo)
 		return -ENOENT;
 
-	bo = drm_mm_node_to_panfrost_bo(node);
 	if (!bo->is_heap) {
 		dev_WARN(pfdev->dev, "matching BO is not heap type (GPU VA = %llx)",
-			 node->start << PAGE_SHIFT);
-		return -EINVAL;
+			 bo->node.start << PAGE_SHIFT);
+		ret = -EINVAL;
+		goto err_bo;
 	}
 	WARN_ON(bo->mmu->as != as);
 
 	/* Assume 2MB alignment and size multiple */
 	addr &= ~((u64)SZ_2M - 1);
 	page_offset = addr >> PAGE_SHIFT;
-	page_offset -= node->start;
+	page_offset -= bo->node.start;
 
 	mutex_lock(&bo->base.pages_lock);
 
@@ -452,7 +463,8 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
 				     sizeof(struct sg_table), GFP_KERNEL | __GFP_ZERO);
 		if (!bo->sgts) {
 			mutex_unlock(&bo->base.pages_lock);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_bo;
 		}
 
 		pages = kvmalloc_array(bo->base.base.size >> PAGE_SHIFT,
@@ -461,7 +473,8 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
 			kfree(bo->sgts);
 			bo->sgts = NULL;
 			mutex_unlock(&bo->base.pages_lock);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_bo;
 		}
 		bo->base.pages = pages;
 		bo->base.pages_use_count = 1;
@@ -499,12 +512,16 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
 
 	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
 
+	drm_gem_object_put_unlocked(&bo->base.base);
+
 	return 0;
 
 err_map:
 	sg_free_table(sgt);
 err_pages:
 	drm_gem_shmem_put_pages(&bo->base);
+err_bo:
+	drm_gem_object_put_unlocked(&bo->base.base);
 	return ret;
 }
 
-- 
2.20.1

