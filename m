Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A434C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576E22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504807;
	bh=rTDytNybTMpmHuu9kc52l5nuTYKlAz2MLesx6TT+Fps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AAnI3UbS6Y7vjBzU7BTC4K5d0zmzAx3ti/myzEpgqIVMB1juzSj/vgzNe3RRtYRaL
	 iPbOeoL90hNyxxrzRlVGmz1n3y/++1ENqZFV8IzBTFwmcKlXO+Mi9dB3vDKDSe0h4K
	 Tm0Zywt9hSJd60aQKFo5lUpbUJs2RByPnE4F3NVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfCMTTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfCMTS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:18:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A936B213A2;
        Wed, 13 Mar 2019 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504738;
        bh=rTDytNybTMpmHuu9kc52l5nuTYKlAz2MLesx6TT+Fps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=updxydXqbGJguzQf9QZSXqvzJTHVsyzyGrId7FqraALHjLuzGjeU/vvxe3zz/eWWZ
         4VGO5vxthc7X/BQz6VaR9itvAxTCVkjunyS7l3Y237H0vIreAuxG04787TIpDOitrV
         oWjyEVA9JfP29DNk/zNrmhBCqHyxtTnbqpXN7R9o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 04/10] net: systemport: Fix reception of BPDUs
Date:   Wed, 13 Mar 2019 15:18:40 -0400
Message-Id: <20190313191847.160801-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191847.160801-1-sashal@kernel.org>
References: <20190313191847.160801-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit a40061ea2e39494104602b3048751341bda374a1 ]

SYSTEMPORT has its RXCHK parser block that attempts to validate the
packet structures, unfortunately setting the L2 header check bit will
cause Bridge PDUs (BPDUs) to be incorrectly rejected because they look
like LLC/SNAP packets with a non-IPv4 or non-IPv6 Ethernet Type.

Fixes: 4e8aedfe78c7 ("net: systemport: Turn on offloads by default")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index dbe35e9277c3..c81e0139fe74 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -126,6 +126,10 @@ static int bcm_sysport_set_rx_csum(struct net_device *dev,
 
 	priv->rx_chk_en = !!(wanted & NETIF_F_RXCSUM);
 	reg = rxchk_readl(priv, RXCHK_CONTROL);
+	/* Clear L2 header checks, which would prevent BPDUs
+	 * from being received.
+	 */
+	reg &= ~RXCHK_L2_HDR_DIS;
 	if (priv->rx_chk_en)
 		reg |= RXCHK_EN;
 	else
-- 
2.19.1

