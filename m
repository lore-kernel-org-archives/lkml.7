Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF78C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F07218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="riD0pe4z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KpwkNqvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfCUJr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:47:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15691 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCUJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553161697; x=1584697697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TFYL4eqVb0jXiSXMlqxFlpDrPIsv9WoAzlfJnt9SHxs=;
  b=riD0pe4zc7ixQONS6J5rAG1wsKCO4I3c50lYRJYAyEDkaGllMR06alLQ
   RQzY5XP48d0WuOR3rj40HI2jY2VZB0nsGXC4EaXNSun5F6p8bTwBFBN6Z
   vxpu68P+2skEGbK8/R1E7D6MjZZXKfYIfta6q8FJn8V4IySKW24mO04X2
   wpYQKRaJl5KQtIHcYvpSMCq0q+OCaIntgwNKEj9irr3/p89u9XDC7wdVS
   ojflaOwWKcyIUFWdHO5NaWYBWfgvwzSTgWBJv+my+fIlaYGwBT2mKF8Pt
   UGUUwuWJNO/3mjrsaXA+tktOHcFQhJiK08aa24aDnp0LXW6709AXvfe8I
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,252,1549900800"; 
   d="scan'208";a="202598360"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 17:48:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3h8iZ+jadvxf04CQHJpGglOn7DTTWn4Y4fhaXeRsuM=;
 b=KpwkNqvmXlEM60lQaEQGBt7d6AoKQu7aAgJ2sBrqeCXna4HdzqfODi8v4FPdBbbiRRQJ/LZBhk7B9VDRMNeUMqAXWn101ryD2+MgXV8kup6Sx7ePA/oKaqLLYO5uf5+BqzTGgeU/dnhFc2b4BDzejj7AR/+KF432ObvtYe+HzdU=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6239.namprd04.prod.outlook.com (20.178.249.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 21 Mar 2019 09:47:55 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 09:47:55 +0000
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
Subject: [PATCH v2 4/5] RISC-V: Remove redundant trampoline page table
Thread-Topic: [PATCH v2 4/5] RISC-V: Remove redundant trampoline page table
Thread-Index: AQHU38sosu9cOHGmQkG5TxxiSwF1Nw==
Date:   Thu, 21 Mar 2019 09:47:55 +0000
Message-ID: <20190321094710.16552-5-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: a2782063-6942-4428-1d90-08d6ade24acf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6239;
x-ms-traffictypediagnostic: MN2PR04MB6239:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB62390B5069FC5739B7FDE6818D420@MN2PR04MB6239.namprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(256004)(6506007)(4326008)(6512007)(486006)(36756003)(2171002)(446003)(102836004)(478600001)(386003)(72206003)(53936002)(2906002)(305945005)(76176011)(11346002)(26005)(44832011)(14444005)(55236004)(7736002)(25786009)(14454004)(476003)(78486014)(1076003)(2616005)(52116002)(6486002)(6436002)(9456002)(81156014)(186003)(316002)(8676002)(5660300002)(68736007)(106356001)(105586002)(71200400001)(86362001)(81166006)(54906003)(8936002)(66066001)(97736004)(6116002)(71190400001)(3846002)(99286004)(110136005)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6239;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pAy4iDkcWAVf9G5ckvoCEUILNEaGaEhV+FIRJvxxhjKP8S9qoz4SSekhjrvm6JKsML3/7KwA4py5Lq2KH+IqOZaVYbNYsvLV/9KLWFG43Yn5PpSoNpj307h4WMf9W32MaTSFzGVVM1boxE3oAz2bCMCzIth8768ZKqyzLH9FncZcmcl7ylx64ACuewXont0wOiAG5qsC7vMW9P+5WA4ufnhr6IDPVqNF41HsROE3RWSVofD0b4YoQhMMvQd0bSyyKpT2ss/3YB/D8VVUxl1ammhSPX++bdqC3/zDW5AqM+9TDK+TkIrQYKOi3qi5ze3aj3KDoeFO4PCdnqAywqn61aZtHTvCI4SgBVG24LNKZTAAen5jNIfxFhzRfM/xxHzoYNuW0nAh5AHpuiYLQTtXey99h1eFSGZhYgRY64Ex/Rg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2782063-6942-4428-1d90-08d6ade24acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 09:47:55.0976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trampoline page table is redundant because:

1. There is no mapping in trampoling page table which is not covered
   by swapper page table.
2. The relocate() in head.S will first load trampoline page table and
   after that it will load swapper page table. Same thing can be achieved
   by straight away loading swapper page table.
3. The trampoline page table is in init section. The relocate() will
   break after trampoline page table has been free'ed by kernel. This
   also means runtime HART hotplug will not work correctly due to broken
   relocate() after kernel is booted.

Due to above, this patch removes trampoline page table and related code
from kernel/head.S and mm/init.c.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/head.S | 13 ++-----
 arch/riscv/mm/init.c     | 79 ++++++++--------------------------------
 2 files changed, 19 insertions(+), 73 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 12a3ec5eb8ab..94f424e2038d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -93,21 +93,19 @@ relocate:
 	add a0, a0, a1
 	csrw stvec, a0
=20
-	/* Compute satp for kernel page tables, but don't load it yet */
+	/* Compute satp for kernel page directory, but don't load it yet */
 	la a2, swapper_pg_dir
 	srl a2, a2, PAGE_SHIFT
 	li a1, SATP_MODE
 	or a2, a2, a1
=20
 	/*
-	 * Load trampoline page directory, which will cause us to trap to
+	 * Load kernel page directory, which will cause us to trap to
 	 * stvec if VA !=3D PA, or simply fall through if VA =3D=3D PA
 	 */
-	la a0, trampoline_pg_dir
-	srl a0, a0, PAGE_SHIFT
-	or a0, a0, a1
 	sfence.vma
-	csrw sptbr, a0
+	csrw sptbr, a2
+
 .align 2
 1:
 	/* Set trap vector to spin forever to help debug */
@@ -120,9 +118,6 @@ relocate:
 	la gp, __global_pointer$
 .option pop
=20
-	/* Switch to kernel page tables */
-	csrw sptbr, a2
-
 	ret
=20
 .Lsecondary_start:
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c389fbfeccd8..2e2f2567964c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -132,7 +132,6 @@ void __init setup_bootmem(void)
 #define MAX_EARLY_MAPPING_SIZE	SZ_128M
=20
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
=20
 #ifndef __PAGETABLE_PMD_FOLDED
 #if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
@@ -140,21 +139,14 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __al=
igned(PAGE_SIZE);
 #else
 #define NUM_SWAPPER_PMDS	(MAX_EARLY_MAPPING_SIZE/PGDIR_SIZE)
 #endif
-#define NUM_TRAMPOLINE_PMDS	1UL
 pmd_t swapper_pmd[PTRS_PER_PMD*NUM_SWAPPER_PMDS] __page_aligned_bss;
-pmd_t trampoline_pmd[PTRS_PER_PMD*NUM_TRAMPOLINE_PMDS]
-	__initdata __aligned(PAGE_SIZE);
 pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #define NUM_SWAPPER_PTES	(MAX_EARLY_MAPPING_SIZE/PMD_SIZE)
 #else
 #define NUM_SWAPPER_PTES	(MAX_EARLY_MAPPING_SIZE/PGDIR_SIZE)
 #endif
=20
-#define NUM_TRAMPOLINE_PTES	1UL
-
 pte_t swapper_pte[PTRS_PER_PTE*NUM_SWAPPER_PTES] __page_aligned_bss;
-pte_t trampoline_pte[PTRS_PER_PTE*NUM_TRAMPOLINE_PTES]
-	__initdata __aligned(PAGE_SIZE);
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
=20
 uintptr_t map_size;
@@ -214,19 +206,7 @@ static pte_t *__init final_get_pte_virt(phys_addr_t pa=
)
 	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
 }
=20
-static phys_addr_t __init early_alloc_trampoline_pte(uintptr_t va,
-						     uintptr_t load_pa)
-{
-	pte_t *base =3D __load_va(trampoline_pte, load_pa);
-	uintptr_t pte_num =3D ((va - PAGE_OFFSET) >> PMD_SHIFT);
-
-	BUG_ON(pte_num >=3D NUM_TRAMPOLINE_PTES);
-
-	return (uintptr_t)&base[pte_num * PTRS_PER_PTE];
-}
-
-static phys_addr_t __init early_alloc_swapper_pte(uintptr_t va,
-						  uintptr_t load_pa)
+static phys_addr_t __init early_alloc_pte(uintptr_t va, uintptr_t load_pa)
 {
 	pte_t *base =3D __load_va(swapper_pte, load_pa);
 	uintptr_t pte_num =3D ((va - PAGE_OFFSET) >> PMD_SHIFT);
@@ -266,19 +246,7 @@ static pmd_t *__init final_get_pmd_virt(phys_addr_t pa=
)
 	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
 }
=20
-static phys_addr_t __init early_alloc_trampoline_pmd(uintptr_t va,
-						     uintptr_t load_pa)
-{
-	pmd_t *base =3D __load_va(trampoline_pmd, load_pa);
-	uintptr_t pmd_num =3D (va - PAGE_OFFSET) >> PGDIR_SHIFT;
-
-	BUG_ON(pmd_num >=3D NUM_TRAMPOLINE_PMDS);
-
-	return (uintptr_t)&base[pmd_num * PTRS_PER_PMD];
-}
-
-static phys_addr_t __init early_alloc_swapper_pmd(uintptr_t va,
-						  uintptr_t load_pa)
+static phys_addr_t __init early_alloc_pmd(uintptr_t va, uintptr_t load_pa)
 {
 	pmd_t *base =3D __load_va(swapper_pmd, load_pa);
 	uintptr_t pmd_num =3D (va - PAGE_OFFSET) >> PGDIR_SHIFT;
@@ -418,7 +386,7 @@ asmlinkage void __init setup_vm(uintptr_t load_pa, uint=
ptr_t dtb_pa)
 	uintptr_t load_sz =3D __load_pa(&_end, load_pa) - load_pa;
 	pgprot_t tableprot =3D __pgprot(_PAGE_TABLE);
 	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
-	struct mapping_ops tramp_ops, swap_ops;
+	struct mapping_ops ops;
=20
 	va_pa_offset =3D PAGE_OFFSET - load_pa;
 	pfn_base =3D PFN_DOWN(load_pa);
@@ -429,51 +397,34 @@ asmlinkage void __init setup_vm(uintptr_t load_pa, ui=
ntptr_t dtb_pa)
 	BUG_ON((load_pa % map_size) !=3D 0);
 	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
=20
-	/* Setup trampoline mapping ops */
-	tramp_ops.get_pte_virt =3D __load_va(early_get_pte_virt, load_pa);
-	tramp_ops.alloc_pte =3D __load_va(early_alloc_trampoline_pte, load_pa);
-	tramp_ops.get_pmd_virt =3D NULL;
-	tramp_ops.alloc_pmd =3D NULL;
-
-	/* Setup swapper mapping ops */
-	swap_ops.get_pte_virt =3D __load_va(early_get_pte_virt, load_pa);
-	swap_ops.alloc_pte =3D __load_va(early_alloc_swapper_pte, load_pa);
-	swap_ops.get_pmd_virt =3D NULL;
-	swap_ops.alloc_pmd =3D NULL;
+	/* Setup mapping ops */
+	ops.get_pte_virt =3D __load_va(early_get_pte_virt, load_pa);
+	ops.alloc_pte =3D __load_va(early_alloc_pte, load_pa);
+	ops.get_pmd_virt =3D NULL;
+	ops.alloc_pmd =3D NULL;
=20
 #ifndef __PAGETABLE_PMD_FOLDED
-	/* Update trampoline mapping ops for PMD */
-	tramp_ops.get_pmd_virt =3D __load_va(early_get_pmd_virt, load_pa);
-	tramp_ops.alloc_pmd =3D __load_va(early_alloc_trampoline_pmd, load_pa);
-
-	/* Update swapper mapping ops for PMD */
-	swap_ops.get_pmd_virt =3D __load_va(early_get_pmd_virt, load_pa);
-	swap_ops.alloc_pmd =3D __load_va(early_alloc_swapper_pmd, load_pa);
+	/* Update mapping ops for PMD */
+	ops.get_pmd_virt =3D __load_va(early_get_pmd_virt, load_pa);
+	ops.alloc_pmd =3D __load_va(early_alloc_pmd, load_pa);
=20
 	/* Setup swapper PGD and PMD for fixmap */
 	map_pa =3D __load_pa(fixmap_pmd, load_pa);
 	create_pgd_mapping(__load_va(swapper_pg_dir, load_pa),
 			   FIXADDR_START, map_pa, PGDIR_SIZE, tableprot,
-			   load_pa, &swap_ops);
+			   load_pa, &ops);
 	map_pa =3D __load_pa(fixmap_pte, load_pa);
 	create_pmd_mapping(__load_va(fixmap_pmd, load_pa),
 			   FIXADDR_START, map_pa, PMD_SIZE, tableprot,
-			   load_pa, &swap_ops);
+			   load_pa, &ops);
 #else
 	/* Setup swapper PGD for fixmap */
 	map_pa =3D __load_pa(fixmap_pte, load_pa);
 	create_pgd_mapping(__load_va(swapper_pg_dir, load_pa),
 			   FIXADDR_START, map_pa, PGDIR_SIZE, tableprot,
-			   load_pa, &swap_ops);
+			   load_pa, &ops);
 #endif
=20
-	/* Setup trampoling PGD covering first few MBs of kernel */
-	end_va =3D PAGE_OFFSET + PAGE_SIZE*PTRS_PER_PTE;
-	for (va =3D PAGE_OFFSET; va < end_va; va +=3D map_size)
-		create_pgd_mapping(__load_va(trampoline_pg_dir, load_pa),
-				   va, load_pa + (va - PAGE_OFFSET),
-				   map_size, prot, load_pa, &tramp_ops);
-
 	/*
 	 * Setup swapper PGD covering entire kernel which will allows
 	 * us to reach paging_init(). We map all memory banks later in
@@ -483,7 +434,7 @@ asmlinkage void __init setup_vm(uintptr_t load_pa, uint=
ptr_t dtb_pa)
 	for (va =3D PAGE_OFFSET; va < end_va; va +=3D map_size)
 		create_pgd_mapping(__load_va(swapper_pg_dir, load_pa),
 				   va, load_pa + (va - PAGE_OFFSET),
-				   map_size, prot, load_pa, &swap_ops);
+				   map_size, prot, load_pa, &ops);
=20
 	/* Create fixed mapping for early parsing of FDT */
 	end_va =3D __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
--=20
2.17.1

