Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A782C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593E82186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCNTpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:45:34 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:53216 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfCNTpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 15:45:33 -0400
Received: from localhost.localdomain (85-76-115-153-nat.elisa-mobile.fi [85.76.115.153])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 989ED2001E;
        Thu, 14 Mar 2019 21:45:31 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 2/2] net: stmmac: fix jumbo frame sending with non-linear skbs
Date:   Thu, 14 Mar 2019 21:43:20 +0200
Message-Id: <20190314194320.25566-2-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190314194320.25566-1-aaro.koskinen@iki.fi>
References: <20190314194320.25566-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

When sending non-linear skbs with jumbo frames, we set up the non-paged
data and mark that as a last segment, although the paged fragments are
also prepared. This will stall the TX queue and trigger a watchdog warning
(a simple reproducer is to run an iperf client mode TCP test with a large
MTU - networking fails instantly).

Fix by checking if the skb is non-linear.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index bc83ced94e1b..f936166d8910 100644
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
2.17.0

