Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D4FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0926222D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kec/I08L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S4Unffs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfCXLId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 07:08:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64007 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 07:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553425713; x=1584961713;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hZDGOxcobjieLc5iMS704AquYL2W1KD6wdIksOJRHXo=;
  b=kec/I08L63n3I3JyXWvUsqWHJdlL0DqxlsktywKD1/em8aTzf7p9unjm
   hWvoxailrJYHFOAe7rljngxBZoxSGkQE0fBDf/HupqW8yfXIPQ62/+Y4l
   wA06sjUYLf1zl0rmScvmbeh4DeEPX7upqAcyklHddHRoKaetUEmCIpDQ1
   BSLL1QVvKymdx9NrkbR/YK4gXv946xHzs2tdRzO+l2edWTOMWODH9B/fA
   kNg/2vaP/BqJvI0iUs/jIGAtmCwqSBFPxKynfVA7aIoa841gwkgZy2DsN
   GnD2rfUUZM269nR59fBh+M3UNNnrSoaJNH6H7W1VpDmoxATsHFT6iJpfK
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="109153273"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2019 19:08:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4utTWQaBZDTuAPm9HAvnSyLgVEp1V/0TZT2mXbfuqo=;
 b=S4Unffs1lylUHu74Fb6+vTlRPOVoJ2W/6B6Qzu0jjuLuahS9it+3Alpuz52QpqT3G57ciLN0KWzlV/rp3Do0uQ2TEanzs+uzpUpfUlnWNbEvnjspTLBx0o0Y+3PUjFNqMxsTLZppNEDRuFfBfeNVl0GoIUPzI3BktM/oJPC/Bx8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6029.namprd04.prod.outlook.com (20.178.246.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Sun, 24 Mar 2019 11:08:30 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.017; Sun, 24 Mar 2019
 11:08:29 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] RISC-V: Always compile mm/init.c with cmodel=medany
Thread-Topic: [PATCH] RISC-V: Always compile mm/init.c with cmodel=medany
Thread-Index: AQHU4jHpL1gWnGWPrEKT6h8SWH7WMA==
Date:   Sun, 24 Mar 2019 11:08:29 +0000
Message-ID: <20190324110804.68555-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::32) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.23.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b1590bf-f84c-422f-f115-08d6b0490bc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6029;
x-ms-traffictypediagnostic: MN2PR04MB6029:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB60293A0AA774860794DCA7C68D5D0@MN2PR04MB6029.namprd04.prod.outlook.com>
x-forefront-prvs: 09860C2161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(8936002)(36756003)(486006)(14454004)(81166006)(4326008)(6486002)(186003)(386003)(2906002)(25786009)(8676002)(6346003)(55236004)(476003)(86362001)(81156014)(110136005)(54906003)(99286004)(72206003)(316002)(305945005)(6116002)(9456002)(478600001)(50226002)(105586002)(7736002)(5660300002)(106356001)(66066001)(14444005)(71200400001)(26005)(78486014)(52116002)(1076003)(71190400001)(68736007)(256004)(3846002)(2171002)(53936002)(2616005)(97736004)(102836004)(44832011)(6512007)(6506007)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6029;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RwN/r5MStus7Xb76Aa7a3jqRXAnVVIHgNutVqPod1RY6kZmX17dIYKVfG9DJytNEY00YZU+PlwkxWhAqlmShpxerhwsNl+0uu27Y7sRLUV4eiNbVL+I93Av5uVCGyVvFWyfA6yhUuRhLkEmLfuZDxleCxi+SLv2VvIW0/cK21m01qfKkjajVhBImLQmtbeYr/N/J0teoKNA4MPERR95NnzjqqmOJG/V8MZYBlRnEgp9enqQ4dWKRUW1Z2bjg8XSdwgUW+QQ83yBqdRLymOhKyVJ6UGvVgmPbXIOVif0jVQ1hyFBusQ/11BAE1tsZX8BEwuDLiDyFU8jSOqBa7wbPhfpLgcXRD951uNhPk8raVZmw9DEP82ozBISTFfcecpAfCajf4VZvOOrmH68yhH+U6AfqxC/pqdWz0HFKxxI4UIw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1590bf-f84c-422f-f115-08d6b0490bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2019 11:08:29.8961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux RISC-V 32bit kernel is broken after we moved setup_vm() from
kernel/setup.c to mm/init.c because Linux RISC-V 32bit kernel by default
uses cmodel=3Dmedlow which results in a non-position-independent setup_vm()=
.

This patch fixes Linux RISC-V 32bit kernel booting by:
1. Forcing cmodel=3Dmedany for mm/init.c
2. Moving remaing MM-related stuff va_pa_offset, pfn_base and
   empty_zero_page from kernel/setup.c to mm/init.c

Fixes: 6f1e9e946f0b ("RISC-V: Move setup_vm() to mm/init.c")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/setup.c | 8 --------
 arch/riscv/mm/Makefile    | 2 ++
 arch/riscv/mm/init.c      | 9 +++++++++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ecb654f6a79e..540a331d1376 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -48,14 +48,6 @@ struct screen_info screen_info =3D {
 };
 #endif
=20
-unsigned long va_pa_offset;
-EXPORT_SYMBOL(va_pa_offset);
-unsigned long pfn_base;
-EXPORT_SYMBOL(pfn_base);
-
-unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_al=
igned_bss;
-EXPORT_SYMBOL(empty_zero_page);
-
 /* The lucky hart to first increment this variable will boot the other cor=
es */
 atomic_t hart_lottery;
 unsigned long boot_cpu_hartid;
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index eb22ab49b3e0..7307609d405b 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -3,3 +3,5 @@ obj-y +=3D fault.o
 obj-y +=3D extable.o
 obj-y +=3D ioremap.o
 obj-y +=3D cacheflush.o
+
+CFLAGS_init.o :=3D -mcmodel=3Dmedany
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b379a75ac6a6..1e7a106fb583 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -25,6 +25,15 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
=20
+unsigned long va_pa_offset;
+EXPORT_SYMBOL(va_pa_offset);
+unsigned long pfn_base;
+EXPORT_SYMBOL(pfn_base);
+
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
+							__page_aligned_bss;
+EXPORT_SYMBOL(empty_zero_page);
+
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES] =3D { 0, };
--=20
2.17.1

