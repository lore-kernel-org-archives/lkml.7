Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACBFC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6228D21743
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfEPOPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:15:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47212 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfEPOPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:15:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46871AED;
        Thu, 16 May 2019 07:15:04 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF8893F71E;
        Thu, 16 May 2019 07:15:01 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm: shmem: Add drm_gem_shmem_map_offset() wrapper
Date:   Thu, 16 May 2019 15:14:46 +0100
Message-Id: <20190516141447.46839-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516141447.46839-1-steven.price@arm.com>
References: <20190516141447.46839-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a wrapper for drm_gem_map_offset() for clients of shmem. This
wrapper provides the correct semantics for the drm_gem_shmem_mmap()
callback.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
 include/drm/drm_gem_shmem_helper.h     |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 1ee208c2c85e..9dbebc4897d1 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -400,6 +400,26 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
 
+/**
+ * drm_gem_map_offset - return the fake mmap offset for a gem object
+ * @file: drm file-private structure containing the gem object
+ * @dev: corresponding drm_device
+ * @handle: gem object handle
+ * @offset: return location for the fake mmap offset
+ *
+ * This provides an offset suitable for user space to return to the
+ * drm_gem_shmem_mmap() callback via an mmap() call.
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
+int drm_gem_shmem_map_offset(struct drm_file *file, struct drm_device *dev,
+			     u32 handle, u64 *offset)
+{
+	return drm_gem_map_offset(file, dev, handle, offset);
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_map_offset);
+
 static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 038b6d313447..4239ddaaaa4f 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -128,6 +128,8 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
 
+int drm_gem_shmem_map_offset(struct drm_file *file, struct drm_device *dev,
+			     u32 handle, u64 *offset);
 int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma);
 
 extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
-- 
2.20.1

