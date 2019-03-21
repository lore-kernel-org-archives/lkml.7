Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3305EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DF120850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jHOI6kq5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fDvboi2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfCUJrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:47:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33279 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCUJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553161674; x=1584697674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DReYSIu4lu3Znm6sxWmsqhc/bnFDCL7zBw5k+5T5irc=;
  b=jHOI6kq5t/QLAsefFMPyO6BkKj/DVHaj3rs/859lzIaVwz7UFReeOM1/
   ASEcNBvFJSDv6vecLHbbJIYmx7Wgl1wFYJfh9It3C2yYXPZM6Zwsbgi0v
   FW2xE71RegDH3yQQonHtjR3NG2VoU5Ixq/GrEqrHY9swQabo68VhqjBnM
   b4s0OQqNlidnbKafQwzSZXp9YbIZJbPDKFoWMscScTFM/vevx43einFOK
   9rCQzKKhBelUwlXMNeqk2swHm0qpzGaC5/v1tNJfO3pL60dW3dGjKa2e0
   8WZsfTVl/sMWYlRV3mi36EXXLAOHtEZvcsyAGS7Q1vEk5gWeBOac80/CU
   g==;
X-IronPort-AV: E=Sophos;i="5.60,252,1549900800"; 
   d="scan'208";a="105647559"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 17:47:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsItQezegWagmh5VljIaT25x1DWlaRs2xIA5T4KFAt0=;
 b=fDvboi2soonVXHISN0QSfZQobWi9Qkse4hFV4pvk120JQlJSYck8AHVfz9N29sRN6kHmnbIrL/3jjyD27Ukfjk2ln5p+tHzOclViCp4h/u6wy8B4Fw/N6tdQ14wz12eOdJrPEyrePaOvyRUeOmkWsZK8WRQtTeFumnjL3F3WTP8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6239.namprd04.prod.outlook.com (20.178.249.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 21 Mar 2019 09:47:51 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 09:47:51 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 3/5] RISC-V: Allow booting kernel from any 4KB aligned
 address
Thread-Topic: [PATCH v2 3/5] RISC-V: Allow booting kernel from any 4KB aligned
 address
Thread-Index: AQHU38smxmc1jYxaFE+Ebv0FuT3Fyg==
Date:   Thu, 21 Mar 2019 09:47:51 +0000
Message-ID: <20190321094710.16552-4-anup.patel@wdc.com>
References: <20190321094710.16552-1-anup.patel@wdc.com>
In-Reply-To: <20190321094710.16552-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::23) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.18.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6596b96-a6d6-4bb0-0db3-08d6ade24884
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6239;
x-ms-traffictypediagnostic: MN2PR04MB6239:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB6239BF9910FB93F14D73B55F8D420@MN2PR04MB6239.namprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(256004)(6506007)(4326008)(6512007)(486006)(36756003)(2171002)(446003)(102836004)(478600001)(386003)(72206003)(53946003)(53936002)(2906002)(305945005)(76176011)(11346002)(26005)(44832011)(14444005)(55236004)(7736002)(25786009)(14454004)(476003)(78486014)(1076003)(2616005)(52116002)(6486002)(6436002)(9456002)(30864003)(81156014)(186003)(316002)(8676002)(5660300002)(68736007)(106356001)(105586002)(71200400001)(86362001)(81166006)(54906003)(8936002)(66066001)(97736004)(6116002)(71190400001)(3846002)(99286004)(110136005)(50226002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6239;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4t7faPdXyY7JUp/nxWHs/GJ1pY72k1NmC5zD6HLcH2GYyBTNRyM6l1WyTDjB64ivdqHQsqH6FCebc2ovEPGtTHvhC4urc5VsZZGSpcd4iXE7HE2N5dr0zMgh3se7QgER23wxS7WQddhXkkRE1JLzaFsQb5eZ948PJBaO2JON4kb6zBwoMEmBLN5vHXWPPN+aQ5cQotiuOeINn2OecYmbMZ/gEx5bUybAWdgrf07tv+2us9CHCxhn8v0QDr2AH+aGbe2EcHW3N9miLf3LCqEjQTpQCCvg/nfB4cBzG/m+CW8fAPTjAYMotYkpDeTyVaNu4muYiUU8D0S1VZVXG3W9szH7o3Qr3JkQbfm6VCyVEueGrPHbmjm5Of7EO78iN5oWu05SkZ7AFh1wE0CjODU0o/xHF4nzeLlVF7gtnM16Y6w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6596b96-a6d6-4bb0-0db3-08d6ade24884
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 09:47:51.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6239
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
 arch/riscv/Kconfig                  |  11 +
 arch/riscv/include/asm/fixmap.h     |   5 +
 arch/riscv/include/asm/pgtable-64.h |   5 +
 arch/riscv/include/asm/pgtable.h    |   6 +-
 arch/riscv/kernel/head.S            |   1 +
 arch/riscv/kernel/setup.c           |   4 +-
 arch/riscv/mm/init.c                | 402 ++++++++++++++++++++++++----
 7 files changed, 378 insertions(+), 56 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb56c82d8aa1..1b0c66f7aba3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -172,6 +172,17 @@ config SMP
=20
 	  If you don't know what to do here, say N.
=20
+config BOOT_PAGE_ALIGNED
+	bool "Allow booting from page aligned address"
+	help
+	  This enables support for booting kernel from any page aligned
+	  address (i.e. 4KB aligned). This option is particularly useful
+	  on systems with very less RAM (few MBs) because using it we
+	  can boot kernel closer RAM start thereby reducing unusable RAM
+	  below kernel.
+
+	  If you don't know what to do here, say N.
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixma=
p.h
index 57afe604b495..5cf53dd882e5 100644
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
index 1141364d990e..05fa2115e736 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -121,12 +121,16 @@ static inline void pmd_clear(pmd_t *pmdp)
 	set_pmd(pmdp, __pmd(0));
 }
=20
-
 static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 {
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
index 7966262b4f9d..12a3ec5eb8ab 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -63,6 +63,7 @@ clear_bss_done:
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
 	la a0, _start
+	mv a1, s1
 	call setup_vm
 	call relocate
=20
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ecb654f6a79e..acdd0f74982b 100644
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
@@ -62,7 +63,8 @@ unsigned long boot_cpu_hartid;
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
index e38f8195e45b..c389fbfeccd8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1,14 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
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
  */
=20
 #include <linux/init.h>
@@ -43,13 +36,6 @@ void setup_zero_page(void)
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
@@ -143,18 +129,36 @@ void __init setup_bootmem(void)
 	}
 }
=20
+#define MAX_EARLY_MAPPING_SIZE	SZ_128M
+
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
=20
 #ifndef __PAGETABLE_PMD_FOLDED
-#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
-pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned=
_bss;
-pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
+#define NUM_SWAPPER_PMDS	1UL
+#else
+#define NUM_SWAPPER_PMDS	(MAX_EARLY_MAPPING_SIZE/PGDIR_SIZE)
+#endif
+#define NUM_TRAMPOLINE_PMDS	1UL
+pmd_t swapper_pmd[PTRS_PER_PMD*NUM_SWAPPER_PMDS] __page_aligned_bss;
+pmd_t trampoline_pmd[PTRS_PER_PMD*NUM_TRAMPOLINE_PMDS]
+	__initdata __aligned(PAGE_SIZE);
 pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
+#define NUM_SWAPPER_PTES	(MAX_EARLY_MAPPING_SIZE/PMD_SIZE)
+#else
+#define NUM_SWAPPER_PTES	(MAX_EARLY_MAPPING_SIZE/PGDIR_SIZE)
 #endif
=20
+#define NUM_TRAMPOLINE_PTES	1UL
+
+pte_t swapper_pte[PTRS_PER_PTE*NUM_SWAPPER_PTES] __page_aligned_bss;
+pte_t trampoline_pte[PTRS_PER_PTE*NUM_TRAMPOLINE_PTES]
+	__initdata __aligned(PAGE_SIZE);
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
=20
+uintptr_t map_size;
+
 void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t pro=
t)
 {
 	unsigned long addr =3D __fix_to_virt(idx);
@@ -172,6 +176,13 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_=
t phys, pgprot_t prot)
 	}
 }
=20
+struct mapping_ops {
+	pte_t *(*get_pte_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pte)(uintptr_t va, uintptr_t load_pa);
+	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pmd)(uintptr_t va, uintptr_t load_pa);
+};
+
 static inline void *__load_addr(void *ptr, uintptr_t load_pa)
 {
 	extern char _start;
@@ -186,64 +197,347 @@ static inline void *__load_addr(void *ptr, uintptr_t=
 load_pa)
 #define __load_va(ptr, load_pa)	__load_addr(ptr, load_pa)
 #define __load_pa(ptr, load_pa)	((uintptr_t)__load_addr(ptr, load_pa))
=20
-asmlinkage void __init setup_vm(uintptr_t load_pa)
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
+static phys_addr_t __init early_alloc_trampoline_pte(uintptr_t va,
+						     uintptr_t load_pa)
+{
+	pte_t *base =3D __load_va(trampoline_pte, load_pa);
+	uintptr_t pte_num =3D ((va - PAGE_OFFSET) >> PMD_SHIFT);
+
+	BUG_ON(pte_num >=3D NUM_TRAMPOLINE_PTES);
+
+	return (uintptr_t)&base[pte_num * PTRS_PER_PTE];
+}
+
+static phys_addr_t __init early_alloc_swapper_pte(uintptr_t va,
+						  uintptr_t load_pa)
+{
+	pte_t *base =3D __load_va(swapper_pte, load_pa);
+	uintptr_t pte_num =3D ((va - PAGE_OFFSET) >> PMD_SHIFT);
+
+	BUG_ON(pte_num >=3D NUM_SWAPPER_PTES);
+
+	return (uintptr_t)&base[pte_num * PTRS_PER_PTE];
+}
+
+static phys_addr_t __init final_alloc_pte(uintptr_t va, uintptr_t load_pa)
+{
+	return final_alloc_pgtable();
+}
+
+static void __init create_pte_mapping(pte_t *ptep,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot)
 {
-	uintptr_t i;
+	uintptr_t pte_index =3D pte_index(va);
+
+	BUG_ON(sz !=3D PAGE_SIZE);
+
+	if (pte_none(ptep[pte_index]))
+		ptep[pte_index] =3D pfn_pte(PFN_DOWN(pa), prot);
+}
+
 #ifndef __PAGETABLE_PMD_FOLDED
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
+static phys_addr_t __init early_alloc_trampoline_pmd(uintptr_t va,
+						     uintptr_t load_pa)
+{
+	pmd_t *base =3D __load_va(trampoline_pmd, load_pa);
+	uintptr_t pmd_num =3D (va - PAGE_OFFSET) >> PGDIR_SHIFT;
+
+	BUG_ON(pmd_num >=3D NUM_TRAMPOLINE_PMDS);
+
+	return (uintptr_t)&base[pmd_num * PTRS_PER_PMD];
+}
+
+static phys_addr_t __init early_alloc_swapper_pmd(uintptr_t va,
+						  uintptr_t load_pa)
+{
+	pmd_t *base =3D __load_va(swapper_pmd, load_pa);
+	uintptr_t pmd_num =3D (va - PAGE_OFFSET) >> PGDIR_SHIFT;
+
+	BUG_ON(pmd_num >=3D NUM_SWAPPER_PMDS);
+
+	return (uintptr_t)&base[pmd_num * PTRS_PER_PMD];
+}
+
+static phys_addr_t __init final_alloc_pmd(uintptr_t va, uintptr_t load_pa)
+{
+	return final_alloc_pgtable();
+}
+
+static void __init create_pmd_mapping(pmd_t *pmdp,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot,
+				      uintptr_t ops_load_pa,
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
+		pte_phys =3D ops->alloc_pte(va, ops_load_pa);
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
+static void __init create_pgd_mapping(pgd_t *pgdp,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot,
+				      uintptr_t ops_load_pa,
+				      struct mapping_ops *ops)
+{
 	pmd_t *pmdp;
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
+		pmd_phys =3D ops->alloc_pmd(va, ops_load_pa);
+		pgdp[pgd_index] =3D pfn_pgd(PFN_DOWN(pmd_phys),
+					  __pgprot(_PAGE_TABLE));
+		pmdp =3D ops->get_pmd_virt(pmd_phys);
+		memset(pmdp, 0, PAGE_SIZE);
+	} else {
+		pmd_phys =3D PFN_PHYS(_pgd_pfn(pgdp[pgd_index]));
+		pmdp =3D ops->get_pmd_virt(pmd_phys);
+	}
+
+	create_pmd_mapping(pmdp, va, pa, sz, prot, ops_load_pa, ops);
+}
+#else
+static void __init create_pgd_mapping(pgd_t *pgdp,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot,
+				      uintptr_t ops_load_pa,
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
+		pte_phys =3D ops->alloc_pte(va, ops_load_pa);
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
 #endif
-	pgd_t *pgdp;
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
+asmlinkage void __init setup_vm(uintptr_t load_pa, uintptr_t dtb_pa)
+{
 	phys_addr_t map_pa;
+	uintptr_t va, end_va;
+	uintptr_t load_sz =3D __load_pa(&_end, load_pa) - load_pa;
 	pgprot_t tableprot =3D __pgprot(_PAGE_TABLE);
 	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
+	struct mapping_ops tramp_ops, swap_ops;
=20
 	va_pa_offset =3D PAGE_OFFSET - load_pa;
 	pfn_base =3D PFN_DOWN(load_pa);
+	map_size =3D best_map_size(load_pa, PGDIR_SIZE);
=20
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) !=3D 0);
-	BUG_ON((load_pa % (PAGE_SIZE * PTRS_PER_PTE)) !=3D 0);
+	BUG_ON((load_pa % map_size) !=3D 0);
+	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
=20
-#ifndef __PAGETABLE_PMD_FOLDED
-	pgdp =3D __load_va(trampoline_pg_dir, load_pa);
-	map_pa =3D __load_pa(trampoline_pmd, load_pa);
-	pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN(map_pa), tableprot);
-	trampoline_pmd[0] =3D pfn_pmd(PFN_DOWN(load_pa), prot);
+	/* Setup trampoline mapping ops */
+	tramp_ops.get_pte_virt =3D __load_va(early_get_pte_virt, load_pa);
+	tramp_ops.alloc_pte =3D __load_va(early_alloc_trampoline_pte, load_pa);
+	tramp_ops.get_pmd_virt =3D NULL;
+	tramp_ops.alloc_pmd =3D NULL;
=20
-	pgdp =3D __load_va(swapper_pg_dir, load_pa);
+	/* Setup swapper mapping ops */
+	swap_ops.get_pte_virt =3D __load_va(early_get_pte_virt, load_pa);
+	swap_ops.alloc_pte =3D __load_va(early_alloc_swapper_pte, load_pa);
+	swap_ops.get_pmd_virt =3D NULL;
+	swap_ops.alloc_pmd =3D NULL;
=20
-	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
-		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+#ifndef __PAGETABLE_PMD_FOLDED
+	/* Update trampoline mapping ops for PMD */
+	tramp_ops.get_pmd_virt =3D __load_va(early_get_pmd_virt, load_pa);
+	tramp_ops.alloc_pmd =3D __load_va(early_alloc_trampoline_pmd, load_pa);
=20
-		map_pa =3D __load_pa(swapper_pmd, load_pa);
-		pgdp[o] =3D pfn_pgd(PFN_DOWN(map_pa) + i, tableprot);
-	}
-	pmdp =3D __load_va(swapper_pmd, load_pa);
-	for (i =3D 0; i < ARRAY_SIZE(swapper_pmd); i++)
-		pmdp[i] =3D pfn_pmd(PFN_DOWN(load_pa + i * PMD_SIZE), prot);
+	/* Update swapper mapping ops for PMD */
+	swap_ops.get_pmd_virt =3D __load_va(early_get_pmd_virt, load_pa);
+	swap_ops.alloc_pmd =3D __load_va(early_alloc_swapper_pmd, load_pa);
=20
+	/* Setup swapper PGD and PMD for fixmap */
 	map_pa =3D __load_pa(fixmap_pmd, load_pa);
-	pgdp[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN(map_pa), tableprot);
-	pmdp =3D __load_va(fixmap_pmd, load_pa);
+	create_pgd_mapping(__load_va(swapper_pg_dir, load_pa),
+			   FIXADDR_START, map_pa, PGDIR_SIZE, tableprot,
+			   load_pa, &swap_ops);
 	map_pa =3D __load_pa(fixmap_pte, load_pa);
-	fixmap_pmd[(FIXADDR_START >> PMD_SHIFT) % PTRS_PER_PMD] =3D
-		pfn_pmd(PFN_DOWN(map_pa), tableprot);
+	create_pmd_mapping(__load_va(fixmap_pmd, load_pa),
+			   FIXADDR_START, map_pa, PMD_SIZE, tableprot,
+			   load_pa, &swap_ops);
 #else
-	pgdp =3D __load_va(trampoline_pg_dir, load_pa);
-	pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN(load_pa), prot);
+	/* Setup swapper PGD for fixmap */
+	map_pa =3D __load_pa(fixmap_pte, load_pa);
+	create_pgd_mapping(__load_va(swapper_pg_dir, load_pa),
+			   FIXADDR_START, map_pa, PGDIR_SIZE, tableprot,
+			   load_pa, &swap_ops);
+#endif
=20
-	pgdp =3D __load_va(swapper_pg_dir, load_pa);
-	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
-		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+	/* Setup trampoling PGD covering first few MBs of kernel */
+	end_va =3D PAGE_OFFSET + PAGE_SIZE*PTRS_PER_PTE;
+	for (va =3D PAGE_OFFSET; va < end_va; va +=3D map_size)
+		create_pgd_mapping(__load_va(trampoline_pg_dir, load_pa),
+				   va, load_pa + (va - PAGE_OFFSET),
+				   map_size, prot, load_pa, &tramp_ops);
+
+	/*
+	 * Setup swapper PGD covering entire kernel which will allows
+	 * us to reach paging_init(). We map all memory banks later in
+	 * setup_vm_final() below.
+	 */
+	end_va =3D PAGE_OFFSET + load_sz;
+	for (va =3D PAGE_OFFSET; va < end_va; va +=3D map_size)
+		create_pgd_mapping(__load_va(swapper_pg_dir, load_pa),
+				   va, load_pa + (va - PAGE_OFFSET),
+				   map_size, prot, load_pa, &swap_ops);
+
+	/* Create fixed mapping for early parsing of FDT */
+	end_va =3D __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
+	for (va =3D __fix_to_virt(FIX_FDT); va < end_va; va +=3D PAGE_SIZE)
+		create_pte_mapping(__load_va(fixmap_pte, load_pa),
+				   va, dtb_pa + (va - __fix_to_virt(FIX_FDT)),
+				   PAGE_SIZE, prot);
+}
=20
-		pgdp[o] =3D pfn_pgd(PFN_DOWN(load_pa + i * PGDIR_SIZE), prot);
-	}
+static void __init setup_vm_final(void)
+{
+	phys_addr_t pa, start, end;
+	struct memblock_region *reg;
+	struct mapping_ops ops;
+	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
=20
-	map_pa =3D __load_pa(fixmap_pte, load_pa);
-	pgdp[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN(map_pa), tableprot);
+	/* Setup mapping ops */
+	ops.get_pte_virt =3D final_get_pte_virt;
+	ops.alloc_pte =3D final_alloc_pte;
+#ifndef __PAGETABLE_PMD_FOLDED
+	ops.get_pmd_virt =3D final_get_pmd_virt;
+	ops.alloc_pmd =3D final_alloc_pmd;
+#else
+	ops.get_pmd_virt =3D NULL;
+	ops.alloc_pmd =3D NULL;
 #endif
+
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
+					   map_size, prot, 0, &ops);
+	}
+
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

