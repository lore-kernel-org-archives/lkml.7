Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFDCCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0D52173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wRTOx1Wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405515AbfJWM7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:59:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50286 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405415AbfJWM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwQwj040839;
        Wed, 23 Oct 2019 07:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835506;
        bh=pTDs+F9DlwcWqOO7mCdM7pTZQAYeGldBe85WSbu6hBI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wRTOx1Wfar1DMgXSdQJt9gMe3DMeYydxZLZkRllSuF8YaDl3BgbIq5STUY00wCg7U
         4LBeimmFWOmxHf4VHMf5AqMi/vIsKjHmduQWI2HPPe90uATYviVz7IS2L3uNKep0lU
         9RUqugzBBW5zHAz05IFQdIoO4XP+rMapn2W2V+zs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwPY8064626;
        Wed, 23 Oct 2019 07:58:26 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:25 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5oB061147;
        Wed, 23 Oct 2019 07:58:23 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 07/14] phy: cadence: Sierra: Configure both lane cdb and common cdb registers for external SSC
Date:   Wed, 23 Oct 2019 18:27:28 +0530
Message-ID: <20191023125735.4713-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023125735.4713-1-kishon@ti.com>
References: <20191023125735.4713-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anil Varughese <aniljoy@cadence.com>

The existing configuration done in Cadence Sierra driver is only for
reference and is not used in any platforms. Remove them and configure
both lane cdb and common cdb registers to be used with external
SSC configuration. This is validated in TI J721E platform.

Signed-off-by: Anil Varughese <aniljoy@cadence.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 356 ++++++++++++++++-------
 1 file changed, 257 insertions(+), 99 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index c0ea0863d050..b555d4c3633b 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -22,56 +22,123 @@
 #include <dt-bindings/phy/phy.h>
 
 /* PHY register offsets */
-#define SIERRA_COMMON_CDB_OFFSET		0x0
-#define SIERRA_MACRO_ID_REG			0x0
+#define SIERRA_COMMON_CDB_OFFSET			0x0
+#define SIERRA_MACRO_ID_REG				0x0
+#define SIERRA_CMN_PLLLC_MODE_PREG			0x48
+#define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG		0x49
+#define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG		0x4A
+#define SIERRA_CMN_PLLLC_LOCK_CNTSTART_PREG		0x4B
+#define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
+#define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
+#define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
 
 #define SIERRA_LANE_CDB_OFFSET(ln, offset)	\
 				(0x4000 + ((ln) * (0x800 >> (2 - (offset)))))
 
-#define SIERRA_DET_STANDEC_A_PREG		0x000
-#define SIERRA_DET_STANDEC_B_PREG		0x001
-#define SIERRA_DET_STANDEC_C_PREG		0x002
-#define SIERRA_DET_STANDEC_D_PREG		0x003
-#define SIERRA_DET_STANDEC_E_PREG		0x004
-#define SIERRA_PSM_LANECAL_PREG			0x008
-#define SIERRA_PSM_DIAG_PREG			0x015
-#define SIERRA_PSC_TX_A0_PREG			0x028
-#define SIERRA_PSC_TX_A1_PREG			0x029
-#define SIERRA_PSC_TX_A2_PREG			0x02A
-#define SIERRA_PSC_TX_A3_PREG			0x02B
-#define SIERRA_PSC_RX_A0_PREG			0x030
-#define SIERRA_PSC_RX_A1_PREG			0x031
-#define SIERRA_PSC_RX_A2_PREG			0x032
-#define SIERRA_PSC_RX_A3_PREG			0x033
-#define SIERRA_PLLCTRL_SUBRATE_PREG		0x03A
-#define SIERRA_PLLCTRL_GEN_D_PREG		0x03E
-#define SIERRA_DRVCTRL_ATTEN_PREG		0x06A
-#define SIERRA_CLKPATHCTRL_TMR_PREG		0x081
-#define SIERRA_RX_CREQ_FLTR_A_MODE1_PREG	0x087
-#define SIERRA_RX_CREQ_FLTR_A_MODE0_PREG	0x088
-#define SIERRA_CREQ_CCLKDET_MODE01_PREG		0x08E
-#define SIERRA_RX_CTLE_MAINTENANCE_PREG		0x091
-#define SIERRA_CREQ_FSMCLK_SEL_PREG		0x092
-#define SIERRA_CTLELUT_CTRL_PREG		0x098
-#define SIERRA_DFE_ECMP_RATESEL_PREG		0x0C0
-#define SIERRA_DFE_SMP_RATESEL_PREG		0x0C1
-#define SIERRA_DEQ_VGATUNE_CTRL_PREG		0x0E1
-#define SIERRA_TMRVAL_MODE3_PREG		0x16E
-#define SIERRA_TMRVAL_MODE2_PREG		0x16F
-#define SIERRA_TMRVAL_MODE1_PREG		0x170
-#define SIERRA_TMRVAL_MODE0_PREG		0x171
-#define SIERRA_PICNT_MODE1_PREG			0x174
-#define SIERRA_CPI_OUTBUF_RATESEL_PREG		0x17C
-#define SIERRA_LFPSFILT_NS_PREG			0x18A
-#define SIERRA_LFPSFILT_RD_PREG			0x18B
-#define SIERRA_LFPSFILT_MP_PREG			0x18C
-#define SIERRA_SDFILT_H2L_A_PREG		0x191
-
-#define SIERRA_PHY_CONFIG_CTRL_OFFSET		0xc000
-#define SIERRA_PHY_PLL_CFG			0xe
-
-#define SIERRA_MACRO_ID				0x00007364
-#define SIERRA_MAX_LANES			4
+#define SIERRA_DET_STANDEC_A_PREG			0x000
+#define SIERRA_DET_STANDEC_B_PREG			0x001
+#define SIERRA_DET_STANDEC_C_PREG			0x002
+#define SIERRA_DET_STANDEC_D_PREG			0x003
+#define SIERRA_DET_STANDEC_E_PREG			0x004
+#define SIERRA_PSM_LANECAL_DLY_A1_RESETS_PREG		0x008
+#define SIERRA_PSM_A0IN_TMR_PREG			0x009
+#define SIERRA_PSM_DIAG_PREG				0x015
+#define SIERRA_PSC_TX_A0_PREG				0x028
+#define SIERRA_PSC_TX_A1_PREG				0x029
+#define SIERRA_PSC_TX_A2_PREG				0x02A
+#define SIERRA_PSC_TX_A3_PREG				0x02B
+#define SIERRA_PSC_RX_A0_PREG				0x030
+#define SIERRA_PSC_RX_A1_PREG				0x031
+#define SIERRA_PSC_RX_A2_PREG				0x032
+#define SIERRA_PSC_RX_A3_PREG				0x033
+#define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
+#define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
+#define SIERRA_PLLCTRL_CPGAIN_MODE_PREG			0x03F
+#define SIERRA_CLKPATH_BIASTRIM_PREG			0x04B
+#define SIERRA_DFE_BIASTRIM_PREG			0x04C
+#define SIERRA_DRVCTRL_ATTEN_PREG			0x06A
+#define SIERRA_CLKPATHCTRL_TMR_PREG			0x081
+#define SIERRA_RX_CREQ_FLTR_A_MODE3_PREG		0x085
+#define SIERRA_RX_CREQ_FLTR_A_MODE2_PREG		0x086
+#define SIERRA_RX_CREQ_FLTR_A_MODE1_PREG		0x087
+#define SIERRA_RX_CREQ_FLTR_A_MODE0_PREG		0x088
+#define SIERRA_CREQ_CCLKDET_MODE01_PREG			0x08E
+#define SIERRA_RX_CTLE_MAINTENANCE_PREG			0x091
+#define SIERRA_CREQ_FSMCLK_SEL_PREG			0x092
+#define SIERRA_CREQ_EQ_CTRL_PREG			0x093
+#define SIERRA_CREQ_SPARE_PREG				0x096
+#define SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG		0x097
+#define SIERRA_CTLELUT_CTRL_PREG			0x098
+#define SIERRA_DFE_ECMP_RATESEL_PREG			0x0C0
+#define SIERRA_DFE_SMP_RATESEL_PREG			0x0C1
+#define SIERRA_DEQ_PHALIGN_CTRL				0x0C4
+#define SIERRA_DEQ_CONCUR_CTRL1_PREG			0x0C8
+#define SIERRA_DEQ_CONCUR_CTRL2_PREG			0x0C9
+#define SIERRA_DEQ_EPIPWR_CTRL2_PREG			0x0CD
+#define SIERRA_DEQ_FAST_MAINT_CYCLES_PREG		0x0CE
+#define SIERRA_DEQ_ERRCMP_CTRL_PREG			0x0D0
+#define SIERRA_DEQ_OFFSET_CTRL_PREG			0x0D8
+#define SIERRA_DEQ_GAIN_CTRL_PREG			0x0E0
+#define SIERRA_DEQ_VGATUNE_CTRL_PREG			0x0E1
+#define SIERRA_DEQ_GLUT0				0x0E8
+#define SIERRA_DEQ_GLUT1				0x0E9
+#define SIERRA_DEQ_GLUT2				0x0EA
+#define SIERRA_DEQ_GLUT3				0x0EB
+#define SIERRA_DEQ_GLUT4				0x0EC
+#define SIERRA_DEQ_GLUT5				0x0ED
+#define SIERRA_DEQ_GLUT6				0x0EE
+#define SIERRA_DEQ_GLUT7				0x0EF
+#define SIERRA_DEQ_GLUT8				0x0F0
+#define SIERRA_DEQ_GLUT9				0x0F1
+#define SIERRA_DEQ_GLUT10				0x0F2
+#define SIERRA_DEQ_GLUT11				0x0F3
+#define SIERRA_DEQ_GLUT12				0x0F4
+#define SIERRA_DEQ_GLUT13				0x0F5
+#define SIERRA_DEQ_GLUT14				0x0F6
+#define SIERRA_DEQ_GLUT15				0x0F7
+#define SIERRA_DEQ_GLUT16				0x0F8
+#define SIERRA_DEQ_ALUT0				0x108
+#define SIERRA_DEQ_ALUT1				0x109
+#define SIERRA_DEQ_ALUT2				0x10A
+#define SIERRA_DEQ_ALUT3				0x10B
+#define SIERRA_DEQ_ALUT4				0x10C
+#define SIERRA_DEQ_ALUT5				0x10D
+#define SIERRA_DEQ_ALUT6				0x10E
+#define SIERRA_DEQ_ALUT7				0x10F
+#define SIERRA_DEQ_ALUT8				0x110
+#define SIERRA_DEQ_ALUT9				0x111
+#define SIERRA_DEQ_ALUT10				0x112
+#define SIERRA_DEQ_ALUT11				0x113
+#define SIERRA_DEQ_ALUT12				0x114
+#define SIERRA_DEQ_ALUT13				0x115
+#define SIERRA_DEQ_DFETAP_CTRL_PREG			0x128
+#define SIERRA_DFE_EN_1010_IGNORE_PREG			0x134
+#define SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG		0x150
+#define SIERRA_DEQ_TAU_CTRL2_PREG			0x151
+#define SIERRA_DEQ_PICTRL_PREG				0x161
+#define SIERRA_CPICAL_TMRVAL_MODE1_PREG			0x170
+#define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
+#define SIERRA_CPICAL_PICNT_MODE1_PREG			0x174
+#define SIERRA_CPI_OUTBUF_RATESEL_PREG			0x17C
+#define SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG		0x183
+#define SIERRA_LFPSDET_SUPPORT_PREG			0x188
+#define SIERRA_LFPSFILT_NS_PREG				0x18A
+#define SIERRA_LFPSFILT_RD_PREG				0x18B
+#define SIERRA_LFPSFILT_MP_PREG				0x18C
+#define SIERRA_SIGDET_SUPPORT_PREG			0x190
+#define SIERRA_SDFILT_H2L_A_PREG			0x191
+#define SIERRA_SDFILT_L2H_PREG				0x193
+#define SIERRA_RXBUFFER_CTLECTRL_PREG			0x19E
+#define SIERRA_RXBUFFER_RCDFECTRL_PREG			0x19F
+#define SIERRA_RXBUFFER_DFECTRL_PREG			0x1A0
+#define SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG		0x14F
+#define SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG		0x150
+
+#define SIERRA_PHY_CONFIG_CTRL_OFFSET			0xc000
+#define SIERRA_PHY_PLL_CFG				0xe
+
+#define SIERRA_MACRO_ID					0x00007364
+#define SIERRA_MAX_LANES				4
 
 static const struct reg_field macro_id_type =
 				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
@@ -95,10 +162,14 @@ struct cdns_sierra_data {
 		u32 id_value;
 		u8 block_offset_shift;
 		u8 reg_offset_shift;
-		u32 pcie_regs;
-		u32 usb_regs;
-		struct cdns_reg_pairs *pcie_vals;
-		struct cdns_reg_pairs  *usb_vals;
+		u32 pcie_cmn_regs;
+		u32 pcie_ln_regs;
+		u32 usb_cmn_regs;
+		u32 usb_ln_regs;
+		struct cdns_reg_pairs *pcie_cmn_vals;
+		struct cdns_reg_pairs *pcie_ln_vals;
+		struct cdns_reg_pairs *usb_cmn_vals;
+		struct cdns_reg_pairs *usb_ln_vals;
 };
 
 struct cdns_regmap_cdb_context {
@@ -181,26 +252,35 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
 	struct regmap *regmap = phy->regmap;
 	int i, j;
-	struct cdns_reg_pairs *vals;
-	u32 num_regs;
+	struct cdns_reg_pairs *cmn_vals, *ln_vals;
+	u32 num_cmn_regs, num_ln_regs;
 
 	/* Initialise the PHY registers, unless auto configured */
 	if (phy->autoconf)
 		return 0;
 
 	if (ins->phy_type == PHY_TYPE_PCIE) {
-		num_regs = phy->init_data->pcie_regs;
-		vals = phy->init_data->pcie_vals;
+		num_cmn_regs = phy->init_data->pcie_cmn_regs;
+		num_ln_regs = phy->init_data->pcie_ln_regs;
+		cmn_vals = phy->init_data->pcie_cmn_vals;
+		ln_vals = phy->init_data->pcie_ln_vals;
 	} else if (ins->phy_type == PHY_TYPE_USB3) {
-		num_regs = phy->init_data->usb_regs;
-		vals = phy->init_data->usb_vals;
+		num_cmn_regs = phy->init_data->usb_cmn_regs;
+		num_ln_regs = phy->init_data->usb_ln_regs;
+		cmn_vals = phy->init_data->usb_cmn_vals;
+		ln_vals = phy->init_data->usb_ln_vals;
 	} else {
 		return -EINVAL;
 	}
+
+	regmap = phy->regmap_common_cdb;
+	for (j = 0; j < num_cmn_regs ; j++)
+		regmap_write(regmap, cmn_vals[j].off, cmn_vals[j].val);
+
 	for (i = 0; i < ins->num_lanes; i++) {
-		for (j = 0; j < num_regs ; j++) {
+		for (j = 0; j < num_ln_regs ; j++) {
 			regmap = phy->regmap_lane_cdb[i + ins->mlane];
-			regmap_write(regmap, vals[j].off, vals[j].val);
+			regmap_write(regmap, ln_vals[j].off, ln_vals[j].val);
 		}
 	}
 
@@ -489,80 +569,158 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct cdns_reg_pairs cdns_usb_regs[] = {
-	/*
-	 * Write USB configuration parameters to the PHY.
-	 * These values are specific to this specific hardware
-	 * configuration.
-	 */
+/* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc */
+static struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
+	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
+	{0x1B1B, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG}
+};
+
+/* refclk100MHz_32b_PCIe_ln_ext_ssc */
+static struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
+	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
+	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
+	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG}
+};
+
+/* refclk100MHz_20b_USB_cmn_pll_ext_ssc */
+static struct cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] = {
+	{0x2085, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x2085, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG}
+};
+
+/* refclk100MHz_20b_USB_ln_ext_ssc */
+static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0xFE0A, SIERRA_DET_STANDEC_A_PREG},
 	{0x000F, SIERRA_DET_STANDEC_B_PREG},
-	{0x55A5, SIERRA_DET_STANDEC_C_PREG},
-	{0x69AD, SIERRA_DET_STANDEC_D_PREG},
+	{0x00A5, SIERRA_DET_STANDEC_C_PREG},
+	{0x69ad, SIERRA_DET_STANDEC_D_PREG},
 	{0x0241, SIERRA_DET_STANDEC_E_PREG},
-	{0x0110, SIERRA_PSM_LANECAL_PREG},
+	{0x0010, SIERRA_PSM_LANECAL_DLY_A1_RESETS_PREG},
+	{0x0014, SIERRA_PSM_A0IN_TMR_PREG},
 	{0xCF00, SIERRA_PSM_DIAG_PREG},
 	{0x001F, SIERRA_PSC_TX_A0_PREG},
 	{0x0007, SIERRA_PSC_TX_A1_PREG},
 	{0x0003, SIERRA_PSC_TX_A2_PREG},
 	{0x0003, SIERRA_PSC_TX_A3_PREG},
 	{0x0FFF, SIERRA_PSC_RX_A0_PREG},
-	{0x0003, SIERRA_PSC_RX_A1_PREG},
+	{0x0619, SIERRA_PSC_RX_A1_PREG},
 	{0x0003, SIERRA_PSC_RX_A2_PREG},
 	{0x0001, SIERRA_PSC_RX_A3_PREG},
 	{0x0001, SIERRA_PLLCTRL_SUBRATE_PREG},
 	{0x0406, SIERRA_PLLCTRL_GEN_D_PREG},
+	{0x5233, SIERRA_PLLCTRL_CPGAIN_MODE_PREG},
+	{0x00CA, SIERRA_CLKPATH_BIASTRIM_PREG},
+	{0x2512, SIERRA_DFE_BIASTRIM_PREG},
 	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
-	{0x823E, SIERRA_CLKPATHCTRL_TMR_PREG},
-	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
-	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x873E, SIERRA_CLKPATHCTRL_TMR_PREG},
+	{0x03CF, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x01CE, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
 	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01_PREG},
-	{0x023C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
+	{0x033F, SIERRA_RX_CTLE_MAINTENANCE_PREG},
 	{0x3232, SIERRA_CREQ_FSMCLK_SEL_PREG},
-	{0x8452, SIERRA_CTLELUT_CTRL_PREG},
-	{0x4121, SIERRA_DFE_ECMP_RATESEL_PREG},
-	{0x4121, SIERRA_DFE_SMP_RATESEL_PREG},
-	{0x9999, SIERRA_DEQ_VGATUNE_CTRL_PREG},
-	{0x0330, SIERRA_TMRVAL_MODE0_PREG},
-	{0x01FF, SIERRA_PICNT_MODE1_PREG},
+	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
+	{0x8000, SIERRA_CREQ_SPARE_PREG},
+	{0xCC44, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
+	{0x8453, SIERRA_CTLELUT_CTRL_PREG},
+	{0x4110, SIERRA_DFE_ECMP_RATESEL_PREG},
+	{0x4110, SIERRA_DFE_SMP_RATESEL_PREG},
+	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
+	{0x3200, SIERRA_DEQ_CONCUR_CTRL1_PREG},
+	{0x5064, SIERRA_DEQ_CONCUR_CTRL2_PREG},
+	{0x0030, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
+	{0x0048, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
+	{0x5A5A, SIERRA_DEQ_ERRCMP_CTRL_PREG},
+	{0x02F5, SIERRA_DEQ_OFFSET_CTRL_PREG},
+	{0x02F5, SIERRA_DEQ_GAIN_CTRL_PREG},
+	{0x9A8A, SIERRA_DEQ_VGATUNE_CTRL_PREG},
+	{0x0014, SIERRA_DEQ_GLUT0},
+	{0x0014, SIERRA_DEQ_GLUT1},
+	{0x0014, SIERRA_DEQ_GLUT2},
+	{0x0014, SIERRA_DEQ_GLUT3},
+	{0x0014, SIERRA_DEQ_GLUT4},
+	{0x0014, SIERRA_DEQ_GLUT5},
+	{0x0014, SIERRA_DEQ_GLUT6},
+	{0x0014, SIERRA_DEQ_GLUT7},
+	{0x0014, SIERRA_DEQ_GLUT8},
+	{0x0014, SIERRA_DEQ_GLUT9},
+	{0x0014, SIERRA_DEQ_GLUT10},
+	{0x0014, SIERRA_DEQ_GLUT11},
+	{0x0014, SIERRA_DEQ_GLUT12},
+	{0x0014, SIERRA_DEQ_GLUT13},
+	{0x0014, SIERRA_DEQ_GLUT14},
+	{0x0014, SIERRA_DEQ_GLUT15},
+	{0x0014, SIERRA_DEQ_GLUT16},
+	{0x0BAE, SIERRA_DEQ_ALUT0},
+	{0x0AEB, SIERRA_DEQ_ALUT1},
+	{0x0A28, SIERRA_DEQ_ALUT2},
+	{0x0965, SIERRA_DEQ_ALUT3},
+	{0x08A2, SIERRA_DEQ_ALUT4},
+	{0x07DF, SIERRA_DEQ_ALUT5},
+	{0x071C, SIERRA_DEQ_ALUT6},
+	{0x0659, SIERRA_DEQ_ALUT7},
+	{0x0596, SIERRA_DEQ_ALUT8},
+	{0x0514, SIERRA_DEQ_ALUT9},
+	{0x0492, SIERRA_DEQ_ALUT10},
+	{0x0410, SIERRA_DEQ_ALUT11},
+	{0x038E, SIERRA_DEQ_ALUT12},
+	{0x030C, SIERRA_DEQ_ALUT13},
+	{0x03F4, SIERRA_DEQ_DFETAP_CTRL_PREG},
+	{0x0001, SIERRA_DFE_EN_1010_IGNORE_PREG},
+	{0x3C01, SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG},
+	{0x3C40, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C08, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0033, SIERRA_DEQ_PICTRL_PREG},
+	{0x0400, SIERRA_CPICAL_TMRVAL_MODE1_PREG},
+	{0x0330, SIERRA_CPICAL_TMRVAL_MODE0_PREG},
+	{0x01FF, SIERRA_CPICAL_PICNT_MODE1_PREG},
 	{0x0009, SIERRA_CPI_OUTBUF_RATESEL_PREG},
+	{0x3232, SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG},
+	{0x0005, SIERRA_LFPSDET_SUPPORT_PREG},
 	{0x000F, SIERRA_LFPSFILT_NS_PREG},
 	{0x0009, SIERRA_LFPSFILT_RD_PREG},
 	{0x0001, SIERRA_LFPSFILT_MP_PREG},
 	{0x8013, SIERRA_SDFILT_H2L_A_PREG},
-	{0x0400, SIERRA_TMRVAL_MODE1_PREG},
-};
-
-static struct cdns_reg_pairs cdns_pcie_regs[] = {
-	/*
-	 * Write PCIe configuration parameters to the PHY.
-	 * These values are specific to this specific hardware
-	 * configuration.
-	 */
-	{0x891f, SIERRA_DET_STANDEC_D_PREG},
-	{0x0053, SIERRA_DET_STANDEC_E_PREG},
-	{0x0400, SIERRA_TMRVAL_MODE2_PREG},
-	{0x0200, SIERRA_TMRVAL_MODE3_PREG},
+	{0x8009, SIERRA_SDFILT_L2H_PREG},
+	{0x0024, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x0020, SIERRA_RXBUFFER_RCDFECTRL_PREG},
+	{0x4243, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
 static const struct cdns_sierra_data cdns_map_sierra = {
 	SIERRA_MACRO_ID,
 	0x2,
 	0x2,
-	ARRAY_SIZE(cdns_pcie_regs),
-	ARRAY_SIZE(cdns_usb_regs),
-	cdns_pcie_regs,
-	cdns_usb_regs
+	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
+	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
+	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
+	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
+	cdns_pcie_cmn_regs_ext_ssc,
+	cdns_pcie_ln_regs_ext_ssc,
+	cdns_usb_cmn_regs_ext_ssc,
+	cdns_usb_ln_regs_ext_ssc,
 };
 
 static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	SIERRA_MACRO_ID,
 	0x0,
 	0x1,
-	ARRAY_SIZE(cdns_pcie_regs),
-	ARRAY_SIZE(cdns_usb_regs),
-	cdns_pcie_regs,
-	cdns_usb_regs
+	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
+	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
+	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
+	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
+	cdns_pcie_cmn_regs_ext_ssc,
+	cdns_pcie_ln_regs_ext_ssc,
+	cdns_usb_cmn_regs_ext_ssc,
+	cdns_usb_ln_regs_ext_ssc,
 };
 
 static const struct of_device_id cdns_sierra_id_table[] = {
-- 
2.17.1

