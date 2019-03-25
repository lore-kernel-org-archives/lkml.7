Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AE62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="elgvGs2Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KftHg8sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfCYJXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:23:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38365 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfCYJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553505796; x=1585041796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oZLQx/tbmS7RddtQdtFXP0JHmxSDGyLjXUkvWjW88fM=;
  b=elgvGs2QQ8hx8MYpk7yjZ6GgMU1tMPN3TU383w3PjkMuCBDca23wPEv/
   hFxzkk8zmzvZ4qlLuqPESDqWqFkfTlLPj7Zu2ZxlLtX11LhhIjMm8YJSt
   RdeQVJAsARQ+nu+xjQZzdFF/vIw3K1T9Mr5tPtEECwA6JWLq1met1P/ZM
   l1BLp9pr4maoA8tUI4mVmWs6OoMnmBp9SXTny/uGDNzBY1ubhM46iOEwd
   AMXviB2lmbXvYGHX+Uo9rDQeXoLKYXwQjQuhBS5V2u0qKRcNvln+AssvB
   SI7wm0V3QJkCO+9Z662e+hbkqm8MRBUv+53scwzxwSCwEo6dLc7GW3o6B
   g==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="109204931"
Received: from mail-dm3nam05lp2057.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 17:23:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMbWwzUIgEI2RuXGcTYocf3iYWj/b3jFpraVcRgdhts=;
 b=KftHg8sbwGWLZAXpNCKv0cl2BmawvAtT59oFjY2EGNRFEaJ94N87wN24JBGuDf+DHznaGMzCJDJz/lIV1MM0Wy6wGV9XMXeuUXGVOHpGWB3T/dGXtU5fpZObVZ46h8qw5iC6Sj++AMyFBwCX01NjN/gIdAqYbAB+oXUBIFM0pvA=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6141.namprd04.prod.outlook.com (20.178.246.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 09:23:14 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 09:23:14 +0000
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
Subject: [PATCH v3 3/4] RISC-V: Remove redundant trampoline page table
Thread-Topic: [PATCH v3 3/4] RISC-V: Remove redundant trampoline page table
Thread-Index: AQHU4uxfMcGWMxjUrU+hAvBpoMjG3Q==
Date:   Mon, 25 Mar 2019 09:23:14 +0000
Message-ID: <20190325092234.5451-4-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: cae6bb68-3a58-4c78-a148-08d6b10381b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6141;
x-ms-traffictypediagnostic: MN2PR04MB6141:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB614149A07EAD2CA89DC875DD8D5E0@MN2PR04MB6141.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(68736007)(54906003)(66066001)(53936002)(446003)(110136005)(71200400001)(316002)(256004)(11346002)(1076003)(50226002)(25786009)(8936002)(86362001)(72206003)(476003)(8676002)(3846002)(105586002)(5660300002)(4326008)(6512007)(305945005)(486006)(2906002)(478600001)(7736002)(106356001)(102836004)(81156014)(6116002)(99286004)(81166006)(76176011)(386003)(44832011)(6486002)(2171002)(2616005)(6506007)(26005)(52116002)(6436002)(14454004)(97736004)(36756003)(71190400001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6141;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rAZ4KyNpctnhJ5CPEbWUjPVV6A7uFXcTOPBl3C0k2Nb9QuOSybNNIzwl74hYI9mV1pE0MCeyclnEB8WJl6RHU6JCPJcuIU0TNnF4rxeb7vcBdxpqTT1eOG9pZiD3m8BSXpNlnjnrVv4uNsi3mCpltHahnO8uecsoxxPfFipy+xbpN7Rwyde7w5Jl4O6diqCdOkD8tTbDelZF9RUG1qU01SvIRkIunuLOGrnUsyEaAGk35Jguj7QjZkaaF5UTY/xK2e8J0/wu0tWH8Jq3UBn3nP0o+h2tW9VLU1fvT7fPIOJn4WvNhOgMavrCapZwCvQ3hLKm9WWFGbIFEqhUo3k/4uOsn9d3Ef+/LdF0hOB7irVgbFztV1rJDgBfWaLFn8NfEHB5XmajE6bhS18mbk8OQPzx/CALYM0QNE0H/v/2iPI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae6bb68-3a58-4c78-a148-08d6b10381b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 09:23:14.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6141
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
 arch/riscv/kernel/head.S | 13 ++++---------
 arch/riscv/mm/init.c     | 10 ----------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fe884cd69abd..3449671ec867 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -91,21 +91,19 @@ relocate:
 	add a0, a0, a1
 	csrw stvec, a0
=20
-	/* Compute satp for kernel page tables, but don't load it yet */
+	/* Compute satp for kernel page table root, but don't load it yet */
 	la a2, swapper_pg_dir
 	srl a2, a2, PAGE_SHIFT
 	li a1, SATP_MODE
 	or a2, a2, a1
=20
 	/*
-	 * Load trampoline page directory, which will cause us to trap to
+	 * Load kernel page table root, which will cause us to trap to
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
@@ -118,9 +116,6 @@ relocate:
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
index 3e66b7cb3a61..f9add4381c73 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -153,12 +153,10 @@ unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
=20
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
=20
 #ifndef __PAGETABLE_PMD_FOLDED
 #define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
 pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned=
_bss;
-pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
=20
@@ -208,11 +206,6 @@ asmlinkage void __init setup_vm(void)
 	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) !=3D 0);
=20
 #ifndef __PAGETABLE_PMD_FOLDED
-	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
-			__pgprot(_PAGE_TABLE));
-	trampoline_pmd[0] =3D pfn_pmd(PFN_DOWN(pa), prot);
-
 	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
 		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
=20
@@ -230,9 +223,6 @@ asmlinkage void __init setup_vm(void)
 		pfn_pmd(PFN_DOWN((uintptr_t)fixmap_pte),
 				__pgprot(_PAGE_TABLE));
 #else
-	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN(pa), prot);
-
 	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
 		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
=20
--=20
2.17.1

