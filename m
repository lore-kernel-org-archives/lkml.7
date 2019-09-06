Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837212053B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392487AbfIFHUy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:20:54 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:39904 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392442AbfIFHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:20:54 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Fri,  6 Sep 2019 07:18:05 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 6 Sep 2019 07:17:17 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 6 Sep 2019 07:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6ce23scdtxLdc7y8abArsDracMcB/50HMaLfL2v+nya54iF0KWdOxUpucp3wJpr+VtiCwwTl44Zx95/Psj5lIlgNgnMZLfEhFc0Vt7msktLOnevl9WqBRDY/MgeMBihD9oUCCl9kZ7Oy3dlTmycBXiTUmbOjlyzUF54yUldT+P8oQ9Clirjq95KL7wDgH0q8iJiFbfn0bqv0KfOadAminID5o8ur5dlkyaq+LAMi5Oeu5jDe84nsozuBecCu6tj3JJNyOnm49gd9Qs/D1AqLge7q6yUGtd4YyXqvEaOWyxd6O6SGtAIV7tnHEdb0CIpqjUIEHBsyHeYasD3q+jsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTdPGuCoAiG0yJYCZE89xJMOVWPqp009nAHsu3p4EP0=;
 b=D9WEk9fvrjBYMiNjWrzQkeZgbrQl0+Lxpp7leoeYfeo8t2L1gDsRUUTD+LfuANsV7aqz1PVBxFSujMQA0RzRf4LZPL4fv5gcvP+80+m5AaArrqIlDYmiyBC3Y7IpNq/5TGjkPJCNAgWr19tG7alcLHbvLbGliudzuj2V20KFynAPO0J0D/O3m1cfOXpO4peZyYQ/btEA8Ej5BiKFkwFu/RAkyOEerC3HDZz+JMNfVNQfZi0a/H+pNfnBICADtm9/3/aXcugZ3unozMlXOODIFsu//kLTilj7Lmo9kqY5XFJcZoDSTJvH9A//i5jJsw8kjxYEThgyoU00BwAanY3ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3139.namprd18.prod.outlook.com (10.255.136.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Fri, 6 Sep 2019 07:17:16 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::a46b:1f66:8378:b25e]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::a46b:1f66:8378:b25e%3]) with mapi id 15.20.2241.014; Fri, 6 Sep 2019
 07:17:16 +0000
From:   Chester Lin <clin@suse.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "merker@debian.org" <merker@debian.org>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rick@andestech.com" <rick@andestech.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Chester Lin <clin@suse.com>
Subject: [PATCH] riscv: save space on the magic number field of image header
Thread-Topic: [PATCH] riscv: save space on the magic number field of image
 header
Thread-Index: AQHVZIMcNduMKr0kk0WFNI6AGCbw5w==
Date:   Fri, 6 Sep 2019 07:17:15 +0000
Message-ID: <20190906071631.23695-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [60.251.47.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f46e4041-a95f-4c1c-8a73-08d7329a3e95
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3139;
x-ms-traffictypediagnostic: BY5PR18MB3139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB3139EF69604CACB6E7D7C6DCADBA0@BY5PR18MB3139.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(256004)(36756003)(486006)(2616005)(14454004)(476003)(2501003)(478600001)(6486002)(186003)(386003)(6506007)(50226002)(8936002)(71200400001)(71190400001)(66946007)(26005)(7416002)(66556008)(81166006)(81156014)(5660300002)(8676002)(102836004)(6116002)(3846002)(52116002)(66476007)(55236004)(6436002)(64756008)(99286004)(66446008)(2906002)(86362001)(6512007)(1076003)(2201001)(110136005)(54906003)(2171002)(316002)(305945005)(4326008)(107886003)(66066001)(7736002)(25786009)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3139;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gwOxo58LCPBFLmm0855bKAeXkUICZfL26NTt0HGsjCnEXntS7OC7RJbl00OHEIKYFntU1RQcwNMHwFSI+qf4K7wDq5nYSYwlHmocHamboW+MzrY0M/jw3duYVGNsNhzjY5oUW65Own5ulibQ74hqrtzf3ECaIbhzDiIGFPLHZLX1Xvy8fP0R1CXlhqLKv/fcHOqyyp9EQfCt+M0OfTLo2H8K+2GJHZO8r0GOBjYzXb4gtnL1myFpry4Gb2j/H2KBrgWSuo6SNLbxsgT9/vRS+HZxoTCI4Tb9XqciPHYNqj+tuPunQfY8wA5C2V216Ypy8qbxrZsffpGA5UPHvhG0ewNp//Jw9dPLAik6y7aMrrNlY04f8XQLTUnzEfGtJg94Uw+hYx3BKU45RTOjhssyUhyrU2mqX+yJMFatZMdlI5I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f46e4041-a95f-4c1c-8a73-08d7329a3e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 07:17:15.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jVT5rwHENlXecm0yziQHeIBI/AN5q8u9tIgpXrOwJW/eM8wbExr6Xud5BL5O93Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3139
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the symbol from "RISCV" to "RSCV" so the magic number can be 32-bit
long, which is consistent with other architectures.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/riscv/include/asm/image.h | 9 +++++----
 arch/riscv/kernel/head.S       | 5 ++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
index ef28e106f247..ec8bbfe86dde 100644
--- a/arch/riscv/include/asm/image.h
+++ b/arch/riscv/include/asm/image.h
@@ -3,7 +3,8 @@
 #ifndef __ASM_IMAGE_H
 #define __ASM_IMAGE_H
 
-#define RISCV_IMAGE_MAGIC	"RISCV"
+#define RISCV_IMAGE_MAGIC	"RSCV"
+
 
 #define RISCV_IMAGE_FLAG_BE_SHIFT	0
 #define RISCV_IMAGE_FLAG_BE_MASK	0x1
@@ -39,9 +40,9 @@
  * @version:		version
  * @res1:		reserved
  * @res2:		reserved
- * @magic:		Magic number
  * @res3:		reserved (will be used for additional RISC-V specific
  *			header)
+ * @magic:		Magic number
  * @res4:		reserved (will be used for PE COFF offset)
  *
  * The intention is for this header format to be shared between multiple
@@ -57,8 +58,8 @@ struct riscv_image_header {
 	u32 version;
 	u32 res1;
 	u64 res2;
-	u64 magic;
-	u32 res3;
+	u64 res3;
+	u32 magic;
 	u32 res4;
 };
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 0f1ba17e476f..1f8fffbecf68 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -39,9 +39,8 @@ ENTRY(_start)
 	.word RISCV_HEADER_VERSION
 	.word 0
 	.dword 0
-	.asciz RISCV_IMAGE_MAGIC
-	.word 0
-	.balign 4
+	.dword 0
+	.ascii RISCV_IMAGE_MAGIC
 	.word 0
 
 .global _start_kernel
-- 
2.22.0

