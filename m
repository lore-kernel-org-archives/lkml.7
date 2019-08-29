Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE3FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4006922CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="C6syHjZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfH2RlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:41:03 -0400
Received: from mail-eopbgr720126.outbound.protection.outlook.com ([40.107.72.126]:29888
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbfH2RlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:41:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXwztxWvpuhMYpePGZUiOyFKXCFxWBAaKrlmOI0YG42hb0PlzP7Mbm1HpAiKe5sPfabKV9fPupHqP1vK7fd8Vs+UblF/P8ts9pKdbKsGqEEG5lbSIRgupWd2L8O1gS3jBG0X95EVQFPytlhZCUAAOW+TdLU6F76uqilLxttWK1aTbABV3cyCJctSvUToilOKT2rnoM6A3D+F1rxDRHNvvp24TNEDqppMrO+IRi0q9vn1Mc2scFBPq0t3UcdBIQ4pbCzW8kQ8sQaxDMk0PJ8oCpuaYn/ZokQaE/So4gfRJo2r5zMWn6iypMVR8jlxVyEIjaoysTcuXUWcLWCH+0ZNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF62lCNsz3cITZ/X0d65xdQ9Pmh8WLe6sxBkgWVn6bk=;
 b=kqQ2egnDzaPOI/pEGr6FzhSOYGyXnHSecuYxFjGNxxckEaHM8ceFHk0SRxvYFBLtOZfp3qgko87b2yBOLC50lGJMJ4XReWz8yu+JyS3ZX0Q8/nh7l2BxpINjF50ZaJ/+qP739KnhDZ2l4EUiwfkMJPK65BNfHQJZfS1QY3f1q/NKpMZztB3zwUiad/vgBS8yHks2VVKiut0bU9KMU9rXXeevq2jdyw5EfGmdVd6IujE6HhO0M+W929AlAuAluIGOcdT/GMejSB+ZWbakB/zyElgt5iIXPr25V7IDhFkvuvK8i24nqYqwMJWMRkIxhfpkPS7w4WdZql3kmQ1kXYiaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF62lCNsz3cITZ/X0d65xdQ9Pmh8WLe6sxBkgWVn6bk=;
 b=C6syHjZZEy+VpsYpSA81njfXCAEX30fW2OjytUMwWZzzqYx5QLYOdaCz/9ngawkuqbEe2BTSPuWjiOytU1ktGu2SuQ+zTTDWe0Tic/c6zI9FjCQxZDwQWI8esnra5rojem31a9XZFHVXW7JjXQef/+obH3q5DeBjNdeCYW23ie8=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB0110.namprd16.prod.outlook.com (10.172.97.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 29 Aug 2019 17:40:57 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2220.013; Thu, 29 Aug 2019
 17:40:57 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V9 2/3] mmc: sdhci-pci-o2micro: Move functions in preparation
 to fix DLL lock phase shift issue
Thread-Topic: [PATCH V9 2/3] mmc: sdhci-pci-o2micro: Move functions in
 preparation to fix DLL lock phase shift issue
Thread-Index: AQHVXpDqqVggdWx2XESNdLxRh+b02Q==
Date:   Thu, 29 Aug 2019 17:40:57 +0000
Message-ID: <1567100454-5905-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:a03:54::39) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 021fd66d-4568-4b99-a8c2-08d72ca80c57
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB0110;
x-ms-traffictypediagnostic: MWHPR16MB0110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB01101B75144C946D7BDD80AB8BA20@MWHPR16MB0110.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(366004)(346002)(396003)(376002)(199004)(189003)(2616005)(6436002)(486006)(476003)(14444005)(36756003)(256004)(71190400001)(71200400001)(26005)(14454004)(102836004)(386003)(6506007)(186003)(52116002)(3846002)(305945005)(6116002)(7736002)(8936002)(50226002)(508600001)(2501003)(99286004)(54906003)(316002)(110136005)(2201001)(86362001)(6486002)(8676002)(81156014)(81166006)(66946007)(66446008)(64756008)(66556008)(25786009)(4326008)(53936002)(5660300002)(107886003)(6512007)(2906002)(66066001)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB0110;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wm1irtOY1MUqusKpc3wmKJnoIzRT/G+ul7NUdLlhcdzntLerpw7Lbk7raRlcr9CoWVc+T/wCj+P7obLNrfPV9HdtKMcAEHvW0mWtdc+zNTnajHCrUA9/PmtuggPUj8+SVs7+hAeDOCh9PIuZYzbjlCkhn1HDuzNdRK7/ME0gj/gQtS8hvnhp+ky4/Sub0TNfWi1zPGT3CA3qLpxobvm+367Ya9EvXaO6OMMxYmu5P9GaaVjNATB4dx0KoziujxrtOvoYp88dITjoEilQPFfSdl8dGIpGTGO2EegXqOf0w2CnPbFNCq7hpGe7xDjSqea8PK3gdOs2bvGs71lKnyAn9k0N0IMHIU8F9e4+Q2bpkaOhSRFnJ6ALZIlZfxr2f80BTrWnBo6Nc1x9TIOR0rX9Y9+EE7lL/meecXlJcmVdnxY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021fd66d-4568-4b99-a8c2-08d72ca80c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 17:40:57.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZRbPkQI0JXlp6i15/qip+OxD2sICL0H1DjVnfe+31LN4nUWAtKVO1Hz0nS2TAUbGmN/mEqjUgkyDD+znz/ilL7ULJdD3FkaSae1M5fm+Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB0110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move functions in preparation to fix DLL lock phase shift issue

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
---
change in V9:
 1. modify subject and commit message to match the patch

change in V8:
 1. fix patch format error

change in V7:
 1. change subject to match the patch
 2. move functions in preparation to fix DLL lock phase shift issue

change in V6:
 1. change subject and commit message to match the patch
 2. modify the get CD status function
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
 drivers/mmc/host/sdhci-pci-o2micro.c | 187 ++++++++++++++++++-------------=
----
 1 file changed, 94 insertions(+), 93 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index b3a33d9..57c8b83 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -58,6 +58,100 @@
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
@@ -136,19 +230,6 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mm=
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
@@ -284,86 +365,6 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_c=
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

