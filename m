Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F0C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9279220CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577111479;
	bh=rKlmP8qCOreILakRYVKDlU4TZ4C5i5QpLwBHZqwKiVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=owvs+hV1mY/IMtkQN+NL9gznFC91n4av9MiT0eLjGEuyKwuIpY/QjXaXq/wH3RVuN
	 8vClSyYq+bFXr/UeD9M5GroncesC4a7sji4+4NVvPI09QsLYidF0tBqiayB5wWaf7E
	 dfsPIPl1smmC1ZTZ3O8XMPlTdR2/7dE5WD2Sisvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLWObS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfLWObQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:31:16 -0500
Received: from vkoul-mobl.Dlink (unknown [106.51.110.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48EC220709;
        Mon, 23 Dec 2019 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577111475;
        bh=rKlmP8qCOreILakRYVKDlU4TZ4C5i5QpLwBHZqwKiVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iv+aWzTH8e+kLR0srzVQxgtvQG/L5+1MkVpbPa6869c4GPMk1y2VyMQdaj6XxwQ97
         5inRhWzyGxLAEHdYZExPIjrAt1gU4Ba2GNqH9UhIFHtInYML4MYXEBaSLkOgRgzMPV
         bTqg6sXolOglqqfIQ44c2O+9EuyMm9GHN0+aIY3k=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] phy: qcom-qmp: Add SW reset register
Date:   Mon, 23 Dec 2019 20:00:46 +0530
Message-Id: <20191223143046.3376299-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191223143046.3376299-1-vkoul@kernel.org>
References: <20191223143046.3376299-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For V4 QMP UFS Phy, we need to assert reset bits, configure the phy and
then deassert it, so add the QPHY_SW_RESET register which does this.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index ce5e18f188c3..7db2a94f7a99 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -168,6 +168,7 @@ static const unsigned int sdm845_ufsphy_regs_layout[] = {
 static const unsigned int sm8150_ufsphy_regs_layout[] = {
 	[QPHY_START_CTRL]		= QPHY_V4_PHY_START,
 	[QPHY_PCS_READY_STATUS]		= QPHY_V4_PCS_READY_STATUS,
+	[QPHY_SW_RESET]			= QPHY_V4_SW_RESET,
 };
 
 static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
-- 
2.23.0

