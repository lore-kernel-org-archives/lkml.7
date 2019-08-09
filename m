Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBBC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DE8214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="OrarfEAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407547AbfHIRi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:38:58 -0400
Received: from mail-eopbgr720102.outbound.protection.outlook.com ([40.107.72.102]:6407
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406652AbfHIRi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUbzJ6rAgq5mVJ7ehG4d7N7uIgNJTJUSKvo4ZD7Rx0Q7FW07N2kbPuEknvuGZWLdVjZnWCDRv/mqQWcVxoFR2yCPSx5vuDoZps27CU4iSbQjdqy/tQaVBHs5Veebxz/86t7tbsnIqnZtFdpd3nChAfElKm5h8Dco/wRRABAHnQ+qtgTkXVB9L/U4iT+sqoK5kDoTFNiWj1OyIa7KPS6XgnJRoaHQ1Aps/xg+bNC0bS9JGqKni8oqMX4EdUCPO7ZbPY2RUNAAKdXRPPx6fghvLXwIocDDx292N9Q9Z+vq22DGEK311IEbTFY716tQ8Sg5LsSobORvcEkAYD2cKq6Spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGDId1utBw/ct+9aj2Z35TosJjK0CXZVBriU0UuKzc0=;
 b=mtmJOoqmKrGpG6ciQ8gakO7LXhSEHmj/m1APGgI8+Jz8HA3PmV/S02PYeICCAdzhevhRw22vILGtlo9+swHZ6fuMsEVfhELh2DtP/KMg3nJAP2gkCFaJzv1vbN5y7CmeHIRtaR4zHcGrsyGhgmRVZuyR3DGjgYj6xpz1QVLsCfDIL4RNAy55KYJWnI0pIA+rnI7gziWUD/UIE7lhpyaPzjG6gHrtDg4zUERB0aVN+Dmx/67PBtfRor3p4aRefkWUg/146+/3PJjBcDP34vYgvSdcYIpWZu0ZVoyWnfyC79nKdsCippdOWwhGmA+zYpwRnzZAQ9BH0TuFo251W7lshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGDId1utBw/ct+9aj2Z35TosJjK0CXZVBriU0UuKzc0=;
 b=OrarfEANwyoQMphtT7IQQdVUPzo9VJI1QzEL9D216jvw/b1s8Wactne9cOzcBynzI9qqOznB74dY8rqSXGkUqtR7UVkqq8u3uO2MwK41gHOK4sXFVPUPSKy7ilbogEWTe5PA7Mue3tkS9wK0jE8x+UuK6Fb2907bxSy0hTAGf5Q=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1453.namprd16.prod.outlook.com (10.175.3.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 9 Aug 2019 17:38:54 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 17:38:54 +0000
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
Subject: [PATCH V6 3/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock Phase
 shift issue
Thread-Topic: [PATCH V6 3/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Thread-Index: AQHVTtlQoNsPDRzcVUak1Mrn1uge3w==
Date:   Fri, 9 Aug 2019 17:38:54 +0000
Message-ID: <1565372331-4716-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::36) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ed7bf36-5be8-4606-c765-08d71cf072ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB1453;
x-ms-traffictypediagnostic: MWHPR16MB1453:
x-microsoft-antispam-prvs: <MWHPR16MB145353A72D1D1C52F63026BD8BD60@MWHPR16MB1453.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(64756008)(66446008)(54906003)(53936002)(305945005)(66066001)(8676002)(7736002)(2201001)(110136005)(71200400001)(71190400001)(476003)(508600001)(66556008)(66476007)(66946007)(316002)(107886003)(6512007)(6436002)(36756003)(8936002)(6486002)(2501003)(14454004)(14444005)(86362001)(256004)(486006)(50226002)(5660300002)(81166006)(81156014)(3846002)(6116002)(6506007)(386003)(2906002)(102836004)(4326008)(52116002)(2616005)(99286004)(25786009)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1453;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XdPOMfNf6boYSR+PLqqjamZ1qe2+iiW26S6Ysg45ib76XFSpnogJqQWjcEJmvp5qjQkLsL8unSe7dHNsXiY6RIIiexFeei2Rp+8ozGtIw+tEShOF86v/ARDz5NkBxeLocdtFSgxlga7bdNKu/JiKG69Awq78SMLuALy8pdaD7pto7L4c7S8vDyVBuO7HeR+vyW3abGG03b8ugRibk8K90BCunVUG8f2iWeFpsK+O/oqjiEFiCXh7pIaVOnJaflgHef6O2qTtd1L/Kg1YB49EBJhRUleFvsdBP3hFqYJNs9jD0ZKdkTi/ggKepqBeKdh6WGjANKxuanewc5H79/UTTir/zhIy65uDEi/5j4OOWqzUD7GAQm98rTNwhMIBLv/c67ccofxhybqiLdy+tTGeiaZLDkEbk/wm7JpxgSUsb+k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed7bf36-5be8-4606-c765-08d71cf072ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 17:38:54.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQXHuzmYXs2mc6R+zfMisg64DAGdEANwZRXzKEg375CMGw0dbPwQ7BawqkIcGEir+hgmElRQGAT781kBBtYL+dYJAPf77kdZ7NgzmENtEIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
---
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
 drivers/mmc/host/sdhci-pci-o2micro.c | 128 +++++++++++++++++++++++++++++++=
+++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index c780888..8cb516d 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -55,9 +55,18 @@
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
@@ -153,6 +162,38 @@ static void o2_pci_set_baseclk(struct sdhci_pci_chip *=
chip, u32 value)
 			       O2_SD_PLL_SETTING, scratch_32);
 }
=20
+/*
+ * This function is used to detect dll lock status.
+ * Before detect, need wait 5ms for dll status stable.
+ * In order to detect the toggle of dll lock status bit,
+ * we should fast polling this bit status without delay.
+ */
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
@@ -190,6 +231,78 @@ static void __sdhci_o2_execute_tuning(struct sdhci_hos=
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
@@ -204,7 +317,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mm=
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
@@ -372,6 +494,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host=
, u16 clk)
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
=20
+	sdhci_o2_enable_internal_clock(host);
 	if (sdhci_o2_get_cd(host->mmc)) {
 		clk |=3D SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
@@ -397,12 +520,14 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *sl=
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
@@ -689,4 +814,5 @@ const struct sdhci_pci_fixes sdhci_o2 =3D {
 	.resume =3D sdhci_pci_o2_resume,
 #endif
 	.ops =3D &sdhci_pci_o2_ops,
+	.priv_size =3D sizeof(struct o2_host),
 };
--=20
2.7.4

