Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9CAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C417204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963487;
	bh=gmocDgUQYMyUOkmtWP4xkpkSiaPbVgR4wZ04EOQDWz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kQSYhXJvY1IxfywB1CGmwkqwpUDdKpU+YEqY0T1PWiDL96t9JQl8R4hB6y8LPmiCi
	 LdSI7hu7UlIYFtC3k8UOyQXP9fPlR/gT2Zg9IH8zUwWR/k4Zi06/8252bLMgvOP9v4
	 lWmPb6RWTi7ULHI0nCBqmO4RQeKGLiBH3Hru+mpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfDVTp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbfDVTp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CDDC218FF;
        Mon, 22 Apr 2019 19:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962326;
        bh=gmocDgUQYMyUOkmtWP4xkpkSiaPbVgR4wZ04EOQDWz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vvp2LcRAPwrFVMwAtCtVbIXQxPAwnIzjXJs16yPBO/IbUEPOQelv1TQx1Z5D44sAe
         0ZC6tu/FbobRC9sM+F1QwK9PfrIuVCjdbqWLe0g/56SPddvzJlLeLeaEgaa1uAVaHR
         7MDSIBLZN6HrIYBgc1ELmUk1Xq3VpbuJkQ4pAjVM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/68] net: stmmac: don't set own bit too early for jumbo frames
Date:   Mon, 22 Apr 2019 15:44:13 -0400
Message-Id: <20190422194516.11634-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 80acbed9f8fca1db3fbe915540b756f048aa0fd7 ]

Commit 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit
routine") overlooked jumbo frames when re-ordering the code, and as a
result the own bit was not getting set anymore for the first jumbo frame
descriptor. Commit 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo
frames") tried to fix this, but now the bit is getting set too early and
the DMA may start while we are still setting up the remaining descriptors.
And with the chain mode the own bit remains still unset.

Fix by setting the own bit at the end of xmit also with jumbo frames.

Fixes: 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit routine")
Fixes: 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo frames")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Acked-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 886176be818e..3d35cbeb1028 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3197,14 +3197,16 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_prepare_tx_desc(priv, first, 1, nopaged_len,
 				csum_insertion, priv->mode, 1, last_segment,
 				skb->len);
-
-		/* The own bit must be the latest setting done when prepare the
-		 * descriptor and then barrier is needed to make sure that
-		 * all is coherent before granting the DMA engine.
-		 */
-		wmb();
+	} else {
+		stmmac_set_tx_owner(priv, first);
 	}
 
+	/* The own bit must be the latest setting done when prepare the
+	 * descriptor and then barrier is needed to make sure that
+	 * all is coherent before granting the DMA engine.
+	 */
+	wmb();
+
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
-- 
2.19.1

