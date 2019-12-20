Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F37C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B262467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576837079;
	bh=WDlz/eaahcbrJ7H+D15Kf/SYPxCgh/g8ow8gZBeOjYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2H9nWoKWFvJhOKj6CfgC0QMNfaej83WqXg/72Gr4ucDJA2Bs4YeN9TGnNqZWztgsm
	 bSO5Tdq9Bv4bd7zazCBbiQjSoni7av82gPz08s84QWCX5hAUrjtkTpjzEXRifopBTi
	 2GSejKwXA5ogMlepbd/FxniJtvlgW0B5jVAh64wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLTKR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfLTKR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:17:56 -0500
Received: from localhost.localdomain (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AEC24683;
        Fri, 20 Dec 2019 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576837075;
        bh=WDlz/eaahcbrJ7H+D15Kf/SYPxCgh/g8ow8gZBeOjYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKgzrY8lQJgst6jMMwjLnhJx/QOO63BykHJmIpDRSHgezSg5UJ+HZ44h9hQUB0RLj
         rGzPL+MXbubTsausxdVAYQJ5Z/xDnqUPaf30y6Uow24kKY2pc2/jTOSNZF2Q9EsStK
         qn0IF9kqEMc7+mGi40jmvLEAsShryp065uWyVSU8=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] phy: qcom-qmp: remove no_pcs_sw_reset for sm8150
Date:   Fri, 20 Dec 2019 15:47:19 +0530
Message-Id: <20191220101719.3024693-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191220101719.3024693-1-vkoul@kernel.org>
References: <20191220101719.3024693-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8150 QMPY phy for UFS and onwards the PHY_SW_RESET is present in PHY's
PCS register so we should not mark no_pcs_sw_reset for sm8150 and
onwards

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 2a12a0b3bd72..2696640ee3f9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1393,7 +1393,6 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN,
 
 	.is_dual_lane_phy	= true,
-	.no_pcs_sw_reset	= true,
 	.has_sw_reset		= true,
 };
 
-- 
2.23.0

