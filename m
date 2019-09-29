Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB50C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BB7218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765630;
	bh=KLbFfGlf9oltN7d7+gTl8gb7w5YEcQPPEj9x0jk4g74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uGqw5NkOGkz3ztCOBNxPdnvHoXeycuzlPbhRcZ2o9qlWUguppu0XCLlTh9rgJUHp7
	 +kF9OYuVNz5SAVIptgrxuFy0MBH12qpRWXvrzZts/gIpuRoo2vELs72WsgEdj8SZ2F
	 Ry1L47Nxf1j38MO3dzGnBMAHSnGFpiIDWBHVZn88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfI2OA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbfI2OAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:00:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DDF21882;
        Sun, 29 Sep 2019 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765623;
        bh=KLbFfGlf9oltN7d7+gTl8gb7w5YEcQPPEj9x0jk4g74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTkYVPs5I6L/ZE65V06LzlacLZq/isYE4S+Ja2BYs2D5qLH+MM9cioV/cPn+uk2z0
         u0aH/zOFiDzL6pJxz6cxhVt1NDghDQSc1UbZnzl3p7VndI1XwEINAl4hfViU8WoEI1
         Ezc6WfhqZ2RrQ6luTwxwxYj6mJXZS2y1TEEwu/hY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 03/45] phy: qcom-qmp: Raise qcom_qmp_phy_enable() polling delay
Date:   Sun, 29 Sep 2019 15:55:31 +0200
Message-Id: <20190929135025.438428669@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Gonzalez <marc.w.gonzalez@free.fr>

[ Upstream commit 5206026404190125436f81088eb3667076e56083 ]

readl_poll_timeout() calls usleep_range() to sleep between reads.
usleep_range() doesn't work efficiently for tiny values.

Raise the polling delay in qcom_qmp_phy_enable() to bring it in line
with the delay in qcom_qmp_phy_com_init().

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 43abdfd0deed9..99b3bc04d215a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1549,7 +1549,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 	status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
 	mask = cfg->mask_pcs_ready;
 
-	ret = readl_poll_timeout(status, val, val & mask, 1,
+	ret = readl_poll_timeout(status, val, val & mask, 10,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev, "phy initialization timed-out\n");
-- 
2.20.1



