Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4BFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4A9214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748710;
	bh=QTPcXnlZ5T+jEEW715T3WxHVcsOeUgIQyvi0fQbVuMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H19g7EKkooLuPF+mYK23ATgv+ZKA6CW3tw/ftkWb7HMjTZLAB4TQUPHGVJnEkg+7E
	 FojbOkfRlbHp01fugQqR+AA1pPqpTIhzc0FPecNPYXE8W7W+yAx+ca2z4KBbuo6znA
	 NBanSZC+1ShO14GrMamlhMav4ZDb0UKCbud0Qe74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfHNCLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbfHNCLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:11:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5855E2085A;
        Wed, 14 Aug 2019 02:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748705;
        bh=QTPcXnlZ5T+jEEW715T3WxHVcsOeUgIQyvi0fQbVuMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDUCWx+cB49Ovuy3fbM1jSE/f4XHfzvmRLf1sqd6lSgE8eiXyuf6AelQnU+XsTI/j
         xijo+UrRnayd7KdfM8u42B9rAxRE5RMk7+Nd8HzJPnw9ttvO5EthKOt3dHg7wqBP6S
         zJbU65ERlGPiw57IHoHZpEMmFVIOqn9vUXhOTdho=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 031/123] net: mvpp2: Don't check for 3 consecutive Idle frames for 10G links
Date:   Tue, 13 Aug 2019 22:09:15 -0400
Message-Id: <20190814021047.14828-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit bba18318e7d1d5c8b0bbafd65010a0cee3c65608 ]

PPv2's XLGMAC can wait for 3 idle frames before triggering a link up
event. This can cause the link to be stuck low when there's traffic on
the interface, so disable this feature.

Fixes: 4bb043262878 ("net: mvpp2: phylink support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 50ed1bdb632db..885529701de90 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4580,9 +4580,9 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 	else
 		ctrl0 &= ~MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN;
 
-	ctrl4 &= ~MVPP22_XLG_CTRL4_MACMODSELECT_GMAC;
-	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC |
-		 MVPP22_XLG_CTRL4_EN_IDLE_CHECK;
+	ctrl4 &= ~(MVPP22_XLG_CTRL4_MACMODSELECT_GMAC |
+		   MVPP22_XLG_CTRL4_EN_IDLE_CHECK);
+	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC;
 
 	if (old_ctrl0 != ctrl0)
 		writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
-- 
2.20.1

