Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D7C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77141208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfE0KcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:32:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfE0KcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:32:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C750AC20;
        Mon, 27 May 2019 10:32:11 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 1/3] xen: remove tmem driver
Date:   Mon, 27 May 2019 12:32:05 +0200
Message-Id: <20190527103207.13287-2-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190527103207.13287-1-jgross@suse.com>
References: <20190527103207.13287-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen tmem (transcendent memory) driver can be removed, as the
related Xen hypervisor feature never made it past the "experimental"
state and will be removed in future Xen versions (>= 4.13).

The xen-selfballoon driver depends on tmem, so it can be removed, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  21 -
 drivers/xen/Kconfig                             |  23 -
 drivers/xen/Makefile                            |   2 -
 drivers/xen/tmem.c                              | 419 -----------------
 drivers/xen/xen-balloon.c                       |   2 -
 drivers/xen/xen-selfballoon.c                   | 579 ------------------------
 include/xen/balloon.h                           |   8 -
 include/xen/tmem.h                              |  18 -
 8 files changed, 1072 deletions(-)
 delete mode 100644 drivers/xen/tmem.c
 delete mode 100644 drivers/xen/xen-selfballoon.c
 delete mode 100644 include/xen/tmem.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..2660f1a983a3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4663,27 +4663,6 @@
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
 
-	tmem		[KNL,XEN]
-			Enable the Transcendent memory driver if built-in.
-
-	tmem.cleancache=0|1 [KNL, XEN]
-			Default is on (1). Disable the usage of the cleancache
-			API to send anonymous pages to the hypervisor.
-
-	tmem.frontswap=0|1 [KNL, XEN]
-			Default is on (1). Disable the usage of the frontswap
-			API to send swap pages to the hypervisor. If disabled
-			the selfballooning and selfshrinking are force disabled.
-
-	tmem.selfballooning=0|1 [KNL, XEN]
-			Default is on (1). Disable the driving of swap pages
-			to the hypervisor.
-
-	tmem.selfshrinking=0|1 [KNL, XEN]
-			Default is on (1). Partial swapoff that immediately
-			transfers pages from Xen hypervisor back to the
-			kernel based on different criteria.
-
 	topology=	[S390]
 			Format: {off | on}
 			Specify if the kernel should make use of the cpu
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index ec6558b79e9d..79cc75096f42 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -10,21 +10,6 @@ config XEN_BALLOON
 	  the system to expand the domain's memory allocation, or alternatively
 	  return unneeded memory to the system.
 
-config XEN_SELFBALLOONING
-	bool "Dynamically self-balloon kernel memory to target"
-	depends on XEN && XEN_BALLOON && CLEANCACHE && SWAP && XEN_TMEM
-	help
-	  Self-ballooning dynamically balloons available kernel memory driven
-	  by the current usage of anonymous memory ("committed AS") and
-	  controlled by various sysfs-settable parameters.  Configuring
-	  FRONTSWAP is highly recommended; if it is not configured, self-
-	  ballooning is disabled by default. If FRONTSWAP is configured,
-	  frontswap-selfshrinking is enabled by default but can be disabled
-	  with the 'tmem.selfshrink=0' kernel boot parameter; and self-ballooning
-	  is enabled by default but can be disabled with the 'tmem.selfballooning=0'
-	  kernel boot parameter.  Note that systems without a sufficiently
-	  large swap device should not enable self-ballooning.
-
 config XEN_BALLOON_MEMORY_HOTPLUG
 	bool "Memory hotplug support for Xen balloon driver"
 	depends on XEN_BALLOON && MEMORY_HOTPLUG
@@ -191,14 +176,6 @@ config SWIOTLB_XEN
 	def_bool y
 	select SWIOTLB
 
-config XEN_TMEM
-	tristate
-	depends on !ARM && !ARM64
-	default m if (CLEANCACHE || FRONTSWAP)
-	help
-	  Shim to interface in-kernel Transcendent Memory hooks
-	  (e.g. cleancache and frontswap) to Xen tmem hypercalls.
-
 config XEN_PCIDEV_BACKEND
 	tristate "Xen PCI-device backend driver"
 	depends on PCI && X86 && XEN
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index ad3844d9f876..0c4efa6fe450 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -17,14 +17,12 @@ dom0-$(CONFIG_X86) += pcpu.o
 obj-$(CONFIG_XEN_DOM0)			+= $(dom0-y)
 obj-$(CONFIG_BLOCK)			+= biomerge.o
 obj-$(CONFIG_XEN_BALLOON)		+= xen-balloon.o
-obj-$(CONFIG_XEN_SELFBALLOONING)	+= xen-selfballoon.o
 obj-$(CONFIG_XEN_DEV_EVTCHN)		+= xen-evtchn.o
 obj-$(CONFIG_XEN_GNTDEV)		+= xen-gntdev.o
 obj-$(CONFIG_XEN_GRANT_DEV_ALLOC)	+= xen-gntalloc.o
 obj-$(CONFIG_XENFS)			+= xenfs/
 obj-$(CONFIG_XEN_SYS_HYPERVISOR)	+= sys-hypervisor.o
 obj-$(CONFIG_XEN_PVHVM)			+= platform-pci.o
-obj-$(CONFIG_XEN_TMEM)			+= tmem.o
 obj-$(CONFIG_SWIOTLB_XEN)		+= swiotlb-xen.o
 obj-$(CONFIG_XEN_MCE_LOG)		+= mcelog.o
 obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+= xen-pciback/
diff --git a/drivers/xen/tmem.c b/drivers/xen/tmem.c
deleted file mode 100644
index 64d7479ad5ad..000000000000
--- a/drivers/xen/tmem.c
+++ /dev/null
@@ -1,419 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Xen implementation for transcendent memory (tmem)
- *
- * Copyright (C) 2009-2011 Oracle Corp.  All rights reserved.
- * Author: Dan Magenheimer
- */
-
-#define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/cleancache.h>
-#include <linux/frontswap.h>
-
-#include <xen/xen.h>
-#include <xen/interface/xen.h>
-#include <xen/page.h>
-#include <asm/xen/hypercall.h>
-#include <asm/xen/hypervisor.h>
-#include <xen/tmem.h>
-
-#ifndef CONFIG_XEN_TMEM_MODULE
-bool __read_mostly tmem_enabled = false;
-
-static int __init enable_tmem(char *s)
-{
-	tmem_enabled = true;
-	return 1;
-}
-__setup("tmem", enable_tmem);
-#endif
-
-#ifdef CONFIG_CLEANCACHE
-static bool cleancache __read_mostly = true;
-module_param(cleancache, bool, S_IRUGO);
-static bool selfballooning __read_mostly = true;
-module_param(selfballooning, bool, S_IRUGO);
-#endif /* CONFIG_CLEANCACHE */
-
-#ifdef CONFIG_FRONTSWAP
-static bool frontswap __read_mostly = true;
-module_param(frontswap, bool, S_IRUGO);
-#else /* CONFIG_FRONTSWAP */
-#define frontswap (0)
-#endif /* CONFIG_FRONTSWAP */
-
-#ifdef CONFIG_XEN_SELFBALLOONING
-static bool selfshrinking __read_mostly = true;
-module_param(selfshrinking, bool, S_IRUGO);
-#endif /* CONFIG_XEN_SELFBALLOONING */
-
-#define TMEM_CONTROL               0
-#define TMEM_NEW_POOL              1
-#define TMEM_DESTROY_POOL          2
-#define TMEM_NEW_PAGE              3
-#define TMEM_PUT_PAGE              4
-#define TMEM_GET_PAGE              5
-#define TMEM_FLUSH_PAGE            6
-#define TMEM_FLUSH_OBJECT          7
-#define TMEM_READ                  8
-#define TMEM_WRITE                 9
-#define TMEM_XCHG                 10
-
-/* Bits for HYPERVISOR_tmem_op(TMEM_NEW_POOL) */
-#define TMEM_POOL_PERSIST          1
-#define TMEM_POOL_SHARED           2
-#define TMEM_POOL_PAGESIZE_SHIFT   4
-#define TMEM_VERSION_SHIFT        24
-
-
-struct tmem_pool_uuid {
-	u64 uuid_lo;
-	u64 uuid_hi;
-};
-
-struct tmem_oid {
-	u64 oid[3];
-};
-
-#define TMEM_POOL_PRIVATE_UUID	{ 0, 0 }
-
-/* flags for tmem_ops.new_pool */
-#define TMEM_POOL_PERSIST          1
-#define TMEM_POOL_SHARED           2
-
-/* xen tmem foundation ops/hypercalls */
-
-static inline int xen_tmem_op(u32 tmem_cmd, u32 tmem_pool, struct tmem_oid oid,
-	u32 index, unsigned long gmfn, u32 tmem_offset, u32 pfn_offset, u32 len)
-{
-	struct tmem_op op;
-	int rc = 0;
-
-	op.cmd = tmem_cmd;
-	op.pool_id = tmem_pool;
-	op.u.gen.oid[0] = oid.oid[0];
-	op.u.gen.oid[1] = oid.oid[1];
-	op.u.gen.oid[2] = oid.oid[2];
-	op.u.gen.index = index;
-	op.u.gen.tmem_offset = tmem_offset;
-	op.u.gen.pfn_offset = pfn_offset;
-	op.u.gen.len = len;
-	set_xen_guest_handle(op.u.gen.gmfn, (void *)gmfn);
-	rc = HYPERVISOR_tmem_op(&op);
-	return rc;
-}
-
-static int xen_tmem_new_pool(struct tmem_pool_uuid uuid,
-				u32 flags, unsigned long pagesize)
-{
-	struct tmem_op op;
-	int rc = 0, pageshift;
-
-	for (pageshift = 0; pagesize != 1; pageshift++)
-		pagesize >>= 1;
-	flags |= (pageshift - 12) << TMEM_POOL_PAGESIZE_SHIFT;
-	flags |= TMEM_SPEC_VERSION << TMEM_VERSION_SHIFT;
-	op.cmd = TMEM_NEW_POOL;
-	op.u.new.uuid[0] = uuid.uuid_lo;
-	op.u.new.uuid[1] = uuid.uuid_hi;
-	op.u.new.flags = flags;
-	rc = HYPERVISOR_tmem_op(&op);
-	return rc;
-}
-
-/* xen generic tmem ops */
-
-static int xen_tmem_put_page(u32 pool_id, struct tmem_oid oid,
-			     u32 index, struct page *page)
-{
-	return xen_tmem_op(TMEM_PUT_PAGE, pool_id, oid, index,
-			   xen_page_to_gfn(page), 0, 0, 0);
-}
-
-static int xen_tmem_get_page(u32 pool_id, struct tmem_oid oid,
-			     u32 index, struct page *page)
-{
-	return xen_tmem_op(TMEM_GET_PAGE, pool_id, oid, index,
-			   xen_page_to_gfn(page), 0, 0, 0);
-}
-
-static int xen_tmem_flush_page(u32 pool_id, struct tmem_oid oid, u32 index)
-{
-	return xen_tmem_op(TMEM_FLUSH_PAGE, pool_id, oid, index,
-		0, 0, 0, 0);
-}
-
-static int xen_tmem_flush_object(u32 pool_id, struct tmem_oid oid)
-{
-	return xen_tmem_op(TMEM_FLUSH_OBJECT, pool_id, oid, 0, 0, 0, 0, 0);
-}
-
-
-#ifdef CONFIG_CLEANCACHE
-static int xen_tmem_destroy_pool(u32 pool_id)
-{
-	struct tmem_oid oid = { { 0 } };
-
-	return xen_tmem_op(TMEM_DESTROY_POOL, pool_id, oid, 0, 0, 0, 0, 0);
-}
-
-/* cleancache ops */
-
-static void tmem_cleancache_put_page(int pool, struct cleancache_filekey key,
-				     pgoff_t index, struct page *page)
-{
-	u32 ind = (u32) index;
-	struct tmem_oid oid = *(struct tmem_oid *)&key;
-
-	if (pool < 0)
-		return;
-	if (ind != index)
-		return;
-	mb(); /* ensure page is quiescent; tmem may address it with an alias */
-	(void)xen_tmem_put_page((u32)pool, oid, ind, page);
-}
-
-static int tmem_cleancache_get_page(int pool, struct cleancache_filekey key,
-				    pgoff_t index, struct page *page)
-{
-	u32 ind = (u32) index;
-	struct tmem_oid oid = *(struct tmem_oid *)&key;
-	int ret;
-
-	/* translate return values to linux semantics */
-	if (pool < 0)
-		return -1;
-	if (ind != index)
-		return -1;
-	ret = xen_tmem_get_page((u32)pool, oid, ind, page);
-	if (ret == 1)
-		return 0;
-	else
-		return -1;
-}
-
-static void tmem_cleancache_flush_page(int pool, struct cleancache_filekey key,
-				       pgoff_t index)
-{
-	u32 ind = (u32) index;
-	struct tmem_oid oid = *(struct tmem_oid *)&key;
-
-	if (pool < 0)
-		return;
-	if (ind != index)
-		return;
-	(void)xen_tmem_flush_page((u32)pool, oid, ind);
-}
-
-static void tmem_cleancache_flush_inode(int pool, struct cleancache_filekey key)
-{
-	struct tmem_oid oid = *(struct tmem_oid *)&key;
-
-	if (pool < 0)
-		return;
-	(void)xen_tmem_flush_object((u32)pool, oid);
-}
-
-static void tmem_cleancache_flush_fs(int pool)
-{
-	if (pool < 0)
-		return;
-	(void)xen_tmem_destroy_pool((u32)pool);
-}
-
-static int tmem_cleancache_init_fs(size_t pagesize)
-{
-	struct tmem_pool_uuid uuid_private = TMEM_POOL_PRIVATE_UUID;
-
-	return xen_tmem_new_pool(uuid_private, 0, pagesize);
-}
-
-static int tmem_cleancache_init_shared_fs(uuid_t *uuid, size_t pagesize)
-{
-	struct tmem_pool_uuid shared_uuid;
-
-	shared_uuid.uuid_lo = *(u64 *)&uuid->b[0];
-	shared_uuid.uuid_hi = *(u64 *)&uuid->b[8];
-	return xen_tmem_new_pool(shared_uuid, TMEM_POOL_SHARED, pagesize);
-}
-
-static const struct cleancache_ops tmem_cleancache_ops = {
-	.put_page = tmem_cleancache_put_page,
-	.get_page = tmem_cleancache_get_page,
-	.invalidate_page = tmem_cleancache_flush_page,
-	.invalidate_inode = tmem_cleancache_flush_inode,
-	.invalidate_fs = tmem_cleancache_flush_fs,
-	.init_shared_fs = tmem_cleancache_init_shared_fs,
-	.init_fs = tmem_cleancache_init_fs
-};
-#endif
-
-#ifdef CONFIG_FRONTSWAP
-/* frontswap tmem operations */
-
-/* a single tmem poolid is used for all frontswap "types" (swapfiles) */
-static int tmem_frontswap_poolid;
-
-/*
- * Swizzling increases objects per swaptype, increasing tmem concurrency
- * for heavy swaploads.  Later, larger nr_cpus -> larger SWIZ_BITS
- */
-#define SWIZ_BITS		4
-#define SWIZ_MASK		((1 << SWIZ_BITS) - 1)
-#define _oswiz(_type, _ind)	((_type << SWIZ_BITS) | (_ind & SWIZ_MASK))
-#define iswiz(_ind)		(_ind >> SWIZ_BITS)
-
-static inline struct tmem_oid oswiz(unsigned type, u32 ind)
-{
-	struct tmem_oid oid = { .oid = { 0 } };
-	oid.oid[0] = _oswiz(type, ind);
-	return oid;
-}
-
-/* returns 0 if the page was successfully put into frontswap, -1 if not */
-static int tmem_frontswap_store(unsigned type, pgoff_t offset,
-				   struct page *page)
-{
-	u64 ind64 = (u64)offset;
-	u32 ind = (u32)offset;
-	int pool = tmem_frontswap_poolid;
-	int ret;
-
-	/* THP isn't supported */
-	if (PageTransHuge(page))
-		return -1;
-
-	if (pool < 0)
-		return -1;
-	if (ind64 != ind)
-		return -1;
-	mb(); /* ensure page is quiescent; tmem may address it with an alias */
-	ret = xen_tmem_put_page(pool, oswiz(type, ind), iswiz(ind), page);
-	/* translate Xen tmem return values to linux semantics */
-	if (ret == 1)
-		return 0;
-	else
-		return -1;
-}
-
-/*
- * returns 0 if the page was successfully gotten from frontswap, -1 if
- * was not present (should never happen!)
- */
-static int tmem_frontswap_load(unsigned type, pgoff_t offset,
-				   struct page *page)
-{
-	u64 ind64 = (u64)offset;
-	u32 ind = (u32)offset;
-	int pool = tmem_frontswap_poolid;
-	int ret;
-
-	if (pool < 0)
-		return -1;
-	if (ind64 != ind)
-		return -1;
-	ret = xen_tmem_get_page(pool, oswiz(type, ind), iswiz(ind), page);
-	/* translate Xen tmem return values to linux semantics */
-	if (ret == 1)
-		return 0;
-	else
-		return -1;
-}
-
-/* flush a single page from frontswap */
-static void tmem_frontswap_flush_page(unsigned type, pgoff_t offset)
-{
-	u64 ind64 = (u64)offset;
-	u32 ind = (u32)offset;
-	int pool = tmem_frontswap_poolid;
-
-	if (pool < 0)
-		return;
-	if (ind64 != ind)
-		return;
-	(void) xen_tmem_flush_page(pool, oswiz(type, ind), iswiz(ind));
-}
-
-/* flush all pages from the passed swaptype */
-static void tmem_frontswap_flush_area(unsigned type)
-{
-	int pool = tmem_frontswap_poolid;
-	int ind;
-
-	if (pool < 0)
-		return;
-	for (ind = SWIZ_MASK; ind >= 0; ind--)
-		(void)xen_tmem_flush_object(pool, oswiz(type, ind));
-}
-
-static void tmem_frontswap_init(unsigned ignored)
-{
-	struct tmem_pool_uuid private = TMEM_POOL_PRIVATE_UUID;
-
-	/* a single tmem poolid is used for all frontswap "types" (swapfiles) */
-	if (tmem_frontswap_poolid < 0)
-		tmem_frontswap_poolid =
-		    xen_tmem_new_pool(private, TMEM_POOL_PERSIST, PAGE_SIZE);
-}
-
-static struct frontswap_ops tmem_frontswap_ops = {
-	.store = tmem_frontswap_store,
-	.load = tmem_frontswap_load,
-	.invalidate_page = tmem_frontswap_flush_page,
-	.invalidate_area = tmem_frontswap_flush_area,
-	.init = tmem_frontswap_init
-};
-#endif
-
-static int __init xen_tmem_init(void)
-{
-	if (!xen_domain())
-		return 0;
-#ifdef CONFIG_FRONTSWAP
-	if (tmem_enabled && frontswap) {
-		char *s = "";
-
-		tmem_frontswap_poolid = -1;
-		frontswap_register_ops(&tmem_frontswap_ops);
-		pr_info("frontswap enabled, RAM provided by Xen Transcendent Memory%s\n",
-			s);
-	}
-#endif
-#ifdef CONFIG_CLEANCACHE
-	BUILD_BUG_ON(sizeof(struct cleancache_filekey) != sizeof(struct tmem_oid));
-	if (tmem_enabled && cleancache) {
-		int err;
-
-		err = cleancache_register_ops(&tmem_cleancache_ops);
-		if (err)
-			pr_warn("xen-tmem: failed to enable cleancache: %d\n",
-				err);
-		else
-			pr_info("cleancache enabled, RAM provided by "
-				"Xen Transcendent Memory\n");
-	}
-#endif
-#ifdef CONFIG_XEN_SELFBALLOONING
-	/*
-	 * There is no point of driving pages to the swap system if they
-	 * aren't going anywhere in tmem universe.
-	 */
-	if (!frontswap) {
-		selfshrinking = false;
-		selfballooning = false;
-	}
-	xen_selfballoon_init(selfballooning, selfshrinking);
-#endif
-	return 0;
-}
-
-module_init(xen_tmem_init)
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Dan Magenheimer <dan.magenheimer@oracle.com>");
-MODULE_DESCRIPTION("Shim to Xen transcendent memory");
diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index a67236b02452..6d12fc368210 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -129,8 +129,6 @@ void xen_balloon_init(void)
 {
 	register_balloon(&balloon_dev);
 
-	register_xen_selfballooning(&balloon_dev);
-
 	register_xenstore_notifier(&xenstore_notifier);
 }
 EXPORT_SYMBOL_GPL(xen_balloon_init);
diff --git a/drivers/xen/xen-selfballoon.c b/drivers/xen/xen-selfballoon.c
deleted file mode 100644
index 246f6122c9ee..000000000000
--- a/drivers/xen/xen-selfballoon.c
+++ /dev/null
@@ -1,579 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- * Xen selfballoon driver (and optional frontswap self-shrinking driver)
- *
- * Copyright (c) 2009-2011, Dan Magenheimer, Oracle Corp.
- *
- * This code complements the cleancache and frontswap patchsets to optimize
- * support for Xen Transcendent Memory ("tmem").  The policy it implements
- * is rudimentary and will likely improve over time, but it does work well
- * enough today.
- *
- * Two functionalities are implemented here which both use "control theory"
- * (feedback) to optimize memory utilization. In a virtualized environment
- * such as Xen, RAM is often a scarce resource and we would like to ensure
- * that each of a possibly large number of virtual machines is using RAM
- * efficiently, i.e. using as little as possible when under light load
- * and obtaining as much as possible when memory demands are high.
- * Since RAM needs vary highly dynamically and sometimes dramatically,
- * "hysteresis" is used, that is, memory target is determined not just
- * on current data but also on past data stored in the system.
- *
- * "Selfballooning" creates memory pressure by managing the Xen balloon
- * driver to decrease and increase available kernel memory, driven
- * largely by the target value of "Committed_AS" (see /proc/meminfo).
- * Since Committed_AS does not account for clean mapped pages (i.e. pages
- * in RAM that are identical to pages on disk), selfballooning has the
- * affect of pushing less frequently used clean pagecache pages out of
- * kernel RAM and, presumably using cleancache, into Xen tmem where
- * Xen can more efficiently optimize RAM utilization for such pages.
- *
- * When kernel memory demand unexpectedly increases faster than Xen, via
- * the selfballoon driver, is able to (or chooses to) provide usable RAM,
- * the kernel may invoke swapping.  In most cases, frontswap is able
- * to absorb this swapping into Xen tmem.  However, due to the fact
- * that the kernel swap subsystem assumes swapping occurs to a disk,
- * swapped pages may sit on the disk for a very long time; even if
- * the kernel knows the page will never be used again.  This is because
- * the disk space costs very little and can be overwritten when
- * necessary.  When such stale pages are in frontswap, however, they
- * are taking up valuable real estate.  "Frontswap selfshrinking" works
- * to resolve this:  When frontswap activity is otherwise stable
- * and the guest kernel is not under memory pressure, the "frontswap
- * selfshrinking" accounts for this by providing pressure to remove some
- * pages from frontswap and return them to kernel memory.
- *
- * For both "selfballooning" and "frontswap-selfshrinking", a worker
- * thread is used and sysfs tunables are provided to adjust the frequency
- * and rate of adjustments to achieve the goal, as well as to disable one
- * or both functions independently.
- *
- * While some argue that this functionality can and should be implemented
- * in userspace, it has been observed that bad things happen (e.g. OOMs).
- *
- * System configuration note: Selfballooning should not be enabled on
- * systems without a sufficiently large swap device configured; for best
- * results, it is recommended that total swap be increased by the size
- * of the guest memory. Note, that selfballooning should be disabled by default
- * if frontswap is not configured.  Similarly selfballooning should be enabled
- * by default if frontswap is configured and can be disabled with the
- * "tmem.selfballooning=0" kernel boot option.  Finally, when frontswap is
- * configured, frontswap-selfshrinking can be disabled  with the
- * "tmem.selfshrink=0" kernel boot option.
- *
- * Selfballooning is disallowed in domain0 and force-disabled.
- *
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/memblock.h>
-#include <linux/swap.h>
-#include <linux/mm.h>
-#include <linux/mman.h>
-#include <linux/workqueue.h>
-#include <linux/device.h>
-#include <xen/balloon.h>
-#include <xen/tmem.h>
-#include <xen/xen.h>
-
-/* Enable/disable with sysfs. */
-static int xen_selfballooning_enabled __read_mostly;
-
-/*
- * Controls rate at which memory target (this iteration) approaches
- * ultimate goal when memory need is increasing (up-hysteresis) or
- * decreasing (down-hysteresis). Higher values of hysteresis cause
- * slower increases/decreases. The default values for the various
- * parameters were deemed reasonable by experimentation, may be
- * workload-dependent, and can all be adjusted via sysfs.
- */
-static unsigned int selfballoon_downhysteresis __read_mostly = 8;
-static unsigned int selfballoon_uphysteresis __read_mostly = 1;
-
-/* In HZ, controls frequency of worker invocation. */
-static unsigned int selfballoon_interval __read_mostly = 5;
-
-/*
- * Minimum usable RAM in MB for selfballooning target for balloon.
- * If non-zero, it is added to totalreserve_pages and self-ballooning
- * will not balloon below the sum.  If zero, a piecewise linear function
- * is calculated as a minimum and added to totalreserve_pages.  Note that
- * setting this value indiscriminately may cause OOMs and crashes.
- */
-static unsigned int selfballoon_min_usable_mb;
-
-/*
- * Amount of RAM in MB to add to the target number of pages.
- * Can be used to reserve some more room for caches and the like.
- */
-static unsigned int selfballoon_reserved_mb;
-
-static void selfballoon_process(struct work_struct *work);
-static DECLARE_DELAYED_WORK(selfballoon_worker, selfballoon_process);
-
-#ifdef CONFIG_FRONTSWAP
-#include <linux/frontswap.h>
-
-/* Enable/disable with sysfs. */
-static bool frontswap_selfshrinking __read_mostly;
-
-/*
- * The default values for the following parameters were deemed reasonable
- * by experimentation, may be workload-dependent, and can all be
- * adjusted via sysfs.
- */
-
-/* Control rate for frontswap shrinking. Higher hysteresis is slower. */
-static unsigned int frontswap_hysteresis __read_mostly = 20;
-
-/*
- * Number of selfballoon worker invocations to wait before observing that
- * frontswap selfshrinking should commence. Note that selfshrinking does
- * not use a separate worker thread.
- */
-static unsigned int frontswap_inertia __read_mostly = 3;
-
-/* Countdown to next invocation of frontswap_shrink() */
-static unsigned long frontswap_inertia_counter;
-
-/*
- * Invoked by the selfballoon worker thread, uses current number of pages
- * in frontswap (frontswap_curr_pages()), previous status, and control
- * values (hysteresis and inertia) to determine if frontswap should be
- * shrunk and what the new frontswap size should be.  Note that
- * frontswap_shrink is essentially a partial swapoff that immediately
- * transfers pages from the "swap device" (frontswap) back into kernel
- * RAM; despite the name, frontswap "shrinking" is very different from
- * the "shrinker" interface used by the kernel MM subsystem to reclaim
- * memory.
- */
-static void frontswap_selfshrink(void)
-{
-	static unsigned long cur_frontswap_pages;
-	unsigned long last_frontswap_pages;
-	unsigned long tgt_frontswap_pages;
-
-	last_frontswap_pages = cur_frontswap_pages;
-	cur_frontswap_pages = frontswap_curr_pages();
-	if (!cur_frontswap_pages ||
-			(cur_frontswap_pages > last_frontswap_pages)) {
-		frontswap_inertia_counter = frontswap_inertia;
-		return;
-	}
-	if (frontswap_inertia_counter && --frontswap_inertia_counter)
-		return;
-	if (cur_frontswap_pages <= frontswap_hysteresis)
-		tgt_frontswap_pages = 0;
-	else
-		tgt_frontswap_pages = cur_frontswap_pages -
-			(cur_frontswap_pages / frontswap_hysteresis);
-	frontswap_shrink(tgt_frontswap_pages);
-	frontswap_inertia_counter = frontswap_inertia;
-}
-
-#endif /* CONFIG_FRONTSWAP */
-
-#define MB2PAGES(mb)	((mb) << (20 - PAGE_SHIFT))
-#define PAGES2MB(pages) ((pages) >> (20 - PAGE_SHIFT))
-
-/*
- * Use current balloon size, the goal (vm_committed_as), and hysteresis
- * parameters to set a new target balloon size
- */
-static void selfballoon_process(struct work_struct *work)
-{
-	unsigned long cur_pages, goal_pages, tgt_pages, floor_pages;
-	unsigned long useful_pages;
-	bool reset_timer = false;
-
-	if (xen_selfballooning_enabled) {
-		cur_pages = totalram_pages();
-		tgt_pages = cur_pages; /* default is no change */
-		goal_pages = vm_memory_committed() +
-				totalreserve_pages +
-				MB2PAGES(selfballoon_reserved_mb);
-#ifdef CONFIG_FRONTSWAP
-		/* allow space for frontswap pages to be repatriated */
-		if (frontswap_selfshrinking)
-			goal_pages += frontswap_curr_pages();
-#endif
-		if (cur_pages > goal_pages)
-			tgt_pages = cur_pages -
-				((cur_pages - goal_pages) /
-				  selfballoon_downhysteresis);
-		else if (cur_pages < goal_pages)
-			tgt_pages = cur_pages +
-				((goal_pages - cur_pages) /
-				  selfballoon_uphysteresis);
-		/* else if cur_pages == goal_pages, no change */
-		useful_pages = max_pfn - totalreserve_pages;
-		if (selfballoon_min_usable_mb != 0)
-			floor_pages = totalreserve_pages +
-					MB2PAGES(selfballoon_min_usable_mb);
-		/* piecewise linear function ending in ~3% slope */
-		else if (useful_pages < MB2PAGES(16))
-			floor_pages = max_pfn; /* not worth ballooning */
-		else if (useful_pages < MB2PAGES(64))
-			floor_pages = totalreserve_pages + MB2PAGES(16) +
-					((useful_pages - MB2PAGES(16)) >> 1);
-		else if (useful_pages < MB2PAGES(512))
-			floor_pages = totalreserve_pages + MB2PAGES(40) +
-					((useful_pages - MB2PAGES(40)) >> 3);
-		else /* useful_pages >= MB2PAGES(512) */
-			floor_pages = totalreserve_pages + MB2PAGES(99) +
-					((useful_pages - MB2PAGES(99)) >> 5);
-		if (tgt_pages < floor_pages)
-			tgt_pages = floor_pages;
-		balloon_set_new_target(tgt_pages +
-			balloon_stats.current_pages - totalram_pages());
-		reset_timer = true;
-	}
-#ifdef CONFIG_FRONTSWAP
-	if (frontswap_selfshrinking) {
-		frontswap_selfshrink();
-		reset_timer = true;
-	}
-#endif
-	if (reset_timer)
-		schedule_delayed_work(&selfballoon_worker,
-			selfballoon_interval * HZ);
-}
-
-#ifdef CONFIG_SYSFS
-
-#include <linux/capability.h>
-
-#define SELFBALLOON_SHOW(name, format, args...)				\
-	static ssize_t show_##name(struct device *dev,	\
-					  struct device_attribute *attr, \
-					  char *buf) \
-	{ \
-		return sprintf(buf, format, ##args); \
-	}
-
-SELFBALLOON_SHOW(selfballooning, "%d\n", xen_selfballooning_enabled);
-
-static ssize_t store_selfballooning(struct device *dev,
-			    struct device_attribute *attr,
-			    const char *buf,
-			    size_t count)
-{
-	bool was_enabled = xen_selfballooning_enabled;
-	unsigned long tmp;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	err = kstrtoul(buf, 10, &tmp);
-	if (err)
-		return err;
-	if ((tmp != 0) && (tmp != 1))
-		return -EINVAL;
-
-	xen_selfballooning_enabled = !!tmp;
-	if (!was_enabled && xen_selfballooning_enabled)
-		schedule_delayed_work(&selfballoon_worker,
-			selfballoon_interval * HZ);
-
-	return count;
-}
-
-static DEVICE_ATTR(selfballooning, S_IRUGO | S_IWUSR,
-		   show_selfballooning, store_selfballooning);
-
-SELFBALLOON_SHOW(selfballoon_interval, "%d\n", selfballoon_interval);
-
-static ssize_t store_selfballoon_interval(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf,
-					  size_t count)
-{
-	unsigned long val;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	if (val == 0)
-		return -EINVAL;
-	selfballoon_interval = val;
-	return count;
-}
-
-static DEVICE_ATTR(selfballoon_interval, S_IRUGO | S_IWUSR,
-		   show_selfballoon_interval, store_selfballoon_interval);
-
-SELFBALLOON_SHOW(selfballoon_downhys, "%d\n", selfballoon_downhysteresis);
-
-static ssize_t store_selfballoon_downhys(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t count)
-{
-	unsigned long val;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	if (val == 0)
-		return -EINVAL;
-	selfballoon_downhysteresis = val;
-	return count;
-}
-
-static DEVICE_ATTR(selfballoon_downhysteresis, S_IRUGO | S_IWUSR,
-		   show_selfballoon_downhys, store_selfballoon_downhys);
-
-
-SELFBALLOON_SHOW(selfballoon_uphys, "%d\n", selfballoon_uphysteresis);
-
-static ssize_t store_selfballoon_uphys(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf,
-				       size_t count)
-{
-	unsigned long val;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	if (val == 0)
-		return -EINVAL;
-	selfballoon_uphysteresis = val;
-	return count;
-}
-
-static DEVICE_ATTR(selfballoon_uphysteresis, S_IRUGO | S_IWUSR,
-		   show_selfballoon_uphys, store_selfballoon_uphys);
-
-SELFBALLOON_SHOW(selfballoon_min_usable_mb, "%d\n",
-				selfballoon_min_usable_mb);
-
-static ssize_t store_selfballoon_min_usable_mb(struct device *dev,
-					       struct device_attribute *attr,
-					       const char *buf,
-					       size_t count)
-{
-	unsigned long val;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	if (val == 0)
-		return -EINVAL;
-	selfballoon_min_usable_mb = val;
-	return count;
-}
-
-static DEVICE_ATTR(selfballoon_min_usable_mb, S_IRUGO | S_IWUSR,
-		   show_selfballoon_min_usable_mb,
-		   store_selfballoon_min_usable_mb);
-
-SELFBALLOON_SHOW(selfballoon_reserved_mb, "%d\n",
-				selfballoon_reserved_mb);
-
-static ssize_t store_selfballoon_reserved_mb(struct device *dev,
-					     struct device_attribute *attr,
-					     const char *buf,
-					     size_t count)
-{
-	unsigned long val;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	if (val == 0)
-		return -EINVAL;
-	selfballoon_reserved_mb = val;
-	return count;
-}
-
-static DEVICE_ATTR(selfballoon_reserved_mb, S_IRUGO | S_IWUSR,
-		   show_selfballoon_reserved_mb,
-		   store_selfballoon_reserved_mb);
-
-
-#ifdef CONFIG_FRONTSWAP
-SELFBALLOON_SHOW(frontswap_selfshrinking, "%d\n", frontswap_selfshrinking);
-
-static ssize_t store_frontswap_selfshrinking(struct device *dev,
-					     struct device_attribute *attr,
-					     const char *buf,
-					     size_t count)
-{
-	bool was_enabled = frontswap_selfshrinking;
-	unsigned long tmp;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = kstrtoul(buf, 10, &tmp);
-	if (err)
-		return err;
-	if ((tmp != 0) && (tmp != 1))
-		return -EINVAL;
-	frontswap_selfshrinking = !!tmp;
-	if (!was_enabled && !xen_selfballooning_enabled &&
-	     frontswap_selfshrinking)
-		schedule_delayed_work(&selfballoon_worker,
-			selfballoon_interval * HZ);
-
-	return count;
-}
-
-static DEVICE_ATTR(frontswap_selfshrinking, S_IRUGO | S_IWUSR,
-		   show_frontswap_selfshrinking, store_frontswap_selfshrinking);
-
-SELFBALLOON_SHOW(frontswap_inertia, "%d\n", frontswap_inertia);
-
-static ssize_t store_frontswap_inertia(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf,
-				       size_t count)
-{
-	unsigned long val;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	if (val == 0)
-		return -EINVAL;
-	frontswap_inertia = val;
-	frontswap_inertia_counter = val;
-	return count;
-}
-
-static DEVICE_ATTR(frontswap_inertia, S_IRUGO | S_IWUSR,
-		   show_frontswap_inertia, store_frontswap_inertia);
-
-SELFBALLOON_SHOW(frontswap_hysteresis, "%d\n", frontswap_hysteresis);
-
-static ssize_t store_frontswap_hysteresis(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf,
-					  size_t count)
-{
-	unsigned long val;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	if (val == 0)
-		return -EINVAL;
-	frontswap_hysteresis = val;
-	return count;
-}
-
-static DEVICE_ATTR(frontswap_hysteresis, S_IRUGO | S_IWUSR,
-		   show_frontswap_hysteresis, store_frontswap_hysteresis);
-
-#endif /* CONFIG_FRONTSWAP */
-
-static struct attribute *selfballoon_attrs[] = {
-	&dev_attr_selfballooning.attr,
-	&dev_attr_selfballoon_interval.attr,
-	&dev_attr_selfballoon_downhysteresis.attr,
-	&dev_attr_selfballoon_uphysteresis.attr,
-	&dev_attr_selfballoon_min_usable_mb.attr,
-	&dev_attr_selfballoon_reserved_mb.attr,
-#ifdef CONFIG_FRONTSWAP
-	&dev_attr_frontswap_selfshrinking.attr,
-	&dev_attr_frontswap_hysteresis.attr,
-	&dev_attr_frontswap_inertia.attr,
-#endif
-	NULL
-};
-
-static const struct attribute_group selfballoon_group = {
-	.name = "selfballoon",
-	.attrs = selfballoon_attrs
-};
-#endif
-
-int register_xen_selfballooning(struct device *dev)
-{
-	int error = -1;
-
-#ifdef CONFIG_SYSFS
-	error = sysfs_create_group(&dev->kobj, &selfballoon_group);
-#endif
-	return error;
-}
-EXPORT_SYMBOL(register_xen_selfballooning);
-
-int xen_selfballoon_init(bool use_selfballooning, bool use_frontswap_selfshrink)
-{
-	bool enable = false;
-	unsigned long reserve_pages;
-
-	if (!xen_domain())
-		return -ENODEV;
-
-	if (xen_initial_domain()) {
-		pr_info("Xen selfballooning driver disabled for domain0\n");
-		return -ENODEV;
-	}
-
-	xen_selfballooning_enabled = tmem_enabled && use_selfballooning;
-	if (xen_selfballooning_enabled) {
-		pr_info("Initializing Xen selfballooning driver\n");
-		enable = true;
-	}
-#ifdef CONFIG_FRONTSWAP
-	frontswap_selfshrinking = tmem_enabled && use_frontswap_selfshrink;
-	if (frontswap_selfshrinking) {
-		pr_info("Initializing frontswap selfshrinking driver\n");
-		enable = true;
-	}
-#endif
-	if (!enable)
-		return -ENODEV;
-
-	/*
-	 * Give selfballoon_reserved_mb a default value(10% of total ram pages)
-	 * to make selfballoon not so aggressive.
-	 *
-	 * There are mainly two reasons:
-	 * 1) The original goal_page didn't consider some pages used by kernel
-	 *    space, like slab pages and memory used by device drivers.
-	 *
-	 * 2) The balloon driver may not give back memory to guest OS fast
-	 *    enough when the workload suddenly aquries a lot of physical memory.
-	 *
-	 * In both cases, the guest OS will suffer from memory pressure and
-	 * OOM killer may be triggered.
-	 * By reserving extra 10% of total ram pages, we can keep the system
-	 * much more reliably and response faster in some cases.
-	 */
-	if (!selfballoon_reserved_mb) {
-		reserve_pages = totalram_pages() / 10;
-		selfballoon_reserved_mb = PAGES2MB(reserve_pages);
-	}
-	schedule_delayed_work(&selfballoon_worker, selfballoon_interval * HZ);
-
-	return 0;
-}
-EXPORT_SYMBOL(xen_selfballoon_init);
diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index 4914b93a23f2..a72ef3f88b39 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -28,14 +28,6 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages);
 void free_xenballooned_pages(int nr_pages, struct page **pages);
 
 struct device;
-#ifdef CONFIG_XEN_SELFBALLOONING
-extern int register_xen_selfballooning(struct device *dev);
-#else
-static inline int register_xen_selfballooning(struct device *dev)
-{
-	return -ENOSYS;
-}
-#endif
 
 #ifdef CONFIG_XEN_BALLOON
 void xen_balloon_init(void);
diff --git a/include/xen/tmem.h b/include/xen/tmem.h
deleted file mode 100644
index c80bafe31f14..000000000000
--- a/include/xen/tmem.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _XEN_TMEM_H
-#define _XEN_TMEM_H
-
-#include <linux/types.h>
-
-#ifdef CONFIG_XEN_TMEM_MODULE
-#define tmem_enabled true
-#else
-/* defined in drivers/xen/tmem.c */
-extern bool tmem_enabled;
-#endif
-
-#ifdef CONFIG_XEN_SELFBALLOONING
-extern int xen_selfballoon_init(bool, bool);
-#endif
-
-#endif /* _XEN_TMEM_H */
-- 
2.16.4

