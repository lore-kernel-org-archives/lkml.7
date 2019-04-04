Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE23C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27867206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfDDOqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:46:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57674 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfDDOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:46:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hC3cx-0002JK-H6; Thu, 04 Apr 2019 14:46:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp: remove redundant check on tskb
Date:   Thu,  4 Apr 2019 15:46:03 +0100
Message-Id: <20190404144603.27682-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The non-null check on tskb is always false because it is in an else
path of a check on tskb and hence tskb is null in this code block.
This is check is therefore redundant and can be removed as well
as the label coalesc.

if (tsbk) {
        ...
} else {
        ...
        if (unlikely(!skb)) {
                if (tskb)       /* can never be true, redundant code */
                        goto coalesc;
                return;
        }
}

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/ipv4/tcp_output.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e265d1aeeb66..32061928b054 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3088,7 +3088,6 @@ void tcp_send_fin(struct sock *sk)
 		tskb = skb_rb_last(&sk->tcp_rtx_queue);
 
 	if (tskb) {
-coalesce:
 		TCP_SKB_CB(tskb)->tcp_flags |= TCPHDR_FIN;
 		TCP_SKB_CB(tskb)->end_seq++;
 		tp->write_seq++;
@@ -3104,11 +3103,9 @@ void tcp_send_fin(struct sock *sk)
 		}
 	} else {
 		skb = alloc_skb_fclone(MAX_TCP_HEADER, sk->sk_allocation);
-		if (unlikely(!skb)) {
-			if (tskb)
-				goto coalesce;
+		if (unlikely(!skb))
 			return;
-		}
+
 		INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
 		skb_reserve(skb, MAX_TCP_HEADER);
 		sk_forced_mem_schedule(sk, skb->truesize);
-- 
2.20.1

