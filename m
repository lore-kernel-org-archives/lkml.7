Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A89C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E933C2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117918;
	bh=Yl0MfkPBZO6IG+gj7v0ri1dsffYw0adTyxXa2Hv/ULM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZc1BpKuWUvmticpFRqfuV11NwICnPuLprt27wJujxuQIwPcgeOmP7IvSvKYox4N+
	 KAUDTbVbQ4uKNm4NjQ/lkE+R17e+09l5rQkKhTCceV0BBbc5Q3HWrGUSfTI+pgYMPe
	 94DE1Zz1sMgXKHDcOfpUZCxxYXh3EMot7xX14JVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfDXOrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732277AbfDXOri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB7F21905;
        Wed, 24 Apr 2019 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117257;
        bh=Yl0MfkPBZO6IG+gj7v0ri1dsffYw0adTyxXa2Hv/ULM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tL3/t8siBX4ky4jwYFiUTyVVhpM1+J+bC9u4i4YwTIN7o9FoX9XxVReZ5WgpZ4EJj
         VwOn2LY1iRPecBf0NiVIjAx+nIYUaw/6g72TCfYtj+W5Off3LigrlKqv6CX2BCOwNb
         zpatXjkr1tYNzM4pAs75GvHK65+UKPohMf97C0Tw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 12/35] net: stmmac: ratelimit RX error logs
Date:   Wed, 24 Apr 2019 10:46:46 -0400
Message-Id: <20190424144709.30215-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 972c9be784e077bc56472c78243e0326e525b689 ]

Ratelimit RX error logs.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f2429ec07b57..80e138c0336d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3415,9 +3415,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -3475,9 +3476,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
2.19.1

