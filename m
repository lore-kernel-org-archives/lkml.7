Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F23EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B312175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F7+S30PJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G4xWezoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCLWIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:08:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30535 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfCLWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552428499; x=1583964499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ha48n3AS45tOEw4Pyfsa7ec4EIQ3/DEYKuI8wEJ06Zw=;
  b=F7+S30PJ5jKwBUccXQxsERTJUAyZaN0ov8PIpptKxAM9iCP/4ZxQ0S4G
   OiUz8fJgj8UHasYozeFZ7jTbRodLP+7UC/xEKIrlIaOLzl4yompv5W0yg
   n9Lt617WoF1i117ZbQ37chwPkXrwXW8I6qUEYP9JZIJRD7Q+gzNNtb57i
   XXVX7clIgRqh1IrNxFfPvH1dJbRgmK4zJdDiWahI32mdTzeuMntnEpUkd
   YKrqTp8wy4v/SLZdk/5d5oh9fxcFQcQWTLGC/EXHWcnXm9bxPtam4XDHE
   Tj2kY0gDko5pEnDYcwiaWXeUcp2hM823G+k3XIr9PvyJ469JggalFhkfc
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,471,1544457600"; 
   d="scan'208";a="104620474"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2019 06:08:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji/DS0clLT53VPloo9pNYI4u6s6ZtyNVjcXWLm8sxBM=;
 b=G4xWezoQtz+V7qktC7HsvuI+p0ksT1dIkfuecL4oGOmzUA7LP0pxQj/HhUg2CpWPTknqwcQI8sVYlO1zhtLowzMQ75b5PUS3i1B3dq0nERi3a3YoInEdDSEtxlm74tYhU+nvMHIXUHFc6ttYrodSixRYwsQRDQE59FoqZ2/Evew=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB4201.namprd04.prod.outlook.com (20.176.76.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 22:08:16 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::447:8360:6df9:c934]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::447:8360:6df9:c934%3]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 22:08:16 +0000
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
Subject: [PATCH 2/3] RISC-V: Make setup_vm() independent of GCC code model
Thread-Topic: [PATCH 2/3] RISC-V: Make setup_vm() independent of GCC code
 model
Thread-Index: AQHU2SAXFOwCqD7TIUe3nwMe83Le9Q==
Date:   Tue, 12 Mar 2019 22:08:16 +0000
Message-ID: <20190312220752.128141-3-anup.patel@wdc.com>
References: <20190312220752.128141-1-anup.patel@wdc.com>
In-Reply-To: <20190312220752.128141-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dd653cd-dcf9-441c-3a55-08d6a73739e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB4201;
x-ms-traffictypediagnostic: DM6PR04MB4201:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB420199DA0248AD3CDACDA5238D490@DM6PR04MB4201.namprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(71200400001)(478600001)(26005)(305945005)(106356001)(76176011)(7736002)(105586002)(72206003)(102836004)(6506007)(1076003)(386003)(71190400001)(66066001)(97736004)(36756003)(4326008)(5660300002)(14444005)(25786009)(186003)(14454004)(316002)(256004)(6116002)(53936002)(54906003)(99286004)(2906002)(110136005)(2171002)(8936002)(50226002)(486006)(446003)(476003)(11346002)(2616005)(44832011)(81156014)(6436002)(6512007)(8676002)(81166006)(68736007)(86362001)(52116002)(6486002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4201;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tiHj9PVfonobz1GaiyuAd9AepKi7R06MHRXEExm4b7BWIL5tAjQn0tw5nevgMX4QXUp4klgEUWMHBRRpIMUSEn9Gz5LEdE/3vBdjNNai+hQ37q2YFp6HPJV8M8EF8EBh8O31CFGID1DvY/HJELENjhzj3fQPvIUOh47dxnRtHCXw3A9nSWAFjda9jtnZ/XGjw7Ef12aNSPdO82YAv7ctQchKojsu3CSDhpEMHJEVaKuE4Dke1YCrhYHBGwTlvhVNiZHggcmpsPbD12/gAfA9f99hm1WB5GorBsRBWGjvg22Rg0mP2FM211oQSLcLFGr3F+P61L/lRFVkbK3ikycjue1IDWXTRPUgfuFKwA/5StiqJo7H50U4QJt6Sk5m4Felfc/bv7/hX0jZku9Wv3sEkdPAEK2om1hu0YFBFMF/j0A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd653cd-dcf9-441c-3a55-08d6a73739e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 22:08:16.2065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_vm() must access kernel symbols in a position independent way
because it will be called from head.S with MMU off.

If we compile kernel with cmodel=3Dmedany then PC-relative addressing will
be used in setup_vm() to access kernel symbols so it works perfectly fine.

Although, if we compile kernel with cmodel=3Dmedlow then either absolute
addressing or PC-relative addressing (based on whichever requires fewer
instructions) is used to access kernel symbols in setup_vm(). This can
break setup_vm() whenever any absolute addressing is used to access
kernel symbols.

With the movement of setup_vm() from kernel/setup.c to mm/init.c, the
setup_vm() is now broken for cmodel=3Dmedlow but it works perfectly fine
for cmodel=3Dmedany.

This patch fixes setup_vm() and makes it independent of GCC code model
by accessing kernel symbols relative to kernel load address instead of
assuming PC-relative addressing.

Fixes: 6f1e9e946f0b ("RISC-V: Move setup_vm() to mm/init.c")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/head.S |  1 +
 arch/riscv/mm/init.c     | 71 ++++++++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fe884cd69abd..7966262b4f9d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -62,6 +62,7 @@ clear_bss_done:
=20
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
+	la a0, _start
 	call setup_vm
 	call relocate
=20
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b379a75ac6a6..f35299f2f3d5 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -172,55 +172,76 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr=
_t phys, pgprot_t prot)
 	}
 }
=20
-asmlinkage void __init setup_vm(void)
+static inline void *__early_va(void *ptr, uintptr_t load_pa)
 {
 	extern char _start;
+	uintptr_t va =3D (uintptr_t)ptr;
+	uintptr_t sz =3D (uintptr_t)(&_end) - (uintptr_t)(&_start);
+
+	if (va >=3D PAGE_OFFSET && va < (PAGE_OFFSET + sz))
+		return (void *)(load_pa + (va - PAGE_OFFSET));
+	return (void *)va;
+}
+
+asmlinkage void __init setup_vm(uintptr_t load_pa)
+{
 	uintptr_t i;
-	uintptr_t pa =3D (uintptr_t) &_start;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pmd_t *pmdp;
+#endif
+	pgd_t *pgdp;
+	phys_addr_t map_pa;
+	pgprot_t tableprot =3D __pgprot(_PAGE_TABLE);
 	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
=20
-	va_pa_offset =3D PAGE_OFFSET - pa;
-	pfn_base =3D PFN_DOWN(pa);
+	va_pa_offset =3D PAGE_OFFSET - load_pa;
+	pfn_base =3D PFN_DOWN(load_pa);
=20
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) !=3D 0);
-	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) !=3D 0);
+	BUG_ON((load_pa % (PAGE_SIZE * PTRS_PER_PTE)) !=3D 0);
=20
 #ifndef __PAGETABLE_PMD_FOLDED
-	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
-			__pgprot(_PAGE_TABLE));
-	trampoline_pmd[0] =3D pfn_pmd(PFN_DOWN(pa), prot);
+	pgdp =3D __early_va(trampoline_pg_dir, load_pa);
+	map_pa =3D (uintptr_t)__early_va(trampoline_pmd, load_pa);
+	pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
+		pfn_pgd(PFN_DOWN(map_pa), tableprot);
+	trampoline_pmd[0] =3D pfn_pmd(PFN_DOWN(load_pa), prot);
+
+	pgdp =3D __early_va(swapper_pg_dir, load_pa);
=20
 	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
 		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
=20
-		swapper_pg_dir[o] =3D
-			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
-				__pgprot(_PAGE_TABLE));
+		map_pa =3D (uintptr_t)__early_va(swapper_pmd, load_pa);
+		pgdp[o] =3D pfn_pgd(PFN_DOWN(map_pa) + i, tableprot);
 	}
+	pmdp =3D __early_va(swapper_pmd, load_pa);
 	for (i =3D 0; i < ARRAY_SIZE(swapper_pmd); i++)
-		swapper_pmd[i] =3D pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
+		pmdp[i] =3D pfn_pmd(PFN_DOWN(load_pa + i * PMD_SIZE), prot);
=20
-	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pmd),
-				__pgprot(_PAGE_TABLE));
+	map_pa =3D (uintptr_t)__early_va(fixmap_pmd, load_pa);
+	pgdp[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
+		pfn_pgd(PFN_DOWN(map_pa), tableprot);
+	pmdp =3D __early_va(fixmap_pmd, load_pa);
+	map_pa =3D (uintptr_t)__early_va(fixmap_pte, load_pa);
 	fixmap_pmd[(FIXADDR_START >> PMD_SHIFT) % PTRS_PER_PMD] =3D
-		pfn_pmd(PFN_DOWN((uintptr_t)fixmap_pte),
-				__pgprot(_PAGE_TABLE));
+		pfn_pmd(PFN_DOWN(map_pa), tableprot);
 #else
-	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN(pa), prot);
+	pgdp =3D __early_va(trampoline_pg_dir, load_pa);
+	pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
+		pfn_pgd(PFN_DOWN(load_pa), prot);
+
+	pgdp =3D __early_va(swapper_pg_dir, load_pa);
=20
 	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
 		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
=20
-		swapper_pg_dir[o] =3D
-			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
+		pgdp[o] =3D pfn_pgd(PFN_DOWN(load_pa + i * PGDIR_SIZE), prot);
 	}
=20
-	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pte),
-				__pgprot(_PAGE_TABLE));
+	map_pa =3D (uintptr_t)__early_va(fixmap_pte, load_pa);
+	pgdp[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
+		pfn_pgd(PFN_DOWN(map_pa), tableprot);
 #endif
 }
--=20
2.17.1

