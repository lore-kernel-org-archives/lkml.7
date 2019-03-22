Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA086C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956DA2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260234;
	bh=mbRQdXsdkCaFliX0FG6KRvpfNBcoPVWX20HdIk4peD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yk6pKUvZKZZ7ImSPd2MBuVaX5Ioe8xTicYzIfpxUR8I5/ZxYfn8NMt+Y1mT/rfBUM
	 tYTKCKMQ+Tr0ERCT6RzlGy7AbDuftgbsvqOH0fg7zDg9rtSF2mjLzY5prVshO5Bpld
	 UPnpvqFEVUz60C8jUcR8lKIQbnleodx13H2LRAxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfCVLd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbfCVLdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17532183E;
        Fri, 22 Mar 2019 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254434;
        bh=mbRQdXsdkCaFliX0FG6KRvpfNBcoPVWX20HdIk4peD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9vcwYnnuG24/lBx/skSzRR+wDshIJrNEEQdBnuhZufUpeEoesCeAxspZmEdjKuRh
         YZMInQpOUNt7VO9Aer+gneYsoDN6uzktjUddjNwZTY081KYEDRwnQXJGUiOf6EpZKc
         3FRUdKbeOcZv0eBP+HRm3QQTyoHjJeRLQ/5vNMcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 119/230] udplite: call proper backlog handlers
Date:   Fri, 22 Mar 2019 12:14:17 +0100
Message-Id: <20190322111245.019934032@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 30c7be26fd3587abcb69587f781098e3ca2d565b upstream.

In commits 93821778def10 ("udp: Fix rcv socket locking") and
f7ad74fef3af ("net/ipv6/udp: UDP encapsulation: break backlog_rcv into
__udpv6_queue_rcv_skb") UDP backlog handlers were renamed, but UDPlite
was forgotten.

This leads to crashes if UDPlite header is pulled twice, which happens
starting from commit e6afc8ace6dd ("udp: remove headers from UDP packets
before queueing")

Bug found by syzkaller team, thanks a lot guys !

Note that backlog use in UDP/UDPlite is scheduled to be removed starting
from linux-4.10, so this patch is only needed up to linux-4.9

Fixes: 93821778def1 ("udp: Fix rcv socket locking")
Fixes: f7ad74fef3af ("net/ipv6/udp: UDP encapsulation: break backlog_rcv into __udpv6_queue_rcv_skb")
Fixes: e6afc8ace6dd ("udp: remove headers from UDP packets before queueing")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/udp.c      |    2 +-
 net/ipv4/udp_impl.h |    2 +-
 net/ipv4/udplite.c  |    2 +-
 net/ipv6/udp.c      |    2 +-
 net/ipv6/udp_impl.h |    2 +-
 net/ipv6/udplite.c  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1463,7 +1463,7 @@ static void udp_v4_rehash(struct sock *s
 	udp_lib_rehash(sk, new_hash);
 }
 
-static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int rc;
 
--- a/net/ipv4/udp_impl.h
+++ b/net/ipv4/udp_impl.h
@@ -25,7 +25,7 @@ int udp_recvmsg(struct sock *sk, struct
 		int flags, int *addr_len);
 int udp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
 		 int flags);
-int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
 void udp_destroy_sock(struct sock *sk);
 
 #ifdef CONFIG_PROC_FS
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -50,7 +50,7 @@ struct proto 	udplite_prot = {
 	.sendmsg	   = udp_sendmsg,
 	.recvmsg	   = udp_recvmsg,
 	.sendpage	   = udp_sendpage,
-	.backlog_rcv	   = udp_queue_rcv_skb,
+	.backlog_rcv	   = __udp_queue_rcv_skb,
 	.hash		   = udp_lib_hash,
 	.unhash		   = udp_lib_unhash,
 	.get_port	   = udp_v4_get_port,
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -585,7 +585,7 @@ out:
 	sock_put(sk);
 }
 
-static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int rc;
 
--- a/net/ipv6/udp_impl.h
+++ b/net/ipv6/udp_impl.h
@@ -26,7 +26,7 @@ int compat_udpv6_getsockopt(struct sock
 int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
 int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int noblock,
 		  int flags, int *addr_len);
-int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
 void udpv6_destroy_sock(struct sock *sk);
 
 void udp_v6_clear_sk(struct sock *sk, int size);
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -45,7 +45,7 @@ struct proto udplitev6_prot = {
 	.getsockopt	   = udpv6_getsockopt,
 	.sendmsg	   = udpv6_sendmsg,
 	.recvmsg	   = udpv6_recvmsg,
-	.backlog_rcv	   = udpv6_queue_rcv_skb,
+	.backlog_rcv	   = __udpv6_queue_rcv_skb,
 	.hash		   = udp_lib_hash,
 	.unhash		   = udp_lib_unhash,
 	.get_port	   = udp_v6_get_port,


