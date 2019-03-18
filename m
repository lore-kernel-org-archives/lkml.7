Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF320850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCRVhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:37:39 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:52998 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCRVhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:37:38 -0400
Received: from localhost.localdomain (85-76-21-58-nat.elisa-mobile.fi [85.76.21.58])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 33B9830091;
        Mon, 18 Mar 2019 23:37:35 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] net: stmmac: fix memory corruption with large MTUs
Date:   Mon, 18 Mar 2019 23:36:08 +0200
Message-Id: <20190318213608.612-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

When using 16K DMA buffers and ring mode, the DES3 refill is not working
correctly as the function is using a bogus pointer for checking the
private data. As a result stale pointers will remain in the RX descriptor
ring, so DMA will now likely overwrite/corrupt some already freed memory.

As simple reproducer, just receive some UDP traffic:

	# ifconfig eth0 down; ifconfig eth0 mtu 9000; ifconfig eth0 up
	# iperf3 -c 192.168.253.40 -u -b 0 -R

If you didn't crash by now check the RX descriptors to find non-contiguous
RX buffers:

	cat /sys/kernel/debug/stmmaceth/eth0/descriptors_status
	[...]
	1 [0x2be5020]: 0xa3220321 0x9ffc1ffc 0x72d70082 0x130e207e
					     ^^^^^^^^^^^^^^^^^^^^^
	2 [0x2be5040]: 0xa3220321 0x9ffc1ffc 0x72998082 0x1311a07e
					     ^^^^^^^^^^^^^^^^^^^^^

A simple ping test will now report bad data:

	# ping -s 8200 192.168.253.40
	PING 192.168.253.40 (192.168.253.40) 8200(8228) bytes of data.
	8208 bytes from 192.168.253.40: icmp_seq=1 ttl=64 time=1.00 ms
	wrong data byte #8144 should be 0xd0 but was 0x88

Fix the wrong pointer. Also we must refill DES3 only if the DMA buffer
size is 16K.

Fixes: 54139cf3bb33 ("net: stmmac: adding multiple buffers for rx")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index f936166d8910..4d9bcb4d0378 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -113,10 +113,11 @@ static unsigned int is_jumbo_frm(int len, int enh_desc)
 
 static void refill_desc3(void *priv_ptr, struct dma_desc *p)
 {
-	struct stmmac_priv *priv = (struct stmmac_priv *)priv_ptr;
+	struct stmmac_rx_queue *rx_q = priv_ptr;
+	struct stmmac_priv *priv = rx_q->priv_data;
 
 	/* Fill DES3 in case of RING mode */
-	if (priv->dma_buf_sz >= BUF_SIZE_8KiB)
+	if (priv->dma_buf_sz == BUF_SIZE_16KiB)
 		p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
 }
 
-- 
2.17.0

