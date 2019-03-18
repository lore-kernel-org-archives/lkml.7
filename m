Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C943FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3362087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901218;
	bh=R6/Ne2IEmeXYnowOgOxSZS6tJZzR7gyGIniSTuBC+8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhT6rG6WvaXKGbMRORVn13Mv0pTIPacHMRhSJWy6Xi6N/OkU4EvJ6Xr0ZBHEfiw5z
	 GAK63ZjlZT7nnYM9T/fbZl2v5Imrr7WGZujGoJUX+mIaoy8nKqddDus3yI3xOXGfUX
	 AtoUomh/zvNOJ5EeSKHWxCGUsV7pSHZCksrIAdwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfCRJ05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfCRJ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:26:54 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC572087C;
        Mon, 18 Mar 2019 09:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901213;
        bh=R6/Ne2IEmeXYnowOgOxSZS6tJZzR7gyGIniSTuBC+8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZgWGLPtm+MQuuJoMLbgHmhdjV19deUmRNJZwt4ruHO3lDEFkc9S4Wzo5qAjtONXd
         EzHnyJVc0LkLcExRQy61yyuxzClBPxUSltHmQDRjN+EvtG93VTGpBTmQKqIjWfby3N
         6v/egd5eJfPIBhuqHTqJIhFCcNnxnXLkqpx3CdEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Christoph Paasch <cpaasch@apple.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 20/43] tcp: Dont access TCP_SKB_CB before initializing it
Date:   Mon, 18 Mar 2019 10:24:12 +0100
Message-Id: <20190318083716.456347852@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Paasch <cpaasch@apple.com>

[ Upstream commit f2feaefdabb0a6253aa020f65e7388f07a9ed47c ]

Since commit eeea10b83a13 ("tcp: add
tcp_v4_fill_cb()/tcp_v4_restore_cb()"), tcp_vX_fill_cb is only called
after tcp_filter(). That means, TCP_SKB_CB(skb)->end_seq still points to
the IP-part of the cb.

We thus should not mock with it, as this can trigger bugs (thanks
syzkaller):
[   12.349396] ==================================================================
[   12.350188] BUG: KASAN: slab-out-of-bounds in ip6_datagram_recv_specific_ctl+0x19b3/0x1a20
[   12.351035] Read of size 1 at addr ffff88006adbc208 by task test_ip6_datagr/1799

Setting end_seq is actually no more necessary in tcp_filter as it gets
initialized later on in tcp_vX_fill_cb.

Cc: Eric Dumazet <edumazet@google.com>
Fixes: eeea10b83a13 ("tcp: add tcp_v4_fill_cb()/tcp_v4_restore_cb()")
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_ipv4.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1734,15 +1734,8 @@ EXPORT_SYMBOL(tcp_add_backlog);
 int tcp_filter(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcphdr *th = (struct tcphdr *)skb->data;
-	unsigned int eaten = skb->len;
-	int err;
 
-	err = sk_filter_trim_cap(sk, skb, th->doff * 4);
-	if (!err) {
-		eaten -= skb->len;
-		TCP_SKB_CB(skb)->end_seq -= eaten;
-	}
-	return err;
+	return sk_filter_trim_cap(sk, skb, th->doff * 4);
 }
 EXPORT_SYMBOL(tcp_filter);
 


