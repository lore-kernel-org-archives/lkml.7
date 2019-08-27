Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E48EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5E120828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892510;
	bh=u+9OPQw1vstRqpP0g2JG0AgbtnKhFFFhDGGl8jOPHUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7aUMddsPBwZ/Nt6cOuYEnHVWeehmHkf1Ff9RK55/uMI0YIBofPdu/HNlXslvajOS
	 HC/GCBqphRwi0FvD6gll5IwKgqtEtF14WG3ElOheoUJR9qmfdx+IFH02g5R98AoWfq
	 tV5M4RsXcm8gZV/owxIRXc6MOlJNCANPySEDAhKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfH0HzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730232AbfH0HzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:55:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2590B2189D;
        Tue, 27 Aug 2019 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892503;
        bh=u+9OPQw1vstRqpP0g2JG0AgbtnKhFFFhDGGl8jOPHUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MShTDZ1dWoeH7EI5DAeEV2ZpnOAk3mrtYIYcntI4Y2WpSaWdXFAuixBRo++xPhkGv
         GZtHqEHhvew1Dc8yuXqsu5bXJcjgC/gQlTQZaG095wF3Zrhj90Niw9NuGoTubHkLqd
         CDa0+ZLmUOWSuG5K9pXWa0KbvDFl/xc1gVncu1X0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/98] net: mvpp2: Dont check for 3 consecutive Idle frames for 10G links
Date:   Tue, 27 Aug 2019 09:49:47 +0200
Message-Id: <20190827072718.626446975@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 6455511457ca3..9b608d23ff7ee 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4412,9 +4412,9 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 	if (state->pause & MLO_PAUSE_RX)
 		ctrl0 |= MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN;
 
-	ctrl4 &= ~MVPP22_XLG_CTRL4_MACMODSELECT_GMAC;
-	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC |
-		 MVPP22_XLG_CTRL4_EN_IDLE_CHECK;
+	ctrl4 &= ~(MVPP22_XLG_CTRL4_MACMODSELECT_GMAC |
+		   MVPP22_XLG_CTRL4_EN_IDLE_CHECK);
+	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC;
 
 	writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
 	writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
-- 
2.20.1



