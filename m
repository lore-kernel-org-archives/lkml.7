Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABB8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C7A22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="fxEUXHPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHUSjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:39:55 -0400
Received: from mail-eopbgr720106.outbound.protection.outlook.com ([40.107.72.106]:18800
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfHUSjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:39:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhgtwmFrjQe9qML2Ka0LypOzuvrRFzuCA9fFcHUwGO01JsenHpNhq23GkfJJYCpwhQxHkq04KfqoCT74dWWzDrNfLZNM5IoI6r8GGFXf24WfD1oEtz1ppuNc9yPwKUjYB3jZLth1AL9DnDiQDn3B+K/uKK5Dw4CWNdpAB7zedO4KI2uuDB+qCoGU0xVN2woKyA+INYAnMRGffGQhrQ688epmoCVmSbmSn0pD0ZTZxtJ0QPajg9HwrM4bJKJpNq0b9tFt83YxO/PdCVEwB5bBK37z57RtSxoKIw3ahmVs7w5TuHOex++6Wj5vedNNfhgy0NAkNgcVTufM8i4CRt/EKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJV81Rwv/YCrMsncIYG2d4g5RlXM6j+e0ukJxM8dh/Q=;
 b=UxDaOOt1mxdCUdsYi9xRKIMreTIEqsJN9jl/2BBpXETDfBctbSCrtAUt/ShRJP9gRdt8ZajJNhZWr3VOjCpfeqdL82RINkNI9m/KTU2c37kgDM2fXQOs/Erfh00ebdqfnufVZ3kfP38N7s7VzvKXfuvy+Om+4qLI/RIHgLM7bPCJmIsw4v3nn7Oe3ej+sRd1oJHBpBU2jX3i6nk/AgJeUYwJtlMMuoosZjRCiDcMN0WDnpQb6I4Ra4wBM4yVEWGp3a5bGt1tdKHG8AMdAYFTrKCpDSqwhqdpkHYepyoJBHxN80UzgpEHIv13MKdczJkpqwNDkVFP0aZZpRiVOnrYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJV81Rwv/YCrMsncIYG2d4g5RlXM6j+e0ukJxM8dh/Q=;
 b=fxEUXHPWgdq7a8PpIItRMOE5lFPQIYk2ocDwdTktIIZxoGNEQO9h2CiFNPHwEqsragBAgxeF8wQQRF+aIleyhmHicm2O71sb7ZxrVY/fD/nmvyIM6VmB3QoQf3+nCqrR5DSzLvIg56tAbMYfSFYG8iSG/QEgdc00mwlaIdwMxLw=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1693.namprd16.prod.outlook.com (10.172.59.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 18:39:46 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 18:39:46 +0000
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
Subject: [PATCH V8 3/3] mmc: sdhci-pci-o2micro: Fix O2 Host data read/write
 DLL Lock phase shift issue
Thread-Topic: [PATCH V8 3/3] mmc: sdhci-pci-o2micro: Fix O2 Host data
 read/write DLL Lock phase shift issue
Thread-Index: AQHVWE/ONdiK5hE+10WvESHhG6yKGw==
Date:   Wed, 21 Aug 2019 18:39:46 +0000
Message-ID: <1566412784-6224-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:301:3a::32) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e70e786-6852-46f8-2db9-08d72666f0b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:MWHPR16MB1693;
x-ms-traffictypediagnostic: MWHPR16MB1693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB1693C7E9D6A6D1CE42ECF9B88BAA0@MWHPR16MB1693.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39830400003)(346002)(376002)(189003)(199004)(305945005)(6486002)(50226002)(2201001)(6116002)(3846002)(2906002)(36756003)(4326008)(8676002)(81156014)(81166006)(25786009)(66066001)(14454004)(2616005)(66556008)(64756008)(66446008)(486006)(476003)(86362001)(71190400001)(71200400001)(66476007)(66946007)(6436002)(99286004)(110136005)(107886003)(14444005)(256004)(7736002)(6512007)(508600001)(52116002)(54906003)(316002)(53936002)(186003)(26005)(8936002)(102836004)(386003)(6506007)(2501003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1693;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3cspZ6u0QFVbYLzeY5++9zNiSE5Zf8tWMHYpKWdab80mysn1fHFsNhUd57tSzaE4HeO1EwJIEIt/oju3OkG6M8CZKgPvxTGu1N6dbAKeI8erM8mElZ2etO5vqOdWum1DoZ1k/dIEho/vNgJ/+w2I7Ne628p0KqynAJ9BBvtwwy+lyujut/Iv2XINvGEAtgWLA7CRD4b2GcaTwxyZFUQGBjJx2Ya+DdZMt5uYH/auZ4pXYVGSZRErvjfueIfbGEtFS/c9Mlyfp5yafs+JPpPwQI3NaQssh/Wuo5a/7HeTB89L/y3fvfOoM/u6OnV67hQ9vxtzewVg1Vpx23rApM1Y5GMXB0ULrS0MITvah/MtNkHoFPIXDzGUQnw22a3FdWmPSSqsxK5ah3qhiUr6Cdb2rEczjzdtoeSthfHzSvefNek=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e70e786-6852-46f8-2db9-08d72666f0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 18:39:46.5332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5b4kaiA4SlVNYaMQbDFM7a3WmM2iwtOP4tXVdK52thPfAEmkk5EPziKJI8U7IAnrhDOld2yRQKPw9CFuuOTmm73kBebuKNs8WVCGmK0flfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
---
change in V8:
 1. fix patch format error

change in V7:
 1. change subject
 2. change the sdhci_o2_wait_dll_detect_lock_function
 3. add suitable usleep_range() to detect dll lock status

change in V6:
 1. define constant by using array size
 2. add more explanation for the code
 3. fix loop forever code error

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
 drivers/mmc/host/sdhci-pci-o2micro.c | 124 +++++++++++++++++++++++++++++++=
+++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 57c8b83..d879d91 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -11,6 +11,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
=20
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -55,9 +56,18 @@
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
+#define  O2_DLL_LOCK_STATUS	BIT(11)
=20
 #define O2_SD_DETECT_SETTING 0x324
=20
+static const u32 dmdn_table[] =3D {0x2B1C0000,
+	0x2C1A0000, 0x371B0000, 0x35100000};
+#define DMDN_SZ ARRAY_SIZE(dmdn_table)
+
+struct o2_host {
+	u8 dll_adjust_count;
+};
+
 static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
 {
 	ktime_t timeout;
@@ -133,7 +143,8 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
 {
 	struct sdhci_host *host =3D mmc_priv(mmc);
=20
-	sdhci_o2_enable_internal_clock(host);
+	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
+		sdhci_o2_enable_internal_clock(host);
=20
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }
@@ -152,6 +163,25 @@ static void o2_pci_set_baseclk(struct sdhci_pci_chip *=
chip, u32 value)
 			       O2_SD_PLL_SETTING, scratch_32);
 }
=20
+static u32 sdhci_o2_pll_dll_wdt_control(struct sdhci_host *host)
+{
+	return sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+}
+
+/*
+ * This function is used to detect dll lock status.
+ * Since the dll lock status bit will toggle randomly
+ * with very short interval which needs to be polled
+ * as fast as possible. Set sleep_us as 1 microsecond.
+ */
+static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
+{
+	u32	scratch32 =3D 0;
+
+	return readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
+		scratch32, !(scratch32 & O2_DLL_LOCK_STATUS), 1, 1000000);
+}
+
 static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
 {
 	u16 reg;
@@ -189,6 +219,83 @@ static void __sdhci_o2_execute_tuning(struct sdhci_hos=
t *host, u32 opcode)
 	sdhci_reset_tuning(host);
 }
=20
+/*
+ * This function is used to fix o2 dll shift issue.
+ * It isn't necessary to detect card present before recovery.
+ * Firstly, it is used by bht emmc card, which is embedded.
+ * Second, before call recovery card present will be detected
+ * outside of the execute tuning function.
+ */
+static int sdhci_o2_dll_recovery(struct sdhci_host *host)
+{
+	int ret =3D 0;
+	u8 scratch_8 =3D 0;
+	u32 scratch_32 =3D 0;
+	struct sdhci_pci_slot *slot =3D sdhci_priv(host);
+	struct sdhci_pci_chip *chip =3D slot->chip;
+	struct o2_host *o2_host =3D sdhci_pci_priv(slot);
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev,
+			O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 &=3D 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+	while (o2_host->dll_adjust_count < DMDN_SZ && !ret) {
+		/* Disable clock */
+		sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
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
+
+		/* Enable internal clock */
+		scratch_8 =3D SDHCI_CLOCK_INT_EN;
+		sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
+
+		if (sdhci_o2_get_cd(host->mmc)) {
+			/*
+			 * need wait at least 5ms for dll status stable,
+			 * after enable internal clock
+			 */
+			usleep_range(5000, 6000);
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
+		} else {
+			pr_err("%s: card present detect failed.\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+
+		o2_host->dll_adjust_count++;
+	}
+	if (!ret && o2_host->dll_adjust_count =3D=3D DMDN_SZ)
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
@@ -203,7 +310,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mm=
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
@@ -371,6 +487,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host=
, u16 clk)
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
=20
+	sdhci_o2_enable_internal_clock(host);
 	if (sdhci_o2_get_cd(host->mmc)) {
 		clk |=3D SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
@@ -396,12 +513,14 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *sl=
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
=20
+	o2_host->dll_adjust_count =3D 0;
 	caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
=20
 	/*
@@ -688,4 +807,5 @@ const struct sdhci_pci_fixes sdhci_o2 =3D {
 	.resume =3D sdhci_pci_o2_resume,
 #endif
 	.ops =3D &sdhci_pci_o2_ops,
+	.priv_size =3D sizeof(struct o2_host),
 };
--=20
2.7.4

