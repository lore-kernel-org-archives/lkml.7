Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DADCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6152621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="gabbmsE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407022AbfJYIaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:30:08 -0400
Received: from mail-eopbgr710058.outbound.protection.outlook.com ([40.107.71.58]:59413
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405636AbfJYIaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:30:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOelbG6e/Z1PQ/7IvBRUE0TVnKMwXmXmBQpxFVbqS+xJRL5ySPiCEFV0pKkDs2U+UcwZeS7JsbrCBEhnywogT/+I679YyAcT6gPf3KoVUv9gzmkrkv3C2STGqqGWbk8sR39x1PCDRoYj7hEvP9pX+5nyo1/r3lRonWtv6exiL1M/qkXXMVX0EdcOkyRYL44iYl5dqCFMjZur4kC/8uZH5A0iq9IPWXvtO27zAMAEc06JQdGF0PjgHLLpU1ZFUgo88qELHNqj+63VBIagBTBBWlUVEA+TWdDo4DtBv1l3mvTCgaAf08VrRA4s0lBZsH8JMdZ66htYlpg7sAjcCXQ2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Rz61GbAT0OTk7i8YWkOocfdCkMQDbXHTVweKERoYgc=;
 b=KNyYIBmtVi9lIgKI0PllKLwcIvTOFFn0jswJHhzoL1Qoil3zB70sxetAjqMK2aXSTvjoFIM7y+a8hAO6SM02ioXpEwS+JHP/flNyAmwCG7gwC9F90toVc57qFgAbmebVzWweO+4WUeAyyGZdl892YNGc3aNsJfIlEw7NWx2kN/pHEuCypB8x6M9EUIoZv0v3GR4/B43RhbCfSimc7zJiRmMkximQEuCffC3A3R84xqENy0VvNtKnwu4UyyUDGYymFEjGQp8sfw4v5FIOnoUmD3jAkbGlLN+Mx4mTLSo6U6Oa9xDuYzP1LhLYvnFPzzzKiGA3ffOlex4oReCH3XrYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Rz61GbAT0OTk7i8YWkOocfdCkMQDbXHTVweKERoYgc=;
 b=gabbmsE5lmWNd3VogQPNIAj8rc/JgegBRuM9UeEATIWTHna1NPQXhbDJ6Xfph8jb09o29AIyoZcX2ubFb2VzYtHlMN5w6pe5GFwCyhoixiJaD/6SzD26/mwtaXor56oltvs21/C/eyufRM24OmaoOjDRBr9y5FDzeUKQRh8UwiU=
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3751.namprd13.prod.outlook.com (20.180.14.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.17; Fri, 25 Oct 2019 08:30:03 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::c069:f0c7:760b:faba]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::c069:f0c7:760b:faba%3]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 08:30:03 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     "Paul Walmsley ( Sifive)" <paul.walmsley@g.sifive.com>,
        "Palmer Dabbelt ( Sifive)" <palmer@g.sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@g.sifive.com>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "sorear2@gmail.com" <sorear2@gmail.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2] RISC-V: Add PCIe I/O BAR memory mapping
Thread-Topic: [PATCH v2] RISC-V: Add PCIe I/O BAR memory mapping
Thread-Index: AQHViw5l0jY9JQhUEkq6xffYZOywOQ==
Date:   Fri, 25 Oct 2019 08:30:03 +0000
Message-ID: <1571992163-6811-1-git-send-email-yash.shah@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::15) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [114.143.65.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a7ae2d2-c919-40fa-f1ad-08d75925883d
x-ms-traffictypediagnostic: CH2PR13MB3751:
x-ms-exchange-purlcount: 1
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR13MB3751CBC90393882C168AD8B58C650@CH2PR13MB3751.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39850400004)(366004)(136003)(189003)(199004)(71200400001)(54906003)(2201001)(6486002)(86362001)(7416002)(8676002)(26005)(476003)(966005)(186003)(2616005)(486006)(5660300002)(50226002)(81166006)(81156014)(8936002)(2906002)(66066001)(305945005)(7736002)(6116002)(3846002)(99286004)(6436002)(256004)(52116002)(14444005)(110136005)(6306002)(6512007)(14454004)(102836004)(2501003)(386003)(6506007)(478600001)(36756003)(66556008)(4326008)(64756008)(66946007)(66446008)(44832011)(25786009)(66476007)(71190400001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3751;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gOyqL0Cve8csClrQKW6vUZDFgCnceY2KvKaoeGiTQ23lt4YgrrtNHgvMYcSiXFkX1+7qsUKJukHeBsaTM9o6yxkpElDi+seTOLxJN4lbaLpofhQ5NQCAV47/kxoSAFV2gDDY580dfFHS6x2u08qS7wNV7/4jGXzrcalbmq0O285lK6pBqWRjZvOTpqS+SuieK1lvhSYNTJiPSCut2dDb6x8VxeOeAqWVJUB4/GaP2nZbmFGUfcTtaewdtDoT/E7jF0VRhfpeLUH8GbGrRnratOlsV1d7nTYp9XzSamJn/5hP3pFZT+Y92y5JBWTKxcdWdvbsf+YnHJSB7EDsYik7+cskKGOWXHjpugi5kXYtSV4xljNjZuNHf/TH5BKEI00kk0qOFwYUmg+gJVgEPZ8vJuF9mUVRoqc7wBFuPiwNDDTIcKqcAKb2o2d/BAkQpW5UkbGrvIUoLqI+2SpVZO969hzV4n1qbDT3tpYnrHtGgFE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7ae2d2-c919-40fa-f1ad-08d75925883d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 08:30:03.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HatxEUj1ucorqSu81h1KbG3ZjGuZwsR04wB3M/1skUGejBRW2qDhhYRslUafvndgijKgEDlahVmeoUytpclx0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For legacy I/O BARs (non-MMIO BARs) to work correctly on RISC-V Linux,
we need to establish a reserved memory region for them, so that drivers
that wish to use the legacy I/O BARs can issue reads and writes against
a memory region that is mapped to the host PCIe controller's I/O BAR
mapping.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---

Changes in v2:
- update patch description as per Paul's suggestion
https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1910240937350.2001=
0@viisi.sifive.com/

---
 arch/riscv/include/asm/io.h      | 7 +++++++
 arch/riscv/include/asm/pgtable.h | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index fc1189a..3ba4d93 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -13,6 +13,7 @@
=20
 #include <linux/types.h>
 #include <asm/mmiowb.h>
+#include <asm/pgtable.h>
=20
 extern void __iomem *ioremap(phys_addr_t offset, unsigned long size);
=20
@@ -162,6 +163,12 @@ static inline u64 __raw_readq(const volatile void __io=
mem *addr)
 #endif
=20
 /*
+ *  I/O port access constants.
+ */
+#define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
+#define PCI_IOBASE		((void __iomem *)PCI_IO_START)
+
+/*
  * Emulation routines for the port-mapped IO space used by some PCI driver=
s.
  * These are defined as being "fully synchronous", but also "not guarantee=
d to
  * be fully ordered with respect to other memory and I/O operations".  We'=
re
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index 7fc5e4a..d78cc74 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_PGTABLE_H
=20
 #include <linux/mmzone.h>
+#include <linux/sizes.h>
=20
 #include <asm/pgtable-bits.h>
=20
@@ -88,6 +89,7 @@ extern pgd_t swapper_pg_dir[];
 #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
 #define VMALLOC_END      (PAGE_OFFSET - 1)
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+#define PCI_IO_SIZE      SZ_16M
=20
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
@@ -102,7 +104,10 @@ extern pgd_t swapper_pg_dir[];
=20
 #define vmemmap		((struct page *)VMEMMAP_START)
=20
-#define FIXADDR_TOP      (VMEMMAP_START)
+#define PCI_IO_END       VMEMMAP_START
+#define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
+#define FIXADDR_TOP      PCI_IO_START
+
 #ifdef CONFIG_64BIT
 #define FIXADDR_SIZE     PMD_SIZE
 #else
--=20
2.7.4

