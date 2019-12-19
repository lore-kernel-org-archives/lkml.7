Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E1DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF6B2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576767913;
	bh=p80ASa2e+ERmBUt4/2lrbwFwRHc3FZsVGsG89n2xFRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0CQ1hwmf6hjUaIwkyPwQklp72ezgwPoezTL+wFAOMWR+hCYoRNSTIERi/BHQBZfN8
	 cDzIZkv6C8s11zFESYjDlEAURnXQmlLRT4cA1a+YEqnTGAVRoBHFRsTMj+cBllXdb0
	 zyAk5sVLkG8on+LNdyi18XuP8hnlOKq7SMw/T2Zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLSPFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSPFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:05:09 -0500
Received: from localhost.localdomain (unknown [122.178.234.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09EA824672;
        Thu, 19 Dec 2019 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576767908;
        bh=p80ASa2e+ERmBUt4/2lrbwFwRHc3FZsVGsG89n2xFRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYxcHDDB7QXpMzgECtUDyu9s3nmp4cwHUCukVUhPwthi52qMM5l7Pdvp0ZIOOlHxU
         W5yEiCYGb+O1PifZMJacf8Bu1lVzfBe3TPqeXRIV8mcM+fGpx6ym1R5dhPiuDSJoxv
         7E8WLVOZDky85i2qWroG2BzSIAigwJqadWt4H0Ck=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] phy: qcom-qmp: remove duplicate powerdown write
Date:   Thu, 19 Dec 2019 20:34:33 +0530
Message-Id: <20191219150433.2785427-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219150433.2785427-1-vkoul@kernel.org>
References: <20191219150433.2785427-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already write to QPHY_POWER_DOWN_CONTROL in qcom_qmp_phy_com_init()
before invoking qcom_qmp_phy_configure() so remove the duplicate write.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 80304b7cd895..309ef15e46b0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -885,7 +885,6 @@ static const struct qmp_phy_init_tbl msm8998_usb3_pcs_tbl[] = {
 };
 
 static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
-	QMP_PHY_INIT_CFG(QPHY_POWER_DOWN_CONTROL, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL, 0x00),
-- 
2.23.0

