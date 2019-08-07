Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498EEC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BDE217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="w2fYHnNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfHGVKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:10:15 -0400
Received: from mail-eopbgr690102.outbound.protection.outlook.com ([40.107.69.102]:55346
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbfHGVKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:10:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWMyWPJgXce6d5+WjschDB2+1hIEp5X+IOBH+PIG1hfPnFN6xmk2XnwpwhKZbZ9KtJgt0R9IJXx1T0WhIgkAhrgIELTEvWgy0Rmos5rlrErknclq7kn8y6u9BbpCQxut0uTPzlLYD/4V6Ge/3T02C9yWEW3UCmsMU4tNVtdKbLWAbCB9ua85ak8k6v1wmipHahec3YwvzTsRAZK8TpfqjDzBpV6mV+AZJWfD2M3ZV4NkiRRmFU0d6NCMcPfhodiJxN9oTnpjuIlZegizeS+zdZ4LD+PTznrWCOHYwgDphGFmwmyJmONY9sS8Tkw5JB07Dh8FwC366Wig6nwd1x08rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0Mdfc7aA4lKqLvDu576Hek9XXw30OqzaN/Z3BqCZuc=;
 b=CVvg1+EdOzTZeAEC+KgI4hJPENiH5JkYG/bDVHXaTH8+TiEu9vTgPpRQOly4jCYcWSRXE7/s+ABmbU3yvfbvS/MckUeZxOmoHpUjLVNr12hbCIcevd9rzhpwAh7rkWZjG6NUKRD44jOueRnR8U04hyFAcrydLqvCenHMCAtlUzBl/fNmjSZvLo7RGPX6/1R0l9yFpSsR3ol7E78XAFfvkcFUiFZ66ttto+NBKDew+lVXvQa/SMJS4WcrFxVvrd1onA5mYy3KmlzwPz90XSl6ZKcV3jMwBFt6NKReMbK47RV+r3BpPkgTJtkXlm/D/+IlvvZOVcyMgSnUhdjUIpKgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0Mdfc7aA4lKqLvDu576Hek9XXw30OqzaN/Z3BqCZuc=;
 b=w2fYHnNBQWbJMzb5agZR4QDjJgMbqQqyaFjW/OYikNzTx/aKKUpQdTeCwhqKLXL7gIZf5kMRGYykFZmEMGn6pAIsV/W9EIZEnPV81bBFmaxeiaCSUU/3rg9uAn9LJ2XS9vEqfv/S+OLoStTPcKpzRAGEzLMAHGfi8FMW0dn9D2o=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB0048.namprd16.prod.outlook.com (10.172.101.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Wed, 7 Aug 2019 21:10:11 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 21:10:11 +0000
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
Subject: [PATCH V5 3/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock Phase
 shift issue
Thread-Topic: [PATCH V5 3/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Thread-Index: AQHVTWR/ocVHTc0xMUqm+fxRr8Y/nQ==
Date:   Wed, 7 Aug 2019 21:10:10 +0000
Message-ID: <1565212208-32259-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85a2d536-f743-4341-7b79-08d71b7ba1df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB0048;
x-ms-traffictypediagnostic: MWHPR16MB0048:
x-microsoft-antispam-prvs: <MWHPR16MB004822301EB8419EE2F637FC8BD40@MWHPR16MB0048.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(366004)(396003)(346002)(136003)(199004)(189003)(6486002)(102836004)(14444005)(71200400001)(71190400001)(256004)(386003)(6506007)(4326008)(6436002)(486006)(508600001)(25786009)(52116002)(5660300002)(50226002)(86362001)(64756008)(66446008)(66476007)(66556008)(2201001)(66946007)(110136005)(66066001)(305945005)(7736002)(107886003)(316002)(186003)(6116002)(81156014)(81166006)(26005)(8676002)(2501003)(54906003)(2906002)(36756003)(2616005)(476003)(14454004)(53936002)(99286004)(6512007)(3846002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB0048;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CvzZeuc8wP5/vzC/xLrV/R7j5oQXs1chjy6CXcNHWFrZpJWJGv394OGN4Y21Ho51I+2m+oMfK3xjxW/GR7nCz9z+Y6SzInLxHuj3srEogOYkKa3PrdfRHv3xcLT3tQSpe+jYfFT9ifhy9CcfC4WPJYAJx+lcPvksgc44XEmO8aTanetRf9HFTcavwgIZsltv1hs1mr308Rf0YJZVPZEfvu/GCLHk/WKWWB+UpcT75ehJAEsm/X1FqBQTGzd2Xrh2TE8kfju+t+tWsc9qW3rLcCM6NMlEa+F29Kp9PXo5/FfzODIDGA/6HHk5XbR9DHqoGD84NF1KjTHLVeAn+B0dqNWqjcQw+GPVO9y6PICqT0HAMVG6lK0A0DAYS34vcc2hNTbTDTXpgCLlBfLakOhtRVVuK59/YN13tOELNltWSZI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a2d536-f743-4341-7b79-08d71b7ba1df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 21:10:10.9628
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
 drivers/mmc/host/sdhci-pci-o2micro.c | 111 +++++++++++++++++++++++++++++++=
+++-
 1 file changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index c780888..443d2a3 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -55,9 +55,17 @@
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
+#define  O2_DLL_LOCK_STATUS	BIT(11)
=20
 #define O2_SD_DETECT_SETTING 0x324
=20
+static const u32 dmdn_table[4] =3D {0x2B1C0000,
+	0x2C1A0000, 0x371B0000, 0x35100000};
+
+struct o2_host {
+	u8 dll_adjust_count;
+};
+
 static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
 {
 	ktime_t timeout;
@@ -153,6 +161,32 @@ static void o2_pci_set_baseclk(struct sdhci_pci_chip *=
chip, u32 value)
 			       O2_SD_PLL_SETTING, scratch_32);
 }
=20
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
+	/* Detect 1 s */
+	timeout =3D ktime_add_ms(ktime_get(), 1000);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+		if (!(scratch32 & O2_DLL_LOCK_STATUS))
+			return 0;
+
+		if (timedout)
+			return 1;
+	}
+}
+
 static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
 {
 	u16 reg;
@@ -190,6 +224,66 @@ static void __sdhci_o2_execute_tuning(struct sdhci_hos=
t *host, u32 opcode)
 	sdhci_reset_tuning(host);
 }
=20
+/* this function is used to fix o2 dll shift issue */
+static int sdhci_o2_dll_recovery(struct sdhci_host *host)
+{
+	int ret =3D 0;
+	u8 scratch_8 =3D 0;
+	u32 scratch_32 =3D 0;
+	struct sdhci_pci_slot *slot =3D sdhci_priv(host);
+	struct sdhci_pci_chip *chip =3D slot->chip;
+	struct o2_host *o2_host =3D sdhci_pci_priv(slot);
+
+	/* Disable clock */
+	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+	while (o2_host->dll_adjust_count < 4 && 0 =3D=3D ret) {
+		/* UnLock WP */
+		pci_read_config_byte(chip->pdev,
+				O2_SD_LOCK_WP, &scratch_8);
+		scratch_8 &=3D 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+		/* PLL software reset */
+		scratch_32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+		scratch_32 |=3D O2_PLL_SOFT_RESET;
+		sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
+
+		pci_read_config_dword(chip->pdev,
+					    O2_SD_FUNC_REG4,
+					    &scratch_32);
+		/* Enable Base Clk setting change */
+		scratch_32 |=3D O2_SD_FREG4_ENABLE_CLK_SET;
+		pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
+		o2_pci_set_baseclk(chip, dmdn_table[o2_host->dll_adjust_count]);
+		o2_host->dll_adjust_count++;
+		/* Enable internal clock */
+		scratch_8 =3D SDHCI_CLOCK_INT_EN;
+		sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
+
+		if (sdhci_o2_get_cd(host->mmc)) {
+			if (sdhci_o2_wait_dll_detect_lock(host)) {
+				scratch_8 |=3D SDHCI_CLOCK_CARD_EN;
+				sdhci_writeb(host, scratch_8,
+					SDHCI_CLOCK_CONTROL);
+				ret =3D 1;
+			} else {
+				pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
+					mmc_hostname(host->mmc),
+					o2_host->dll_adjust_count);
+			}
+		}
+	}
+	if (o2_host->dll_adjust_count =3D=3D 5)
+		pr_err("%s: DLL adjust over max times\n",
+		mmc_hostname(host->mmc));
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev,
+				   O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 |=3D 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+	return ret;
+}
+
 static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host =3D mmc_priv(mmc);
@@ -204,7 +298,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mm=
c, u32 opcode)
=20
 	if (WARN_ON(opcode !=3D MMC_SEND_TUNING_BLOCK_HS200))
 		return -EINVAL;
-
+	/*
+	 * Judge the tuning reason, whether caused by dll shift
+	 * If cause by dll shift, should call sdhci_o2_dll_recovery
+	 */
+	if (!sdhci_o2_wait_dll_detect_lock(host))
+		if (!sdhci_o2_dll_recovery(host)) {
+			pr_err("%s: o2 dll recovery failed\n",
+				mmc_hostname(host->mmc));
+			return -EINVAL;
+		}
 	/*
 	 * o2 sdhci host didn't support 8bit emmc tuning
 	 */
@@ -371,7 +474,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host=
, u16 clk)
 	/* Enable internal clock */
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
+	sdhci_o2_enable_internal_clock(host);
 	if (sdhci_o2_get_cd(host->mmc)) {
 		clk |=3D SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
@@ -397,12 +500,13 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *sl=
ot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
+	struct o2_host *o2_host =3D sdhci_pci_priv(slot);
 	u32 reg, caps;
 	int ret;
=20
 	chip =3D slot->chip;
 	host =3D slot->host;
-
+	o2_host->dll_adjust_count =3D 0;
 	caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
=20
 	/*
@@ -689,4 +793,5 @@ const struct sdhci_pci_fixes sdhci_o2 =3D {
 	.resume =3D sdhci_pci_o2_resume,
 #endif
 	.ops =3D &sdhci_pci_o2_ops,
+	.priv_size =3D sizeof(struct o2_host),
 };
--=20
2.7.4

