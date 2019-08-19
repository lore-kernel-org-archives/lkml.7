Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8948922CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="yvitK1RS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfHSWJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:09:07 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:47251
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728136AbfHSWJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:09:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf5ywf1nbiKtLuPnWTgWnGRJwEyZPa5TcxKMkBTGL4u1ou2AxVyJM4U/SycQlOXJygz53PAVVpIWF/i0HIFo7EAVJLyJQRorXRarGkA8wZi6wSnHS5yVjQ6UqoA3E6u2vPtW9abuFTnLl16FoyZQorkf2gUxARusFqebQas6zw4iR12/hMoXteo+EABbzCaj8I/Q8fosFhFkicF9rB5UBqCc8fZSLhcJ4SW7TbOb9e2rdnKsBL/zHKa4vr7TlRsGTwHaJSP6xHQ2hYWr65Ajrt7PM3DHIVkT++RQeFhohZEXVMAf7G/dDsJx8BV+ImdSStjEO7pKw33GmrbXlPiPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRR8S1mnSJOCgzbypLKLkPBmqnueSe4S54pZNiJpsCI=;
 b=eHlf0Gdee/p4WAbe01ToD0hZ9wFgB70YMkZghyFrAq6K6y6a9Y3r1wWpLPExkFtTYpAVZ/TtpSxfUnRFdW3ZVXLKS+hCILk99DjB+2s1KMhRAvx0YDK4b6FHY7q4ECE9kLeZ/+nZOn3ghL/9iFTI7KImphZ4fu/nP6oii7k85FUR2CU6iOm2M3jmypwfMSiCnJTVG/xW92eKJZbo6tkSZ4dbZHOVTU4RB6D9RoMWGLmErC1VmkRUpygw7Odu7lEjL+W3D9awE7mbvA3VxWj15hVzU6yFMU7NvDX2bQtBhcn9qlBUpddK50Y75KQuV1Ddonhkl1MHGFDF/1wJT6jpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRR8S1mnSJOCgzbypLKLkPBmqnueSe4S54pZNiJpsCI=;
 b=yvitK1RSly3C0zc5v7DOa9DrOjsL7tAkC5X1Tpvn7kx19sC0nLDGPSa0HUnprwrPeb4M/uf5r300a7n03HlHO3Izupu+lZi6o2RuHpgW+UMKFJSdQbRmqelcgehUPKGy2BfEaDS6Na/8EDeNAV5KVPNJQaHG4pJZG1MccKl2GwI=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB0029.namprd16.prod.outlook.com (10.172.101.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 22:08:59 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 22:08:59 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "max.huang@bayhbutech.com" <max.huang@bayhbutech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: Subject: [PATCH V7 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL
 and DLL register name
Thread-Topic: Subject: [PATCH V7 1/3] mmc: sdhci-pci-o2micro: Change O2 Host
 PLL and DLL register name
Thread-Index: AQHVVtqzFqVTlLM1zkeLMCRoVPRLGA==
Date:   Mon, 19 Aug 2019 22:08:58 +0000
Message-ID: <1566252529-5074-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 529d2554-160f-43aa-b9f7-08d724f1d58e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB0029;
x-ms-traffictypediagnostic: MWHPR16MB0029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB00294FFDA7426FC97CB774EE8BA80@MWHPR16MB0029.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39840400004)(366004)(136003)(189003)(199004)(5660300002)(2616005)(476003)(6436002)(107886003)(86362001)(486006)(26005)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(66066001)(2201001)(7736002)(102836004)(36756003)(256004)(53936002)(8676002)(6486002)(6512007)(14454004)(81156014)(8936002)(186003)(6506007)(386003)(2501003)(4326008)(25786009)(14444005)(50226002)(316002)(3846002)(305945005)(2906002)(6116002)(110136005)(54906003)(81166006)(52116002)(508600001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB0029;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U9iko5eYYq6Z6BMdBXBmxp+DlFAbVRcQbcb5N8ohT95Gjfaq8RuFfPqKAy52b0AXvqCDzZJWSalCD8EBj8a5cQiaw2Fyevp9Pr7nwg9XJ6IaJ3kDkuV5zcKwekQNPeHnWfroqvdWkXYUrla/l9dfhdrl+UMqqqF+uw6kk6VR+GV9nzPJP4rfgwYngnnKsQGT8h6xLVsDSSF3wvQleK033toVO20NWaxx/UKmK17u2ek6ersnfA0cTgdiP+VCaCVsWpp1OxsCgYTQpzVsqMdV6DNgH1qBOz4ASJ4XwDF74AZYe9yoWNXUnUcm6a8TyvLUSTEY11W1KGq3//cz0wJXDJVaO+SoPk4jW6Qo10VaH0UAqgu+qNQQnKFZDXhaCqFEgZhrndTVO4c88I9S3NfZAUT5h6X9CDzk0kKjZMz+z/k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529d2554-160f-43aa-b9f7-08d724f1d58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 22:08:58.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YqnYSB9qhP7f3fc1HCmKpVw3pT5Dy58L7ll4Boc4Q9gPhHaEHZnX1Is3nCDdbpQGpI7VJA3E0HbIPnV7vHmxZGzDzdIoChTdZI/VGY633U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB0029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change O2 Host PLL and DLL register name

Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
---
change in v7:
 1. change subject

change in V6:
 1. change subject and commit message to match the patch
 2. change register name O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1

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

