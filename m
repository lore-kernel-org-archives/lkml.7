Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0A8ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49D62196E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="QoS0iZiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbfJJMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:43:34 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:9466 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733252AbfJJMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:43:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id F16513F9E2;
        Thu, 10 Oct 2019 14:43:29 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=QoS0iZiq;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id plPePNntgy1S; Thu, 10 Oct 2019 14:43:25 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 224B83F9B2;
        Thu, 10 Oct 2019 14:43:25 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C9A94361140;
        Thu, 10 Oct 2019 14:43:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570711403; bh=bx8eG09waI9JD3lCmO6ixUtN4UOAIiobzckYp+RwK+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoS0iZiq0YlDCgHAWxPOPkY2T3T61y3/B4Mxf0r7zJjzIGhNHYt0R0F+cQ7j27pAJ
         C0yAm7Sat1n2EkLyWTaJBpkXcXl12nZMDkDNxhePaK6+xQcQ9rI6OImIvjjovvepSU
         NB2K1cq4nqNN0gD2h8VyzCZcoPQLNfvg8IwdTWRw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH v5 6/8] drm/vmwgfx: Use an RBtree instead of linked list for MOB resources
Date:   Thu, 10 Oct 2019 14:43:12 +0200
Message-Id: <20191010124314.40067-7-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010124314.40067-1-thomas_os@shipmail.org>
References: <20191010124314.40067-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

With emulated coherent memory we need to be able to quickly look up
a resource from the MOB offset. Instead of traversing a linked list with
O(n) worst case, use an RBtree with O(log n) worst case complexity.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       |  5 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h      | 10 +++----
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 33 +++++++++++++++++-------
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 869aeaec2f86..18e4b329e563 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -463,6 +463,7 @@ void vmw_bo_bo_free(struct ttm_buffer_object *bo)
 	struct vmw_buffer_object *vmw_bo = vmw_buffer_object(bo);
 
 	WARN_ON(vmw_bo->dirty);
+	WARN_ON(!RB_EMPTY_ROOT(&vmw_bo->res_tree));
 	vmw_bo_unmap(vmw_bo);
 	kfree(vmw_bo);
 }
@@ -479,6 +480,7 @@ static void vmw_user_bo_destroy(struct ttm_buffer_object *bo)
 	struct vmw_buffer_object *vbo = &vmw_user_bo->vbo;
 
 	WARN_ON(vbo->dirty);
+	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
 	vmw_bo_unmap(vbo);
 	ttm_prime_object_kfree(vmw_user_bo, prime);
 }
@@ -514,8 +516,7 @@ int vmw_bo_init(struct vmw_private *dev_priv,
 	memset(vmw_bo, 0, sizeof(*vmw_bo));
 	BUILD_BUG_ON(TTM_MAX_BO_PRIORITY <= 3);
 	vmw_bo->base.priority = 3;
-
-	INIT_LIST_HEAD(&vmw_bo->res_list);
+	vmw_bo->res_tree = RB_ROOT;
 
 	ret = ttm_bo_init(bdev, &vmw_bo->base, size,
 			  ttm_bo_type_device, placement,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 7944dbbbdd72..53f8522ae032 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -100,7 +100,7 @@ struct vmw_fpriv {
 /**
  * struct vmw_buffer_object - TTM buffer object with vmwgfx additions
  * @base: The TTM buffer object
- * @res_list: List of resources using this buffer object as a backing MOB
+ * @res_tree: RB tree of resources using this buffer object as a backing MOB
  * @pin_count: pin depth
  * @dx_query_ctx: DX context if this buffer object is used as a DX query MOB
  * @map: Kmap object for semi-persistent mappings
@@ -109,7 +109,7 @@ struct vmw_fpriv {
  */
 struct vmw_buffer_object {
 	struct ttm_buffer_object base;
-	struct list_head res_list;
+	struct rb_root res_tree;
 	s32 pin_count;
 	/* Not ref-counted.  Protected by binding_mutex */
 	struct vmw_resource *dx_query_ctx;
@@ -157,8 +157,8 @@ struct vmw_res_func;
  * pin-count greater than zero. It is not on the resource LRU lists and its
  * backup buffer is pinned. Hence it can't be evicted.
  * @func: Method vtable for this resource. Immutable.
+ * @mob_node; Node for the MOB backup rbtree. Protected by @backup reserved.
  * @lru_head: List head for the LRU list. Protected by @dev_priv::resource_lock.
- * @mob_head: List head for the MOB backup list. Protected by @backup reserved.
  * @binding_head: List head for the context binding list. Protected by
  * the @dev_priv::binding_mutex
  * @res_free: The resource destructor.
@@ -179,8 +179,8 @@ struct vmw_resource {
 	unsigned long backup_offset;
 	unsigned long pin_count;
 	const struct vmw_res_func *func;
+	struct rb_node mob_node;
 	struct list_head lru_head;
-	struct list_head mob_head;
 	struct list_head binding_head;
 	struct vmw_resource_dirty *dirty;
 	void (*res_free) (struct vmw_resource *res);
@@ -733,7 +733,7 @@ void vmw_resource_dirty_update(struct vmw_resource *res, pgoff_t start,
  */
 static inline bool vmw_resource_mob_attached(const struct vmw_resource *res)
 {
-	return !list_empty(&res->mob_head);
+	return !RB_EMPTY_NODE(&res->mob_node);
 }
 
 /**
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index e4c97a4cf2ff..328ad46076ff 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -40,11 +40,24 @@
 void vmw_resource_mob_attach(struct vmw_resource *res)
 {
 	struct vmw_buffer_object *backup = res->backup;
+	struct rb_node **new = &backup->res_tree.rb_node, *parent = NULL;
 
 	dma_resv_assert_held(res->backup->base.base.resv);
 	res->used_prio = (res->res_dirty) ? res->func->dirty_prio :
 		res->func->prio;
-	list_add_tail(&res->mob_head, &backup->res_list);
+
+	while (*new) {
+		struct vmw_resource *this =
+			container_of(*new, struct vmw_resource, mob_node);
+
+		parent = *new;
+		new = (res->backup_offset < this->backup_offset) ?
+			&((*new)->rb_left) : &((*new)->rb_right);
+	}
+
+	rb_link_node(&res->mob_node, parent, new);
+	rb_insert_color(&res->mob_node, &backup->res_tree);
+
 	vmw_bo_prio_add(backup, res->used_prio);
 }
 
@@ -58,7 +71,8 @@ void vmw_resource_mob_detach(struct vmw_resource *res)
 
 	dma_resv_assert_held(backup->base.base.resv);
 	if (vmw_resource_mob_attached(res)) {
-		list_del_init(&res->mob_head);
+		rb_erase(&res->mob_node, &backup->res_tree);
+		RB_CLEAR_NODE(&res->mob_node);
 		vmw_bo_prio_del(backup, res->used_prio);
 	}
 }
@@ -204,8 +218,8 @@ int vmw_resource_init(struct vmw_private *dev_priv, struct vmw_resource *res,
 	res->res_free = res_free;
 	res->dev_priv = dev_priv;
 	res->func = func;
+	RB_CLEAR_NODE(&res->mob_node);
 	INIT_LIST_HEAD(&res->lru_head);
-	INIT_LIST_HEAD(&res->mob_head);
 	INIT_LIST_HEAD(&res->binding_head);
 	res->id = -1;
 	res->backup = NULL;
@@ -754,19 +768,20 @@ int vmw_resource_validate(struct vmw_resource *res, bool intr)
  */
 void vmw_resource_unbind_list(struct vmw_buffer_object *vbo)
 {
-
-	struct vmw_resource *res, *next;
 	struct ttm_validate_buffer val_buf = {
 		.bo = &vbo->base,
 		.num_shared = 0
 	};
 
 	dma_resv_assert_held(vbo->base.base.resv);
-	list_for_each_entry_safe(res, next, &vbo->res_list, mob_head) {
-		if (!res->func->unbind)
-			continue;
+	while (!RB_EMPTY_ROOT(&vbo->res_tree)) {
+		struct rb_node *node = vbo->res_tree.rb_node;
+		struct vmw_resource *res =
+			container_of(node, struct vmw_resource, mob_node);
+
+		if (!WARN_ON_ONCE(!res->func->unbind))
+			(void) res->func->unbind(res, res->res_dirty, &val_buf);
 
-		(void) res->func->unbind(res, res->res_dirty, &val_buf);
 		res->backup_dirty = true;
 		res->res_dirty = false;
 		vmw_resource_mob_detach(res);
-- 
2.21.0

