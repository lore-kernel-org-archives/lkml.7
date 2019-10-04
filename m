Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D1CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B32222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V7l7ABt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbfJDNjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:39:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57173 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbfJDNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:39:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191004133906euoutp01cd4d154e5cdf220f053163f55aef424e~KdUIcuOi93138831388euoutp01W
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 13:39:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191004133906euoutp01cd4d154e5cdf220f053163f55aef424e~KdUIcuOi93138831388euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570196346;
        bh=7AAj0sml7sFRkH27RmrjsOJU2zDd+DyZOS5a3+EEhF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7l7ABt/vI2BG44GMwvZZ5dghWL4jZh6+rrC/y1qNMLchrbiFr6bLqybfsMunQJgX
         17MplQ72cS3NnI7v9kdyq8I15erM/jAjsAtEKc6cbXNB+IZrrijO56LCzL3iL5fYyz
         7JggnUmra/ivsbclteEQCywwJAnPk9zBrSxxZ944=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191004133906eucas1p25aca644bd77b214f3b7a20ce0b8c1497~KdUIKBjKx2107621076eucas1p2Z;
        Fri,  4 Oct 2019 13:39:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.65.04374.A7B479D5; Fri,  4
        Oct 2019 14:39:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191004133906eucas1p11441753ba77a4f8568da5b265b27fa1c~KdUH28so60859908599eucas1p1u;
        Fri,  4 Oct 2019 13:39:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191004133906eusmtrp1b24939f8c46bd9bc7845ffbc3c4888d2~KdUH2VGPi2256422564eusmtrp1c;
        Fri,  4 Oct 2019 13:39:06 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-01-5d974b7a115f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 59.4A.04117.A7B479D5; Fri,  4
        Oct 2019 14:39:06 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191004133905eusmtip2c7ca665666ad6d5410bd63db6a629115~KdUHbi9tC2524825248eusmtip2V;
        Fri,  4 Oct 2019 13:39:05 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, lukasz.luba@polnum.com
Cc:     b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [RFC 2/2] dirvers & fs: add sram driver and sramfs
Date:   Fri,  4 Oct 2019 15:38:55 +0200
Message-Id: <20191004133855.17474-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004133855.17474-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djPc7pV3tNjDe5dVrDYOGM9q8WtBhmL
        y7vmsFlMeveIyWLtkbvsFofftLM6sHkcfLeHyeNH50FGj74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4MqYu2IeS8G2/YwVN2f+Z2lgXDibsYuRk0NCwETi6qVG9i5GLg4hgRWMEi1nljFDOF8Y
        JU7NeQBWJSTwmVFiZScTTMf7/VcZIYqWM0p83DaZHa5j26aTQBkODjYBPYkdqwpBTBEBC4kn
        /eUgvcwCVRIHb/wEqxAWsJaYvy4CJMwioCpx/swMdhCbV8Be4ui838wQq+QlVm84AGZzCjhI
        bFl2gglkk4TAfTaJ90f+sUIUuUhsfz0bqkFY4tXxLewQtozE6ck9LBB2sURD70Koj2skHvfP
        haqxljh8/CIryD3MApoS63fpQ4QdJfZO6WQGCUsI8EnceCsIcT2fxKRt06HCvBIdbUIQ1RoS
        W3ouQANHTGL5mmnsECUeEtt+mEKCZjKjRO+3/8wTGOVnIexawMi4ilE8tbQ4Nz212DgvtVyv
        ODG3uDQvXS85P3cTIzARnP53/OsOxn1/kg4xCnAwKvHwzjCbHivEmlhWXJl7iFGCg1lJhPfS
        +imxQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhjPVh25
        prxgM29DbsGnzHsfZvE7fTvgs7ma00dE+OiSlj0xPzX+bn65656IyrIXrQpT3IvTV8c/vWg7
        O16N6ePMOUtX5Ugc2f+kdkV2KZfW1ytfTiiL/hMot9T/5NV7vPvF7xf19c/vzHTgFbrhpnLm
        xrvn8dNX+jZ+LbOdYV/RnH7lXewm9Tu2SizFGYmGWsxFxYkA4C9gHgADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t/xe7pV3tNjDc7f5rLYOGM9q8WtBhmL
        y7vmsFlMeveIyWLtkbvsFofftLM6sHkcfLeHyeNH50FGj74tqxg9Pm+SC2CJ0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuYu2IeS8G2/YwVN2f+
        Z2lgXDibsYuRk0NCwETi/f6rQDYXh5DAUkaJv2ufsEEkxCQm7dvODmELS/y51sUGUfSJUWLZ
        6u9ADgcHm4CexI5VhSA1IgJWEvPW/wLrZRaok2g4MJMdpERYwFpi/roIkDCLgKrE+TMzwEby
        CthLHJ33mxlivLzE6g0HwGxOAQeJLctOMIG0CgHVXP6lM4GRbwEjwypGkdTS4tz03GIjveLE
        3OLSvHS95PzcTYzA4Nx27OeWHYxd74IPMQpwMCrx8H6wmB4rxJpYVlyZe4hRgoNZSYT30vop
        sUK8KYmVValF+fFFpTmpxYcYTYFumsgsJZqcD4ycvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFC
        AumJJanZqakFqUUwfUwcnFINjIaZ4uEb/E/7cthdP3rmrbt/iIHCxosLd952nchvFLuli8/3
        oIplzRNRW1GFAE1R9uDG0nTPFe/mMRVsSv9+/dPOumihvoX8dWbRVzW17ReY+L+02ux6ojX+
        VmFl1ywZDnHv0KzyyHlhLRoxz/2EAzobJrHc2PB0v/Hse+tPzWRvEJkrorxbiaU4I9FQi7mo
        OBEAEUkk/2QCAAA=
X-CMS-MailID: 20191004133906eucas1p11441753ba77a4f8568da5b265b27fa1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191004133906eucas1p11441753ba77a4f8568da5b265b27fa1c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191004133906eucas1p11441753ba77a4f8568da5b265b27fa1c
References: <20191004133855.17474-1-l.luba@partner.samsung.com>
        <CGME20191004133906eucas1p11441753ba77a4f8568da5b265b27fa1c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for managing SRAM device toughether with dedicated file system.
It is a work-in-progress patch which combines driver and file system.
It was used for experiments and proof-of-concept.
It should be split, when I find the proper way to do it.
It also contains debugging prints which should be removed.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/misc/Kconfig       |   7 +
 drivers/misc/Makefile      |   1 +
 drivers/misc/sram.h        |   1 +
 drivers/misc/sram_direct.c | 863 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/magic.h |   1 +
 mm/memory.c                |   5 +-
 6 files changed, 877 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/sram_direct.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 16900357afc2..95d3dca149cb 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -443,6 +443,13 @@ config SRAM
 	  the genalloc API. It is supposed to be used for small on-chip SRAM
 	  areas found on many SoCs.
 
+config SRAM_DIRECT
+	bool "Driver for directly mapped on-chip SRAM"
+	select GENERIC_ALLOCATOR
+	help
+	  This driver allows you to declare a memory region to be managed
+	  directly into the process address space. TBD.
+
 config SRAM_EXEC
 	bool
 
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index abd8ae249746..d6cf888315e0 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_MEI)		+= mei/
 obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
+obj-$(CONFIG_SRAM_DIRECT)	+= sram_direct.o
 obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index 9c1d21ff7347..25f7507fb7e1 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -23,6 +23,7 @@ struct sram_dev {
 
 	struct sram_partition *partition;
 	u32 partitions;
+	phys_addr_t phys_base;
 };
 
 struct sram_reserve {
diff --git a/drivers/misc/sram_direct.c b/drivers/misc/sram_direct.c
new file mode 100644
index 000000000000..367060c65a88
--- /dev/null
+++ b/drivers/misc/sram_direct.c
@@ -0,0 +1,863 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Directly mapped SRAM driver inspired by generic on-chip SRAM allocation
+ * driver. It is also based on hugetlbfs, so proper copyrights
+ * are attached.
+ *
+ * Copyright (C) 2002 Linus Torvalds.
+ * Copyright (C) 2012 Philipp Zabel, Pengutronix
+ * Copyright (C) 2019 Lukasz Luba, Samsung Electronics Ltd.
+ */
+#define DEBUG 1
+
+#include <linux/clk.h>
+#include <linux/bitmap.h>
+#include <linux/delay.h>
+#include <linux/genalloc.h>
+#include <linux/io.h>
+#include <linux/kfifo.h>
+#include <linux/list_sort.h>
+#include <linux/highmem.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+
+#include "sram.h"
+
+#define SRAM_GRANULARITY	PAGE_SIZE
+#define SRAM_GRANULARITY_SHIFT	PAGE_SHIFT
+#define SRAM_DIRECT_MINOR	117
+
+struct sram_pool {
+	unsigned long *bitmap;
+	unsigned long base_pfn;
+	int nbits;
+	struct mutex lock;
+};
+
+struct sram_map {
+	unsigned long *bitmap;
+	int nbits;
+	atomic_t used;
+};
+
+struct remap_sram {
+	unsigned int size;
+	struct mm_struct *mm;
+	pgprot_t prot;
+	struct sram_map *sm;
+	int next_bit;
+};
+
+static struct sram_dev *sram_manager;
+static struct sram_pool sram_pool;
+
+static void sram_touch_test(struct sram_dev *sram)
+{
+	pr_info("SRAM: touch test begin\n");
+	writel(0x00112233, sram->virt_base);
+	pr_info("SRAM: touch test passed\n");
+}
+
+static void sram_vma_open(struct vm_area_struct *vma)
+{
+	pr_info("SRAM: vma opened\n");
+}
+
+static void sram_put_pfn(int bit_id)
+{
+	bitmap_clear(sram_pool.bitmap, bit_id, 1);
+}
+
+static void sram_vma_close(struct vm_area_struct *vma)
+{
+	struct sram_map *sm = vma->vm_private_data;
+	struct sram_map *inode_sm = NULL;
+	int id;
+	int next_bit = -1;
+	struct inode *inode = file_inode(vma->vm_file);
+
+	pr_info("SRAM: vma closing...\n");
+
+	if (inode) {
+		inode_sm = inode->i_private;
+
+		/*
+		 * Do not free the pfn to global pool if it is not the last
+		 * one.
+		 */
+		if (atomic_dec_return(&sm->used))
+			return;
+	} else {
+		return;
+	}
+
+	mutex_lock(&sram_pool.lock);
+	while (1) {
+		next_bit = find_next_bit(sm->bitmap, sm->nbits, next_bit + 1);
+		pr_info("SRAM: bit_id=%d\n", next_bit);
+		if (next_bit >= sm->nbits)
+			break;
+
+		sram_put_pfn(next_bit);
+	}
+	mutex_unlock(&sram_pool.lock);
+
+	kfree(sm->bitmap);
+	kfree(sm);
+}
+
+static vm_fault_t sram_vm_fault(struct vm_fault *vmf)
+{
+	return VM_FAULT_SIGBUS;
+}
+
+static const struct vm_operations_struct sram_vm_ops = {
+	.open = sram_vma_open,
+	.close = sram_vma_close,
+	.fault = sram_vm_fault,
+};
+
+#define CB (BIT(3) | BIT(2))
+#define AP (BIT(5) | BIT(4))
+#define TEX (BIT(8) | BIT(7) | BIT(6))
+#define APX (0)
+#define SRAM_PTE_ATTR (BIT(11) | BIT(10) | APX | TEX | AP | CB | BIT(1) | BIT(0))
+
+static void dump_writen_pte(pte_t *ptep)
+{
+	u32 *hw_pte = ptep + (2048 / sizeof(pte_t));
+	u32 pteval;
+	u32 hwpteval;
+
+	pteval = *ptep;
+	hwpteval = *hw_pte;
+
+	pr_info("SRAM: ptep=%px *ptep=%#x hwpte=%px *hwpte=%#x\n",
+		ptep, pteval, hw_pte, hwpteval);
+}
+
+static unsigned long sram_get_pfn(struct sram_map *sm, int next_bit)
+{
+	unsigned long sram_pfn;
+	unsigned long nbits = sm->nbits;
+
+	if (next_bit < -1 || next_bit >= nbits)
+		return -EINVAL;
+
+	next_bit = find_next_bit(sm->bitmap, nbits, next_bit + 1);
+	if (next_bit >= nbits) {
+		return -ENOMEM;
+	}
+
+	sram_pfn = sram_pool.base_pfn + next_bit * SRAM_GRANULARITY;
+
+	pr_info("SRAM: bit_id=%d\n", next_bit);
+	pr_info("SRAM: base=%#lx allocated pfn=%#lx\n",
+	       sram_pool.base_pfn, sram_pfn);
+
+	return sram_pfn;
+
+
+}
+
+static int remap_sram(pte_t *pte, unsigned long addr, void *data)
+{
+	struct remap_sram *rs = data;
+	unsigned long sram_pfn;
+	int sram_pfn_bit;
+	pte_t sram_pte;
+	pgd_t *pgd_base;
+	unsigned long pgd_v;
+	u32 idx_pgd = (addr & 0xfff00000) >> 20;
+	u32 idx_pte = (addr & 0x000ff000) >> 12;
+	u32 *pgd_ent;
+	u32 *pte_base;
+	u32 *pgd_u;
+	u32 *hw_pte = pte + (2048 / sizeof(pte_t));
+	u32 *pte_v = pte_val(pte);
+	pte_t *ptep;
+	pgd_t *pgd = pgd_offset(rs->mm, addr);
+	p4d_t *p4d = p4d_offset(pgd, addr);
+	pud_t *pud = pud_offset(p4d, addr);
+	pmd_t *pmd = pmd_offset(pud, addr);
+	/* struct page *page = alloc_page(GFP_KERNEL); */
+
+	pgd_base = cpu_get_pgd();
+	pgd_v = pgd_val(pgd_base);
+	pgd_u = (u32 *)pgd_v;
+
+	ptep = pte_val(pte);
+	/* ptep = pte_offset_map(pmd, addr); */
+
+	/* sram_pte = rs->sram_pfn | SRAM_PTE_ATTR; */
+
+	sram_pfn_bit = sram_get_pfn(rs->sm, rs->next_bit);
+
+	if (sram_pfn_bit == -EINVAL)
+		return -EINVAL;
+
+	sram_pfn = sram_pool.base_pfn + sram_pfn_bit * SRAM_GRANULARITY;
+	sram_pte = sram_pfn | rs->prot;
+
+	rs->next_bit = sram_pfn_bit;
+
+	/* sram_pte = page_to_phys(page) | rs->prot; */
+
+	pr_info("SRAM: pgdt=%px pgdt=%x pgd_val=%lx pte=%px sram_pte=%#x for addr=%#lx\n",
+	       pgd_base, pgd_base, pgd_v, pte, sram_pte, addr);
+
+	pr_info("SRAM: idx_pgd=%d idx_pte=%d\n", idx_pgd, idx_pte);
+
+	pr_info("SRAM: pte_val(pte)=%x pte_val(pte)=%px __va(pte)=%px __pa(pte)=%x\n",
+		pte_v, pte_v, __va(pte), __pa(pte));
+
+	/* pr_info("SRAM: pmd=%x __va(pmd)=%p __pa(pmd)=%x\n", pmd, */
+	/* 	__va(pmd), __pa(pmd)); */
+
+	/* pr_info("SRAM: pud=%px pmd=%px ptep=%px\n", pud, pmd, ptep); */
+	pr_info("SRAM: ptep=%px\n", ptep);
+
+	pr_info("SRAM: hw_pte=%px, __va(hw_pte)=%px __pa(hw_pte)=%x\n", hw_pte,
+		__va(hw_pte), __pa(hw_pte));
+	pr_info("SRAM: __pgprot=%x\n", rs->prot);
+	/*
+	 * This special PTEs are not associated with any struct page since
+	 * they point into SRAM memory region.
+	 */
+	/* set_pte_at(rs->mm, addr, pte, pte_mkspecial(sram_pte)); */
+	set_pte_at(rs->mm, addr, ptep, sram_pte);
+	/* rs->sram_pfn++; */
+
+	// workaround the zap_pfn_range() check
+	/* *ptep |= L_PTE_NONE; */
+	/* pr_info("SRAM: *ptep _pgprot=%x\n", *ptep); */
+
+	dump_writen_pte(ptep);
+
+	*hw_pte &= ~(1 << 9);
+	/* *hw_pte &= ~(1 << 3); //clean C cache flag */
+	dump_writen_pte(ptep);
+
+	return 0;
+}
+
+static unsigned long sram_alloc_pfn(struct sram_map *sm)
+{
+	unsigned long sram_pfn;
+	unsigned long nbits = sram_pool.nbits;
+	unsigned long next_zero_bit = 0;
+
+	mutex_lock(&sram_pool.lock);
+
+	next_zero_bit = find_next_zero_bit(sram_pool.bitmap, nbits, 0);
+	if (next_zero_bit >= nbits) {
+		mutex_unlock(&sram_pool.lock);
+		return -ENOMEM;
+	}
+
+	bitmap_set(sram_pool.bitmap, next_zero_bit, 1);
+	bitmap_set(sm->bitmap, next_zero_bit, 1);
+
+	mutex_unlock(&sram_pool.lock);
+
+	sram_pfn = sram_pool.base_pfn + next_zero_bit * SRAM_GRANULARITY;
+
+	pr_info("SRAM: bit_id=%d\n", next_zero_bit);
+	pr_info("SRAM: base=%#lx allocated pfn=%#lx\n",
+	       sram_pool.base_pfn, sram_pfn);
+
+	return sram_pfn;
+}
+
+static int sram_populate_vma(struct vm_area_struct *vma, struct sram_dev *sram)
+{
+	struct sram_map *sm = vma->vm_private_data;
+	u64 req_len;
+	u64 req_size;
+	struct remap_sram rs;
+	int ret;
+
+	req_size = vma->vm_end - vma->vm_start;
+	req_len = req_size >> SRAM_GRANULARITY_SHIFT;
+
+	rs.mm = vma->vm_mm;
+	rs.size = req_size;
+	rs.prot = __pgprot(pgprot_val(vma->vm_page_prot));
+
+	rs.sm = sm;
+	rs.next_bit = -1;
+
+	ret = apply_to_page_range(vma->vm_mm, vma->vm_start, rs.size,
+				  remap_sram, &rs);
+	if (ret) {
+		zap_vma_ptes(vma, vma->vm_start, 1);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sram_misc_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct sram_dev *sram = filp->private_data;
+	unsigned int index;
+	u64 req_len;
+
+	pr_info("SRAM: %s\n", __func__);
+
+	vma->vm_ops = &sram_vm_ops;
+	vma->vm_private_data = sram;
+
+	/*
+	 * We are dealing with Page-ranges managed without "struct page",
+	 * just pure PFN. Thus, set appropriate flags so the clean-up code
+	 * will handle it correctly.
+	 */
+	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_flags |= VM_MIXEDMAP;
+
+	/* if (vma->vm_mm) { */
+	/* 	down_read(&vma->vm_mm->mmap_sem); */
+	/* } */
+
+	/* if (vma->vm_end - vma->vm_start < PAGE_SIZE) */
+	/* 	return -EFAULT; */
+
+	req_len = vma->vm_end - vma->vm_start;
+	req_len >>= SRAM_GRANULARITY_SHIFT;
+
+	sram_populate_vma(vma, sram);
+
+	pr_info("SRAM: mmap area start=%#lx end=%#lx req_len=%llu\n", vma->vm_start,
+		vma->vm_end, req_len);
+
+	/* if (vma->vm_mm) { */
+	/* 	up_read(&vma->vm_mm->mmap_sem); */
+	/* } */
+
+	return 0;
+}
+
+static int sram_misc_open(struct inode *nodp, struct file *filp)
+{
+	struct sram_dev *sram = filp->private_data;
+
+	pr_info("SRAM: %s\n", __func__);
+
+	return 0;
+}
+
+static int sram_misc_release(struct inode *nodp, struct file *filp)
+{
+	struct sram_dev *sram = filp->private_data;
+
+	pr_info("SRAM: %s\n", __func__);
+	return 0;
+}
+
+static loff_t sram_misc_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file_inode(file);
+	loff_t retval;
+
+
+	pr_info("SRAM: %s offset=%llu whence=%d\n", __func__, offset, whence);
+
+	return offset;
+}
+
+static void sram_free_partitions(struct sram_dev *sram)
+{
+	struct sram_partition *part;
+
+	if (!sram->partitions)
+		return;
+
+	part = &sram->partition[sram->partitions - 1];
+	for (; sram->partitions; sram->partitions--, part--) {
+		if (part->battr.size)
+			device_remove_bin_file(sram->dev, &part->battr);
+
+		if (part->pool &&
+		    gen_pool_avail(part->pool) < gen_pool_size(part->pool))
+			dev_err(sram->dev, "removed pool while SRAM allocated\n");
+	}
+}
+
+static const struct file_operations sram_misc_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= sram_misc_llseek,
+	/* .read		= sram_misc_read, */
+	/* .write		= sram_misc_write, */
+	/* .unlocked_ioctl	= sram_misc_ioctl, */
+	.mmap		= sram_misc_mmap,
+	.open		= sram_misc_open,
+	.release	= sram_misc_release,
+};
+
+static struct miscdevice sram_direct_misc = {
+	SRAM_DIRECT_MINOR,
+	"sram_direct_misc",
+	&sram_misc_fops,
+};
+
+static const struct of_device_id sram_dt_ids[] = {
+	{ .compatible = "direct-sram" },
+	{}
+};
+
+static int sram_probe(struct platform_device *pdev)
+{
+	struct sram_dev *sram;
+	struct resource *res;
+	size_t size;
+	int ret;
+	int (*init_func)(void);
+
+	pr_info("SRAM: init direct mapped on-chip SRAM\n");
+
+	mutex_init(&sram_pool.lock);
+
+	sram = devm_kzalloc(&pdev->dev, sizeof(*sram), GFP_KERNEL);
+	if (!sram)
+		return -ENOMEM;
+
+	sram->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(sram->dev, "found no memory resource\n");
+		return -EINVAL;
+	}
+
+	size = resource_size(res);
+
+	if (!devm_request_mem_region(sram->dev, res->start, size, pdev->name)) {
+		dev_err(sram->dev, "could not request region for resource\n");
+		return -EBUSY;
+	}
+        /*  */
+	/* if (of_property_read_bool(pdev->dev.of_node, "no-memory-wc")) */
+	/* 	sram->virt_base = devm_ioremap(sram->dev, res->start, size); */
+	/* else */
+	/* 	sram->virt_base = devm_ioremap_wc(sram->dev, res->start, size); */
+	/* if (!sram->virt_base) */
+	/* 	return -ENOMEM; */
+
+
+	/* sram->pool = devm_gen_pool_create(sram->dev, ilog2(SRAM_GRANULARITY), */
+	/* 				  NUMA_NO_NODE, NULL); */
+	/* if (IS_ERR(sram->pool)) */
+	/* 	return PTR_ERR(sram->pool); */
+
+	sram_pool.nbits = size / SRAM_GRANULARITY;
+
+	sram_pool.bitmap = kzalloc(BITS_TO_LONGS(sram_pool.nbits) *
+				   sizeof(long), GFP_KERNEL);
+	if (!sram_pool.bitmap) {
+		dev_err(sram->dev, "could not allocate memory\n");
+		return -ENOMEM;
+	}
+
+	sram_pool.base_pfn = res->start;
+	sram->phys_base = res->start;
+
+	pr_info("SRAM: resource start=%#lx size=%dKB pages=%lu\n",
+		sram_pool.base_pfn, size >> 10, sram_pool.nbits);
+
+	sram->clk = devm_clk_get(sram->dev, NULL);
+	if (IS_ERR(sram->clk)) {
+		sram->clk = NULL;
+		dev_info(sram->dev, "No clock source\n");
+	} else {
+		clk_prepare_enable(sram->clk);
+	}
+
+	platform_set_drvdata(pdev, sram);
+
+	ret = misc_register(&sram_direct_misc);
+	if (ret) {
+		dev_err(sram->dev, "Couldn't create misc device %d\n", ret);
+		goto err_free_partitions;
+	}
+
+	/* dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n", */
+	/* 	gen_pool_size(sram->pool) / 1024, sram->virt_base); */
+
+	pr_info("SRAM: on-chip SRAM phys_base=%#x\n", sram->phys_base);
+
+	/* sram_touch_test(sram); */
+
+	/* Just for testing with sramfs */
+	sram_manager = sram;
+
+	return 0;
+
+err_free_partitions:
+	sram_free_partitions(sram);
+err_disable_clk:
+	if (sram->clk)
+		clk_disable_unprepare(sram->clk);
+
+	return ret;
+}
+
+static int sram_remove(struct platform_device *pdev)
+{
+	struct sram_dev *sram = platform_get_drvdata(pdev);
+
+	sram_free_partitions(sram);
+
+	if (gen_pool_avail(sram->pool) < gen_pool_size(sram->pool))
+		dev_err(sram->dev, "removed while SRAM allocated\n");
+
+	if (sram->clk)
+		clk_disable_unprepare(sram->clk);
+
+	return 0;
+}
+
+static struct platform_driver sram_driver = {
+	.driver = {
+		.name = "sram_direct",
+		.of_match_table = sram_dt_ids,
+	},
+	.probe = sram_probe,
+	.remove = sram_remove,
+};
+
+static int __init sram_init(void)
+{
+	return platform_driver_register(&sram_driver);
+}
+
+device_initcall(sram_init);
+
+
+/*
+ * //////////// fs part starts here (temporary) ///////////////////
+ */
+
+#include <linux/fs.h>
+#include <linux/magic.h>
+#include <linux/parser.h>
+#include <linux/seq_file.h>
+
+#define SRAMFS_DEFAULT_MODE	0755
+
+struct sramfs_mount_opts {
+	umode_t mode;
+};
+
+struct sramfs_info {
+	struct sramfs_mount_opts mount_opts;
+};
+
+static const match_table_t tokens = {
+	{0, "mode=%o"},
+	{1, NULL}
+};
+
+static const struct inode_operations sramfs_dir_inode_ops;
+static const struct super_operations sramfs_ops;
+
+static int sramfs_file_open(struct inode *nodp, struct file *filp)
+{
+	struct sram_dev *sram = filp->private_data;
+
+	pr_info("SRAMFS: %s\n", __func__);
+
+	return 0;
+}
+
+static int sramfs_file_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(filp);
+	struct sram_map *sm;
+	int req_len;
+	int ret;
+
+	pr_info("SRAMFS: %s\n", __func__);
+
+	/* It must be align to page size */
+	if (vma->vm_pgoff & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	inode_lock(inode);
+
+	if (!inode->i_private) {
+		sm = kzalloc(sizeof(struct sram_map), GFP_KERNEL);
+		if (!sm) {
+			pr_err("SRAMFS: could not allocate memory\n");
+			return -ENOMEM;
+		}
+
+		req_len = vma->vm_end - vma->vm_start;
+		req_len >>= SRAM_GRANULARITY_SHIFT;
+
+		sm->nbits = sram_pool.nbits;
+		sm->bitmap = kzalloc(BITS_TO_LONGS(sm->nbits) * sizeof(long),
+				     GFP_KERNEL);
+		if (!sm->bitmap) {
+			pr_err("SRAMFS: could not allocate memory\n");
+			return -ENOMEM;
+		}
+
+		inode->i_private = sm;
+	} else {
+		sm = inode->i_private;
+	}
+
+	atomic_inc(&sm->used);
+
+	vma->vm_ops = &sram_vm_ops;
+	vma->vm_private_data = sm;
+
+	/*
+	 * We are dealing with Page-ranges managed without "struct page",
+	 * just pure PFN. Thus, set appropriate flags so the clean-up code
+	 * will handle it correctly.
+	 */
+	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_flags |= VM_DONTEXPAND;
+
+	file_accessed(filp);
+
+	sram_populate_vma(vma, sram_manager);
+
+	inode_unlock(inode);
+
+	pr_info("SRAM: mmap area start=%#lx end=%#lx\n", vma->vm_start,
+		vma->vm_end);
+
+	return 0;
+}
+
+const struct file_operations sramfs_file_ops = {
+	.open		= sramfs_file_open,
+	.read_iter	= generic_file_read_iter,
+	.write_iter	= generic_file_write_iter,
+	.mmap		= sramfs_file_mmap,
+	.fsync		= noop_fsync,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
+	.llseek		= generic_file_llseek,
+};
+
+const struct inode_operations sramfs_file_inode_ops = {
+	.setattr	= simple_setattr,
+	.getattr	= simple_getattr,
+};
+//////////////address space operations ////////////////
+
+static const struct address_space_operations sramfs_aops = {
+};
+
+struct inode *sramfs_get_inode(struct super_block *sb, const struct inode *dir,
+			       umode_t mode, dev_t dev)
+{
+	struct inode *inode = new_inode(sb);
+	struct timespec64 curr_time;
+
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode_init_owner(inode, dir, mode);
+		inode->i_mapping->a_ops = &sramfs_aops;
+
+		curr_time = current_time(inode);
+		inode->i_atime = curr_time;
+		inode->i_mtime = curr_time;
+		inode->i_ctime = curr_time;
+		inode->i_private = NULL;
+
+		switch (mode & S_IFMT) {
+		case S_IFREG:
+			inode->i_op = &sramfs_file_inode_ops;
+			inode->i_fop = &sramfs_file_ops;
+			break;
+		case S_IFDIR:
+			inode->i_op = &sramfs_dir_inode_ops;
+			inode->i_fop = &simple_dir_operations;
+
+			inc_nlink(inode);
+			break;
+		case S_IFLNK:
+			inode->i_op = &page_symlink_inode_operations;
+			inode_nohighmem(inode);
+			break;
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+		}
+	}
+
+	return inode;
+}
+
+///////////// mount option section /////////////////
+
+static int sramfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct sramfs_info *fs_info = root->d_sb->s_fs_info;
+
+	if (fs_info->mount_opts.mode != SRAMFS_DEFAULT_MODE)
+		seq_printf(m, ",mode=%o", fs_info->mount_opts.mode);
+	return 0;
+}
+
+static int sramfs_parse_options(char *data, struct sramfs_mount_opts *opts)
+{
+	substring_t args[MAX_OPT_ARGS];
+	int option;
+	int token;
+	char *p;
+
+	opts->mode = SRAMFS_DEFAULT_MODE;
+
+	while ((p = strsep(&data, ",")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, tokens, args);
+
+		/* We only support one option: 'mode=%o'. */
+		switch (token) {
+		case 0:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->mode = option & S_IALLUGO;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static const struct super_operations sramfs_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+	.show_options	= sramfs_show_options,
+};
+
+/*///////////// fs section /////////////// */
+static int sramfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
+		       dev_t dev)
+{
+	struct inode *inode = sramfs_get_inode(dir->i_sb, dir, mode, dev);
+	int ret = -ENOSPC;
+
+	if (inode) {
+		d_instantiate(dentry, inode);
+		dget(dentry);
+		ret = 0;
+		dir->i_mtime = dir->i_ctime = current_time(dir);
+	}
+
+	return ret;
+}
+
+
+static int sramfs_mkdir(struct inode * dir, struct dentry *dentry, umode_t mode)
+{
+	int ret;
+
+	ret = sramfs_mknod(dir, dentry, mode | S_IFDIR, 0);
+	if (!ret)
+		inc_nlink(dir);
+
+	return ret;
+}
+
+static int sramfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
+			 bool excl)
+{
+	return sramfs_mknod(dir, dentry, mode | S_IFREG, 0);
+}
+
+static int sramfs_symlink(struct inode * dir, struct dentry *dentry,
+			  const char *symname)
+{
+	return 0;
+}
+
+static const struct inode_operations sramfs_dir_inode_ops = {
+	.create		= sramfs_create,
+	.lookup		= simple_lookup,
+	.link		= simple_link,
+	.unlink		= simple_unlink,
+	.symlink	= sramfs_symlink,
+	.mkdir		= sramfs_mkdir,
+	.rmdir		= simple_rmdir,
+	.mknod		= sramfs_mknod,
+	.rename		= simple_rename,
+};
+
+/*///////////// Super section /////////////// */
+
+int sramfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct sramfs_info *fs_info;
+	struct inode *inode;
+	int err;
+
+	fs_info = kzalloc(sizeof(struct sramfs_info), GFP_KERNEL);
+	if (!fs_info)
+		return -ENOMEM;
+
+	sb->s_fs_info = fs_info;
+
+	err = sramfs_parse_options(data, &fs_info->mount_opts);
+	if (err)
+		return err;
+
+	sb->s_maxbytes		= MAX_LFS_FILESIZE;
+	sb->s_blocksize		= PAGE_SIZE;
+	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_magic		= SRAMFS_MAGIC;
+	sb->s_op		= &sramfs_ops;
+	sb->s_time_gran		= 1;
+
+	inode = sramfs_get_inode(sb, NULL,
+				 fs_info->mount_opts.mode | S_IFDIR, 0);
+
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+struct dentry *sramfs_mount(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return mount_nodev(fs_type, flags, data, sramfs_fill_super);
+}
+
+static void sramfs_kill_sb(struct super_block *sb)
+{
+	kfree(sb->s_fs_info);
+	kill_litter_super(sb);
+}
+
+static struct file_system_type sramfs_type = {
+	.name		= "sramfs",
+	.mount		= sramfs_mount,
+	.kill_sb	= sramfs_kill_sb,
+	.fs_flags	= FS_USERNS_MOUNT,
+};
+
+static int __init sramfs_init(void)
+{
+	return register_filesystem(&sramfs_type);
+}
+
+fs_initcall(sramfs_init);
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 1274c692e59c..4d010b70594f 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -14,6 +14,7 @@
 #define SELINUX_MAGIC		0xf97cff8c
 #define SMACK_MAGIC		0x43415d53	/* "SMAC" */
 #define RAMFS_MAGIC		0x858458f6	/* some random number */
+#define SRAMFS_MAGIC		0x11171923	/* some random number */
 #define TMPFS_MAGIC		0x01021994
 #define HUGETLBFS_MAGIC 	0x958458f6	/* some random number */
 #define SQUASHFS_MAGIC		0x73717368
diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..2d6f2fbf7185 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1023,8 +1023,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = *pte;
-		if (pte_none(ptent))
+		if (pte_none(ptent)) {
+			if (ptent)
+				pr_info("MM: pte not valid pte=%x\n", ptent);
 			continue;
+		}
 
 		if (pte_present(ptent)) {
 			struct page *page;
-- 
2.17.1

