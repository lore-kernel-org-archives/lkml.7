Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A8EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCBE205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371352;
	bh=OV+leDYPYsoAFltb+eKy+j49AqrEWx8bF/5aw0VA0Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cCR6QrRFJgOhkSzc8/rFVzlQ01MOwtMVpYqS/5Tt15cHUNYjLUBUXDh2NtaaEKY4y
	 yzKP3tyfKv0vLekymUBe37o84lyL296dkSQXX8eUfRqJfQnDlV8VwML8Be8RYgNJqJ
	 hctOc89Q9c+Js5k/Bl46iz9+Vw3tZQYN8oFUNbRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfFXKPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbfFXKPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:15:48 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71662089F;
        Mon, 24 Jun 2019 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371347;
        bh=OV+leDYPYsoAFltb+eKy+j49AqrEWx8bF/5aw0VA0Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdAZHrwjg5mL1JHiG2VO4vAYjAhiON877F5CnhFAHAupOOgiBLjZVDyv8pZHcmNJb
         /XMHwjGbYj/L+rc0qAIcMYOwnH93Dc+NlVlc8CSzv/ePK02N7aWbI8P3u15AbO3YPN
         nVbtph72srzJMoVjs1hvtAbFGJPONbP7/q1L7bJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Lee <mark-mc.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 068/121] net: ethernet: mediatek: Use NET_IP_ALIGN to judge if HW RX_2BYTE_OFFSET is enabled
Date:   Mon, 24 Jun 2019 17:56:40 +0800
Message-Id: <20190624092324.327735639@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 880c2d4b2fdfd580ebcd6bb7240a8027a1d34751 ]

Should only enable HW RX_2BYTE_OFFSET function in the case NET_IP_ALIGN
equals to 2.

Signed-off-by: Mark Lee <mark-mc.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 59601cb5aeee..f3f7551162a9 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1777,6 +1777,7 @@ static void mtk_poll_controller(struct net_device *dev)
 
 static int mtk_start_dma(struct mtk_eth *eth)
 {
+	u32 rx_2b_offset = (NET_IP_ALIGN == 2) ? MTK_RX_2B_OFFSET : 0;
 	int err;
 
 	err = mtk_dma_init(eth);
@@ -1793,7 +1794,7 @@ static int mtk_start_dma(struct mtk_eth *eth)
 		MTK_QDMA_GLO_CFG);
 
 	mtk_w32(eth,
-		MTK_RX_DMA_EN | MTK_RX_2B_OFFSET |
+		MTK_RX_DMA_EN | rx_2b_offset |
 		MTK_RX_BT_32DWORDS | MTK_MULTI_EN,
 		MTK_PDMA_GLO_CFG);
 
-- 
2.20.1



