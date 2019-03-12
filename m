Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8975EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8612147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413035;
	bh=CJVRbMBy+VjSq8iRFMmdk0cnkBa486Yk3SfCkfOHW6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V/aVOkcyRPD8e6N4zCuU65064p1X8Sk1LTzf8x9uBqrJ9yC8ndsUH4dTPwAJ3tzRb
	 105Yx5BCqmu5CUeKXnERnDrLhkEDuiFjyBvBQ/DiP1lj0c+cncYiM99taZSdgvnxlK
	 En8iW7WBcVDGBb1+uBVuq9g85OiRD7L/QpE1nL2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfCLRu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbfCLROn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:43 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7FB9206DF;
        Tue, 12 Mar 2019 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410882;
        bh=CJVRbMBy+VjSq8iRFMmdk0cnkBa486Yk3SfCkfOHW6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFQALlYwsuSWPAnti1U//paB4xOwsHN3d5iNN2ZdOmqtu4xfeg7pB3thTabhpjgSP
         txKex8/hfsLHF9o0Q556QhZpXFgRbOv4nWIVPICWuxI0fWV3FV8fIOuKU/tLnj25qq
         yoW8Fixv+GPSRvXn3wOdxnpOY2Im0RRbU4crS1UY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/149] net: stmmac: Send TSO packets always from Queue 0
Date:   Tue, 12 Mar 2019 10:08:27 -0700
Message-Id: <20190312170357.174972830@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c5acdbee22a1b200dde07effd26fd1f649e9ab8a ]

The number of TSO enabled channels in HW can be different than the
number of total channels. There is no way to determined, at runtime, the
number of TSO capable channels and its safe to assume that if TSO is
enabled then at least channel 0 will be TSO capable.

Lets always send TSO packets from Queue 0.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 123b74e25ed8..57c56e295705 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3030,8 +3030,17 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Manage oversized TCP frames for GMAC4 device */
 	if (skb_is_gso(skb) && priv->tso) {
-		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
+		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
+			/*
+			 * There is no way to determine the number of TSO
+			 * capable Queues. Let's use always the Queue 0
+			 * because if TSO is supported then at least this
+			 * one will be capable.
+			 */
+			skb_set_queue_mapping(skb, 0);
+
 			return stmmac_tso_xmit(skb, dev);
+		}
 	}
 
 	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
-- 
2.19.1



