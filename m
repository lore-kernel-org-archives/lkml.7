Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A670C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581966;
	bh=yTH7VZ46a8LcmLsaDFjMi1fVibm1vd5pU9a5gsZIYK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aW962YN6b6fRvq6L5Y2OsbaGQvwtRkpvme9JbAYiMGCpYk8W77i5j0ZtQgiBanbIE
	 h+9Y5DCAv27GjsamQTNekPOTJ3lOs2uNPvhpOB/IgxvKzF9j/MZmCn5cNShOvuDzf7
	 7b68pFTckI/zYFlxkztYcXvMT+Jap8QoGIaWAeRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfCZGcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731477AbfCZGcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:42 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958A820856;
        Tue, 26 Mar 2019 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581961;
        bh=yTH7VZ46a8LcmLsaDFjMi1fVibm1vd5pU9a5gsZIYK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHp3htAb14yu5vJwWhBsXpQ1gI8OQbJDA8v8Urcf9HLO8xjMDgVA2aP+ymI4SBvs5
         S4bX0ujeR0R7s0/dukYd2qTEJZa7353YvNEor7/1El7P3MYUBlIi40TDpguKleb+yZ
         RaCbjqeyrbQ76BMsLkicv3hKuVMRbNAnLG3Z7QOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 19/30] tcp/dccp: drop SYN packets if accept queue is full
Date:   Tue, 26 Mar 2019 15:29:58 +0900
Message-Id: <20190326042608.219111978@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 5ea8ea2cb7f1d0db15762c9b0bb9e7330425a071 upstream.

Per listen(fd, backlog) rules, there is really no point accepting a SYN,
sending a SYNACK, and dropping the following ACK packet if accept queue
is full, because application is not draining accept queue fast enough.

This behavior is fooling TCP clients that believe they established a
flow, while there is nothing at server side. They might then send about
10 MSS (if using IW10) that will be dropped anyway while server is under
stress.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/inet_connection_sock.h |    5 -----
 net/dccp/ipv4.c                    |    8 +-------
 net/dccp/ipv6.c                    |    2 +-
 net/ipv4/tcp_input.c               |    8 +-------
 4 files changed, 3 insertions(+), 20 deletions(-)

--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -289,11 +289,6 @@ static inline int inet_csk_reqsk_queue_l
 	return reqsk_queue_len(&inet_csk(sk)->icsk_accept_queue);
 }
 
-static inline int inet_csk_reqsk_queue_young(const struct sock *sk)
-{
-	return reqsk_queue_len_young(&inet_csk(sk)->icsk_accept_queue);
-}
-
 static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 {
 	return inet_csk_reqsk_queue_len(sk) >= sk->sk_max_ack_backlog;
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -596,13 +596,7 @@ int dccp_v4_conn_request(struct sock *sk
 	if (inet_csk_reqsk_queue_is_full(sk))
 		goto drop;
 
-	/*
-	 * Accept backlog is full. If we have already queued enough
-	 * of warm entries in syn queue, drop request. It is better than
-	 * clogging syn queue with openreqs with exponentially increasing
-	 * timeout.
-	 */
-	if (sk_acceptq_is_full(sk) && inet_csk_reqsk_queue_young(sk) > 1)
+	if (sk_acceptq_is_full(sk))
 		goto drop;
 
 	req = inet_reqsk_alloc(&dccp_request_sock_ops, sk, true);
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -328,7 +328,7 @@ static int dccp_v6_conn_request(struct s
 	if (inet_csk_reqsk_queue_is_full(sk))
 		goto drop;
 
-	if (sk_acceptq_is_full(sk) && inet_csk_reqsk_queue_young(sk) > 1)
+	if (sk_acceptq_is_full(sk))
 		goto drop;
 
 	req = inet_reqsk_alloc(&dccp6_request_sock_ops, sk, true);
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6374,13 +6374,7 @@ int tcp_conn_request(struct request_sock
 			goto drop;
 	}
 
-
-	/* Accept backlog is full. If we have already queued enough
-	 * of warm entries in syn queue, drop request. It is better than
-	 * clogging syn queue with openreqs with exponentially increasing
-	 * timeout.
-	 */
-	if (sk_acceptq_is_full(sk) && inet_csk_reqsk_queue_young(sk) > 1) {
+	if (sk_acceptq_is_full(sk)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENOVERFLOWS);
 		goto drop;
 	}


