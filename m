Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382C8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F1A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mLYm6//m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jH1N+Mo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfCYJXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:23:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55708 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfCYJXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553505802; x=1585041802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p8hV1YEPcNWXPZtbviU/3u0iQGTcQZdZ0Homvt7+Ywk=;
  b=mLYm6//mYokIcwSFFYo9gy5sfQRoZo2ZqBBuZddlr3eqGHazLkXpv4yF
   q+zWiDKclsEISj6ddKMA3RHt9A2iqkq0zsObAOIp33xgfpADOQqUpOxJD
   xdYEHiKrn52eDhSLxcfp1Oug1wu6+DIKj01XWzKDOepRApqdmIYvAngCb
   /NOpFts6TFmvPTfuJpGShNXAKBzOyJlHi7vt0LYTUkMFceSSQFKwUYLEc
   OsupDYVUj1JL49vJdRo9Zk7t95Fv7YXjhsGEcWbihzyNKlwN7ajt7hTAj
   ldH5WTLDo1GygpfROSHaU1ca8R0CorIMHjM0anW0ERjIgqtrirX1STVez
   g==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105502433"
Received: from mail-co1nam05lp2056.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.56])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 17:23:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQEIPE/k//y+VBvntM08YlzdX4NywZDNYMXYu2Y9nno=;
 b=jH1N+Mo6NIZFS62GVJnYQpFV5q3NejSTVBwDLL2w3dhhWjzUhU5wrNDqvgI2DSdM11PeGj3rmruS56Wpme7hLrsM3eYSxLyporZuY8h8nvyPGLg9o0qs/4SGMBcef9dQ6J0FTv+VG3gSCQk/M82okmsHpakz54kCBGOu02zZCQI=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5838.namprd04.prod.outlook.com (20.179.22.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 09:23:18 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 09:23:18 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned
 address
Thread-Topic: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned
 address
Thread-Index: AQHU4uxi3qM2aSnJoUC7kMYnT9meuQ==
Date:   Mon, 25 Mar 2019 09:23:18 +0000
Message-ID: <20190325092234.5451-5-anup.patel@wdc.com>
References: <20190325092234.5451-1-anup.patel@wdc.com>
In-Reply-To: <20190325092234.5451-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::23) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3c1159d-c5bf-49c7-4c0c-08d6b1038459
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB5838;
x-ms-traffictypediagnostic: MN2PR04MB5838:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB58380F6DEA8A569DCDC2B6CB8D5E0@MN2PR04MB5838.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(6506007)(7736002)(71190400001)(71200400001)(53946003)(106356001)(105586002)(86362001)(102836004)(8936002)(54906003)(110136005)(305945005)(25786009)(26005)(4326008)(2616005)(68736007)(476003)(446003)(1076003)(30864003)(6436002)(486006)(256004)(14444005)(478600001)(97736004)(81166006)(81156014)(186003)(6512007)(76176011)(14454004)(2906002)(5660300002)(6486002)(8676002)(52116002)(2171002)(11346002)(66066001)(316002)(72206003)(36756003)(44832011)(50226002)(53936002)(99286004)(3846002)(386003)(6116002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5838;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FokdkmvIu6cld81M4GrusmV0StIdzn4+9DhrWQJZH/Vr4EzTtjD+IXN0U01MgkczwAk0cRzm4lVbr2pzT7HFAKeR99wrO+DOoGgN91xIOhJBtCe3IB2Gnkda4iXtnpOuUV+reBmGMnBN6p6WZHky93QZW81C8iTmHzoojd9f+KA1hkVP75XWARpKGvapSMeg+MLXCTPvqHsbqrxfZVRO97tVUSyOdMgL8R9pj7zKSnWhG6jNL965LgNA5sEz8zHwSx4Ft3Qg0Dlld6PYtcxmU9NNbx/90EBEtgj4l8PJY1wQiL4c9EBgZJtWPOt79BgahXm0FaAUnBhc4rEomkskc0SBZStLyE8SuGoN34umTfV9b+oG447iePTPURI8ylr3UDs3lmksxe0a546dPGyOCj5xTmt8sP+mJkSS9Mgn7Sw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c1159d-c5bf-49c7-4c0c-08d6b1038459
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 09:23:18.6489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we have to boot RISCV64 kernel from a 2MB aligned physical
address and RISCV32 kernel from a 4MB aligned physical address. This
constraint is because initial pagetable setup (i.e. setup_vm()) maps
entire RAM using hugepages (i.e. 2MB for 3-level pagetable and 4MB for
2-level pagetable).

Further, the above booting contraint also results in memory wastage
because if we boot kernel from some <xyz> address (which is not same as
RAM start address) then RISCV kernel will map PAGE_OFFSET virtual address
lineraly to <xyz> physical address and memory between RAM start and <xyz>
will be reserved/unusable.

For example, RISCV64 kernel booted from 0x80200000 will waste 2MB of RAM
and RISCV32 kernel booted from 0x80400000 will waste 4MB of RAM.

This patch re-writes the initial pagetable setup code to allow booting
RISV32 and RISCV64 kernel from any 4KB (i.e. PAGE_SIZE) aligned address.

To achieve this:
1. We add kconfig option BOOT_PAGE_ALIGNED. When it is enabled we use
   4KB mappings in initial page table setup otherwise we use 2MB/4MB
   mappings.
2. We map kernel and dtb (few MBs) in setup_vm() (called from head.S)
3. Once we reach paging_init() (called from setup_arch()) after
   memblock setup, we map all available memory banks.

With this patch in-place, the booting constraint for RISCV32 and RISCV64
kernel is much more relaxed when CONFIG_BOOT_PAGE_ALIGNED=3Dy and we can
now boot kernel very close to RAM start thereby minimizng memory wastage.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                  |  12 +
 arch/riscv/include/asm/fixmap.h     |   5 +
 arch/riscv/include/asm/pgtable-64.h |   5 +
 arch/riscv/include/asm/pgtable.h    |   5 +
 arch/riscv/kernel/head.S            |   1 +
 arch/riscv/kernel/setup.c           |   4 +-
 arch/riscv/mm/init.c                | 351 ++++++++++++++++++++++++----
 7 files changed, 335 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb56c82d8aa1..d7812b1f7c7e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -172,6 +172,18 @@ config SMP
=20
 	  If you don't know what to do here, say N.
=20
+config BOOT_PAGE_ALIGNED
+	bool "Allow booting from page aligned address"
+	default n
+	help
+	  This enables support for booting the kernel from any page aligned
+	  address (i.e. 4KB aligned). This option is particularly useful on
+	  systems with a very small RAM (few MBs) as we can boot the kernel
+	  closer to the RAM start address, thereby reducing the amount of
+	  unusable RAM below the kernel.
+
+	  If you don't know what to do here, say N.
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixma=
p.h
index c207f6634b91..9c66033c3a54 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -21,6 +21,11 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
+#define FIX_FDT_SIZE	SZ_1M
+	FIX_FDT_END,
+	FIX_FDT =3D FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
+	FIX_PTE,
+	FIX_PMD,
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_fixed_addresses
 };
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/p=
gtable-64.h
index 7aa0ea9bd8bb..56ecc3dc939d 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -78,6 +78,11 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t =
prot)
 	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
=20
+static inline unsigned long _pmd_pfn(pmd_t pmd)
+{
+	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
+}
+
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
=20
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index 1141364d990e..c4968b47c37d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -127,6 +127,11 @@ static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_=
t prot)
 	return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
=20
+static inline unsigned long _pgd_pfn(pgd_t pgd)
+{
+	return pgd_val(pgd) >> _PAGE_PFN_SHIFT;
+}
+
 #define pgd_index(addr) (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
=20
 /* Locate an entry in the page global directory */
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 3449671ec867..61e253ae38b4 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -62,6 +62,7 @@ clear_bss_done:
=20
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
+	mv a0, s1
 	call setup_vm
 	call relocate
=20
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 540a331d1376..79670458527d 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -30,6 +30,7 @@
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
=20
+#include <asm/fixmap.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
@@ -54,7 +55,8 @@ unsigned long boot_cpu_hartid;
=20
 void __init parse_dtb(unsigned int hartid, void *dtb)
 {
-	if (early_init_dt_scan(__va(dtb)))
+	dtb =3D (void *)fix_to_virt(FIX_FDT) + ((uintptr_t)dtb & ~PAGE_MASK);
+	if (early_init_dt_scan(dtb))
 		return;
=20
 	pr_err("No DTB passed to the kernel\n");
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f9add4381c73..56970dab3727 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1,14 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2012 Regents of the University of California
- *
- *   This program is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License
- *   as published by the Free Software Foundation, version 2.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
  */
=20
 #include <linux/init.h>
@@ -49,13 +42,6 @@ void setup_zero_page(void)
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 }
=20
-void __init paging_init(void)
-{
-	setup_zero_page();
-	local_flush_tlb_all();
-	zone_sizes_init();
-}
-
 void __init mem_init(void)
 {
 #ifdef CONFIG_FLATMEM
@@ -152,16 +138,28 @@ EXPORT_SYMBOL(va_pa_offset);
 unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
=20
+#define MAX_EARLY_MAPPING_SIZE	SZ_128M
+
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
=20
 #ifndef __PAGETABLE_PMD_FOLDED
-#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
-pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned=
_bss;
+#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
+#define NUM_SWAPPER_PMDS	1UL
+#else
+#define NUM_SWAPPER_PMDS	(MAX_EARLY_MAPPING_SIZE/PGDIR_SIZE)
+#endif
+pmd_t swapper_pmd[PTRS_PER_PMD*NUM_SWAPPER_PMDS] __page_aligned_bss;
 pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
+#define NUM_SWAPPER_PTES	(MAX_EARLY_MAPPING_SIZE/PMD_SIZE)
+#else
+#define NUM_SWAPPER_PTES	(MAX_EARLY_MAPPING_SIZE/PGDIR_SIZE)
 #endif
=20
+pte_t swapper_pte[PTRS_PER_PTE*NUM_SWAPPER_PTES] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
=20
+static uintptr_t map_size;
+
 void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t pro=
t)
 {
 	unsigned long addr =3D __fix_to_virt(idx);
@@ -179,6 +177,201 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr=
_t phys, pgprot_t prot)
 	}
 }
=20
+struct mapping_ops {
+	pte_t *(*get_pte_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pte)(uintptr_t va);
+	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pmd)(uintptr_t va);
+};
+
+static phys_addr_t __init final_alloc_pgtable(void)
+{
+	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+}
+
+static pte_t *__init early_get_pte_virt(phys_addr_t pa)
+{
+	return (pte_t *)((uintptr_t)pa);
+}
+
+static pte_t *__init final_get_pte_virt(phys_addr_t pa)
+{
+	clear_fixmap(FIX_PTE);
+
+	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
+}
+
+static phys_addr_t __init early_alloc_pte(uintptr_t va)
+{
+	pte_t *base =3D swapper_pte;
+	uintptr_t pte_num =3D ((va - PAGE_OFFSET) >> PMD_SHIFT);
+
+	BUG_ON(pte_num >=3D NUM_SWAPPER_PTES);
+
+	return (uintptr_t)&base[pte_num * PTRS_PER_PTE];
+}
+
+static phys_addr_t __init final_alloc_pte(uintptr_t va)
+{
+	return final_alloc_pgtable();
+}
+
+static void __init create_pte_mapping(pte_t *ptep,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot)
+{
+	uintptr_t pte_index =3D pte_index(va);
+
+	BUG_ON(sz !=3D PAGE_SIZE);
+
+	if (pte_none(ptep[pte_index]))
+		ptep[pte_index] =3D pfn_pte(PFN_DOWN(pa), prot);
+}
+
+#ifndef __PAGETABLE_PMD_FOLDED
+static pmd_t *__init early_get_pmd_virt(phys_addr_t pa)
+{
+	return (pmd_t *)((uintptr_t)pa);
+}
+
+static pmd_t *__init final_get_pmd_virt(phys_addr_t pa)
+{
+	clear_fixmap(FIX_PMD);
+
+	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
+}
+
+static phys_addr_t __init early_alloc_pmd(uintptr_t va)
+{
+	pmd_t *base =3D swapper_pmd;
+	uintptr_t pmd_num =3D (va - PAGE_OFFSET) >> PGDIR_SHIFT;
+
+	BUG_ON(pmd_num >=3D NUM_SWAPPER_PMDS);
+
+	return (uintptr_t)&base[pmd_num * PTRS_PER_PMD];
+}
+
+static phys_addr_t __init final_alloc_pmd(uintptr_t va)
+{
+	return final_alloc_pgtable();
+}
+
+static void __init create_pmd_mapping(pmd_t *pmdp,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot,
+				      struct mapping_ops *ops)
+{
+	pte_t *ptep;
+	phys_addr_t pte_phys;
+	uintptr_t pmd_index =3D pmd_index(va);
+
+	if (sz =3D=3D PMD_SIZE) {
+		if (pmd_none(pmdp[pmd_index]))
+			pmdp[pmd_index] =3D pfn_pmd(PFN_DOWN(pa), prot);
+		return;
+	}
+
+	if (pmd_none(pmdp[pmd_index])) {
+		pte_phys =3D ops->alloc_pte(va);
+		pmdp[pmd_index] =3D pfn_pmd(PFN_DOWN(pte_phys),
+					  __pgprot(_PAGE_TABLE));
+		ptep =3D ops->get_pte_virt(pte_phys);
+		memset(ptep, 0, PAGE_SIZE);
+	} else {
+		pte_phys =3D PFN_PHYS(_pmd_pfn(pmdp[pmd_index]));
+		ptep =3D ops->get_pte_virt(pte_phys);
+	}
+
+	create_pte_mapping(ptep, va, pa, sz, prot);
+}
+
+
+static void __init create_pgd_mapping(pgd_t *pgdp,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot,
+				      struct mapping_ops *ops)
+{
+	pmd_t *pmdp;
+	phys_addr_t pmd_phys;
+	uintptr_t pgd_index =3D pgd_index(va);
+
+	if (sz =3D=3D PGDIR_SIZE) {
+		if (pgd_val(pgdp[pgd_index]) =3D=3D 0)
+			pgdp[pgd_index] =3D pfn_pgd(PFN_DOWN(pa), prot);
+		return;
+	}
+
+	if (pgd_val(pgdp[pgd_index]) =3D=3D 0) {
+		pmd_phys =3D ops->alloc_pmd(va);
+		pgdp[pgd_index] =3D pfn_pgd(PFN_DOWN(pmd_phys),
+					  __pgprot(_PAGE_TABLE));
+		pmdp =3D ops->get_pmd_virt(pmd_phys);
+		memset(pmdp, 0, PAGE_SIZE);
+	} else {
+		pmd_phys =3D PFN_PHYS(_pgd_pfn(pgdp[pgd_index]));
+		pmdp =3D ops->get_pmd_virt(pmd_phys);
+	}
+
+	create_pmd_mapping(pmdp, va, pa, sz, prot, ops);
+}
+#else
+static void __init create_pgd_mapping(pgd_t *pgdp,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot,
+				      struct mapping_ops *ops)
+{
+	pte_t *ptep;
+	phys_addr_t pte_phys;
+	uintptr_t pgd_index =3D pgd_index(va);
+
+	if (sz =3D=3D PGDIR_SIZE) {
+		if (pgd_val(pgdp[pgd_index]) =3D=3D 0)
+			pgdp[pgd_index] =3D pfn_pgd(PFN_DOWN(pa), prot);
+		return;
+	}
+
+	if (pgd_val(pgdp[pgd_index]) =3D=3D 0) {
+		pte_phys =3D ops->alloc_pte(va);
+		pgdp[pgd_index] =3D pfn_pgd(PFN_DOWN(pte_phys),
+					  __pgprot(_PAGE_TABLE));
+		ptep =3D ops->get_pte_virt(pte_phys);
+		memset(ptep, 0, PAGE_SIZE);
+	} else {
+		pte_phys =3D PFN_PHYS(_pgd_pfn(pgdp[pgd_index]));
+		ptep =3D ops->get_pte_virt(pte_phys);
+	}
+
+	create_pte_mapping(ptep, va, pa, sz, prot);
+}
+#endif
+
+static uintptr_t __init best_map_size(uintptr_t load_pa, phys_addr_t size)
+{
+#ifdef CONFIG_BOOT_PAGE_ALIGNED
+	uintptr_t map_sz =3D PAGE_SIZE;
+#else
+#ifndef __PAGETABLE_PMD_FOLDED
+	uintptr_t map_sz =3D PMD_SIZE;
+#else
+	uintptr_t map_sz =3D PGDIR_SIZE;
+#endif
+#endif
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	if (!(load_pa & (PMD_SIZE - 1)) &&
+	    (size >=3D PMD_SIZE) &&
+	    (map_sz < PMD_SIZE))
+		map_sz =3D PMD_SIZE;
+#endif
+
+	if (!(load_pa & (PGDIR_SIZE - 1)) &&
+	    (size >=3D PGDIR_SIZE) &&
+	    (map_sz < PGDIR_SIZE))
+		map_sz =3D PGDIR_SIZE;
+
+	return map_sz;
+}
+
 /*
  * The setup_vm() is called from head.S with MMU-off.
  *
@@ -192,46 +385,110 @@ void __set_fixmap(enum fixed_addresses idx, phys_add=
r_t phys, pgprot_t prot)
  * Currently, the above requirements are honoured by using custom CFLAGS
  * for init.o in mm/Makefile.
  */
-asmlinkage void __init setup_vm(void)
+asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-	uintptr_t i;
-	uintptr_t pa =3D (uintptr_t) &_start;
+	uintptr_t va, end_va;
+	uintptr_t load_pa =3D (uintptr_t)(&_start);
+	uintptr_t load_sz =3D (uintptr_t)(&_end) - load_pa;
+	pgprot_t tableprot =3D __pgprot(_PAGE_TABLE);
 	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
+	struct mapping_ops ops;
=20
-	va_pa_offset =3D PAGE_OFFSET - pa;
-	pfn_base =3D PFN_DOWN(pa);
+	va_pa_offset =3D PAGE_OFFSET - load_pa;
+	pfn_base =3D PFN_DOWN(load_pa);
+	map_size =3D best_map_size(load_pa, PGDIR_SIZE);
=20
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) !=3D 0);
-	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) !=3D 0);
+	BUG_ON((load_pa % map_size) !=3D 0);
+	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
+
+	/* Setup swapper ops */
+	ops.get_pte_virt =3D early_get_pte_virt;
+	ops.alloc_pte =3D early_alloc_pte;
+	ops.get_pmd_virt =3D NULL;
+	ops.alloc_pmd =3D NULL;
=20
 #ifndef __PAGETABLE_PMD_FOLDED
-	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
-		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+	/* Update mapping ops for PMD */
+	ops.get_pmd_virt =3D early_get_pmd_virt;
+	ops.alloc_pmd =3D early_alloc_pmd;
+
+	/* Setup swapper PGD and PMD for fixmap */
+	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
+			   (uintptr_t)fixmap_pmd, PGDIR_SIZE, tableprot, &ops);
+	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
+			   (uintptr_t)fixmap_pte, PMD_SIZE, tableprot, &ops);
+#else
+	/* Setup swapper PGD for fixmap */
+	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
+			   (uintptr_t)fixmap_pte, PGDIR_SIZE, tableprot, &ops);
+#endif
=20
-		swapper_pg_dir[o] =3D
-			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
-				__pgprot(_PAGE_TABLE));
-	}
-	for (i =3D 0; i < ARRAY_SIZE(swapper_pmd); i++)
-		swapper_pmd[i] =3D pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
-
-	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pmd),
-				__pgprot(_PAGE_TABLE));
-	fixmap_pmd[(FIXADDR_START >> PMD_SHIFT) % PTRS_PER_PMD] =3D
-		pfn_pmd(PFN_DOWN((uintptr_t)fixmap_pte),
-				__pgprot(_PAGE_TABLE));
+	/*
+	 * Setup swapper PGD covering entire kernel which will allows
+	 * us to reach paging_init(). We map all memory banks later in
+	 * setup_vm_final() below.
+	 */
+	end_va =3D PAGE_OFFSET + load_sz;
+	for (va =3D PAGE_OFFSET; va < end_va; va +=3D map_size)
+		create_pgd_mapping(swapper_pg_dir, va,
+				   load_pa + (va - PAGE_OFFSET),
+				   map_size, prot, &ops);
+
+	/* Create fixed mapping for early FDT parsing */
+	end_va =3D __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
+	for (va =3D __fix_to_virt(FIX_FDT); va < end_va; va +=3D PAGE_SIZE)
+		create_pte_mapping(fixmap_pte, va,
+				   dtb_pa + (va - __fix_to_virt(FIX_FDT)),
+				   PAGE_SIZE, prot);
+}
+
+static void __init setup_vm_final(void)
+{
+	phys_addr_t pa, start, end;
+	struct memblock_region *reg;
+	struct mapping_ops ops;
+	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
+
+	/* Setup mapping ops */
+	ops.get_pte_virt =3D final_get_pte_virt;
+	ops.alloc_pte =3D final_alloc_pte;
+#ifndef __PAGETABLE_PMD_FOLDED
+	ops.get_pmd_virt =3D final_get_pmd_virt;
+	ops.alloc_pmd =3D final_alloc_pmd;
 #else
-	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
-		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+	ops.get_pmd_virt =3D NULL;
+	ops.alloc_pmd =3D NULL;
+#endif
=20
-		swapper_pg_dir[o] =3D
-			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
+	/* Map all memory banks */
+	for_each_memblock(memory, reg) {
+		start =3D reg->base;
+		end =3D start + reg->size;
+
+		if (start >=3D end)
+			break;
+		if (memblock_is_nomap(reg))
+			continue;
+		if (start <=3D __pa(PAGE_OFFSET) &&
+		    __pa(PAGE_OFFSET) < end)
+			start =3D __pa(PAGE_OFFSET);
+
+		for (pa =3D start; pa < end; pa +=3D map_size)
+			create_pgd_mapping(swapper_pg_dir,
+					   (uintptr_t)__va(pa), pa,
+					   map_size, prot, &ops);
 	}
=20
-	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pte),
-				__pgprot(_PAGE_TABLE));
-#endif
+	clear_fixmap(FIX_PTE);
+	clear_fixmap(FIX_PMD);
+}
+
+void __init paging_init(void)
+{
+	setup_vm_final();
+	setup_zero_page();
+	local_flush_tlb_all();
+	zone_sizes_init();
 }
--=20
2.17.1

