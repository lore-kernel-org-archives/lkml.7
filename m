Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B6C21B68
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138807;
	bh=fw+ecjDV+mo9/9Mu8hCGqwRlB+WuLyCt5bhTQatJbqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JtKO6RYvB3VnHIGuGo3Y64aFupmFzhepoBy/OD/vD9f/FLM7SiW68qhiUT579lita
	 9Dr2giEtCp56n7Om4+HsC0L2jFacdbQsYlZ6eKr6Wk5csipskfSVjOE6Q47dYGIu5b
	 bEjbjYbanhIXOGf2sRigLmWJbYK4RTisMZj/eL74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfDARN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbfDARNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B3721924;
        Mon,  1 Apr 2019 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138803;
        bh=fw+ecjDV+mo9/9Mu8hCGqwRlB+WuLyCt5bhTQatJbqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJBuKp8IZlt/uYZB3IFV2rTaEXj0//oVpHQ9TsSLPIWt1LG7q5K4eF2pvQBnxKtJq
         0QnF1770S+BF4JWf1ZfcOnGmYzbLfk+MRXKbkZWIDQvRTL+n2PmdUKVuC5dm8axZC6
         5yw28ddO+tjgHZZzRYM6MzPfqQK9yWWXk/nfEMS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 025/134] tun: properly test for IFF_UP
Date:   Mon,  1 Apr 2019 19:01:01 +0200
Message-Id: <20190401170046.895378840@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4477138fa0ae4e1b699786ef0600863ea6e6c61c ]

Same reasons than the ones explained in commit 4179cb5a4c92
("vxlan: test dev->flags & IFF_UP before calling netif_rx()")

netif_rx_ni() or napi_gro_frags() must be called under a strict contract.

At device dismantle phase, core networking clears IFF_UP
and flush_all_backlogs() is called after rcu grace period
to make sure no incoming packet might be in a cpu backlog
and still referencing the device.

A similar protocol is used for gro layer.

Most drivers call netif_rx() from their interrupt handler,
and since the interrupts are disabled at device dismantle,
netif_rx() does not have to check dev->flags & IFF_UP

Virtual drivers do not have this guarantee, and must
therefore make the check themselves.

Fixes: 1bd4978a88ac ("tun: honor IFF_UP in tun_get_user()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1718,9 +1718,6 @@ static ssize_t tun_get_user(struct tun_s
 	int skb_xdp = 1;
 	bool frags = tun_napi_frags_enabled(tfile);
 
-	if (!(tun->dev->flags & IFF_UP))
-		return -EIO;
-
 	if (!(tun->flags & IFF_NO_PI)) {
 		if (len < sizeof(pi))
 			return -EINVAL;
@@ -1822,6 +1819,8 @@ static ssize_t tun_get_user(struct tun_s
 			err = skb_copy_datagram_from_iter(skb, 0, from, len);
 
 		if (err) {
+			err = -EFAULT;
+drop:
 			this_cpu_inc(tun->pcpu_stats->rx_dropped);
 			kfree_skb(skb);
 			if (frags) {
@@ -1829,7 +1828,7 @@ static ssize_t tun_get_user(struct tun_s
 				mutex_unlock(&tfile->napi_mutex);
 			}
 
-			return -EFAULT;
+			return err;
 		}
 	}
 
@@ -1913,6 +1912,12 @@ static ssize_t tun_get_user(struct tun_s
 	    !tfile->detached)
 		rxhash = __skb_get_hash_symmetric(skb);
 
+	rcu_read_lock();
+	if (unlikely(!(tun->dev->flags & IFF_UP))) {
+		err = -EIO;
+		goto drop;
+	}
+
 	if (frags) {
 		/* Exercise flow dissector code path. */
 		u32 headlen = eth_get_headlen(skb->data, skb_headlen(skb));
@@ -1920,6 +1925,7 @@ static ssize_t tun_get_user(struct tun_s
 		if (unlikely(headlen > skb_headlen(skb))) {
 			this_cpu_inc(tun->pcpu_stats->rx_dropped);
 			napi_free_frags(&tfile->napi);
+			rcu_read_unlock();
 			mutex_unlock(&tfile->napi_mutex);
 			WARN_ON(1);
 			return -ENOMEM;
@@ -1947,6 +1953,7 @@ static ssize_t tun_get_user(struct tun_s
 	} else {
 		netif_rx_ni(skb);
 	}
+	rcu_read_unlock();
 
 	stats = get_cpu_ptr(tun->pcpu_stats);
 	u64_stats_update_begin(&stats->syncp);


