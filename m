Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE65FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A430A206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfCENbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:31:50 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:35473 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCENbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:31:49 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MuDPf-1hFnri07NV-00ud1Q; Tue, 05 Mar 2019 14:30:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH] [v2] xen: avoid link error on ARM
Date:   Tue,  5 Mar 2019 14:30:23 +0100
Message-Id: <20190305133057.3998926-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sNlZ/b0+5Z/i5IIGurUjpq7SGMkqDoEc7Kli9mP2zHRVY6zy7Pq
 GpwlCSNJw4l2Q5F3qnB1i1dEFXbShvrFq/JGK22bcacVZeIHz6YpWQ+9X7r7Mbx3+g+Am30
 rhMf+DT4UQlrvBYeUKNw4KNnsN+FOCUdH9tCzKrwf/qOykBXZd97yqEwg/2Jay6ov2qqzP2
 rMP5bN64iQp2BP772ZZww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p+OyvcstQ+I=:pb+iPZafoFiViGrcMRi5sL
 kA0PpSYU2+sIvVJHgQUKhX9Y9QwWbmX2+AeFkcyQrmdpyNG2A/7/cZOChnSrBrr3lIzWAKBSs
 wQ1w1vLoiSppF8iQFPQfOdkeQ+fHH122ZvDHNwwL1cboEtB1IPjQlWh6dm2utMhwn++vxUjBo
 I/MnYLXupCPD2WlL9pEDWA7PN6ZNPmtpElZ0pUB2FzTzpFLR0AR3Gp9D4wrVmdXQfFuL01Rew
 nhd9VhePq3qdi4yqznYHHxRiv+9IeD5mAfXugiPliu/Y6xRxHpi9ED3WDx5qADN6rPIloFsvu
 wyl+Mr6EzXrpngqp71YE0p46aXs80Kt2njTBU9fwIFZh/1CNtotKASDOg/DXpdB3U0Oe1OJmv
 qA8Gi9KoSnJUk1I2cw9B/4eQkuIlb4qcKjnxP7QCOFdGF5mIWkwXbOUrCDK0i6/mjCIOUWyP3
 5CephnASm99BiC7HAT7sCjPPzH1mPDdPDEJn58RvfflJIecHgzS22867v1kZo3bB/TZ9qLegI
 TPywYIW+ulhZDFC3MUfGjio0LApsuR5nhaFeUoih/7lZ3lsLIAZaFy9l9O+vad0D5CGVAmDfa
 x7O66lFpwqmdFDUTxWI4AJUHMAnLdV6oWdqxaGIzZBKPbT++Aaqt0F6ZGWIYlE45hwI26QnBy
 7xJHrYfpNNVBQgS2tTToOUxyW5JQ+P+aAoZoMR8Zu5BWcwVMVTu49zVUHzjoKWtKa9yHAotWc
 KBTSk9U9IV7YOwecBnIrlEXeU6x7tytUnKhOZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the privcmd code as a loadable module on ARM, we get
a link error due to the private cache management functions:

ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!

Move the code into a new file that is always built in when Xen
is enabled, as suggested by Juergen Gross. Additional code will
be moved into this file later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rename mm.o to xen-builtin.o, make it unconditional
---
 drivers/xen/Makefile      |  1 +
 drivers/xen/privcmd.c     | 30 +---------------------------
 drivers/xen/xen-builtin.c | 41 +++++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h     |  3 +++
 4 files changed, 46 insertions(+), 29 deletions(-)
 create mode 100644 drivers/xen/xen-builtin.c

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index ad3844d9f876..c3cbfcf30d38 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
 obj-y	+= mem-reservation.o
+obj-y	+= xen-builtin.o
 obj-y	+= events/
 obj-y	+= xenbus/
 
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
diff --git a/drivers/xen/xen-builtin.c b/drivers/xen/xen-builtin.c
new file mode 100644
index 000000000000..8ad0d4900588
--- /dev/null
+++ b/drivers/xen/xen-builtin.c
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

