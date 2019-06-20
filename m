Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16210C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA3D21655
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054594;
	bh=J1YeY68HcNxy4hxTZGUbI6MEMOoqItqMFANsYPUiprg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u4BP/XQ/lCSYxbiDzCP7eNBrSIAXnkRXp+C3MR5QC1RawkcWVofMIHdA2NaE9NVkN
	 Wz2V4RSi7iYjsro78mrJk9zv6aqq9HKNv7Xs1WimeVNBh77wOnWw6xnhfeHg83hf6k
	 oAnQpEFSD9rGYZKo+LdKEdPorVpGfaM1iWtnOsgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfFTSQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbfFTSQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:16:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6ED4205F4;
        Thu, 20 Jun 2019 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054588;
        bh=J1YeY68HcNxy4hxTZGUbI6MEMOoqItqMFANsYPUiprg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJ6yRzJ9zHG5xKiuRCLt0s2uTUq68kHEfOb1nZh1DsBogWeLgQTVST1i0opr5b3YE
         hA89xK3gacHwGLpxLcYDb2POw6YP9WywNlBfiLGsyVagtJuKvR7fR2E8/tVgMrskuZ
         fqtZEopVK9aQ2JINi06RchUEcl3eWj+gzTxsCt5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Biao Huang <biao.huang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 52/98] net: stmmac: update rx tail pointer register to fix rx dma hang issue.
Date:   Thu, 20 Jun 2019 19:57:19 +0200
Message-Id: <20190620174351.650458591@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4523a5611526709ec9b4e2574f1bb7818212651e ]

Currently we will not update the receive descriptor tail pointer in
stmmac_rx_refill. Rx dma will think no available descriptors and stop
once received packets exceed DMA_RX_SIZE, so that the rx only test will fail.

Update the receive tail pointer in stmmac_rx_refill to add more descriptors
to the rx channel, so packets can be received continually

Fixes: 54139cf3bb33 ("net: stmmac: adding multiple buffers for rx")
Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3c409862c52e..8cebc44108b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3338,6 +3338,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		entry = STMMAC_GET_ENTRY(entry, DMA_RX_SIZE);
 	}
 	rx_q->dirty_rx = entry;
+	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
 }
 
 /**
-- 
2.20.1



