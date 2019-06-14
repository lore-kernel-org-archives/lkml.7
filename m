Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D05A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544397;
	bh=EdtY/ixIohmX4Bak3RJMtNK7DinyD8AF6I72XlVbPAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yqJu5jTD4i7xsDfRYoW808AQwfWIUkd+7W82ZspAcwVDn/TlexZiSm9dioG3f73/l
	 t23PuUj6V0/5Qx9xmMyVYfBdlNPzxl2uetGgh4TOSz5j8SWdGPbmJ3kvGzV1krtvBa
	 QWBWctY/DINfAgwwmmk3uHQJM/fx+6XiMTUAj/GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfFNUdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfFNUae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:34 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD6C21850;
        Fri, 14 Jun 2019 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544233;
        bh=EdtY/ixIohmX4Bak3RJMtNK7DinyD8AF6I72XlVbPAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAXbJw2dwEwhZDCuTChbyIVPZVKrFklGBEJ7cGdrBXrZ+aHGtRabvpvt/x28h9/OR
         ODAtAnVBIvtRuB7ukEkawD2EFdhwo6rxL/IapKwwsMGBqj52/xT663FKJj1HEECZDz
         22DBb+mW+R9ef/879fWKOzwhBf3YtoWmJpdvH1r4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <mark-mc.lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 17/27] net: ethernet: mediatek: Use NET_IP_ALIGN to judge if HW RX_2BYTE_OFFSET is enabled
Date:   Fri, 14 Jun 2019 16:30:06 -0400
Message-Id: <20190614203018.27686-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614203018.27686-1-sashal@kernel.org>
References: <20190614203018.27686-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

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
index 5208bf61df10..9ba699cbdbc5 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1788,6 +1788,7 @@ static void mtk_poll_controller(struct net_device *dev)
 
 static int mtk_start_dma(struct mtk_eth *eth)
 {
+	u32 rx_2b_offset = (NET_IP_ALIGN == 2) ? MTK_RX_2B_OFFSET : 0;
 	int err;
 
 	err = mtk_dma_init(eth);
@@ -1804,7 +1805,7 @@ static int mtk_start_dma(struct mtk_eth *eth)
 		MTK_QDMA_GLO_CFG);
 
 	mtk_w32(eth,
-		MTK_RX_DMA_EN | MTK_RX_2B_OFFSET |
+		MTK_RX_DMA_EN | rx_2b_offset |
 		MTK_RX_BT_32DWORDS | MTK_MULTI_EN,
 		MTK_PDMA_GLO_CFG);
 
-- 
2.20.1

