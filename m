Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E1C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73D7218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788340;
	bh=XknEf/+gadoD7U3dWFn2XWM+Y/8d9aXtru5ha2+scOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d24lTLlaUtn+HEGnZDKm6WkBiNml2YXj0Uko3dP0YhjL3FhblYYvNQ+/4xDDLqZ8K
	 RILgsSuSBKm37trg6FwBhRskQw9p35HFTLTWHs5eBNwH5FOoajQoeLoKHCabqeNdHZ
	 jZS4x+DTw4DTvmTX4SmSInVTrEG124gfTte10UUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfIRGWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfIRGWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:22:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB1A218AE;
        Wed, 18 Sep 2019 06:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787731;
        bh=XknEf/+gadoD7U3dWFn2XWM+Y/8d9aXtru5ha2+scOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAXodWAVShJS4CeKlVrx1MquoEFPhPIey8PZJ0HbYXY1UsSR5jm9Tkb7HxG1HNO8G
         F/WQYkTzuV1MluT5vpKLLr6tF3VSAuDsE4NlbL4tZozoy98U92Fh1d3oSqOvAeghWc
         h/lxiAaLa9ZZgVTeBlnv1xGWxM1+2GLKcRd4H9rg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 13/50] tcp: fix tcp_ecn_withdraw_cwr() to clear TCP_ECN_QUEUE_CWR
Date:   Wed, 18 Sep 2019 08:18:56 +0200
Message-Id: <20190918061224.461181062@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
References: <20190918061223.116178343@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit af38d07ed391b21f7405fa1f936ca9686787d6d2 ]

Fix tcp_ecn_withdraw_cwr() to clear the correct bit:
TCP_ECN_QUEUE_CWR.

Rationale: basically, TCP_ECN_DEMAND_CWR is a bit that is purely about
the behavior of data receivers, and deciding whether to reflect
incoming IP ECN CE marks as outgoing TCP th->ece marks. The
TCP_ECN_QUEUE_CWR bit is purely about the behavior of data senders,
and deciding whether to send CWR. The tcp_ecn_withdraw_cwr() function
is only called from tcp_undo_cwnd_reduction() by data senders during
an undo, so it should zero the sender-side state,
TCP_ECN_QUEUE_CWR. It does not make sense to stop the reflection of
incoming CE bits on incoming data packets just because outgoing
packets were spuriously retransmitted.

The bug has been reproduced with packetdrill to manifest in a scenario
with RFC3168 ECN, with an incoming data packet with CE bit set and
carrying a TCP timestamp value that causes cwnd undo. Before this fix,
the IP CE bit was ignored and not reflected in the TCP ECE header bit,
and sender sent a TCP CWR ('W') bit on the next outgoing data packet,
even though the cwnd reduction had been undone.  After this fix, the
sender properly reflects the CE bit and does not set the W bit.

Note: the bug actually predates 2005 git history; this Fixes footer is
chosen to be the oldest SHA1 I have tested (from Sep 2007) for which
the patch applies cleanly (since before this commit the code was in a
.h file).

Fixes: bdf1ee5d3bd3 ("[TCP]: Move code from tcp_ecn.h to tcp*.c and tcp.h & remove it")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -260,7 +260,7 @@ static void tcp_ecn_accept_cwr(struct so
 
 static void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 {
-	tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
+	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
 static void __tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)


