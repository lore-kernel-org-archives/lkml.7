Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5379DC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FE22081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198523;
	bh=u6RQSDbsXz7d1wIj1ywS08mITo8uSGdBMeqTUouL1To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXAyPtHdbyt9+hiCB+yIcO/xKt2Ue6n7m/Tdq1xXvo/fqhSInoNCVlbEJrVPz+ctw
	 6LXGpYN/DGEzlqwWtZqymiN9j2ROURNoq2LY8YUrF9x289cZGkWD6ZcW4JbdR1aYRN
	 ggoBMatKHf7QRwUjoliLfw5FlZKqDNw9XjRvoKT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfGONsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbfGONsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:48:36 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B727D2086C;
        Mon, 15 Jul 2019 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198515;
        bh=u6RQSDbsXz7d1wIj1ywS08mITo8uSGdBMeqTUouL1To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPlQfAjpSnzeZAHCnSRKDRsN0g5XgS16rPJqPwZd+HQ+WoMJnB+ZjdtnMl8yrNSZT
         G9HFhRni+IglK3QEGV+BWklRF882sqhNdMX4f2QdlcZ4/j1/QzjtVRnlp+LryhtHID
         5+78Qr55TVLGyh4wI1Nv+lUyPT31AhCP7La+NzSk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 032/249] net: stmmac: Prevent missing interrupts when running NAPI
Date:   Mon, 15 Jul 2019 09:43:17 -0400
Message-Id: <20190715134655.4076-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit a976ca79e23f13bff79c14e7266cea4a0ea51e67 ]

When we trigger NAPI we are disabling interrupts but in case we receive
or send a packet in the meantime, as interrupts are disabled, we will
miss this event.

Trigger both NAPI instances (RX and TX) when at least one event happens
so that we don't miss any interrupts.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 06358fe5b245..dbee9b0113e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2048,6 +2048,9 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan)
 						 &priv->xstats, chan);
 	struct stmmac_channel *ch = &priv->channel[chan];
 
+	if (status)
+		status |= handle_rx | handle_tx;
+
 	if ((status & handle_rx) && (chan < priv->plat->rx_queues_to_use)) {
 		stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
 		napi_schedule_irqoff(&ch->rx_napi);
-- 
2.20.1

