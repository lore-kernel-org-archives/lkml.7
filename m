Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BEFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D8721773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128433;
	bh=2mEUnRzk58PMTO6CqQBf2vBTtPb3td6HQO5/vSFE0A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JE8kSZHokhXat0ZrG2rSIhqKVa1SIlqc5PN+sVFxq/zUhMezjxRC7nXxW37DRvDRh
	 kt1AWMBSPt34HvD9ZQyS0mxJkUJGEVQtar1JZye3+dsOTZpYwwm3DJNInxCVU9VIC/
	 HS8rqqg1ggkbXk1+jjYkwTfnloPPhBFV4uBW9kQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbfDXRxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389350AbfDXR0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:26:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A6F2054F;
        Wed, 24 Apr 2019 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126813;
        bh=2mEUnRzk58PMTO6CqQBf2vBTtPb3td6HQO5/vSFE0A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=In0KhX1fjA+MZNNea7svHj47+EWEOQMiXgsVk/B0QSq2pzlbMKjHKgWBT/E8CeS1o
         +gyLsNSt7sLNziWERQKSX1s+G91hwNFIqT5OOFtepVMtds2EQtFPhGRLP7yDKVLYJC
         D4WABrbcFWYjwkyJTvoQfKBZzsLo5rgvP4Qy5QT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/70] tcp: tcp_grow_window() needs to respect tcp_space()
Date:   Wed, 24 Apr 2019 19:09:26 +0200
Message-Id: <20190424170908.126628629@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 50ce163a72d817a99e8974222dcf2886d5deb1ae ]

For some reason, tcp_grow_window() correctly tests if enough room
is present before attempting to increase tp->rcv_ssthresh,
but does not prevent it to grow past tcp_space()

This is causing hard to debug issues, like failing
the (__tcp_select_window(sk) >= tp->rcv_wnd) test
in __tcp_ack_snd_check(), causing ACK delays and possibly
slow flows.

Depending on tcp_rmem[2], MTU, skb->len/skb->truesize ratio,
we can see the problem happening on "netperf -t TCP_RR -- -r 2000,2000"
after about 60 round trips, when the active side no longer sends
immediate acks.

This bug predates git history.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Wei Wang <weiwan@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -389,11 +389,12 @@ static int __tcp_grow_window(const struc
 static void tcp_grow_window(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	int room;
+
+	room = min_t(int, tp->window_clamp, tcp_space(sk)) - tp->rcv_ssthresh;
 
 	/* Check #1 */
-	if (tp->rcv_ssthresh < tp->window_clamp &&
-	    (int)tp->rcv_ssthresh < tcp_space(sk) &&
-	    !tcp_under_memory_pressure(sk)) {
+	if (room > 0 && !tcp_under_memory_pressure(sk)) {
 		int incr;
 
 		/* Check #2. Increase window, if skb with such overhead
@@ -406,8 +407,7 @@ static void tcp_grow_window(struct sock
 
 		if (incr) {
 			incr = max_t(int, incr, 2 * skb->len);
-			tp->rcv_ssthresh = min(tp->rcv_ssthresh + incr,
-					       tp->window_clamp);
+			tp->rcv_ssthresh += min(room, incr);
 			inet_csk(sk)->icsk_ack.quick |= 1;
 		}
 	}


