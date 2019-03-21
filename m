Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA28C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902B7218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qrIjZ77m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YV4A9AA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfCUJsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:48:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33304 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCUJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553161682; x=1584697682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q6hXRzC0vGA645ktNicxb3BEemwCUqYLlnUqgkKeibE=;
  b=qrIjZ77mNl0IvV0w9BjFCptV3Sry+iaZKuudtfrbe+Lr/oH32DM/L+ML
   MT5obrWDP3nI1NShouQyrbPowLLO2oqtyrcs7WT5qR62AjbnxNIiVi9Pu
   nFvoVC5LY6SLINrqEbd94b73KtPGM/LM7vn9WmRCrd62YkSCk14CUkSeQ
   DfIpgKLZD36ewBhWJfOLNtAXI8JBQBvRb82v3ow4slAwBUDVIQKP5OzcC
   wT3QUcbdluHZ7FIr08A4Sg1jENdBWLQGCDQnRzoOTm4HdHwy34iFLeiae
   l8V4Gtrzx7t5r8if2sIWXssa3z0WRkmyqHU0Z5YyYMXUWBYk9Pck/+utA
   A==;
X-IronPort-AV: E=Sophos;i="5.60,252,1549900800"; 
   d="scan'208";a="105647572"
Received: from mail-by2nam05lp2053.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.53])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 17:48:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LbwOC8XHClkPLqdxM/n9B1nf499u0WZ63uDkO9yh54=;
 b=YV4A9AA0s8p93yLutItilWhmdWe2FfRLk+lLWcH46KyrJH/w49GsXSA+pzspkGgfKrafBOLpzsD6YIh2jacQwhdPYmyCYwUh70BOj2cD2xwpDREq2l182dR76mnqR5PTGpRIUV/8AcN+L92z4oOyesR2YR2Mf8lPsmHPsMB8qa0=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5757.namprd04.prod.outlook.com (20.179.21.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 09:47:59 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 09:47:59 +0000
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
Subject: [PATCH v2 5/5] RISC-V: Fix memory reservation in setup_bootmem()
Thread-Topic: [PATCH v2 5/5] RISC-V: Fix memory reservation in setup_bootmem()
Thread-Index: AQHU38sqoeGxllaIbUykcsHRC35P2A==
Date:   Thu, 21 Mar 2019 09:47:58 +0000
Message-ID: <20190321094710.16552-6-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 177279ee-b41f-4faa-49d8-08d6ade24d20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB5757;
x-ms-traffictypediagnostic: MN2PR04MB5757:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5757890C2563B5CA57C7995B8D420@MN2PR04MB5757.namprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(54906003)(1076003)(68736007)(110136005)(316002)(6436002)(81166006)(2906002)(78486014)(8936002)(5660300002)(25786009)(50226002)(6486002)(52116002)(102836004)(6506007)(36756003)(386003)(26005)(9456002)(186003)(76176011)(97736004)(99286004)(11346002)(446003)(476003)(486006)(2616005)(44832011)(81156014)(105586002)(14454004)(4326008)(72206003)(106356001)(256004)(86362001)(55236004)(6512007)(71190400001)(7736002)(71200400001)(66066001)(3846002)(478600001)(305945005)(6116002)(53936002)(2171002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5757;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eb3W4JB1Mdxp/nq209Dc01qXKnHHc2l03eOvJOgRGR0M7lys0Ltd1157F1RvBDAC9AYzrGCVEQmypGkFjjOmyvWOVfiNaJGPeSADMNorTlqyu/Y2iztwhIqx+L9C6VnRPaIBCYwY1fckkXIuPhNfVCWGABIPo0v3jsCclR6tgMnJWGW7O8ldX6tXVGaOSqUKIwAHB8+8quGrO/wpputA00DFGT89qpS+ehFzAMXZv7I8n8E4Kq28rAcMOujzQJP/K8QWYcrC8Idhb7KazgAhEHYbc27zMtvbEx5M3CCSc7hGrysrMozt+upOBsEitLaZ1yTwwNg9+bQcalhAsP/YsDOVz9alf9Bbae7LkLloHk9HJNiu+Tj6xaVgRTbLOfIsgppatsWZrz3PqSqR5M3QMYL4sQ4djhJEU9f5sHodBK4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177279ee-b41f-4faa-49d8-08d6ade24d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 09:47:58.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5757
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
---
 arch/riscv/mm/init.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2e2f2567964c..99b42380d17d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -18,6 +18,8 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
=20
+extern char _start[];
+
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES] =3D { 0, };
@@ -93,15 +95,17 @@ void __init setup_bootmem(void)
=20
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
-		phys_addr_t vmlinux_end =3D __pa(_end);
+		phys_addr_t vmlinux_end =3D __pa(&_end);
+		phys_addr_t vmlinux_start =3D __pa(&_start);
 		phys_addr_t end =3D reg->base + reg->size;
=20
 		if (reg->base <=3D vmlinux_end && vmlinux_end <=3D end) {
 			/*
-			 * Reserve from the start of the region to the end of
+			 * Reserve from the start of the kernel to the end of
 			 * the kernel
 			 */
-			memblock_reserve(reg->base, vmlinux_end - reg->base);
+			memblock_reserve(vmlinux_start,
+					 vmlinux_end - vmlinux_start);
 			mem_size =3D min(reg->size, (phys_addr_t)-PAGE_OFFSET);
 		}
 	}
@@ -177,7 +181,6 @@ struct mapping_ops {
=20
 static inline void *__load_addr(void *ptr, uintptr_t load_pa)
 {
-	extern char _start;
 	uintptr_t va =3D (uintptr_t)ptr;
 	uintptr_t sz =3D (uintptr_t)(&_end) - (uintptr_t)(&_start);
=20
--=20
2.17.1

