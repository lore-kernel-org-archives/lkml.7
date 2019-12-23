Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD23C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE85820709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577111466;
	bh=HbnZQLpmgHXuQZD4rzr1fzFLDl+IaGj4mWYVNAsbNqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azhfh0f9SqrulE2oW5HF7Fu+iiUKxOiuDXT66KNIHreNQ6M9NIzy9zUfK0bRYwNIE
	 jZD1eyiCg8DoNRbIwL+TB4P0u/pmF1u1nSoAlPBUYOoxjwf9hkhz88rcppisFgKEVO
	 f1BaH7p7yCA8tB/8hYG+6NavMn/vRIMRTWOJA7IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfLWObE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:31:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfLWObD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:31:03 -0500
Received: from vkoul-mobl.Dlink (unknown [106.51.110.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B605020715;
        Mon, 23 Dec 2019 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577111463;
        bh=HbnZQLpmgHXuQZD4rzr1fzFLDl+IaGj4mWYVNAsbNqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNVaCVZeiTF3YPNzO7IGoU5IepR3bZV0K/2HZ+Hv91LB+uQrhQYYKDDPMB8jnzNen
         IOfNb1pOzdg2N2TPDHLrJ9TtpMvt61fV+7qj3Tp8JNa8pqzlGOg/h6ngIJklHqOE+Z
         pA93xoX2rdzKSCyo4FHL3z+y/ic3E3dxiOrL+sm4=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] phy: qcom-qmp: Use register defines
Date:   Mon, 23 Dec 2019 20:00:43 +0530
Message-Id: <20191223143046.3376299-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191223143046.3376299-1-vkoul@kernel.org>
References: <20191223143046.3376299-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already define register offsets so use them in register layout.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 66f91726b8b2..1196c85aa023 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -166,8 +166,8 @@ static const unsigned int sdm845_ufsphy_regs_layout[] = {
 };
 
 static const unsigned int sm8150_ufsphy_regs_layout[] = {
-	[QPHY_START_CTRL]		= 0x00,
-	[QPHY_PCS_READY_STATUS]		= 0x180,
+	[QPHY_START_CTRL]		= QPHY_V4_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V4_PCS_READY_STATUS,
 };
 
 static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
-- 
2.23.0

