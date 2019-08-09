Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCEDC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC422214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="E/Kj2b5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407373AbfHIRhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:37:32 -0400
Received: from mail-eopbgr760118.outbound.protection.outlook.com ([40.107.76.118]:60740
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406606AbfHIRhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:37:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQUmL38nmEvV31LAH2NJNKyd5ZnJkc519hoDyw+9gLKlXVuyB+xWFRXoF8GVY7IAGxG6lVL45HOcOAIo9X2oMomJuSmaTpxeI73Tm2+RhR3sHxS3/7m/t7QdJDoCCPguYAgmUu/Ljafh58FpxkzHkBpNBoYdeFx3YbDz99r13eNvUfa/XZI4+/aFqLTQAdrgN/w+gl8pqgmjS9Psv/iFGFgVAWq66sNkL9Qd2uJUnRqoGXa4N4EBhvh9kc7MkEmVljYiwJlaHT7hNUHwXa3mnN7Fm0bk1iE851GnQeAZZ8W1lD4s9DZlFxNi34IcD6GhegJPvkLjo8xtcfgzhtpiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPmTa1IVwAlnaQ2T5o4S/A8TEHamvSIf73w5sViDFL8=;
 b=bIncvhSjiHZRDpKqE4cdpXmNsK/rmAZGNaS09324S53X53yhBX2W+QJOEgLe6+UGKAydhC/ZZHxaXYmZzivRuIb1TQlSqWhXkwXvk844Qcl+ReJSgJVtHEZYmsFsxL7fa5HxoTGL/AGOCoagAd0UeGt/9gFWH2XL3TBJlQhKtXRF94VlrUNf4oU9d8d+H3XIw3fj2DcqnmTcqC3Km7+aPJ2wU2ZCPahhERSBD3tTABEgQpHGVUngiGza+ae9i1I3sauXHZ/mJePIPvKlZlAV5qVe5HLWXtqV5HlnDgCWZ3a0q+RNFX2fG71ogQSVidN+ZDNCEP6EteldYFRnWXuh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPmTa1IVwAlnaQ2T5o4S/A8TEHamvSIf73w5sViDFL8=;
 b=E/Kj2b5BbWPVAVDjE3fsZqS4jHuFaYV1d9mrwFjLpuP0RMHIlwu/wG52+hud3IikGf5+igtDZrmn/SZAGR4zIk5eFFAt0pif38uG7IttkojJ7Gv50uWCxGB7lbBuDFuQmiZmYhfFH+ZQmvIqeqQnApG7D9B0Ooep8YzPb/iHFO4=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1453.namprd16.prod.outlook.com (10.175.3.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 9 Aug 2019 17:37:28 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 17:37:28 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V6 1/3] mmc: sdhci: Change O2 Host PLL and DLL register name
Thread-Topic: [PATCH V6 1/3] mmc: sdhci: Change O2 Host PLL and DLL register
 name
Thread-Index: AQHVTtkdH7jLrtWrg0qlL9dujbetyg==
Date:   Fri, 9 Aug 2019 17:37:28 +0000
Message-ID: <1565372245-4598-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36)
 To MWHPR16MB1455.namprd16.prod.outlook.com (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b36c8144-2f93-42f5-7919-08d71cf03f89
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB1453;
x-ms-traffictypediagnostic: MWHPR16MB1453:
x-microsoft-antispam-prvs: <MWHPR16MB14532B3389818C097CFBC1368BD60@MWHPR16MB1453.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(64756008)(66446008)(54906003)(53936002)(305945005)(66066001)(8676002)(7736002)(2201001)(110136005)(71200400001)(71190400001)(476003)(508600001)(66556008)(66476007)(66946007)(316002)(107886003)(6512007)(6436002)(36756003)(8936002)(6486002)(2501003)(14454004)(14444005)(86362001)(256004)(486006)(50226002)(5660300002)(81166006)(81156014)(3846002)(6116002)(6506007)(386003)(2906002)(102836004)(4326008)(52116002)(2616005)(99286004)(25786009)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1453;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DWdHKikN+hxBFwFForn3NkZ4UCR/oAVLX+pbzonZ+C3D93AkI7m5qMzUczU2vXuWtpE/r8iTC0K19CBaDZtZ2ZetLqHgJEKjJryo+6ww6sLn36AOfGb+ce9eUV3RizxxJhKoLgEuMvmNPCILtr+tOg0aTr6GkXkxHQiMd3U3i6t9L/37n2NkxhGp0Ofk11bAVp33zJdlCkY5d/y24h52XpfkIRph795eQ9lQdwGqLK26IdVnMni0UjUPODXf0p+uNoIqYgWOcM6Udq7HEOVgxRNwSOCTKmMoeg8m04IHAfEBjrlbYkOrnhjQ13Jn7BBU6ZN7SXaOXPpr/k0Gbpy0i4UVITcTOnj5t7sRkgG/OnOARP2Aezi6tStcys10Cfyt+zwwwhSccM+PwpyXDzYT1M77ji8BkxancEr5Yf9rXvo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36c8144-2f93-42f5-7919-08d71cf03f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 17:37:28.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7G1XzgtCBjXgd032C/Gj8WLunSK0cH/D0scLUrGwg03onMOcr62eANH6iZA+nUzf+3lL+7ER4QhGyC9qlQ8JukUyIwpnKZ5J05SuhMA/CfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change register name O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1

Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
---
change in V6:
 1. change subject and commit message to match the patch
 2. change register name O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1

change in V5:
 1. split 2 patches into 3 patches
 2. make dll_adjust_count start from 0
 3. fix ret overwritten issue
 4. use break instead of goto

change in V4:
 1. add a bug fix for V3

change in V3:
 1. add more explanation in dll_recovery and execute_tuning function
 2. move dll_adjust_count to O2_host struct
 3. fix some coding style error
 4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1

change in V2:
 1. use usleep_range instead of udelay
 2. move dll_adjust_count to sdhci-pci-o2micro.c

chagne in V1:
 1. add error recovery function to relock DLL with correct phase
 2. retuning HS200 after DLL locked
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 9dc4548..b3a33d9 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -51,7 +51,7 @@
 #define O2_SD_VENDOR_SETTING2	0x1C8
 #define O2_SD_HW_TUNING_DISABLE	BIT(4)
=20
-#define O2_PLL_WDT_CONTROL1	0x1CC
+#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
@@ -316,23 +316,23 @@ static void sdhci_o2_enable_internal_clock(struct sdh=
ci_host *host)
 	u32 scratch32;
=20
 	/* PLL software reset */
-	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
 	scratch32 |=3D O2_PLL_SOFT_RESET;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
 	udelay(1);
 	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
=20
 	/* PLL force active */
 	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
=20
 	/* Wait max 20 ms */
 	timeout =3D ktime_add_ms(ktime_get(), 20);
 	while (1) {
 		bool timedout =3D ktime_after(ktime_get(), timeout);
=20
-		scratch =3D sdhci_readw(host, O2_PLL_WDT_CONTROL1);
+		scratch =3D sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
 		if (scratch & O2_PLL_LOCK_STATUS)
 			break;
 		if (timedout) {
@@ -350,9 +350,9 @@ static void sdhci_o2_enable_internal_clock(struct sdhci=
_host *host)
=20
 out:
 	/* Cancel PLL force active */
-	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
 	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
 }
=20
 static int sdhci_o2_get_cd(struct mmc_host *mmc)
--=20
2.7.4

