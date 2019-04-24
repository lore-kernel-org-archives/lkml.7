Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B0C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A77206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126704;
	bh=h9WynXh8Rs2RNztMmt6HNb9xKHB406IajqeLajFO7+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wvN7N9EITLPPwQrTZej2MmzOOWT/mXqpUVxzoTqdDfXv5KBXrbX75pVdiYrWnZtVX
	 h5SPGZc9rOUV5Ffw+TCiIDPi+9hsZ9cVzKKAotuVUFcddOs6i74d121m95E/7td8YT
	 kNM8D4I5FPzlzVHwoR7Oe81rf3xojB7kgTM5S7Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389971AbfDXRZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389960AbfDXRZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:25:00 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8B0205ED;
        Wed, 24 Apr 2019 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126699;
        bh=h9WynXh8Rs2RNztMmt6HNb9xKHB406IajqeLajFO7+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RR3dDHp+bnwOCEW3KF9NSxNNQHYOlvglNr4bmsNRj16qyAU6huUwcXfbmZIq2xIQb
         rqP/jlTwnHcv0FYLxVGVkhzgr7BWQTjvwb+nVtY2V8LSHrNZqB51vK0jW8pbry1K68
         TXUInpmiAeJEmEs+hAsdVLLiWwx3Jqg4h/IGthQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 03/44] net: bridge: fix per-port af_packet sockets
Date:   Wed, 24 Apr 2019 19:09:41 +0200
Message-Id: <20190424170842.862884137@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit 3b2e2904deb314cc77a2192f506f2fd44e3d10d0 ]

When the commit below was introduced it changed two visible things:
 - the skb was no longer passed through the protocol handlers with the
   original device
 - the skb was passed up the stack with skb->dev = bridge

The first change broke af_packet sockets on bridge ports. For example we
use them for hostapd which listens for ETH_P_PAE packets on the ports.
We discussed two possible fixes:
 - create a clone and pass it through NF_HOOK(), act on the original skb
   based on the result
 - somehow signal to the caller from the okfn() that it was called,
   meaning the skb is ok to be passed, which this patch is trying to
   implement via returning 1 from the bridge link-local okfn()

Note that we rely on the fact that NF_QUEUE/STOLEN would return 0 and
drop/error would return < 0 thus the okfn() is called only when the
return was 1, so we signal to the caller that it was called by preserving
the return value from nf_hook().

Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook returns QUEUE or STOLEN verdict")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_input.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -231,13 +231,10 @@ static void __br_handle_local_finish(str
 /* note: already called with rcu_read_lock */
 static int br_handle_local_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
-
 	__br_handle_local_finish(skb);
 
-	BR_INPUT_SKB_CB(skb)->brdev = p->br->dev;
-	br_pass_frame_up(skb);
-	return 0;
+	/* return 1 to signal the okfn() was called so it's ok to use the skb */
+	return 1;
 }
 
 /*
@@ -308,10 +305,18 @@ rx_handler_result_t br_handle_frame(stru
 				goto forward;
 		}
 
-		/* Deliver packet to local host only */
-		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, dev_net(skb->dev),
-			NULL, skb, skb->dev, NULL, br_handle_local_finish);
-		return RX_HANDLER_CONSUMED;
+		/* The else clause should be hit when nf_hook():
+		 *   - returns < 0 (drop/error)
+		 *   - returns = 0 (stolen/nf_queue)
+		 * Thus return 1 from the okfn() to signal the skb is ok to pass
+		 */
+		if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
+			    dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+			    br_handle_local_finish) == 1) {
+			return RX_HANDLER_PASS;
+		} else {
+			return RX_HANDLER_CONSUMED;
+		}
 	}
 
 forward:


