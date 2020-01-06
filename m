Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CEFC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A7720848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTNMoYGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgAFITK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:19:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38455 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgAFITH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:19:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so26631489pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 00:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WW7XOwv6ov1DcBjkPAxvkxF8MxG29vmU9V6Eg0R4jhU=;
        b=GTNMoYGBhDJ0XuoNL71GIiFnFOu6r7iXiSli9kyQ/aVy5KJc/2V0F9ZbmbenPbFs2d
         aB49Zu0niXIDpb+Xd3JTNXDVfXRtVhPaUoFwkGPTL+xNSI/o7342Z2Tg5W25DBanfu5s
         sEAD+nIEQoV1fWJvEzt9VhgbBGQFh9API2QbRCIHXERXDgrPu1JZZ6WAed1TlJTgPs10
         rvxcJXK8D/VXl7CeKMzS8Rn1CNILCCEYSVu6bt1vbGIiug9odQHeG+2o6V8Mi0dfON0L
         iSWWS4ARoM0T+t7BocGbWHlM1n4EnPzXQwSg50umZNK7QcJT26AQ1gW67I/gDE1KY8nb
         S++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WW7XOwv6ov1DcBjkPAxvkxF8MxG29vmU9V6Eg0R4jhU=;
        b=T4dIN7EoVe3l4ztnZF7W/DpN4mn/NNbCFzLUjsJXcf2+HmPLeuzNi9b9qNQOsDASal
         joLXjtQMnwwbs3+zi5wUcL/67pdpSfTNDup0vB4DqbM3APmRlNSOJfIANMQMe/1jfYiJ
         Js51CU1/xdEFsuBtReqhK27UyNoT1SRo8spk4bm3c8QW+Zj30Kx28tVfEqerprJxPwMi
         kJ1xvfopSuJqNI45VSj86XFY8yR99KM7NF0F7IAZCcUi9BJYbZDDqIgQLpOHCDLW13F0
         SANLMnhEW3h3wZmuEtHou4BUyJU05htLuJkBLfenM0okKhl5jsNGBhiFEtKhQ8lR5jpX
         N+eg==
X-Gm-Message-State: APjAAAXOwUJ5Z9AEG5SJ1rlkRKcmQxqMq1bYyoRxVA7c5ZQLPuFByofT
        4lPQFDYYX4Grv6TVy1ZmkpOaHQ==
X-Google-Smtp-Source: APXvYqzN4DXrQHoTMHjPXmV6VWr6HTPQC7/k6QosvaUfm7hPUmyFTg45jYSYfb9yjhGXX6/papoSRA==
X-Received: by 2002:a63:9d07:: with SMTP id i7mr114701488pgd.344.1578298746224;
        Mon, 06 Jan 2020 00:19:06 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h7sm82343457pfq.36.2020.01.06.00.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 00:19:05 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 2/3] phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
Date:   Mon,  6 Jan 2020 00:18:20 -0800
Message-Id: <20200106081821.3192922-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106081821.3192922-1-bjorn.andersson@linaro.org>
References: <20200106081821.3192922-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_qmp_phy_init() is extended to support the additional register
writes needed in PCS MISC and the appropriate sequences and resources
are defined for the GEN2 PCIe QMP PHY found in SDM845.

Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Rebased patch

 drivers/phy/qualcomm/phy-qcom-qmp.c | 156 ++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index e107a7eec235..8ece0c0c2288 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -160,6 +160,12 @@ static const unsigned int qmp_v3_usb3phy_regs_layout[] = {
 	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x170,
 };
 
+static const unsigned int sdm845_qmp_pciephy_regs_layout[] = {
+	[QPHY_SW_RESET]			= 0x00,
+	[QPHY_START_CTRL]		= 0x08,
+	[QPHY_PCS_STATUS]		= 0x174,
+};
+
 static const unsigned int sdm845_ufsphy_regs_layout[] = {
 	[QPHY_START_CTRL]		= 0x00,
 	[QPHY_PCS_READY_STATUS]		= 0x160,
@@ -481,6 +487,109 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG_L(QPHY_START_CTRL, 0x3),
 };
 
+static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x007),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xc9),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_TIMER1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_TIMER2, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_EP_DIV, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_MODE, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x33),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_BUF_ENABLE, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER1, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE1, 0x7e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE2, 0x15),
+};
+
+static const struct qmp_phy_init_tbl sdm845_qmp_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
+};
+
+static const struct qmp_phy_init_tbl sdm845_qmp_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_ENABLES, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN_HALF, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x71),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_01, 0x59),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x71),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x40),
+};
+
+static const struct qmp_phy_init_tbl sdm845_qmp_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_ENDPOINT_REFCLK_DRIVE, 0x04),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LP_WAKEUP_DLY_TIME_AUXCLK_MSB, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LP_WAKEUP_DLY_TIME_AUXCLK, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PLL_LOCK_CHK_DLY_TIME, 0x73),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0xbb),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG1, 0x0d),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG4, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sdm845_qmp_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_CONFIG2, 0x52),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG2, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG4, 0x1a),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG5, 0x06),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
+};
+
 static const struct qmp_phy_init_tbl qmp_v3_usb3_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x14),
@@ -988,6 +1097,8 @@ struct qmp_phy_cfg {
 	int rx_tbl_num;
 	const struct qmp_phy_init_tbl *pcs_tbl;
 	int pcs_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_misc_tbl;
+	int pcs_misc_tbl_num;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1126,6 +1237,10 @@ static const char * const qmp_v3_phy_clk_l[] = {
 	"aux", "cfg_ahb", "ref", "com_aux",
 };
 
+static const char * const sdm845_pciephy_clk_l[] = {
+	"aux", "cfg_ahb", "ref", "refgen",
+};
+
 static const char * const sdm845_ufs_phy_clk_l[] = {
 	"ref", "ref_aux",
 };
@@ -1139,6 +1254,10 @@ static const char * const msm8996_usb3phy_reset_l[] = {
 	"phy", "common",
 };
 
+static const char * const sdm845_pciephy_reset_l[] = {
+	"phy",
+};
+
 /* list of regulators */
 static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
@@ -1234,6 +1353,36 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.pwrdn_delay_max	= 1005,		/* us */
 };
 
+static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
+	.type = PHY_TYPE_PCIE,
+	.nlanes = 1,
+
+	.serdes_tbl		= sdm845_qmp_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_serdes_tbl),
+	.tx_tbl			= sdm845_qmp_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_tx_tbl),
+	.rx_tbl			= sdm845_qmp_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_rx_tbl),
+	.pcs_tbl		= sdm845_qmp_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sdm845_qmp_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sdm845_qmp_pcie_pcs_misc_tbl),
+	.clk_list		= sdm845_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sdm845_qmp_pciephy_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
 static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -1563,6 +1712,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 	void __iomem *tx = qphy->tx;
 	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
+	void __iomem *pcs_misc = qphy->pcs_misc;
 	void __iomem *dp_com = qmp->dp_com;
 	void __iomem *status;
 	unsigned int mask, val, ready;
@@ -1633,6 +1783,9 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 	if (ret)
 		goto err_lane_rst;
 
+	qcom_qmp_phy_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
+			       cfg->pcs_misc_tbl_num);
+
 	/*
 	 * Pull out PHY from POWER DOWN state.
 	 * This is active low enable signal to power-down PHY.
@@ -2102,6 +2255,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,ipq8074-qmp-pcie-phy",
 		.data = &ipq8074_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-pcie-phy",
+		.data = &sdm845_qmp_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sdm845-qmp-usb3-phy",
 		.data = &qmp_v3_usb3phy_cfg,
-- 
2.24.0

