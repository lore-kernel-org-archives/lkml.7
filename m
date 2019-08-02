Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D3AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD1D2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739215;
	bh=QnRODtU+IhQ9R5ywnjwo5VAXF8+yANFaGCE63gBLPss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KP09qWLG59pfUIM4WkhIj90LLQfDhlgGEsMGHw0QJJSACNGFavktSCwULlQe7mFqW
	 csURkQOA3czpVFQ8tsRTfrWirNI+QSIYTO2DAVndyINOboJmMSP6dTfJCZ8HJp6EZk
	 n1Sc/tcJa0C/vR+ynFO1gQfMCIBHhck00+RBJ7+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405618AbfHBJqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392071AbfHBJqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:46:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0398C2086A;
        Fri,  2 Aug 2019 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739208;
        bh=QnRODtU+IhQ9R5ywnjwo5VAXF8+yANFaGCE63gBLPss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5yky6alrmucaqX5P7ID953rcxLrx1gUgRdVuo7mJcnncYoaXlxSos1iXFpgZSAcm
         T/fIqtWvFxxKdTq+/ionSKBRTXCbwjKUubJUKJnuT/+6AT5806W3M3JZQ7Ss0VDQEN
         tU61AYQDA6addrV92u8w8AQ3uyrflPmat0yA7wOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Christoph Paasch <cpaasch@apple.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 147/223] tcp: Reset bytes_acked and bytes_received when disconnecting
Date:   Fri,  2 Aug 2019 11:36:12 +0200
Message-Id: <20190802092248.090760100@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Paasch <cpaasch@apple.com>

[ Upstream commit e858faf556d4e14c750ba1e8852783c6f9520a0e ]

If an app is playing tricks to reuse a socket via tcp_disconnect(),
bytes_acked/received needs to be reset to 0. Otherwise tcp_info will
report the sum of the current and the old connection..

Cc: Eric Dumazet <edumazet@google.com>
Fixes: 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info")
Fixes: bdd1f9edacb5 ("tcp: add tcpi_bytes_received to tcp_info")
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2312,6 +2312,8 @@ int tcp_disconnect(struct sock *sk, int
 	dst_release(sk->sk_rx_dst);
 	sk->sk_rx_dst = NULL;
 	tcp_saved_syn_free(tp);
+	tp->bytes_acked = 0;
+	tp->bytes_received = 0;
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
 


