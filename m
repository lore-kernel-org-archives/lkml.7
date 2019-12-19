Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD4D24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576767909;
	bh=2vFU+S6HKqKhfz4jubJ0RuqI/YrwcWJmmCmTPInyZtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nkURCzKodwt+RTmK7cEV3K64XRnHaCfyfdS8FuBy54rtNIYWzJeWylW3Y9NhyeUJE
	 kPxQfokjRP0m3i8TwTgbMCxSJcs49plggGe2gKblErOFWzbXFoagJKXCo/rpdQ94SA
	 58nRvQa/nWDG8jaQR5YsfvFsDm4usSFHlSDq1KkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLSPFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfLSPFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:05:06 -0500
Received: from localhost.localdomain (unknown [122.178.234.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1D8221655;
        Thu, 19 Dec 2019 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576767905;
        bh=2vFU+S6HKqKhfz4jubJ0RuqI/YrwcWJmmCmTPInyZtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYgNPf78Ks2olSLVdWXX45DQN+xgYZmkM4W7388mGgelnnhI4LdEBenVPTxkPpk/2
         UEcAZTgAdfHMGHbTE9jdbwVmn9cE7bEXtNY1qqaM/QiN/2oEVkqjsGyXthHzzYLK2A
         f5vfJLWD/WFsYwnwiLKOE4NjGn04YwInN4WG7KiY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] phy: qcom-qmp: Add optional SW reset
Date:   Thu, 19 Dec 2019 20:34:32 +0530
Message-Id: <20191219150433.2785427-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219150433.2785427-1-vkoul@kernel.org>
References: <20191219150433.2785427-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For V4 QMP UFS Phy, we need to assert reset bits, configure the phy and
then deassert it, so add optional has_sw_reset flag and use that to
configure the QPHY_SW_RESET register.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 06f971ca518e..80304b7cd895 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1023,6 +1023,9 @@ struct qmp_phy_cfg {
 
 	/* true, if PCS block has no separate SW_RESET register */
 	bool no_pcs_sw_reset;
+
+	/* true if sw reset needs to be invoked */
+	bool has_sw_reset;
 };
 
 /**
@@ -1391,6 +1394,7 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 
 	.is_dual_lane_phy	= true,
 	.no_pcs_sw_reset	= true,
+	.has_sw_reset		= true,
 };
 
 static void qcom_qmp_phy_configure(void __iomem *base,
@@ -1475,6 +1479,9 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
 			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
 	}
 
+	if (cfg->has_sw_reset)
+		qphy_setbits(serdes, cfg->regs[QPHY_SW_RESET], SW_RESET);
+
 	if (cfg->has_phy_com_ctrl)
 		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
 			     SW_PWRDN);
@@ -1651,6 +1658,9 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 	if (cfg->has_phy_dp_com_ctrl)
 		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 
+	if (cfg->has_sw_reset)
+		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+
 	/* start SerDes and Phy-Coding-Sublayer */
 	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
-- 
2.23.0

