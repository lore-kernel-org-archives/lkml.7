Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88537C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B095206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139220;
	bh=e2BVyA5PDxmhUn1VaEYTtdQdd/vxLBBXQxeSGHTnG0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E5SSkvfOkpsj7MHWfQA+OawYR6mC92UAhyuzSJAArTSw23yJzT7vBEBBLx9UxniVf
	 v2F7D/v72PXB7ce8Unp//tFoQZbtYWeIiX3FRHSyrg0IJiMUEOFqHLOuJL7CnqSd1z
	 rVjQuUcyFSY5fs5HwSWV/CuprWzPRz7/4KL3s1+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfDARUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729490AbfDARUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:20:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED004218FF;
        Mon,  1 Apr 2019 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139215;
        bh=e2BVyA5PDxmhUn1VaEYTtdQdd/vxLBBXQxeSGHTnG0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/WPx5ubCPB40ebbQyVI7s8YYJKpjXiuoy0wBAjJJDz5ALNNCtqiKWgubpaIJkgmd
         aO63rYX84t9aFN2KTQpB7hPn1jbwns9Dgen+T1po+qVHqWKoe/qJlB+9QZYYUhQvRU
         LDsgpGXc67el5pYF5rnPJpJN8VorG26lP47aYRqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 011/107] net: stmmac: fix memory corruption with large MTUs
Date:   Mon,  1 Apr 2019 19:01:26 +0200
Message-Id: <20190401170046.571814054@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 223a960c01227e4dbcb6f9fa06b47d73bda21274 ]

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
Acked-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -114,10 +114,11 @@ static unsigned int stmmac_is_jumbo_frm(
 
 static void stmmac_refill_desc3(void *priv_ptr, struct dma_desc *p)
 {
-	struct stmmac_priv *priv = (struct stmmac_priv *)priv_ptr;
+	struct stmmac_rx_queue *rx_q = priv_ptr;
+	struct stmmac_priv *priv = rx_q->priv_data;
 
 	/* Fill DES3 in case of RING mode */
-	if (priv->dma_buf_sz >= BUF_SIZE_8KiB)
+	if (priv->dma_buf_sz == BUF_SIZE_16KiB)
 		p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
 }
 


