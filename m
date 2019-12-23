Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E64C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E55122522
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577111472;
	bh=3cUpT0mny7tfDIGYn2V0LDUiAbt2ffFJwm4dcoAsQww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mEPAUpgIiHOBUJfYl/fw21h2FCtSd+vCuZmtzorp6mOyjMEKu9JdoULeg+9I8jpf9
	 TqR+ug7B2bN+gHaen27kuKBOK5awSQ7FI+89kbEpEmbsu0VbMQr6e7KvHzEeXW9+WM
	 vp+0TvJMX7n2kuCtAplfB76GeZ2S6ZIjUcphnfH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLWObL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfLWObI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:31:08 -0500
Received: from vkoul-mobl.Dlink (unknown [106.51.110.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14F52073A;
        Mon, 23 Dec 2019 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577111467;
        bh=3cUpT0mny7tfDIGYn2V0LDUiAbt2ffFJwm4dcoAsQww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mP71U7+bwHXCPh8kzD4jtLNTeggnElMia699oF1a+KgUrxT0I/ZkvNkzZWxyw2MwB
         Mt3RoYgMTmLkEzqWaPl2pHoBacKGcFqHK4tZ+Dzborinh8XjyHY8IiM8U5Qf0T/cJF
         ljin2oev0Bk/UOk5D2/4dB0KK1Cg3d76l7+nYBQ8=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] phy: qcom-qmp: remove duplicate powerdown write
Date:   Mon, 23 Dec 2019 20:00:44 +0530
Message-Id: <20191223143046.3376299-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191223143046.3376299-1-vkoul@kernel.org>
References: <20191223143046.3376299-1-vkoul@kernel.org>
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
index 1196c85aa023..4f2e65c7cf45 100644
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

