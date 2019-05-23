Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA9BC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC562075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="erG7Kki4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfEWHiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:38:05 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:43630 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730202AbfEWHhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:37:31 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7341FC019C;
        Thu, 23 May 2019 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558597058; bh=sqNeNnhFIza31bv3sRCKiuGYnwSngPvoI+RLGZM7FZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=erG7Kki4vx70SSPbAb5Kl7uA9tx8JBgTRjKAPppmMcuIMSN0FahC8qL+lOkdoj7k0
         k41Krr+1L2FwT2dGF5t4nPX21y38WkRt/g5yx1ba23dApEmabAWP39WMcgHaR2LG8n
         r6yQ9pvea6NtDtSqaVuxi7ATfgm5NnlAvQ2N+bMQ95yO6Az+Rr0A/2Zbs5Wd4StguB
         9cqxCmc48oZk2kQSUigSdN6IPKlrP0l9khFK01aL9a0ohRCfhTl5PmKfpUKBqFumbX
         cllWusmSzJsq1uM1ChVPUWl3dPkEJ/COqx4mlnDu5q4WcyceR8ZrBq/XRIhTFOLrpm
         tgpEFgY44NjXA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id F246EA00A4;
        Thu, 23 May 2019 07:37:30 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 39F973D970;
        Thu, 23 May 2019 09:37:29 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 18/18] net: stmmac: Prevent missing interrupts when running NAPI
Date:   Thu, 23 May 2019 09:37:08 +0200
Message-Id: <f8ec046e59eb5925887e99ea988b7081b58cf7d9.1558596600.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558596599.git.joabreu@synopsys.com>
References: <cover.1558596599.git.joabreu@synopsys.com>
In-Reply-To: <cover.1558596599.git.joabreu@synopsys.com>
References: <cover.1558596599.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 571b4a619ed6..603dfc639dd2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2058,6 +2058,9 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan)
 						 &priv->xstats, chan);
 	struct stmmac_channel *ch = &priv->channel[chan];
 
+	if (status)
+		status |= handle_rx | handle_tx;
+
 	if ((status & handle_rx) && (chan < priv->plat->rx_queues_to_use)) {
 		stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
 		napi_schedule_irqoff(&ch->rx_napi);
-- 
2.7.4

