Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE01C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A0F21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388417AbfKGLPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:15:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:39060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbfKGLPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:15:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1728B3C0;
        Thu,  7 Nov 2019 11:15:48 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 1/2] xen/gntdev: replace global limit of mapped pages by limit per call
Date:   Thu,  7 Nov 2019 12:15:45 +0100
Message-Id: <20191107111546.26579-2-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191107111546.26579-1-jgross@suse.com>
References: <20191107111546.26579-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today there is a global limit of pages mapped via /dev/xen/gntdev set
to 1 million pages per default. There is no reason why that limit is
existing, as total number of grant mappings is limited by the
hypervisor anyway and preferring kernel mappings over userspace ones
doesn't make sense. It should be noted that the gntdev device is
usable by root only.

Additionally checking of that limit is fragile, as the number of pages
to map via one call is specified in a 32-bit unsigned variable which
isn't tested to stay within reasonable limits (the only test is the
value to be <= zero, which basically excludes only calls without any
mapping requested). So trying to map e.g. 0xffff0000 pages while
already nearly 1000000 pages are mapped will effectively lower the
global number of mapped pages such that a parallel call mapping a
reasonable amount of pages can succeed in spite of the global limit
being violated.

So drop the global limit and introduce per call limit instead. This
per call limit (default: 65536 grant mappings) protects against
allocating insane large arrays in the kernel for doing a hypercall
which will fail anyway in case a user is e.g. trying to map billions
of pages.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/gntdev-common.h |  2 +-
 drivers/xen/gntdev-dmabuf.c | 11 +++--------
 drivers/xen/gntdev.c        | 24 +++++++-----------------
 3 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
index 2f8b949c3eeb..0e5d4660e7b8 100644
--- a/drivers/xen/gntdev-common.h
+++ b/drivers/xen/gntdev-common.h
@@ -87,7 +87,7 @@ void gntdev_add_map(struct gntdev_priv *priv, struct gntdev_grant_map *add);
 
 void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map);
 
-bool gntdev_account_mapped_pages(int count);
+bool gntdev_test_page_count(unsigned int count);
 
 int gntdev_map_grant_pages(struct gntdev_grant_map *map);
 
diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 2c4f324f8626..63f0857bf62d 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -446,7 +446,7 @@ dmabuf_exp_alloc_backing_storage(struct gntdev_priv *priv, int dmabuf_flags,
 {
 	struct gntdev_grant_map *map;
 
-	if (unlikely(count <= 0))
+	if (unlikely(gntdev_test_page_count(count)))
 		return ERR_PTR(-EINVAL);
 
 	if ((dmabuf_flags & GNTDEV_DMA_FLAG_WC) &&
@@ -459,11 +459,6 @@ dmabuf_exp_alloc_backing_storage(struct gntdev_priv *priv, int dmabuf_flags,
 	if (!map)
 		return ERR_PTR(-ENOMEM);
 
-	if (unlikely(gntdev_account_mapped_pages(count))) {
-		pr_debug("can't map %d pages: over limit\n", count);
-		gntdev_put_map(NULL, map);
-		return ERR_PTR(-ENOMEM);
-	}
 	return map;
 }
 
@@ -771,7 +766,7 @@ long gntdev_ioctl_dmabuf_exp_from_refs(struct gntdev_priv *priv, int use_ptemod,
 	if (copy_from_user(&op, u, sizeof(op)) != 0)
 		return -EFAULT;
 
-	if (unlikely(op.count <= 0))
+	if (unlikely(gntdev_test_page_count(op.count)))
 		return -EINVAL;
 
 	refs = kcalloc(op.count, sizeof(*refs), GFP_KERNEL);
@@ -818,7 +813,7 @@ long gntdev_ioctl_dmabuf_imp_to_refs(struct gntdev_priv *priv,
 	if (copy_from_user(&op, u, sizeof(op)) != 0)
 		return -EFAULT;
 
-	if (unlikely(op.count <= 0))
+	if (unlikely(gntdev_test_page_count(op.count)))
 		return -EINVAL;
 
 	gntdev_dmabuf = dmabuf_imp_to_refs(priv->dmabuf_priv,
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 81401f386c9c..0578d369e537 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -55,12 +55,10 @@ MODULE_AUTHOR("Derek G. Murray <Derek.Murray@cl.cam.ac.uk>, "
 	      "Gerd Hoffmann <kraxel@redhat.com>");
 MODULE_DESCRIPTION("User-space granted page access driver");
 
-static int limit = 1024*1024;
-module_param(limit, int, 0644);
-MODULE_PARM_DESC(limit, "Maximum number of grants that may be mapped by "
-		"the gntdev device");
-
-static atomic_t pages_mapped = ATOMIC_INIT(0);
+static unsigned int limit = 64*1024;
+module_param(limit, uint, 0644);
+MODULE_PARM_DESC(limit,
+	"Maximum number of grants that may be mapped by one mapping request");
 
 static int use_ptemod;
 #define populate_freeable_maps use_ptemod
@@ -72,9 +70,9 @@ static struct miscdevice gntdev_miscdev;
 
 /* ------------------------------------------------------------------ */
 
-bool gntdev_account_mapped_pages(int count)
+bool gntdev_test_page_count(unsigned int count)
 {
-	return atomic_add_return(count, &pages_mapped) > limit;
+	return !count || count > limit;
 }
 
 static void gntdev_print_maps(struct gntdev_priv *priv,
@@ -242,8 +240,6 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
 	if (!refcount_dec_and_test(&map->users))
 		return;
 
-	atomic_sub(map->count, &pages_mapped);
-
 	if (map->notify.flags & UNMAP_NOTIFY_SEND_EVENT) {
 		notify_remote_via_evtchn(map->notify.event);
 		evtchn_put(map->notify.event);
@@ -668,7 +664,7 @@ static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
 	if (copy_from_user(&op, u, sizeof(op)) != 0)
 		return -EFAULT;
 	pr_debug("priv %p, add %d\n", priv, op.count);
-	if (unlikely(op.count <= 0))
+	if (unlikely(gntdev_test_page_count(op.count)))
 		return -EINVAL;
 
 	err = -ENOMEM;
@@ -676,12 +672,6 @@ static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
 	if (!map)
 		return err;
 
-	if (unlikely(gntdev_account_mapped_pages(op.count))) {
-		pr_debug("can't map: over limit\n");
-		gntdev_put_map(NULL, map);
-		return err;
-	}
-
 	if (copy_from_user(map->grants, &u->refs,
 			   sizeof(map->grants[0]) * op.count) != 0) {
 		gntdev_put_map(NULL, map);
-- 
2.16.4

