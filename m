Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD8FC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7198A21846
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888916;
	bh=OJZ8AaGi6qccJKH+7gyFpQT2+Q0mktnDPmUzldyvW/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qAmYlnSsGP1tDx6HVbxfXEI309fJ/CVhgKCoZJDTBYx321gZNo+gM783zlM63JT6B
	 nRkqEJp4gZWXou40Hr80kRwWQHBRVPeZON45udwvihJeizY/XVFWdM94ME2xKiTwH4
	 X+czCJ/I9A/gVdwXv5IGdFVSExZ4MzEVR65K7dBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbfK0VIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732750AbfK0VIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:08:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6ED217D9;
        Wed, 27 Nov 2019 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888910;
        bh=OJZ8AaGi6qccJKH+7gyFpQT2+Q0mktnDPmUzldyvW/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neWnYi2RqfG66CiJNRBO56Qq8PTA/D1heP4aI41MLJjYqe1mhFTXcjFCHK/9i+VTw
         7hmNj3i9T7stTuh1rL9gxWwmA81/wNP285uzbshk6Vn4CM7gBA647aWgzgfSHOpvf1
         wb7iMxu5fNOyimBnsRvczkE0NzR0Bx00lwkghPIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 11/95] net/tls: enable sk_msg redirect to tls socket egress
Date:   Wed, 27 Nov 2019 21:31:28 +0100
Message-Id: <20191127202849.967998412@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit d4ffb02dee2fcb20e0c8086a8d1305bf885820bb ]

Bring back tls_sw_sendpage_locked. sk_msg redirection into a socket
with TLS_TX takes the following path:

  tcp_bpf_sendmsg_redir
    tcp_bpf_push_locked
      tcp_bpf_push
        kernel_sendpage_locked
          sock->ops->sendpage_locked

Also update the flags test in tls_sw_sendpage_locked to allow flag
MSG_NO_SHARED_FRAGS. bpf_tcp_sendmsg sets this.

Link: https://lore.kernel.org/netdev/CA+FuTSdaAawmZ2N8nfDDKu3XLpXBbMtcCT0q4FntDD2gn8ASUw@mail.gmail.com/T/#t
Link: https://github.com/wdebruij/kerneltools/commits/icept.2
Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
Fixes: f3de19af0f5b ("Revert \"net/tls: remove unused function tls_sw_sendpage_locked\"")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tls.h  |    2 ++
 net/tls/tls_main.c |    1 +
 net/tls/tls_sw.c   |   11 +++++++++++
 3 files changed, 14 insertions(+)

--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -364,6 +364,8 @@ int tls_set_sw_offload(struct sock *sk,
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
+			   int offset, size_t size, int flags);
 int tls_sw_sendpage(struct sock *sk, struct page *page,
 		    int offset, size_t size, int flags);
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -852,6 +852,7 @@ static int __init tls_register(void)
 {
 	tls_sw_proto_ops = inet_stream_ops;
 	tls_sw_proto_ops.splice_read = tls_sw_splice_read;
+	tls_sw_proto_ops.sendpage_locked   = tls_sw_sendpage_locked,
 
 #ifdef CONFIG_TLS_DEVICE
 	tls_device_init();
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1204,6 +1204,17 @@ sendpage_end:
 	return copied ? copied : ret;
 }
 
+int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
+			   int offset, size_t size, int flags)
+{
+	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
+		      MSG_NO_SHARED_FRAGS))
+		return -ENOTSUPP;
+
+	return tls_sw_do_sendpage(sk, page, offset, size, flags);
+}
+
 int tls_sw_sendpage(struct sock *sk, struct page *page,
 		    int offset, size_t size, int flags)
 {


