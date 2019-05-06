Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9FCC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C912053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155255;
	bh=5tKBW8PYzLrLHOVNxUwGQWrc0VZ1JE/XrthbPqqGBZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=waLN9ZjZkpaW/ix1Jm3ASc0Y87+qowPbUPuLQCT5T1wwEGN3TU/IP2DXit/k4NNJZ
	 1aakKaKBolLqCZmGTc1p7AhNZR8XiBSXCz3mB6T9qbiT4WYzfgF4aIiOiiPwkmtPlT
	 pXDHdOKsfWqKXDJWs81wxKmOuY53N2FpUMhtp8P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfEFPHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfEFOg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:36:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D135204EC;
        Mon,  6 May 2019 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153419;
        bh=5tKBW8PYzLrLHOVNxUwGQWrc0VZ1JE/XrthbPqqGBZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiItCVHNOR6YIG0VzHHWIEDhx19QRydgRA7jNh6XVtc4z66foUJzBifBcyRGm2hem
         cP/Z9HHDM02MOOhmV5AIeGq2BPpq5F50ZZz3OC2Xl2fL0AvUWf95OLhtL0kZwb355H
         7H3k4YuflG0wfwM1AS+Jpc+D1qzUQu2DxHTnLRjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 051/122] net: stmmac: ratelimit RX error logs
Date:   Mon,  6 May 2019 16:31:49 +0200
Message-Id: <20190506143059.501226800@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 972c9be784e077bc56472c78243e0326e525b689 ]

Ratelimit RX error logs.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f765869bd864..0ccf91a08290 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3407,9 +3407,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			 *  ignored
 			 */
 			if (frame_len > priv->dma_buf_sz) {
-				netdev_err(priv->dev,
-					   "len %d larger than size (%d)\n",
-					   frame_len, priv->dma_buf_sz);
+				if (net_ratelimit())
+					netdev_err(priv->dev,
+						   "len %d larger than size (%d)\n",
+						   frame_len, priv->dma_buf_sz);
 				priv->dev->stats.rx_length_errors++;
 				break;
 			}
@@ -3466,9 +3467,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			} else {
 				skb = rx_q->rx_skbuff[entry];
 				if (unlikely(!skb)) {
-					netdev_err(priv->dev,
-						   "%s: Inconsistent Rx chain\n",
-						   priv->dev->name);
+					if (net_ratelimit())
+						netdev_err(priv->dev,
+							   "%s: Inconsistent Rx chain\n",
+							   priv->dev->name);
 					priv->dev->stats.rx_dropped++;
 					break;
 				}
-- 
2.20.1



