Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CDFC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F1214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="Y05ZiuIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfHUSie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:38:34 -0400
Received: from mail-eopbgr720120.outbound.protection.outlook.com ([40.107.72.120]:12010
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfHUSie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwGDMGYiLBouJ7dPJT+xyGJhZrQP8cH68oYYfsJuXJ0NZ5ElT7g+311h3+4k4Ax7HtznmdywFmBy9bzs3C7qF5zAbc6C6SQqb0s4d05Nh+/znVYY+6ZLnvz84Rw378HwBIS0HcQL0/7kYU6OuKVgmH9XexY4fpwpdSGYQqBdYHhSbYHaqHmXgZreDvYtOMKXJfBFJBCNXmlXDAhwVuNetJYxI76Lt8739Q6GsrNEmpi0X+IwmDbdV/hW3FmEUrfKOhAx4oyJaU8fkWKpxaXiY9z73kFYAotbJNoGtaePDnSWimNEa2/0edgqHpGBKQWYc3o7hoFBwKvO054v6OpsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q+4ec9Q98lPMYFZ16r58O1zIwiI1eWKyBoHlAqbbUU=;
 b=OedlhpODNKUEdxhVoNxDLGkieg0cBVtDcrwG4QrtbTNS791HyE5D3MvbEyRMciSm0QoqKaXrmTKlKvRrJJq9e72j1a77fnMqimx/6n1gjbTJbjIUMj7jsoCRXG2UGOAUwfktM1UHxS/awj9EsXMlVZWm4v6LGnchz7E6yRgtkpvOqXk2cuOOcJ7UJu1Dkn6vNuw6eExRAMbL05dY6ZeEYLVKMWJ7lINbsBdUqhhEaoeN9caZg3JlJMbUcRqXqp4OIwGYK2+dFcWlScHMiJWRAkitjG40uDvhZVSH8YNEr9VDqcY6ycARt0cAdZtDuZn0BPX3FN647VH2Tk7wHomzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q+4ec9Q98lPMYFZ16r58O1zIwiI1eWKyBoHlAqbbUU=;
 b=Y05ZiuIXil8oSTt32VC/RO2DdrrjZVkzZSv1VUuUJ6V+D3G+ORp0Nelr1I93IwX96GhcEadCQxFyiECslFymfVuPvwLoHFsGfR0J+8WFfzS8uOPfmDAjzuGig/vRzbLJyZ2DMIBSiM2GnLos7F6mca30iHYeDPtvHGDrqd9YwN4=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1693.namprd16.prod.outlook.com (10.172.59.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 18:38:30 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 18:38:30 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V8 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL and DLL
 register name
Thread-Topic: [PATCH V8 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL and
 DLL register name
Thread-Index: AQHVWE+hFDk0c1SojEGAt3evjZxCYg==
Date:   Wed, 21 Aug 2019 18:38:30 +0000
Message-ID: <1566412708-6130-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::22) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bab04537-63d0-4c02-615c-08d72666c385
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:MWHPR16MB1693;
x-ms-traffictypediagnostic: MWHPR16MB1693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB16934728F2FA4DB906B202A98BAA0@MWHPR16MB1693.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39830400003)(346002)(376002)(189003)(199004)(305945005)(6486002)(50226002)(2201001)(6116002)(3846002)(2906002)(36756003)(4326008)(8676002)(81156014)(81166006)(25786009)(66066001)(14454004)(2616005)(66556008)(64756008)(66446008)(486006)(476003)(86362001)(71190400001)(71200400001)(66476007)(66946007)(6436002)(99286004)(110136005)(107886003)(14444005)(256004)(7736002)(6512007)(508600001)(52116002)(54906003)(316002)(53936002)(186003)(26005)(8936002)(102836004)(386003)(6506007)(2501003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1693;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fHTL+GdilSgIkttn2Ye7gqu6kZiE6c01VHXXzFti1PK93H41IfOjxBTIdMkIOHvMiHswKVwpRvLOD1PWiCN0l6jZxXk4r5FfA3oiPO396vDH7o/uIViWsJ40gNejVd55KB/dS9K22FG3fxI1SI99z7qaTZxqYlcjnZIw7YtdcxiVjsQRD7CI0zaAIVjcu7L1g0IcO93SeDcdlTc3G1HrTq6S6YnFL4v2B0LCk4tBchZChpmkhTPffPa84PjYkqlL55d0tbdBecRUOFd9tiFZNCFhGlyoNOMgAN3C1t4dF9ZPbMA6+amHEgE0l3zg5Q8Uf4aWVdrUoJTsmuXrE8b31JlKOsVao3GR5ZAEpgNbmfStL8yoNmkfg9gar7G7hnP3wdnKtEHGJWRY5fZS4Ywa5dgMVynu2REH1nOoMm1a7CI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab04537-63d0-4c02-615c-08d72666c385
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 18:38:30.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsaDBeTxhufxKbjUmTFt842T5PLI1r1DwpaHhnnWxrzPrV9eFWGN0LHlPudiVnkG6EiWx0XZrBYRDIt6VB3sLXuyAYNiKc4RqBhis0Xwkfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change O2 Host PLL and DLL register name

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
---
change in V8:
 1. fix patch format error

change in V7:
 1. change subject

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

