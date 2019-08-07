Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C03C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D7C217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="tQmxfDp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfHGVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:09:57 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:61889
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbfHGVJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:09:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isGg0O2DWWqp7JDAuMtTvPO8JWhLbC40oKfHaKIGRb20x7ODF+CE2GHB04CsxU58ppivndj8LzKlGzwVhgxdPfKHDLC5dcMSjO/acDoq68QdiCB7P/YuniqV+MSBCjlGhKI0uIbEoqrqIrqtft+WcahQgeaFI0DcVgCiKtlcvAak9WITnxGBca6jNiemk8qoOBspt4u/7xbYj/mXUHVsqBA2fwKNtHt4j5qYaPud7mWTVZT9Q9TQGtZqkLoLjYmTZ2ILFUFyKqeCWUSee0zbAWL5AtgTBm/EF+3eQUC16D7DY3c3i/5Qx3F/dN8bcMvpELNXw8MKjdXpkzIAQUl15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nke92tXuN9G0UeOOkuKRwElurnPwNJ5xS+W1cLK53Nc=;
 b=KT+mbgFCOowODdRSfBFBH3qfomx6etlXOuaxzyuxNrZShS+zf+kzRl/QFUMhx1q0t+DzOy4+ygSXhe6NhCAfWQxCVjZ24ks/J4U3QU5jufFZkh+PjUOFbV93ExKlqmloeHawLqaG/zrSSrmrHXTj7supNwZ5k/bkyQy8b9U3XO/hnCA4Fg+fvPi8Cd5XpRN6csOU5h0JVkM21nMt73YeYWcnwxWMcuvOBOPVMH7zCc4X0AmB8loWCRX9hWoZ0Vsax0IGmuYnRP8OiBAYcGMLA+7/tAMa4aNtEaKFeuxxfCS6kDFAp2LG6c+zrh30TV1qCp5HL1fOq+xyPOLwOwYMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nke92tXuN9G0UeOOkuKRwElurnPwNJ5xS+W1cLK53Nc=;
 b=tQmxfDp69YnXFiWPetkrCi76incyOeBZwhGs8DDoyRpSffQp/yh2OklK5kRcvR5cWA6d02gmgNvtm/yYS7HXVwQtdyECKW5kFpYVapoiL7uZw4NuN9/2imA/IBZCIP2uIXhVeiZmkc+MWZnnYTmazDHOmRYAVwjAbibzQcTvOMI=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB0048.namprd16.prod.outlook.com (10.172.101.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Wed, 7 Aug 2019 21:09:52 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 21:09:52 +0000
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
Subject: [PATCH V5 2/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock Phase
 shift issue
Thread-Topic: [PATCH V5 2/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Thread-Index: AQHVTWR02vwvmIuGP0S0QiigW71RAg==
Date:   Wed, 7 Aug 2019 21:09:52 +0000
Message-ID: <1565212190-31562-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81a57eb8-8051-406a-914b-08d71b7b96db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB0048;
x-ms-traffictypediagnostic: MWHPR16MB0048:
x-microsoft-antispam-prvs: <MWHPR16MB004880AE9A7D1E30C2465DD38BD40@MWHPR16MB0048.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(366004)(396003)(346002)(136003)(199004)(189003)(6486002)(102836004)(14444005)(71200400001)(71190400001)(256004)(386003)(6506007)(4326008)(6436002)(486006)(508600001)(25786009)(52116002)(5660300002)(50226002)(86362001)(64756008)(66446008)(66476007)(66556008)(2201001)(66946007)(110136005)(66066001)(305945005)(7736002)(107886003)(316002)(186003)(6116002)(81156014)(81166006)(26005)(8676002)(2501003)(54906003)(2906002)(36756003)(2616005)(476003)(14454004)(53936002)(99286004)(6512007)(3846002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB0048;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hUPvWaabFQRwl34wTvquIxy9nyyNP+gnC7N1pYIadhnV+3TBOcPu19S3sP6Tcvd9bldPYulH489t+5dach4hvW2VCuugYfhAUhi+UTLxSKM6xBgEcUlnequKZVINTF9Wq/qxtq1u7iwlmxpVd+H5nyFCJB2C+cOMR5m1VLkXtaQmcddC9znxq4607LraPNltPt+FGzKJGoGEPpXZLj4K2dex22RmH9j0eU1SxNXcGbK3dHGT2bZciJ7it1p63x0Fw+r/Kc6u51+IXlxNl7FKYiMhRitn+34GpXVcZUJo+eb5gLeUoZzHVxq2LGotgxX8c1VdR7BOLP9h7T2180pvFjPYhi02cVP5Fz/urEnOFh1xuG9XLoHy20+gWQD26RkU24gyuIfYbhwdBywgSYkOoAgw2w7aICCWVDnHi21oS+c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a57eb8-8051-406a-914b-08d71b7b96db
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 21:09:52.4952
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
 drivers/mmc/host/sdhci-pci-o2micro.c | 188 ++++++++++++++++++-------------=
----
 1 file changed, 95 insertions(+), 93 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index b3a33d9..c780888 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -58,6 +58,101 @@
=20
 #define O2_SD_DETECT_SETTING 0x324
=20
+static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u32 scratch32;
+
+	/* Wait max 50 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 50);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch32 =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
+		    =3D=3D (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
+			break;
+
+		if (timedout) {
+			pr_err("%s: Card Detect debounce never finished.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+}
+
+static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u16 scratch;
+	u32 scratch32;
+
+	/* PLL software reset */
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	scratch32 |=3D O2_PLL_SOFT_RESET;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+	udelay(1);
+	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+
+	/* PLL force active */
+	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+
+	/* Wait max 20 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch =3D sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
+		if (scratch & O2_PLL_LOCK_STATUS)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			goto out;
+		}
+		udelay(10);
+	}
+
+	/* Wait for card detect finish */
+	udelay(1);
+	sdhci_o2_wait_card_detect_stable(host);
+
+out:
+	/* Cancel PLL force active */
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+}
+
+static int sdhci_o2_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host =3D mmc_priv(mmc);
+
+	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
+		sdhci_o2_enable_internal_clock(host);
+
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
+
+static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
+{
+	u32 scratch_32;
+
+	pci_read_config_dword(chip->pdev,
+			      O2_SD_PLL_SETTING, &scratch_32);
+
+	scratch_32 &=3D 0x0000FFFF;
+	scratch_32 |=3D value;
+
+	pci_write_config_dword(chip->pdev,
+			       O2_SD_PLL_SETTING, scratch_32);
+}
+
 static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
 {
 	u16 reg;
@@ -136,19 +231,6 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mm=
c, u32 opcode)
 	return 0;
 }
=20
-static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
-{
-	u32 scratch_32;
-	pci_read_config_dword(chip->pdev,
-			      O2_SD_PLL_SETTING, &scratch_32);
-
-	scratch_32 &=3D 0x0000FFFF;
-	scratch_32 |=3D value;
-
-	pci_write_config_dword(chip->pdev,
-			       O2_SD_PLL_SETTING, scratch_32);
-}
-
 static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
 {
 	int ret;
@@ -284,86 +366,6 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_c=
hip *chip,
 	host->irq =3D pci_irq_vector(chip->pdev, 0);
 }
=20
-static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
-{
-	ktime_t timeout;
-	u32 scratch32;
-
-	/* Wait max 50 ms */
-	timeout =3D ktime_add_ms(ktime_get(), 50);
-	while (1) {
-		bool timedout =3D ktime_after(ktime_get(), timeout);
-
-		scratch32 =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
-		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
-		    =3D=3D (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
-			break;
-
-		if (timedout) {
-			pr_err("%s: Card Detect debounce never finished.\n",
-			       mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
-			return;
-		}
-		udelay(10);
-	}
-}
-
-static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
-{
-	ktime_t timeout;
-	u16 scratch;
-	u32 scratch32;
-
-	/* PLL software reset */
-	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
-	scratch32 |=3D O2_PLL_SOFT_RESET;
-	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
-	udelay(1);
-	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
-	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
-
-	/* PLL force active */
-	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
-
-	/* Wait max 20 ms */
-	timeout =3D ktime_add_ms(ktime_get(), 20);
-	while (1) {
-		bool timedout =3D ktime_after(ktime_get(), timeout);
-
-		scratch =3D sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
-		if (scratch & O2_PLL_LOCK_STATUS)
-			break;
-		if (timedout) {
-			pr_err("%s: Internal clock never stabilised.\n",
-			       mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
-			goto out;
-		}
-		udelay(10);
-	}
-
-	/* Wait for card detect finish */
-	udelay(1);
-	sdhci_o2_wait_card_detect_stable(host);
-
-out:
-	/* Cancel PLL force active */
-	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
-	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
-}
-
-static int sdhci_o2_get_cd(struct mmc_host *mmc)
-{
-	struct sdhci_host *host =3D mmc_priv(mmc);
-
-	sdhci_o2_enable_internal_clock(host);
-
-	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
-}
-
 static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
 {
 	/* Enable internal clock */
--=20
2.7.4

