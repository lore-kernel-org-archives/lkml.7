Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C66EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11F92064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963878;
	bh=GCQUrZPIi42z/z2Emzf7MkZ24o+BlkR/YzHXuIv3FSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MrZqsNADd7GYMy1+IH6CrzP/qiI7eLckq2S+KocWWJ5RRdbsbime/Zwp7cg0rbwoN
	 K9xFbFDMfl0AYjhAYzDHxEcpLWRxFF+CzcYGEQl4g31fdN2dJiV+gAYOgzw46uZpg8
	 Aa+fN7nmW/tyRL4Xlb6bB4vcF8NF+J2Tx0iMjbn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfDVTmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbfDVTmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88578218D9;
        Mon, 22 Apr 2019 19:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962136;
        bh=GCQUrZPIi42z/z2Emzf7MkZ24o+BlkR/YzHXuIv3FSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgdwjF7U8v5QGJ3AW/6RApcT8ZiXhMqZs4up4+ZqdmCKXk6k8yriC6YY0ejapKuO4
         WGah9WFZdsbMLN5LM0ZNHhzalfbVA8gVDCyzc9ddDO3VAML6W84a6TMeqtqQhUiM0F
         dGKiWpq6KbHgRgs/3M5uFq0+JvDyQas3LVrhIFyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 11/98] net: stmmac: fix jumbo frame sending with non-linear skbs
Date:   Mon, 22 Apr 2019 15:40:38 -0400
Message-Id: <20190422194205.10404-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 58f2ce6f61615dfd8dd3cc01c9e5bb54ed35637e ]

When sending non-linear skbs with jumbo frames, we set up the non-paged
data and mark that as a last segment, although the paged fragments are
also prepared. This will stall the TX queue and trigger a watchdog warning
(a simple reproducer is to run an iperf client mode TCP test with a large
MTU - networking fails instantly).

Fix by checking if the skb is non-linear.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Acked-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index afed0f0f4027..4d9bcb4d0378 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -79,7 +79,8 @@ static int jumbo_frm(void *p, struct sk_buff *skb, int csum)
 
 		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 0, len, csum,
-				STMMAC_RING_MODE, 1, true, skb->len);
+				STMMAC_RING_MODE, 1, !skb_is_nonlinear(skb),
+				skb->len);
 	} else {
 		des2 = dma_map_single(priv->device, skb->data,
 				      nopaged_len, DMA_TO_DEVICE);
@@ -91,7 +92,8 @@ static int jumbo_frm(void *p, struct sk_buff *skb, int csum)
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
 		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
-				STMMAC_RING_MODE, 0, true, skb->len);
+				STMMAC_RING_MODE, 0, !skb_is_nonlinear(skb),
+				skb->len);
 	}
 
 	tx_q->cur_tx = entry;
-- 
2.19.1

