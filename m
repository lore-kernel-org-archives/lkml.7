Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E505C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319E92087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LGfkcTLo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MQ8RFhCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfCYJXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:23:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38365 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfCYJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553505792; x=1585041792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b2Hcnvhs/KQE69U8P6G3S5MngiqqExuoY7qv0k4i8Xc=;
  b=LGfkcTLoFjL9hsGCflrNt5TFk7Ake4WkYnB8ziBuImOtia2J9CuEW67M
   rTsj/x+EkWQg2opF87/Mf3zC95Lp0KS8/INbYk04JU5MAPyh7nasIF/As
   NTDhzy5gMUV/F7jBOjWV47fXJllNAAB2KMPLs43Hqo5sbSqJ+6uHjWRLs
   tccA6TdwQrQ9Vc6I2qzCRwgM/acpAS1cSP7Q06I9RRYm9hhAKI9OHKF6m
   SOOMIhAlPTBeLaySRGh7dEWD99qdZTaj439lBvgE/KsmLcDdmsoCMAFhW
   e0QZdGk1zhcFQT4fBG5BsRoo4WotsTWURgJHAhS7gRc4c47eCCHH+9m/R
   g==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="109204925"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 17:23:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0rneJZ/QSkyAghrGkwdoL0DeAQ8ccbq6Hva5aLbwVY=;
 b=MQ8RFhCEDPalEqGP283SWEkWdLy+a+BgWDau+wDxfAJ+Awt2ISZqFoStLzMWadLzfdf7leYnm5v1Ug1bvwAkdO19ynu5roPGOAMxn5t3qwQZbQEQiJYms1a6Z3eSsgKgmFkLsDt5TjljfpqcyFG38FpJmH4fIRA8HuIjT5gL6sU=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6141.namprd04.prod.outlook.com (20.178.246.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 09:23:09 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 09:23:09 +0000
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
Subject: [PATCH v3 2/4] RISC-V: Fix memory reservation in setup_bootmem()
Thread-Topic: [PATCH v3 2/4] RISC-V: Fix memory reservation in setup_bootmem()
Thread-Index: AQHU4uxcyWJzHoWFE0yGh9y5j2+2Mw==
Date:   Mon, 25 Mar 2019 09:23:09 +0000
Message-ID: <20190325092234.5451-3-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 8483ec23-c78d-44a2-aaac-08d6b1037f16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6141;
x-ms-traffictypediagnostic: MN2PR04MB6141:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB61419A338F1C04439F17636D8D5E0@MN2PR04MB6141.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(68736007)(54906003)(66066001)(53936002)(446003)(110136005)(71200400001)(316002)(256004)(11346002)(1076003)(50226002)(25786009)(8936002)(86362001)(72206003)(476003)(8676002)(3846002)(105586002)(5660300002)(4326008)(6512007)(305945005)(486006)(2906002)(478600001)(7736002)(106356001)(102836004)(81156014)(6116002)(99286004)(81166006)(76176011)(386003)(44832011)(6486002)(2171002)(2616005)(6506007)(26005)(52116002)(6436002)(14454004)(97736004)(36756003)(71190400001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6141;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wTeay75ym4pOSj+DXrc/EGDY1zL7k/RbkYUY1LXjk0U9mbI6XFsnQMffbDyuQX2A3myOtq8c7qawJfLZoXUgYx08PQdVX1UiPaGMb96tRXRrqa/5qPXXvedWQz+qjggA8t2ufh+8EAVdVWrKhlktLXkBD9cADDIxqV9nr44EjGbRoeIuFXCsWNwOwAQ1pGf7gos7yfVjoxCbljyFGbAhJJfx9mErRprWd9nV4P9ahtmHo4wvnlcS0GCmRYjGX3ku474fe8BgWgjFjS+AZnVrBaCaG4SEiBK4eEJ7NSaxMp4iOLewLT6jBfijKyk/W0i1umvMn79bnE8+Iwdo3Dtn8B5rYJPZ37mEZI2/3Q7bY4WmtAIMERREPkF4Ck0hdKKmseqOEu3Hr4A6QJvztFkr1q9sXPLJc17bqc3rk2Vdgwc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8483ec23-c78d-44a2-aaac-08d6b1037f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 09:23:09.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the setup_bootmem() reserves memory from RAM start to the
kernel end. This prevents us from exploring ways to use the RAM below
(or before) the kernel start hence this patch updates setup_bootmem()
to only reserve memory from the kernel start to the kernel end.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/mm/init.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8cf9ff1f9058..3e66b7cb3a61 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -29,6 +29,8 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned=
 long)]
 							__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
=20
+extern char _start[];
+
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES] =3D { 0, };
@@ -108,23 +110,21 @@ void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
 	phys_addr_t mem_size =3D 0;
+	phys_addr_t vmlinux_end =3D __pa(&_end);
+	phys_addr_t vmlinux_start =3D __pa(&_start);
=20
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
-		phys_addr_t vmlinux_end =3D __pa(_end);
 		phys_addr_t end =3D reg->base + reg->size;
=20
-		if (reg->base <=3D vmlinux_end && vmlinux_end <=3D end) {
-			/*
-			 * Reserve from the start of the region to the end of
-			 * the kernel
-			 */
-			memblock_reserve(reg->base, vmlinux_end - reg->base);
+		if (reg->base <=3D vmlinux_end && vmlinux_end <=3D end)
 			mem_size =3D min(reg->size, (phys_addr_t)-PAGE_OFFSET);
-		}
 	}
 	BUG_ON(mem_size =3D=3D 0);
=20
+	/* Reserve from the start of the kernel to the end of the kernel */
+	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
+
 	set_max_mapnr(PFN_DOWN(mem_size));
 	max_low_pfn =3D PFN_DOWN(memblock_end_of_DRAM());
=20
@@ -196,7 +196,6 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t=
 phys, pgprot_t prot)
  */
 asmlinkage void __init setup_vm(void)
 {
-	extern char _start;
 	uintptr_t i;
 	uintptr_t pa =3D (uintptr_t) &_start;
 	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
--=20
2.17.1

