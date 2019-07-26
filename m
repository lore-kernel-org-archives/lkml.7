Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF3C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71B622BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="ixgGvgs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbfGZSsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:48:41 -0400
Received: from mail-eopbgr820134.outbound.protection.outlook.com ([40.107.82.134]:25873
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387394AbfGZSsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bALzeBDYHWr3+LVvLZ1MuyM90oZxXi2DN4CWEQXEEQAXR2NLMC4MkGc4zDGz5h94t/aaiu7FD+eUocKfbclzhnH7VTpcZp917HMpOMjEWuNSqhhyK1V0572r5fAZ4aPQgJox4oUP6KfwtXCu8oiFw66r4m2nPDXix8I4wIn2CStp15DRgGxjioCzqYmompd+sb+RGYXmAiRTBXVET+dDKUnQ1HNlBN/hvKZKAE5B+u3HscGcgM0sRxLayKNkJ3Mv18OxAXpCMQdAcAdEioK87zH0MA0BvexIRaoBLDcoGQEziqr0u9RUeZkoJy1W7ueuJXnmYgHOsybiaPRFpAGLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPIXgS7fMX2TeJ8KZDldJui0mCkXcGHAGmGnSyH3Ivc=;
 b=dMDmOt0ktCW5lgFFr65cy4sWEzl1/ZiY+RGa9jXAXLcHyyyAeEHz7N3uVpRwR2le6owcV2VNsL+pgiVV5/xKHdS1Vmo4DarNIHF+VbxLmA9fh6OXgQXcOc75ZBdkjuXy7pMg8/ythHxm5zIlKLnxmwOHz4Cc+wY3rmxc/vQYaO0TVuTucj1gDy7lDJMcj3aoPyX0ssVwbU1GABS5u+0Hm4/M2SgJq5vX4HQBVPquT14osc3i3CQff8+1cMd7i+StiFrO/Q0R8P8BWJmtTaeSo1CS++MMuOhgDkEQIZ3J+7tE6dUufIJUosiGRmbYmiJW1WBkWe5qS7Gde/zZA+ptaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPIXgS7fMX2TeJ8KZDldJui0mCkXcGHAGmGnSyH3Ivc=;
 b=ixgGvgs1H1H/3FQECvdoO4EheSAU43Ouxq3rXFHadKAcdSFz63bckkjwwoa3NUfb7n8cgbO1sSC12LpK5qVY0CipyQ+euY+dBenvDR5k7D+TQnbkqLfQLd2SCkU/hquGpfQzAGs4OMHqajZPccMthZBagpO8V9bjtQFiEQTBjoM=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1791.namprd16.prod.outlook.com (10.174.160.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Fri, 26 Jul 2019 18:48:32 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::cc4a:10c6:fcac:d3e0]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::cc4a:10c6:fcac:d3e0%9]) with mapi id 15.20.2094.017; Fri, 26 Jul 2019
 18:48:32 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V2 1/1] mmc: sdhci: Fix O2 Host data read/write DLL lock Phase
 shift issue
Thread-Topic: [PATCH V2 1/1] mmc: sdhci: Fix O2 Host data read/write DLL lock
 Phase shift issue
Thread-Index: AQHVQ+K4pHmBxuIv/kq4swnDVRnZkg==
Date:   Fri, 26 Jul 2019 18:48:32 +0000
Message-ID: <1564166909-7437-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48f73ada-0b75-4a35-cd23-08d711f9db30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB1791;
x-ms-traffictypediagnostic: MWHPR16MB1791:
x-microsoft-antispam-prvs: <MWHPR16MB17919F358A74FC8A171F9E1F8BC00@MWHPR16MB1791.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(50226002)(68736007)(186003)(4326008)(6506007)(52116002)(508600001)(99286004)(386003)(2501003)(53936002)(25786009)(107886003)(3846002)(6116002)(66066001)(486006)(2616005)(476003)(36756003)(86362001)(6512007)(5660300002)(6486002)(66946007)(2906002)(6436002)(71200400001)(71190400001)(14444005)(256004)(64756008)(66556008)(66446008)(66476007)(26005)(102836004)(8936002)(14454004)(305945005)(7736002)(54906003)(110136005)(2201001)(316002)(8676002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1791;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: od/Qpur9gnJjcoqR2/nSTEbMhYVbEM+3Q+uoS0b6ElhGX8k+qHVHFFFFFnNRRHOHCWlBsAc45hElOMtvbbyzuYYOxkGCKiiOaf+sCQb0k8s94vpxjVKI8bLrDY8pvyqJRCLYdJMjMlxP209k3xtK3IUwQuwKUeJUTD9DxKRKFdepv5UtpW4NZF1DD/5VfZbqf8V6wkyuVIwC5ivMlKIDzM3WZTErxDB286ZOBVtE8UHlyg0kDspgCWKw9hfH2gGM7CG1YMG/HzlAG2yacfubqKqOBWQqZd7sHEhrG3+cYJGW7Zukt2XBhvH5w1fH6Gxdws/+MgPrHJ5D5lXRnz/k9ZQgBaZE9Nk8ZaOMz5ZJVn4GiT6SeecUrPy7zDF8IwVXpP9waye1ptHQ2nEmrZ8+pEdUH+NhSM/Tm6fm6aufVIk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f73ada-0b75-4a35-cd23-08d711f9db30
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 18:48:32.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shirley.her@bayhubtech.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her<shirley.her@bayhubtech.com>
---
change in V2:
  1. Use usleep_range instead of udelay
  2. move dll_adjust_count to sdhci-pci-o2micro.c

change in V1:
  1. Add error recovery function to relock the DLL with correct phase
  2. Retuning HS200 after DLL locked
---
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 157 +++++++++++++++++++++++++++++--=
----
 1 file changed, 133 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 9dc4548..c43b2ce 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -51,13 +51,60 @@
 #define O2_SD_VENDOR_SETTING2	0x1C8
 #define O2_SD_HW_TUNING_DISABLE	BIT(4)
=20
-#define O2_PLL_WDT_CONTROL1	0x1CC
+#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
+#define  O2_DLL_LOCK_STATUS	BIT(11)
=20
 #define O2_SD_DETECT_SETTING 0x324
=20
+static const u32 dmdn_table[5] =3D {0x25100000, 0x2B1C0000,
+	0x2C1A0000, 0x371B0000, 0x35100000};
+static u8 dll_adjust_count;
+static int sdhci_o2_get_cd(struct mmc_host *mmc);
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
+static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u32 scratch32;
+
+	usleep_range(5000, 6000);
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	if (!(scratch32 & O2_DLL_LOCK_STATUS)) {
+		pr_warn("%s: DLL is still unlocked after wait 5ms\n",
+			mmc_hostname(host->mmc));
+	}
+
+	/* Detect 500 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 500);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+		if (!(scratch32 & O2_DLL_LOCK_STATUS))
+			return 0;
+
+		if (timedout)
+			return 1;
+		usleep_range(10, 1000);
+	}
+}
+
 static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
 {
 	u16 reg;
@@ -95,11 +142,85 @@ static void __sdhci_o2_execute_tuning(struct sdhci_hos=
t *host, u32 opcode)
 	sdhci_reset_tuning(host);
 }
=20
+static int sdhci_o2_error_recovery(struct sdhci_pci_chip *chip,
+				 struct sdhci_host *host)
+{
+	int ret =3D 0;
+	u8 scratch_8 =3D 0;
+	u32 scratch_32 =3D 0;
+	/* Disable clock */
+	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+
+DLL_ADJUST:
+	if (dll_adjust_count >=3D 5) {
+		dll_adjust_count =3D 4;
+		pr_warn("%s: error recovery failed with the dll_adjust_count over max va=
lue.\n",
+			mmc_hostname(host->mmc));
+	}
+
+	/* UnLock WP */
+	ret =3D pci_read_config_byte(chip->pdev,
+			O2_SD_LOCK_WP, &scratch_8);
+	if (ret)
+		return ret;
+
+	scratch_8 &=3D 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+	/* PLL software reset */
+	scratch_32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	scratch_32 |=3D O2_PLL_SOFT_RESET;
+	sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
+
+	ret =3D pci_read_config_dword(chip->pdev,
+				    O2_SD_FUNC_REG4,
+				    &scratch_32);
+	/* Enable Base Clk setting change */
+	scratch_32 |=3D O2_SD_FREG4_ENABLE_CLK_SET;
+	pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
+	o2_pci_set_baseclk(chip, dmdn_table[dll_adjust_count]);
+
+
+	/* Enable internal clock */
+	scratch_8 =3D SDHCI_CLOCK_INT_EN;
+	sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
+
+	if (sdhci_o2_get_cd(host->mmc)) {
+		if (sdhci_o2_wait_dll_detect_lock(host)) {
+			scratch_8 |=3D SDHCI_CLOCK_CARD_EN;
+			sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
+			ret =3D 1;
+		} else {
+
+			pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
+			mmc_hostname(host->mmc), dll_adjust_count);
+			dll_adjust_count++;
+			goto DLL_ADJUST;
+		}
+	} else
+		goto DLL_ADJUST;
+
+		/* Lock WP */
+	ret =3D pci_read_config_byte(chip->pdev,
+				   O2_SD_LOCK_WP, &scratch_8);
+	if (ret)
+		return ret;
+	scratch_8 |=3D 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+	return ret;
+}
+
 static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host =3D mmc_priv(mmc);
+	struct sdhci_pci_slot *slot =3D sdhci_priv(host);
 	int current_bus_width =3D 0;
=20
+
+	if (dll_adjust_count)
+		sdhci_o2_error_recovery(slot->chip, host);
+
+	dll_adjust_count++;
 	/*
 	 * This handler only implements the eMMC tuning that is specific to
 	 * this controller.  Fall back to the standard method for other TIMING.
@@ -131,23 +252,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *m=
mc, u32 opcode)
 		mmc->ios.bus_width =3D MMC_BUS_WIDTH_8;
 		sdhci_set_bus_width(host, current_bus_width);
 	}
-
 	host->flags &=3D ~SDHCI_HS400_TUNING;
 	return 0;
 }
=20
-static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
-{
-	u32 scratch_32;
-	pci_read_config_dword(chip->pdev,
-			      O2_SD_PLL_SETTING, &scratch_32);
=20
-	scratch_32 &=3D 0x0000FFFF;
-	scratch_32 |=3D value;
-
-	pci_write_config_dword(chip->pdev,
-			       O2_SD_PLL_SETTING, scratch_32);
-}
=20
 static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
 {
@@ -316,23 +425,23 @@ static void sdhci_o2_enable_internal_clock(struct sdh=
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
@@ -350,16 +459,16 @@ static void sdhci_o2_enable_internal_clock(struct sdh=
ci_host *host)
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
 {
 	struct sdhci_host *host =3D mmc_priv(mmc);
-
-	sdhci_o2_enable_internal_clock(host);
+	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
+		sdhci_o2_enable_internal_clock(host);
=20
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }
@@ -369,7 +478,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host=
, u16 clk)
 	/* Enable internal clock */
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
+	sdhci_o2_enable_internal_clock(host);
 	if (sdhci_o2_get_cd(host->mmc)) {
 		clk |=3D SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
@@ -400,7 +509,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot=
)
=20
 	chip =3D slot->chip;
 	host =3D slot->host;
-
+	dll_adjust_count =3D 0;
 	caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
=20
 	/*
--=20
2.7.4

