Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05008C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA727204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902302;
	bh=/lEMIxScnSCzRkIXQ+wldYYVIuwm5MQ5iCcDZ1hVCuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMhyigxc1ROnKMGW1nyWpQIQAra1aB34U8udVII1M7ykR4mCoIUC9RRPwPc9FBF1O
	 9oDe6piuA0DLrK01fWZmvqqDcDymNgeBhJn8cAiRMG/2kYb/FSDtO8XlsdIwxRMoGi
	 f0IG1a7/FXTUMmjpCmJ29PBq90qSg8603m3o5+28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfCRJaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfCRJaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:14 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A062083D;
        Mon, 18 Mar 2019 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901413;
        bh=/lEMIxScnSCzRkIXQ+wldYYVIuwm5MQ5iCcDZ1hVCuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHip9KQfkpchTtfHmsojBxKXWq98DznCoNMDWsILyC4JZCpqK+bZ9YfQKOkiQ07bU
         ELDbb6CNPP+W67b1syk6huBLKNUUvwiQcyyn9sihM9/eRtA9MwuARbGdTyyAaArHVM
         0W+T3sLqSb9lp1SkuE4oz72Pj3AH87zip34hakaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Bernat <vincent@bernat.ch>,
        Michal Soltys <soltys@ziu.info>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 36/52] bonding: fix PACKET_ORIGDEV regression
Date:   Mon, 18 Mar 2019 10:25:23 +0100
Message-Id: <20190318083847.588994226@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Soltys <soltys@ziu.info>

[ Upstream commit 3c963a3306eada999be5ebf4f293dfa3d3945487 ]

This patch fixes a subtle PACKET_ORIGDEV regression which was a side
effect of fixes introduced by:

6a9e461f6fe4 bonding: pass link-local packets to bonding master also.

... to:

b89f04c61efe bonding: deliver link-local packets with skb->dev set to link that packets arrived on

While 6a9e461f6fe4 restored pre-b89f04c61efe presence of link-local
packets on bonding masters (which is required e.g. by linux bridges
participating in spanning tree or needed for lab-like setups created
with group_fwd_mask) it also caused the originating device
information to be lost due to cloning.

Maciej Żenczykowski proposed another solution that doesn't require
packet cloning and retains original device information - instead of
returning RX_HANDLER_PASS for all link-local packets it's now limited
only to packets from inactive slaves.

At the same time, packets passed to bonding masters retain correct
information about the originating device and PACKET_ORIGDEV can be used
to determine it.

This elegantly solves all issues so far:

- link-local packets that were removed from bonding masters
- LLDP daemons being forced to explicitly bind to slave interfaces
- PACKET_ORIGDEV having no effect on bond interfaces

Fixes: 6a9e461f6fe4 (bonding: pass link-local packets to bonding master also.)
Reported-by: Vincent Bernat <vincent@bernat.ch>
Signed-off-by: Michal Soltys <soltys@ziu.info>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |   35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1172,29 +1172,22 @@ static rx_handler_result_t bond_handle_f
 		}
 	}
 
-	/* Link-local multicast packets should be passed to the
-	 * stack on the link they arrive as well as pass them to the
-	 * bond-master device. These packets are mostly usable when
-	 * stack receives it with the link on which they arrive
-	 * (e.g. LLDP) they also must be available on master. Some of
-	 * the use cases include (but are not limited to): LLDP agents
-	 * that must be able to operate both on enslaved interfaces as
-	 * well as on bonds themselves; linux bridges that must be able
-	 * to process/pass BPDUs from attached bonds when any kind of
-	 * STP version is enabled on the network.
+	/*
+	 * For packets determined by bond_should_deliver_exact_match() call to
+	 * be suppressed we want to make an exception for link-local packets.
+	 * This is necessary for e.g. LLDP daemons to be able to monitor
+	 * inactive slave links without being forced to bind to them
+	 * explicitly.
+	 *
+	 * At the same time, packets that are passed to the bonding master
+	 * (including link-local ones) can have their originating interface
+	 * determined via PACKET_ORIGDEV socket option.
 	 */
-	if (is_link_local_ether_addr(eth_hdr(skb)->h_dest)) {
-		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
-
-		if (nskb) {
-			nskb->dev = bond->dev;
-			nskb->queue_mapping = 0;
-			netif_rx(nskb);
-		}
-		return RX_HANDLER_PASS;
-	}
-	if (bond_should_deliver_exact_match(skb, slave, bond))
+	if (bond_should_deliver_exact_match(skb, slave, bond)) {
+		if (is_link_local_ether_addr(eth_hdr(skb)->h_dest))
+			return RX_HANDLER_PASS;
 		return RX_HANDLER_EXACT;
+	}
 
 	skb->dev = bond->dev;
 


