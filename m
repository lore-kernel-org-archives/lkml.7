Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE7AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3C8206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCDUs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:48:58 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:41307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfCDUs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:48:58 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTzrW-1gbACN1ZvG-00R2qt; Mon, 04 Mar 2019 21:48:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Matthew Wilcox <willy@infradead.org>,
        Paul Durrant <paul.durrant@citrix.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH] xen: avoid link error on ARM
Date:   Mon,  4 Mar 2019 21:47:52 +0100
Message-Id: <20190304204826.2414365-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zD/cWwO0hmB7+ie+bIHG6Mz/lAutIvzcy8D6QjKzWARBd/P32aF
 rsTMDRqh6OUDcVVQPzF+L5jXTYSioKas+yeqfZWQKLiAOvMzNWEAv9EogAvn4K8jU+33xYB
 Wk3e2kkxL+qCUA8Xu2Td9NO/sQJk2Y+7X3B8U9hkX1y7Zd9e1uFhu+GWhKRcQfvOkvyxT34
 3M0pxTPZkH89IKTFJZXTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kbree5Ra92E=:H7qcgrKdCxdCK995jkpgDg
 2rHz5QpHsXfxFHji8tmH/9Y5gUCIS1ZGDzlL2E57E4R9344wc5zzpmn9zJhbbi6zzZ/3mCo7Z
 41zyE+SsEy7KdtYY4c1C3+i2aaRiBKufiBZHcF9sxnUfaqSVxeiLsaF6YdVtZBMgYinyyuJXo
 7YcunWzlAvGF73kIgNHDgZ3y6U5rlftgbBsR/jPGYYhU1G+diXRzBKt/7gjVyALi0Cu3kUHRo
 y/fDm7+CMEuqdarn1wdyoauSeN+jWZZH6jfuio/2iFziZ9UNW1yYP6UGx6A6zDu6YJNP6ui4K
 g4H8YZCcDSQjhyXlFGqDXOgOijUo8454xEXnZQR2N/3f5iJaOay0GFPNNtapNEpQa34BETTfZ
 KDwF9eWHmF4oObsLKv4hpZd+9MkPndwX8gq0QwfWKafHEw9ZWoZCut9HCW5jVRBgwMA6ot4sw
 y2FSCtiYcAhQ09q7c0qjmtoU2vw8gXdSAHM/qW8JkAlq9o7X62PfuLSTlguGWzr+OhwRWQAf+
 8QyrJkmht5BKTX54jLvU1JwFit1M9BMqMfFuBKGXCpi9ZIa6lndyaHrt3kwWEIP67akTQPyvb
 fVdBQ5lYT+O7ItkcALE7XdPrljWVoBzwPC8GL7il4LpTGrWJi+zqiXQ6qvkZSqGA/vs+Z9NB2
 +mLdETZtfyDzLTHFgW9GEDlyFzfECYDK8gxcwE6dN0QjaiHVMfAIIQqfbUUZCtxWy8QlzG9db
 +jiByblkreU7zCty6lDyeESQfYSvQrbN+uwKTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the privcmd code as a loadable module on ARM, we get
a link error due to the private cache management functions:

ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!

Move the code into a new file that is built along with privcmd.o
but is always built-in, even when the latter is a loadable module.

xen_remap_vma_range() may not be the best name here, if someone
comes up with a better one, let me know.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/xen/Makefile  |  3 +++
 drivers/xen/mm.c      | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/xen/privcmd.c | 30 +-----------------------------
 include/xen/xen-ops.h |  3 +++
 4 files changed, 48 insertions(+), 29 deletions(-)
 create mode 100644 drivers/xen/mm.c

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index ad3844d9f876..7124f9e749b4 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -29,6 +29,9 @@ obj-$(CONFIG_SWIOTLB_XEN)		+= swiotlb-xen.o
 obj-$(CONFIG_XEN_MCE_LOG)		+= mcelog.o
 obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+= xen-pciback/
 obj-$(CONFIG_XEN_PRIVCMD)		+= xen-privcmd.o
+ifdef CONFIG_XEN_PRIVCMD
+obj-y					+= mm.o
+endif
 obj-$(CONFIG_XEN_STUB)			+= xen-stub.o
 obj-$(CONFIG_XEN_ACPI_HOTPLUG_MEMORY)	+= xen-acpi-memhotplug.o
 obj-$(CONFIG_XEN_ACPI_HOTPLUG_CPU)	+= xen-acpi-cpuhotplug.o
diff --git a/drivers/xen/mm.c b/drivers/xen/mm.c
new file mode 100644
index 000000000000..8ad0d4900588
--- /dev/null
+++ b/drivers/xen/mm.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Architecture independent helper functions for memory management
+ *
+ * Written by Paul Durrant <paul.durrant@citrix.com>
+ */
+#include <linux/mm.h>
+#include <linux/export.h>
+
+struct remap_pfn {
+	struct mm_struct *mm;
+	struct page **pages;
+	pgprot_t prot;
+	unsigned long i;
+};
+
+static int remap_pfn_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
+			void *data)
+{
+	struct remap_pfn *r = data;
+	struct page *page = r->pages[r->i];
+	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));
+
+	set_pte_at(r->mm, addr, ptep, pte);
+	r->i++;
+
+	return 0;
+}
+
+/* Used by the privcmd module, but has to be built-in on ARM */
+int xen_remap_vma_range(struct vm_area_struct *vma, unsigned long addr, unsigned long len)
+{
+	struct remap_pfn r = {
+		.mm = vma->vm_mm,
+		.pages = vma->vm_private_data,
+		.prot = vma->vm_page_prot,
+	};
+
+	return apply_to_page_range(vma->vm_mm, addr, len, remap_pfn_fn, &r);
+}
+EXPORT_SYMBOL_GPL(xen_remap_vma_range);
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b24ddac1604b..290b6aca7e1d 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -723,26 +723,6 @@ static long privcmd_ioctl_restrict(struct file *file, void __user *udata)
 	return 0;
 }
 
-struct remap_pfn {
-	struct mm_struct *mm;
-	struct page **pages;
-	pgprot_t prot;
-	unsigned long i;
-};
-
-static int remap_pfn_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
-			void *data)
-{
-	struct remap_pfn *r = data;
-	struct page *page = r->pages[r->i];
-	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));
-
-	set_pte_at(r->mm, addr, ptep, pte);
-	r->i++;
-
-	return 0;
-}
-
 static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
 {
 	struct privcmd_data *data = file->private_data;
@@ -809,15 +789,7 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
 		goto out;
 
 	if (xen_feature(XENFEAT_auto_translated_physmap)) {
-		struct remap_pfn r = {
-			.mm = vma->vm_mm,
-			.pages = vma->vm_private_data,
-			.prot = vma->vm_page_prot,
-		};
-
-		rc = apply_to_page_range(r.mm, kdata.addr,
-					 kdata.num << PAGE_SHIFT,
-					 remap_pfn_fn, &r);
+		rc = xen_remap_vma_range(vma, kdata.addr, kdata.num << PAGE_SHIFT);
 	} else {
 		unsigned int domid =
 			(xdata.flags & XENMEM_rsrc_acq_caller_owned) ?
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 4969817124a8..98b30c1613b2 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -109,6 +109,9 @@ static inline int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
 }
 #endif
 
+int xen_remap_vma_range(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long len);
+
 /*
  * xen_remap_domain_gfn_array() - map an array of foreign frames by gfn
  * @vma:     VMA to map the pages into
-- 
2.20.0

