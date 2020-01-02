Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C47C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D6C2465D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003733;
	bh=PokvHP29eWUB8qkmtCFYFZdQErIwko2O5Re8dgS8JfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jgrA9xs/Av4sF7FDuE7eR9YB+43RNO6h0TKrBS31l0uGPO48BIoyazbK+UlJ2GPoQ
	 kVttT7u/0S2bUejLyrXN1UqOZbT/U3GYZY2PNC96v//PfHMiLm+TmgwDU+v4LuYDH4
	 ZRgCgea2I1xEuZFzimtM/a/tFq+VGKHcUw5lzL8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgABWWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbgABWWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:22:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 948DA222C3;
        Thu,  2 Jan 2020 22:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003728;
        bh=PokvHP29eWUB8qkmtCFYFZdQErIwko2O5Re8dgS8JfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbLMKAZXB600WRFOBsGkz01rdt89Cw1z2V0gBf4fLSy5iFxaA+O1GY2SwkRPXIO6H
         mv2EQMuhsCFm1KH1x7b4ALyhVA7csSBrmOIvuaaLAo7ttlpbOJFl/kawYjepzfqc5X
         GA58c2xauwEkPAf2+iBDdMuiwfy+uC7w2I3og69o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 090/114] net: ena: fix napi handler misbehavior when the napi budget is zero
Date:   Thu,  2 Jan 2020 23:07:42 +0100
Message-Id: <20200102220038.258393874@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 24dee0c7478d1a1e00abdf5625b7f921467325dc ]

In netpoll the napi handler could be called with budget equal to zero.
Current ENA napi handler doesn't take that into consideration.

The napi handler handles Rx packets in a do-while loop.
Currently, the budget check happens only after decrementing the
budget, therefore the napi handler, in rare cases, could run over
MAX_INT packets.

In addition to that, this moves all budget related variables to int
calculation and stop mixing u32 to avoid ambiguity

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1197,8 +1197,8 @@ static int ena_io_poll(struct napi_struc
 	struct ena_napi *ena_napi = container_of(napi, struct ena_napi, napi);
 	struct ena_ring *tx_ring, *rx_ring;
 
-	u32 tx_work_done;
-	u32 rx_work_done;
+	int tx_work_done;
+	int rx_work_done = 0;
 	int tx_budget;
 	int napi_comp_call = 0;
 	int ret;
@@ -1215,7 +1215,11 @@ static int ena_io_poll(struct napi_struc
 	}
 
 	tx_work_done = ena_clean_tx_irq(tx_ring, tx_budget);
-	rx_work_done = ena_clean_rx_irq(rx_ring, napi, budget);
+	/* On netpoll the budget is zero and the handler should only clean the
+	 * tx completions.
+	 */
+	if (likely(budget))
+		rx_work_done = ena_clean_rx_irq(rx_ring, napi, budget);
 
 	/* If the device is about to reset or down, avoid unmask
 	 * the interrupt and return 0 so NAPI won't reschedule


