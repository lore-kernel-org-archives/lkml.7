Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC20C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079B12054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="byvkxwPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfLKJ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:29:24 -0500
Received: from mail-eopbgr70091.outbound.protection.outlook.com ([40.107.7.91]:57028
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727493AbfLKJ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:29:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWVdr/J54/aCBVpVMUWucO2rDWty8LUXGprRgSIrResA8wajDMZfLM8kaXEOU/ADhrj5yHMJ4ggFHpU4LZ5KRdmr6OiQ+Zp2lVLkti2N/VGPRegeucunf3pbBG1wCSRCx45hRceAvk1zIziqn0b2QvWR+T75uoL3YeKvIh1o8WdY7B/IxS3u44HzcfuBRcfkSgeCV7fwu0umcJ+ND+D56rwvT7OrdUUdX+1FH2syxe7BFbCEeMH/OrPW1pBVcTK/uyPErMRq+zV16rj84n+BmY8bdl841Ku7Fz9bzYTcZ+gpFdla1/hF42Wunkj5jtOkRVVUTCmLWx4mpYCFw3XPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnAXBQTnoPKEZg9WPbTjY/ufZ7DWMSbKweyVdFzW00w=;
 b=RzgTrWIowr/Ph3jX8zzo/vojGzi8vmZBEBNn1r5UpFFrjvEAVBZcuCDIEYLSZIoBszdxqF4XwmSsENr4gCjIJ4HXlSdho8uldR/CBhFpDxEKNIY5VjngrjExmW5Wm2rnUD6Qog1UPUCl0Z19arKi60hSnUIZ8wEyMruqduWoYsiUSEr6q/CUSZ+HEtxWdoAC0ZqTWqQ7ntPJPv120DA46g28CJZOwMUATjk6NEhA7CnUlTaBLpfzHEUbPtAZXJaCnDqSwfKJ7yHFtUYsrovIzLLv3togxRfQ8/Fkk+LEWEpYloq6k52fSCJAAtCphNttFBn/IbJ2Dqf4dYkJ3PjgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnAXBQTnoPKEZg9WPbTjY/ufZ7DWMSbKweyVdFzW00w=;
 b=byvkxwPeiTdU2r4s66eK5/CGkLfHcpMhEyUduDQySg+utwgH4SbnRDQNZIVp2+bgBj3coTnhtI8MecxqMyoctc3ZWuTOLJYH3QLUwkp46qQEM0f71B7JDXtkKAZB56ZnDR34hoyeXx/0bUE8okulQkMEGd0Wi4OI9GdgorJhWI4=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB4869.eurprd02.prod.outlook.com (20.177.123.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 09:29:18 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06%2]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 09:29:18 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: [RFC PATCH v1 1/4] mm/remote_mapping: mirror a process address space
Thread-Topic: [RFC PATCH v1 1/4] mm/remote_mapping: mirror a process address
 space
Thread-Index: AdWwBBdjWL1iwgZWSiiPCON+EPj4xA==
Date:   Wed, 11 Dec 2019 09:29:17 +0000
Message-ID: <DB7PR02MB3979DB548160D2D9D25FE5ADBB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74d65d0f-67e3-4cba-1ca6-08d77e1c98a0
x-ms-traffictypediagnostic: DB7PR02MB4869:|DB7PR02MB4869:|DB7PR02MB4869:
x-microsoft-antispam-prvs: <DB7PR02MB4869BB8935A311C93CA34EB3BB5A0@DB7PR02MB4869.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(316002)(30864003)(8936002)(33656002)(478600001)(26005)(71200400001)(110136005)(186003)(86362001)(8676002)(66476007)(81156014)(76116006)(66556008)(55016002)(52536014)(6506007)(9686003)(66946007)(7696005)(2906002)(64756008)(66446008)(5660300002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4869;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMDlW+aXIhcuN2qXo907jxt8sRAFgVfCekHdmoon/zcPrjqV1DYHgMUREeyEgmrH/j0c6zIq9Dpc5dlWjCLgjdNZbnxRin2948xqQHqE4X3MorZlNnHSjpSoe51nRFijKZ72iNuEA5kbgfu6TnPPYvFi6NPXCe20RQdOCg98o6jO+u28RpTIEwDhtjg6NsMM06VEd80kxgMfCHxxxarwmVlPaet8l/fMMtazZA+S4oDrRlMHx359CnJqF1bol8YwoLFvd8RsKHpxqsaKLVTiqdldTTciTETdamouowRl2HOJiTvwxjT7pktLx83BiSpQJUPMBI1LXWxZni/SIxTEOt5emKstjgz3cWvWbOBf5Gmz2zKRJ1+Yhtxq0IqUXJFerhdJNBtHDEccOxkTsHxlMzsGlsHYIjbTrJbG8f6P3KJrBoisnxe//z8APC3PG+Wl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d65d0f-67e3-4cba-1ca6-08d77e1c98a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 09:29:17.9339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpnbQ71EUW9NWv1nS3/ckSKVUxYMMwN2M5963Fy6MAomT0xiArBi9t5eIxk95RVd6JWeaM+nQZ4mg5EcgFKGdupLIzqAu26rL7KiDiBapZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4869
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a device to inspect another process address space via page table mirror=
ing.
Give this device a source process PID via an ioctl(), then use mmap()
to analyze the source process address space like an ordinary file.
Process address space mirroring is limited to anon VMAs.
The device mirrors page tables on demand (faults) and invalidates them
by listening to MMU notifier events.

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
---
 include/linux/remote_mapping.h      |  33 ++
 include/uapi/linux/remote_mapping.h |  12 +
 mm/Kconfig                          |   9 +
 mm/Makefile                         |   1 +
 mm/remote_mapping.c                 | 615 ++++++++++++++++++++++++++++++++=
++++
 5 files changed, 670 insertions(+)
 create mode 100644 include/linux/remote_mapping.h
 create mode 100644 include/uapi/linux/remote_mapping.h
 create mode 100644 mm/remote_mapping.c

diff --git a/include/linux/remote_mapping.h b/include/linux/remote_mapping.=
h
new file mode 100644
index 0000000..ad0995d
--- /dev/null
+++ b/include/linux/remote_mapping.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _REMOTE_MAPPING_H
+#define _REMOTE_MAPPING_H
+
+#include <linux/mm.h>
+#include <linux/mmu_notifier.h>
+#include <linux/rbtree.h>
+#include <linux/srcu.h>
+#include <linux/rwsem.h>
+
+struct remote_file_context {
+	struct srcu_struct mm_srcu;
+	spinlock_t mm_lock;
+	struct mm_struct __rcu *mm;
+	struct mmu_notifier mn;
+
+	// interval tree for mapped ranges
+	struct rb_root_cached rb_root;
+	struct rw_semaphore tree_lock;
+};
+
+// describes a mapped range
+// mirror VMA points here
+struct remote_vma_context {
+	// al information about the mapped interval is found in the VMA
+	struct vm_area_struct *vma;
+
+	// interval tree link
+	struct rb_node target_rb;
+	unsigned long rb_subtree_last;
+};
+
+#endif /* _REMOTE_MAPPING_H */
diff --git a/include/uapi/linux/remote_mapping.h b/include/uapi/linux/remot=
e_mapping.h
new file mode 100644
index 0000000..eb0eec3
--- /dev/null
+++ b/include/uapi/linux/remote_mapping.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __UAPI_REMOTE_MAPPING_H__
+#define __UAPI_REMOTE_MAPPING_H__
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define REMOTE_PROC_MAP	_IOW('r', 0x01, int)
+// TODO: also ioctl for pidfd
+
+#endif /* __UAPI_REMOTE_MAPPING_H__ */
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933..c10dd5c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -739,4 +739,13 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
=20
+config REMOTE_MAPPING
+        bool "Remote memory mapping"
+        depends on MMU && MMU_NOTIFIER
+        default n
+
+        help
+          Allows a given process to map pages of another process in its ow=
n
+          address space.
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 1937cc2..595f1a8c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_ZONE_DEVICE) +=3D memremap.o
 obj-$(CONFIG_HMM_MIRROR) +=3D hmm.o
 obj-$(CONFIG_MEMFD_CREATE) +=3D memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) +=3D mapping_dirty_helpers.o
+obj-$(CONFIG_REMOTE_MAPPING) +=3D remote_mapping.o
diff --git a/mm/remote_mapping.c b/mm/remote_mapping.c
new file mode 100644
index 0000000..358b1f5
--- /dev/null
+++ b/mm/remote_mapping.c
@@ -0,0 +1,615 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Remote memory mapping.
+ *
+ * Copyright (C) 2017-2018 Bitdefender S.R.L.
+ *
+ * Author:
+ *   Mircea Cirjaliu <mcirjaliu@bitdefender.com>
+ */
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/rmap.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/rbtree.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/mm.h>
+#include <linux/pid.h>
+#include <linux/oom.h>
+#include <linux/huge_mm.h>
+#include <linux/mmu_notifier.h>
+#include <linux/sched/mm.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/refcount.h>
+#include <linux/debugfs.h>
+#include <linux/miscdevice.h>
+#include <linux/remote_mapping.h>
+#include <uapi/linux/remote_mapping.h>
+#include <asm/pgalloc.h>
+#include <linux/mman.h>
+#include <linux/pfn_t.h>
+#include <linux/errno.h>
+#include <linux/lockdep.h>
+
+#include "internal.h"
+
+#include <linux/kgdb.h>
+
+#define ASSERT(exp) BUG_ON(!(exp))
+
+
+static inline unsigned long ctx_start(struct remote_vma_context *ctx)
+{
+	return ctx->vma->vm_pgoff << PAGE_SHIFT;
+}
+
+static inline unsigned long ctx_end(struct remote_vma_context *ctx)
+{
+	return (ctx->vma->vm_pgoff << PAGE_SHIFT) +
+		(ctx->vma->vm_end - ctx->vma->vm_start);
+}
+
+static inline unsigned long range_start(struct remote_vma_context *ctx)
+{
+	return ctx_start(ctx) + 1;
+}
+
+static inline unsigned long range_last(struct remote_vma_context *ctx)
+{
+	return ctx_end(ctx) - 1;
+}
+
+INTERVAL_TREE_DEFINE(struct remote_vma_context, target_rb, unsigned long,
+	rb_subtree_last, range_start, range_last,
+	static inline, range_interval_tree)
+
+#define range_tree_foreach(ctx, root, start, last)	\
+	for (ctx =3D range_interval_tree_iter_first(root, start, last);\
+	     ctx; ctx =3D range_interval_tree_iter_next(ctx, start, last))
+
+static inline bool
+range_interval_tree_overlaps(struct remote_vma_context *ctx,
+			     struct remote_file_context *fctx)
+{
+	struct remote_vma_context *iter;
+
+	range_tree_foreach(iter, &fctx->rb_root, ctx_start(ctx), ctx_end(ctx))
+		return true;
+
+	return false;
+}
+
+static int
+mirror_invalidate_range_start(struct mmu_notifier *mn,
+				const struct mmu_notifier_range *range)
+{
+	struct remote_file_context *fctx =3D
+		container_of(mn, struct remote_file_context, mn);
+	struct remote_vma_context *ctx;
+	unsigned long src_start, src_end;
+	unsigned long vma_start, vma_end;
+
+	/* quick filter - we only map pages from anon VMAs */
+	if (!vma_is_anonymous(range->vma))
+		return 0;
+
+	/*
+	 * If ctx + VMA were found here, then the VMA + its address space
+	 * haven't been unmapped. See comments in mirror_vm_close().
+	 */
+	down_read(&fctx->tree_lock);
+
+	range_tree_foreach(ctx, &fctx->rb_root, range->start, range->end) {
+		pr_debug("%s: %lx-%lx found %lx-%lx\n",
+			__func__, range->start, range->end,
+			ctx_start(ctx), ctx_end(ctx));
+
+		// intersect these intervals (source process address range)
+		src_start =3D max(range->start, ctx_start(ctx));
+		src_end =3D min(range->end, ctx_end(ctx));
+
+		// translate to destination process address range
+		vma_start =3D ctx->vma->vm_start + (src_start - ctx_start(ctx));
+		vma_end =3D ctx->vma->vm_end + (src_end - ctx_end(ctx));
+
+		zap_vma_ptes(ctx->vma, vma_start, vma_end - vma_start);
+	}
+
+	up_read(&fctx->tree_lock);
+
+	return 0;
+}
+
+/* get notified when source MM is shutting down, so we avoid faulting in v=
ain */
+static void
+mirror_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct remote_file_context *fctx =3D
+		container_of(mn, struct remote_file_context, mn);
+
+	spin_lock(&fctx->mm_lock);
+	rcu_assign_pointer(fctx->mm, NULL);
+	spin_unlock(&fctx->mm_lock);
+
+	/* delay address space closing until local faults finish */
+	synchronize_srcu(&fctx->mm_srcu);
+}
+
+static const struct mmu_notifier_ops mirror_notifier_ops =3D {
+	.invalidate_range_start =3D mirror_invalidate_range_start,
+	.release =3D mirror_release,
+};
+
+
+static void remote_file_context_init(struct remote_file_context *ctx)
+{
+	ctx->mm =3D NULL;
+	ctx->mn.ops =3D &mirror_notifier_ops;
+	init_srcu_struct(&ctx->mm_srcu);
+	spin_lock_init(&ctx->mm_lock);
+
+	ctx->rb_root =3D RB_ROOT_CACHED;
+	init_rwsem(&ctx->tree_lock);
+}
+
+static struct remote_file_context *remote_file_context_alloc(void)
+{
+	struct remote_file_context *ctx;
+
+	ctx =3D kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (ctx)
+		remote_file_context_init(ctx);
+
+	return ctx;
+}
+
+static void remote_file_context_free(struct remote_file_context *ctx)
+{
+	kfree(ctx);
+}
+
+
+static void remote_vma_context_init(struct remote_vma_context *ctx)
+{
+	ctx->vma =3D NULL;
+}
+
+static struct remote_vma_context *remote_vma_context_alloc(void)
+{
+	struct remote_vma_context *ctx;
+
+	ctx =3D kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (ctx)
+		remote_vma_context_init(ctx);
+
+	return ctx;
+}
+
+static void remote_vma_context_free(struct remote_vma_context *ctx)
+{
+	kfree(ctx);
+}
+
+
+static struct page *mm_remote_get_page(struct mm_struct *req_mm,
+	unsigned long req_hva, unsigned int flags)
+{
+	struct page *req_page =3D NULL;
+	long nrpages;
+
+	might_sleep();
+
+	flags |=3D FOLL_ANON | FOLL_MIGRATION;
+
+	/* get host page corresponding to requested address */
+	nrpages =3D get_user_pages_remote(NULL, req_mm, req_hva, 1,
+					flags, &req_page, NULL, NULL);
+	if (unlikely(nrpages =3D=3D 0)) {
+		pr_err("no page for req_hva %016lx\n", req_hva);
+		return ERR_PTR(-ENOENT);
+	} else if (IS_ERR_VALUE(nrpages)) {
+		pr_err("get_user_pages_remote() failed: %d\n", (int)nrpages);
+		return ERR_PTR(nrpages);
+	}
+
+	/* limit introspection to anon memory (this also excludes zero-page) */
+	if (!PageAnon(req_page)) {
+		put_page(req_page);
+		pr_err("page at req_hva %016lx not anon\n", req_hva);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return req_page;
+}
+
+static int mirror_dev_open(struct inode *inode, struct file *file)
+{
+	struct remote_file_context *fctx;
+
+	fctx =3D remote_file_context_alloc();
+	if (!fctx)
+		return -ENOMEM;
+	file->private_data =3D fctx;
+
+	return 0;
+}
+
+static int do_remote_proc_map(struct file *file, int pid)
+{
+	struct task_struct *req_task;
+	struct mm_struct *req_mm;
+	struct remote_file_context *fctx =3D file->private_data;
+	int result;
+
+	/* this function may race with mirror_release() notifier */
+	spin_lock(&fctx->mm_lock);
+	if (fctx->mm) {
+		spin_unlock(&fctx->mm_lock);
+		return -EALREADY;
+	}
+	spin_unlock(&fctx->mm_lock);
+
+	// find task
+	req_task =3D find_get_task_by_vpid(pid);
+	if (!req_task)
+		return -ESRCH;
+
+	// find + get mm
+	req_mm =3D get_task_mm(req_task);
+	put_task_struct(req_task);
+	if (!req_mm)
+		return -EINVAL;
+
+	/* there should be no mirror VMA faults at the moment */
+	spin_lock(&fctx->mm_lock);
+	rcu_assign_pointer(fctx->mm, req_mm);
+	spin_unlock(&fctx->mm_lock);
+
+	// register MMU notifier
+	result =3D mmu_notifier_register(&fctx->mn, req_mm);
+	if (result) {
+		mmput(req_mm);
+		pr_err("unable to register MMU notifier\n");
+
+		return result;
+	}
+
+	mmput(req_mm);
+
+	return 0;
+}
+
+static long mirror_dev_ioctl(struct file *file, unsigned int ioctl,
+	unsigned long arg)
+{
+	long result;
+
+	switch (ioctl) {
+	case REMOTE_PROC_MAP: {
+		int pid =3D (int)arg;
+
+		result =3D do_remote_proc_map(file, pid);
+		break;
+	}
+
+	default:
+		pr_err("ioctl %d not implemented\n", ioctl);
+		result =3D -ENOTTY;
+	}
+
+	return result;
+}
+
+static int mirror_dev_release(struct inode *inode, struct file *file)
+{
+	struct remote_file_context *fctx =3D file->private_data;
+	struct mm_struct *src_mm =3D NULL;
+
+	/* this function may race with mirror_release() notifier */
+	spin_lock(&fctx->mm_lock);
+	if (fctx->mm) {
+		mmgrab(fctx->mm);
+		src_mm =3D fctx->mm;
+	}
+	spin_unlock(&fctx->mm_lock);
+
+	/* attempt unregistering if pointer found to be valid */
+	if (src_mm) {
+		mmu_notifier_unregister(&fctx->mn, fctx->mm);
+		mmdrop(src_mm);
+	}
+
+	/*
+	 * the synchronization inside mmu_notifier_unregister() makes sure no
+	 * notifier will run after the call
+	 */
+	remote_file_context_free(fctx);
+
+	return 0;
+}
+
+/*
+ * We end up here if the local PMD is NULL.
+ * Doesn't matter if the address is aligned to huge page boundary or not.
+ * We look for a huge page mapped at the target equivalent address and try=
 to
+ * map it in our page tables without splitting it.
+ */
+static vm_fault_t
+mirror_vm_hugefault(struct vm_fault *vmf, enum page_entry_size pe_size)
+{
+	struct vm_area_struct *vma =3D vmf->vma;
+	struct file *file =3D vma->vm_file;
+	struct remote_file_context *fctx =3D file->private_data;
+	unsigned long req_address;
+	unsigned int gup_flags;
+	struct page *req_page;
+	vm_fault_t result;
+	struct mm_struct *src_mm;
+	int idx;
+
+	pr_debug("%s: pe_size %d, address %016lx\n",
+		__func__, pe_size, vmf->address);
+
+	/* No support for anonymous transparent PUD pages yet */
+	if (pe_size =3D=3D PE_SIZE_PUD)
+		return VM_FAULT_FALLBACK;
+
+	idx =3D srcu_read_lock(&fctx->mm_srcu);
+
+	/* check if source mm still exists */
+	src_mm =3D srcu_dereference(fctx->mm, &fctx->mm_srcu);
+	if (!src_mm) {
+		result =3D VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	/* attempt near-deadlock situation */
+	if (!down_read_trylock(&src_mm->mmap_sem)) {
+		srcu_read_unlock(&fctx->mm_srcu, idx);
+		up_read(&current->mm->mmap_sem);
+
+		return VM_FAULT_RETRY;
+	}
+
+	/* set GUP flags depending on the VMA */
+	gup_flags =3D FOLL_HUGE;
+	if (vma->vm_flags & VM_WRITE)
+		gup_flags |=3D FOLL_WRITE | FOLL_FORCE;
+
+	req_address =3D vmf->pgoff << PAGE_SHIFT;
+	req_page =3D mm_remote_get_page(src_mm, req_address, gup_flags);
+
+	/* check for validity of the page */
+	if (IS_ERR_OR_NULL(req_page)) {
+		up_read(&src_mm->mmap_sem);
+
+		if (PTR_ERR(req_page) =3D=3D -ERESTARTSYS) {
+			srcu_read_unlock(&fctx->mm_srcu, idx);
+			up_read(&current->mm->mmap_sem);
+
+			return VM_FAULT_RETRY;
+		}
+
+		result =3D VM_FAULT_FALLBACK;
+		goto out;
+	}
+
+	/* shouldn't reach this case, but check anyway */
+	if (unlikely(!PageCompound(req_page))) {
+		result =3D VM_FAULT_FALLBACK;
+		goto out_page;
+	}
+
+	result =3D vmf_insert_pfn_pmd(vmf, page_to_pfn_t(req_page),
+				    vmf->flags & FAULT_FLAG_WRITE);
+
+out_page:
+	put_page(req_page);
+	up_read(&src_mm->mmap_sem);
+
+out:
+	srcu_read_unlock(&fctx->mm_srcu, idx);
+
+	return result;
+}
+
+static vm_fault_t mirror_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma =3D vmf->vma;
+	struct file *file =3D vma->vm_file;
+	struct remote_file_context *fctx =3D file->private_data;
+	unsigned long req_address;
+	unsigned int gup_flags;
+	struct page *req_page;
+	vm_fault_t result;
+	struct mm_struct *src_mm;
+	int idx;
+
+	pr_debug("%s: address %016lx\n", __func__, vmf->address);
+
+	idx =3D srcu_read_lock(&fctx->mm_srcu);
+
+	/* check if source mm still exists */
+	src_mm =3D srcu_dereference(fctx->mm, &fctx->mm_srcu);
+	if (!src_mm) {
+		result =3D VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	/* attempt near-deadlock situation */
+	if (!down_read_trylock(&src_mm->mmap_sem)) {
+		srcu_read_unlock(&fctx->mm_srcu, idx);
+		up_read(&current->mm->mmap_sem);
+
+		return VM_FAULT_RETRY;
+	}
+
+	/* set GUP flags depending on the VMA */
+	gup_flags =3D FOLL_SPLIT;
+	if (vma->vm_flags & VM_WRITE)
+		gup_flags |=3D FOLL_WRITE | FOLL_FORCE;
+
+	req_address =3D vmf->pgoff << PAGE_SHIFT;
+	req_page =3D mm_remote_get_page(src_mm, req_address, gup_flags);
+
+	/* check for validity of the page */
+	if (IS_ERR_OR_NULL(req_page)) {
+		up_read(&src_mm->mmap_sem);
+
+		if (PTR_ERR(req_page) =3D=3D -ERESTARTSYS ||
+		    PTR_ERR(req_page) =3D=3D -EBUSY) {
+			srcu_read_unlock(&fctx->mm_srcu, idx);
+			up_read(&current->mm->mmap_sem);
+
+			return VM_FAULT_RETRY;
+		}
+
+		result =3D VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	result =3D vmf_insert_pfn(vmf->vma, vmf->address, page_to_pfn(req_page));
+
+//out_page:
+	put_page(req_page);
+	up_read(&src_mm->mmap_sem);
+
+out:
+	srcu_read_unlock(&fctx->mm_srcu, idx);
+
+	return result;
+}
+
+/*
+ * This is called in remove_vma() at the end of __do_munmap() after the ad=
dress
+ * space has been unmapped and the page tables have been freed.
+ */
+static void mirror_vm_close(struct vm_area_struct *vma)
+{
+	struct remote_vma_context *ctx =3D vma->vm_private_data;
+	struct remote_file_context *fctx =3D vma->vm_file->private_data;
+
+	pr_debug("%s: %016lx - %016lx (%lu bytes)\n",
+		__func__, vma->vm_start, vma->vm_end,
+		vma->vm_end - vma->vm_start);
+
+	/* will wait for any running invalidate notifiers to finish */
+	down_write(&fctx->tree_lock);
+	range_interval_tree_remove(ctx, &fctx->rb_root);
+	up_write(&fctx->tree_lock);
+
+	remote_vma_context_free(ctx);
+	vma->vm_private_data =3D NULL;
+}
+
+// this will prevent partial unmap of destination VMA
+static int mirror_vm_split(struct vm_area_struct *area, unsigned long addr=
)
+{
+	return -EINVAL;
+}
+
+static const struct vm_operations_struct mirror_vm_ops =3D {
+	.close =3D mirror_vm_close,
+	.fault =3D mirror_vm_fault,
+	.huge_fault =3D mirror_vm_hugefault,
+	.split =3D mirror_vm_split,
+};
+
+
+static int mirror_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct remote_file_context *fctx =3D file->private_data;
+	struct remote_vma_context *ctx;
+
+	pr_debug("%s: %016lx - %016lx (%lu bytes)\n",
+		__func__, vma->vm_start, vma->vm_end,
+		vma->vm_end - vma->vm_start);
+
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	/* prepare the context */
+	ctx =3D remote_vma_context_alloc();
+	if (!ctx)
+		return -ENOMEM;
+
+	vma->vm_private_data =3D ctx;
+	ctx->vma =3D vma;
+
+	down_write(&fctx->tree_lock);
+	if (range_interval_tree_overlaps(ctx, fctx)) {
+		up_write(&fctx->tree_lock);
+
+		pr_err("part of range already mirrored\n");
+		remote_vma_context_free(ctx);
+		return -EALREADY;
+	}
+
+	range_interval_tree_insert(ctx, &fctx->rb_root);
+	up_write(&fctx->tree_lock);
+
+	/* set basic VMA properties */
+	vma->vm_flags |=3D VM_DONTCOPY | VM_DONTDUMP | VM_PFNMAP;
+	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
+	vma->vm_ops =3D &mirror_vm_ops;
+
+	return 0;
+}
+
+/*
+ * We must have the same alignment relative to a huge page boundary
+ * as the target VMA or requested address
+ */
+static unsigned long
+mirror_get_unmapped_area(struct file *file, const unsigned long addr0,
+	const unsigned long len, const unsigned long pgoff,
+	const unsigned long flags)
+{
+	struct vm_unmapped_area_info info;
+	unsigned long address =3D pgoff << PAGE_SHIFT;
+	bool huge_align =3D !(address & ~HPAGE_PMD_MASK);
+
+	pr_debug("%s: len %lu, pgoff 0x%016lx, %s alignment.\n",
+		__func__, len, pgoff, huge_align ? "PMD" : "page");
+
+	info.flags =3D VM_UNMAPPED_AREA_TOPDOWN;
+	info.length =3D len;
+	info.low_limit =3D PAGE_SIZE;
+	info.high_limit =3D get_mmap_base(0);
+	info.align_mask =3D ~HPAGE_PMD_MASK;
+	info.align_offset =3D address & ~HPAGE_PMD_MASK;
+
+	address =3D vm_unmapped_area(&info);
+
+	pr_debug("%s: address 0x%016lx\n", __func__, address);
+
+	return address;
+}
+
+static const struct file_operations mirror_ops =3D {
+	.open =3D mirror_dev_open,
+	.unlocked_ioctl =3D mirror_dev_ioctl,
+	.compat_ioctl =3D mirror_dev_ioctl,
+	.get_unmapped_area =3D mirror_get_unmapped_area,
+	.llseek =3D no_llseek,
+	.mmap =3D mirror_dev_mmap,
+	.release =3D mirror_dev_release,
+};
+
+static struct miscdevice mirror_dev =3D {
+	.minor =3D MISC_DYNAMIC_MINOR,
+	.name =3D "mirror-proc",
+	.fops =3D &mirror_ops,
+};
+
+builtin_misc_device(mirror_dev);
+
