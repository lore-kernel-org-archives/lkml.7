Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F86C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F432206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfGVHrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:47:55 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfGVHrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:47:55 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MSbov-1i04vK0nhx-00T03d; Mon, 22 Jul 2019 09:47:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] xen: avoid link error on ARM
Date:   Mon, 22 Jul 2019 09:46:29 +0200
Message-Id: <20190722074705.2082153-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3EdOY3EUnlUpz1I3SU7SExGgM9Np4XJCmPkMfsKvDxZfzJkaD2X
 f9IRekbqSDJcE1EVqjNOA9BdXcMErvJxelu1521l2QAetrl5ETmalOPD0QL4Zcvom9mSXyc
 uRLbnfLZv+hDj2noZweapQyB7LLryFnru7t9yiXOb1r6C6biY4aLRZtuZ9KBYat1oJPr5p+
 RDIU7ZjihuLGcHKObaqdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oeVD7OeF3dY=:wxlNhsi0rCLsy/PPJPNYuB
 w26Lnf05qvb2AdLALuGE2FvIUZkDZtgpoU6R8YB9hoqyzcezCEjXqZfCtnWSxB7Xd5r0zYrGV
 vQgqb+8zmFG973E4Xn/5KB9dzReifXqBPS9DwprfNIaxW952EkjWCZWkJiv9mZ53kuyXupCYu
 BH4Z2Yazmzn+S9axnkq6V+//UJLH62xLvYX5HrecVy9r11BIMk4AhFwVxRT74f+ABJos42aR4
 c0KR9ItikEembbodxyYbGQKk6LU1xlZ+nRLqT0JZwWpcuNAHYFBTMjJieq+mM2AC1m3bZ+S7/
 lW2FOeUhQhrfktt/vryAYwEmU2pR7Iv7GbFhZPXZgMvuxqKEyTj4WOPWg1bTn/32HA4xVd8Ks
 XezYmPel78/F1PXEN5U9XaXolkKia3orRT+Gw6MVhHpBiyYFFiC5jNifG7bchp0bVtujzRDgT
 gaE3Mf7ImSTATrDw2BHDOY9qSJsP3mHXnRJiHiTlQwweOHI0pQK1ylxvqEeq1iOsxlh3Bc8us
 GMbXaRMYAe/sK2ZmmNyPlc2pmfJCkvQK/L+NAKGJNrzHD5VmQlTsHDEW0py9v/jtxEX7ftRuX
 Hs9gFyNnwJxyktB+BwksaAfS2L9CeavlqqyuA736zO4tju9QTXgDzzE5rmY4ZNmOpixszww+5
 Jpy+8fuI3MnGH4RWdSGmk9RaFDzxdeI5PVYLYa7nQYum1fWu+P4eg7xG/CqH74ZYUJOd26EHa
 XMLWYPQ8+CG6T24kqI6rhBECg/v+6XhkuUwLSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the privcmd code as a loadable module on ARM, we get
a link error due to the private cache management functions:

ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!

Move the code into a new that is always built in when Xen is enabled,
as suggested by Juergen Gross and Boris Ostrovsky.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rename mm.o to xen-builtin.o, make it unconditional
v3: move new code into xlate_mmu as suggested by Boris Ostrovsky.
    sorry for the long delay since v2, I lost track of this.
---
 drivers/xen/privcmd.c   | 35 +++++------------------------------
 drivers/xen/xlate_mmu.c | 32 ++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h   |  3 +++
 3 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 2f5ce7230a43..c6070e70dd73 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -724,25 +724,6 @@ static long privcmd_ioctl_restrict(struct file *file, void __user *udata)
 	return 0;
 }
 
-struct remap_pfn {
-	struct mm_struct *mm;
-	struct page **pages;
-	pgprot_t prot;
-	unsigned long i;
-};
-
-static int remap_pfn_fn(pte_t *ptep, unsigned long addr, void *data)
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
@@ -774,7 +755,8 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
 		goto out;
 	}
 
-	if (xen_feature(XENFEAT_auto_translated_physmap)) {
+	if (IS_ENABLED(CONFIG_XEN_AUTO_XLATE) &&
+	    xen_feature(XENFEAT_auto_translated_physmap)) {
 		unsigned int nr = DIV_ROUND_UP(kdata.num, XEN_PFN_PER_PAGE);
 		struct page **pages;
 		unsigned int i;
@@ -808,16 +790,9 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
 	if (rc)
 		goto out;
 
-	if (xen_feature(XENFEAT_auto_translated_physmap)) {
-		struct remap_pfn r = {
-			.mm = vma->vm_mm,
-			.pages = vma->vm_private_data,
-			.prot = vma->vm_page_prot,
-		};
-
-		rc = apply_to_page_range(r.mm, kdata.addr,
-					 kdata.num << PAGE_SHIFT,
-					 remap_pfn_fn, &r);
+	if (IS_ENABLED(CONFIG_XEN_AUTO_XLATE) &&
+	    xen_feature(XENFEAT_auto_translated_physmap)) {
+		rc = xen_remap_vma_range(vma, kdata.addr, kdata.num << PAGE_SHIFT);
 	} else {
 		unsigned int domid =
 			(xdata.flags & XENMEM_rsrc_acq_caller_owned) ?
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index ba883a80b3c0..7b1077f0abcb 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -262,3 +262,35 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xen_xlate_map_ballooned_pages);
+
+struct remap_pfn {
+	struct mm_struct *mm;
+	struct page **pages;
+	pgprot_t prot;
+	unsigned long i;
+};
+
+static int remap_pfn_fn(pte_t *ptep, unsigned long addr, void *data)
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

