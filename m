Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9612BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AED2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504416;
	bh=PNvkFhzIAllO8hBoOourl4gYWO0bqtH8G2xzYFdin0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/u7Oyl4NLqE5bvs0U9N5qvg6xZPtzOCixgxf2KvWczSHaSdyFcAmaf47FgVIOMla
	 2aUoit5v+4X0XA5sv89Nm65juobw9UIvASoOlvTiE6M8kfcC28sckU1GJFDVbebbrA
	 FtkspHJwdcKyYpvK3vUyQPz7BbLsmpgbbvdt7ZmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfCMTNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfCMTNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:13:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6275C2177E;
        Wed, 13 Mar 2019 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504411;
        bh=PNvkFhzIAllO8hBoOourl4gYWO0bqtH8G2xzYFdin0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGZ2iJtjJwiLpDCW0x5yvmNRFRebuF+ruhPE6f6AZN34wYY6fd278ulL+kt6n6vt/
         cR4+2mBJOmGIrzHh9rCvfYiKmjvmVpMBo8ZdhFywgvTER02nOnxs/m4BeMGTYggZ2E
         1o1QGjjLaGoD/k6jUt/Q2/XiXXFx+bl6esClDPxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/48] net: systemport: Fix reception of BPDUs
Date:   Wed, 13 Mar 2019 15:12:15 -0400
Message-Id: <20190313191250.158955-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
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
index fc16b2b0d0e9..0bdbc72605e1 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -134,6 +134,10 @@ static int bcm_sysport_set_rx_csum(struct net_device *dev,
 
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

