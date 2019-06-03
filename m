Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF8C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E7A27ED9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553280;
	bh=F+WH521pKwpdz27eW9ZhfHJ86+Jmo59k6+j31Jvp1PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ylHk6ftNv8ss35XP00y4SbvB379YyGOdBwYKFjmqDWhAWpPvgiGgVWTFuSLEPhWM6
	 UU+E1jZAlUiGJ5mHUXWVoqD41WI8XGxu/xp5/FkH4lVkt4lmyn7M3AROeOgdFGfXXE
	 zc+fuCtcUgYBZ2O+Hu7B9p92ewLK6LA2d8yqrFUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfFCJOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfFCJOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:14:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81ED527EDF;
        Mon,  3 Jun 2019 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553275;
        bh=F+WH521pKwpdz27eW9ZhfHJ86+Jmo59k6+j31Jvp1PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chL90GiYFzxBPW6t+YbHNb1/xKzVmupMfX6CEiX16g0pFLgFo7p/Ez0/6pVrgxHSW
         5SuxZY9uYGpAvZAuv/y6PNOzJX8CymHtVvyYRaByDN/+l3J0LprtKH/AOZpvTUKc3e
         zRRlQywXgP6UK8sJ8dp6WZDGzNQ8jDA3wCCHFO1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Beckett <david.beckett@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 32/40] net/tls: fix no wakeup on partial reads
Date:   Mon,  3 Jun 2019 11:09:25 +0200
Message-Id: <20190603090524.509763583@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
References: <20190603090522.617635820@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 04b25a5411f966c2e586909a8496553b71876fae ]

When tls_sw_recvmsg() partially copies a record it pops that
record from ctx->recv_pkt and places it on rx_list.

Next iteration of tls_sw_recvmsg() reads from rx_list via
process_rx_list() before it enters the decryption loop.
If there is no more records to be read tls_wait_data()
will put the process on the wait queue and got to sleep.
This is incorrect, because some data was already copied
in process_rx_list().

In case of RPC connections process may never get woken up,
because peer also simply blocks in read().

I think this may also fix a similar issue when BPF is at
play, because after __tcp_bpf_recvmsg() returns some data
we subtract it from len and use continue to restart the
loop, but len could have just reached 0, so again we'd
sleep unnecessarily. That's added by:
commit d3b18ad31f93 ("tls: add bpf support to sk_msg handling")

Fixes: 692d7b5d1f91 ("tls: Fix recvmsg() to be able to peek across multiple records")
Reported-by: David Beckett <david.beckett@netronome.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Tested-by: David Beckett <david.beckett@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1692,7 +1692,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	len = len - copied;
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
-	do {
+	while (len && (decrypted + copied < target || ctx->recv_pkt)) {
 		bool retain_skb = false;
 		bool zc = false;
 		int to_decrypt;
@@ -1823,11 +1823,7 @@ pick_next_record:
 		} else {
 			break;
 		}
-
-		/* If we have a new message from strparser, continue now. */
-		if (decrypted + copied >= target && !ctx->recv_pkt)
-			break;
-	} while (len);
+	}
 
 recv_end:
 	if (num_async) {


