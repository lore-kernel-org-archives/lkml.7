Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D8C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9371F214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="WCcuGXmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfHSWJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:09:27 -0400
Received: from mail-eopbgr800120.outbound.protection.outlook.com ([40.107.80.120]:52800
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728136AbfHSWJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:09:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXsk0YjX1yq5FWMqFjOnweHr7kqHN9I3XpkNbwWjITX5oAin1v3643KvQ6LWjE3AY0bheX+LHoyB02M9a4PJ1xV7v6YFerGuouNtoUOob/9Wa9srMCPgGXikBvOvcPwsnNyYIOc1dsKNBFCn9OmLsR3ecahmV1iVzv7gjmssNFGKeIz4T4EH1ge2zX3MbVF7DL/ay3W8ar2gnYNKNAW9W7U59w8H0qJwvsh99XjehT3zDpfWh8/ytDwp7H8BUryDcSvjUhaRhQUO2e4bQzKxvO14KFIsOYgL0NkDIhRAvbOsfAdAmAiUdP7HUsOTZDfU9x+2mtOcJp9Pu2vC7udGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTXOHKH1bla8W3Kw0N6XRdSNfVesMqMthyVY0NFzFnM=;
 b=DbEowvnbBMIMMvVjS8tMs2oW/ejZEhppweAwAddDALopa7qAd0aJVZd56cV4skJ+xEA4mqTxtrkrfTJ4u2t9c9neijYXpIa+p324xeph76B637aF0cVE01brX33hf9Lp6yefpuXp5TYDUXCo2/2FZ7EWG5uv9uk7tIHe1MjZIyFjOTnYIJ6L2uFSmImkTLGvCsDfc8KHju+y5fo9YvNa+IHoBHTywGf5iMt6eq+PcffPrHbTAGt3EUZf1uMAoZpamw0K7uVdyrXQHfQ7DLDZyRh0F/fEPk3IWmv05EY/ggJTAC7I3RrJiwftPoq3cjxXitQztf8PNXd93BjtquGaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTXOHKH1bla8W3Kw0N6XRdSNfVesMqMthyVY0NFzFnM=;
 b=WCcuGXmx8KoAaAEBKhBOUs6D/jZtIWzQY+za10R7zt0uZUb/9rZVou+I5/05pz/0CZOnK9WtlhCpFpBLk3JtlfWsRIxoGAnDNjGx298+BtGD8SSojm7jcRGJR5mTtf7k8fqH9rIHGYSY07KSy5kasZWZKOnJc4UHy1rlDBVOgFM=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB0029.namprd16.prod.outlook.com (10.172.101.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 22:09:23 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 22:09:23 +0000
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
Subject: Subject: [PATCH V7 2/3] mmc: sdhci-pci-o2micro: Move functions in
 preparation to fix DLL lock phase shift issue
Thread-Topic: Subject: [PATCH V7 2/3] mmc: sdhci-pci-o2micro: Move functions
 in preparation to fix DLL lock phase shift issue
Thread-Index: AQHVVtrCDQhIjjDlrUWEGKagsZN8YQ==
Date:   Mon, 19 Aug 2019 22:09:23 +0000
Message-ID: <1566252561-5144-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::38) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dc32291-dddd-4370-8306-08d724f1e46c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB0029;
x-ms-traffictypediagnostic: MWHPR16MB0029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB0029C59B9E8FB37E66247C5A8BA80@MWHPR16MB0029.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39840400004)(366004)(136003)(189003)(199004)(5660300002)(2616005)(476003)(6436002)(107886003)(86362001)(486006)(26005)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(66066001)(2201001)(7736002)(102836004)(36756003)(256004)(53936002)(8676002)(6486002)(6512007)(14454004)(81156014)(8936002)(186003)(6506007)(386003)(2501003)(4326008)(25786009)(14444005)(50226002)(316002)(3846002)(305945005)(2906002)(6116002)(110136005)(54906003)(81166006)(52116002)(508600001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB0029;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XB+binCcNUN8eO+g+rBXRdqTN0lcUkyJoLs2/ldr3VyLyMzbQw8B4ISn9y9dFOaME7uun10UBY/lF31QXcMUUSC+/bIrl2ofyY8L0JAPanh0IUbmtA4dZcr8/vrTidGY4LXqKCNGO7J7FGmDnpfGDB7q4R0wTLxEElW3M2DwKWXCNm5GEuALB0yNijyPcQpCnzJH9V59CT35mHq8XcGtp6/+U01j8NQNg+rcYVBE6Pn/p8ZtJ8ie+7+KLa/q/IM0lJ1l70rqZMqp3YdRFsUETgZXay9CFScTKZN9DLPA91nt9/rzsJ2vK6Q+ikqbV5wxe2oFhvDVeABNumd1WrDyHkyUW3ggoCGuDazw4LUtPPioh4NR/IAdWAqYqC5cmYQrMgUH0bBOaMx59EhPdPkK8lMHzA7qiwqN6amNmTSiASo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc32291-dddd-4370-8306-08d724f1e46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 22:09:23.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRCR1HOllOHjLBCm62Th9NwmdnBLOnMkEBqfNet5xW2bobrwEPHkOZ5PNr1pN0AWo4RLPLjxGvCJh4rUVjFFfL/JejkFXqZyZqk04XOvvcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB0029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move functions in preparation to fix DLL lock phase shift issue

Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
---
change in V7:
 1. change subject to match the patch
 2. move functions in preparation to fix DLL lock phase shift issue

change in V6:
 1. change subject and commit message to match the patch
 2. modify the get CD status functions
 3. re-arrange the order of some functions

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
 drivers/mmc/host/sdhci-pci-o2micro.c | 186 +++++++++++++++++--------------=
----
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index b3a33d9..021e481 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -58,6 +58,99 @@
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
+	sdhci_o2_enable_internal_clock(host);
+
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
+
+static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
+{
+	u32 scratch_32;
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
@@ -136,19 +229,6 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mm=
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
@@ -284,86 +364,6 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_c=
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

