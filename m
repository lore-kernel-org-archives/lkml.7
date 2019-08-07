Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A2BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56973217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="ZKmfcXpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbfHGVJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:09:16 -0400
Received: from mail-eopbgr690119.outbound.protection.outlook.com ([40.107.69.119]:63430
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729938AbfHGVJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:09:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieSADLgqqv1u08MPdMKFy1rPvw7CrUgR3bELvb1AeHdOi35b515h74uiiOybpjMw7W0DVidqo+gNp71OIoeN7WGMFFx6ZU8AAQBBqd7NmL394y7y12TEvzYGEm2QVgd2L3jsYDkk0FSpFhmG0c2g2U30l+mO8ZyOjsQa6Q5tepbe9yUCK09shBXp9RdL7oJvPwixDbW2SkoiMgwPa88z2vzvXXJFgyripaRDrk2qVBgfVsLQI7Qr4IfgEXmuw6h1057jDXwcpI7ERWYQ0CiF83/1Z4LuB+ZSoEEwV1wDERQwH9qr2CWwHwOr9lj0yukBCDZ5/Dv8mGlQvOoJu1LLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhLfe25n5aO+ttsiVVE2h7Re3/yTbMDkDPanvxrzprk=;
 b=QaCFmmD3sQj296f7jPPlwZ6wXWOdXjJFvy+qF+rJC0UgSKFldb3VdMk/pXO2HgebkRDGA9QrgX77p0yzJjPOS9LROySeHqSTzkclir+IvyfOnjjtPVf1vJTa8XMjQh24Ylw9NnGjXJ9lnNbgqCTrRQUCr+177ccgo72sC7itwcXd6FZeQlsJs14B1trZIMkLMgSdmMfsvdBWg/bibxvgTjU2eFkcacBaAg9bbzOFRraBl9RNiENGFPzgcdu7E1VYPRagVY9w3ITIL+yXx/bLm7Rp276uPpWtmGXI5dzelObR7RnsN4Pnl0LPMU8INAdysDf6TZCz/QjfF2jqNrcQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhLfe25n5aO+ttsiVVE2h7Re3/yTbMDkDPanvxrzprk=;
 b=ZKmfcXpNSb3AzbP/HwTLAOEs5zcc/pf1LxqWb9iFUZCNPV+16gNuPhiAX62gkwECeqNJEDR0LGESL0rtbhNMsYTU7yzxJsnpPb4VbXAsYzrg/Rwa5To2EOGH+KCOm3fUz417EBXH7XiRWCQ4PqG9dLU8ZVWOiaB2mgzQzd11ZCw=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB0048.namprd16.prod.outlook.com (10.172.101.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Wed, 7 Aug 2019 21:09:12 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 21:09:12 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V5 1/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock Phase
 shift issue
Thread-Topic: [PATCH V5 1/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Thread-Index: AQHVTWRchmH6ehvVVk2yBe6zaZNnAA==
Date:   Wed, 7 Aug 2019 21:09:11 +0000
Message-ID: <1565212148-30092-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:300:13d::29) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8402fdfc-8141-41d1-5d79-08d71b7b7eb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB0048;
x-ms-traffictypediagnostic: MWHPR16MB0048:
x-microsoft-antispam-prvs: <MWHPR16MB0048B7E85C00FD72A90FC8138BD40@MWHPR16MB0048.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(366004)(396003)(346002)(136003)(199004)(189003)(6486002)(102836004)(14444005)(71200400001)(71190400001)(256004)(386003)(6506007)(4326008)(6436002)(486006)(508600001)(25786009)(52116002)(5660300002)(50226002)(86362001)(64756008)(66446008)(66476007)(66556008)(2201001)(66946007)(110136005)(66066001)(305945005)(7736002)(107886003)(316002)(186003)(6116002)(81156014)(81166006)(26005)(8676002)(2501003)(54906003)(2906002)(36756003)(2616005)(476003)(14454004)(53936002)(99286004)(6512007)(3846002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB0048;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rSd/uBVd6kApJjU2czeKXopTfFeUqQuhmZCVtHplP/qeD7ab5eYCvMNSw0IVIc2NC55h3ARzttEot4985aclnEXxYzqsFs3KkRU4vacRsNzLMnI4pm2OSg8Y2n33HSnti4MpTgb11CjkxzdAuU9lTwNelkMCe1yuXok2Pd5V2ryfW2mM3+NWN7c95O/KXG3Ysf9y3meJ3ZV26iznQfIxPF0YwoYYLlgNp6EwxgAoKYuhHHcOovXSioeeYHjKx6RZP7e7YLlTG8XC6/D4gK3ixZasP+vEQh4HKH/+IuHHenoYKGEvyRAPiB8CiYqP/xFLqgvMFAfObofBWJnw6ESxEVqJPcBcwk6kRjPVjvJBQ+GqrhQxFyjo72nhA1ZMytkkkH3PW33v/OAuoAay0/dnIQamq7whSQLk1Gqv5687yoo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8402fdfc-8141-41d1-5d79-08d71b7b7eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 21:09:12.1985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shirley.her@bayhubtech.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB0048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
---
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

