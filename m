Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45D7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0D32183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfCVPsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:48:35 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49005 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCVPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:48:35 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1My3Ef-1gmy8v2Jdn-00zXSP; Fri, 22 Mar 2019 16:48:22 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Wei Wang <weiwan@google.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yafang Shao <laoar.shao@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dccp@vger.kernel.org
Subject: [BACKPORT 4.4.y 18/25] tcp/dccp: drop SYN packets if accept queue is full
Date:   Fri, 22 Mar 2019 16:44:09 +0100
Message-Id: <20190322154425.3852517-19-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Clx4QEa8CHf+79ocuFelFxKkv6ZBgct37aKzyZa4h5hcFxZpErA
 /p4ee3N9oMC9s1WB5dkF17idBT8GVTpwUvpAiwx8aIrpmLwva6sPD27mZyXnodecqODNk5E
 Q4EZLmiU3X3NAVN1wSql3DT+BF5rHpyWf1vLPm25IIRUMHbuPT2EyY6/wB72eVDuhSzY+zk
 FCabVacbKEB1rKsKy3vhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TD8UNPVaM9A=:tW9VtVmKapwwbgz00NKdcD
 Tc1KlNsEVKs1or3vGyC6ojkMhDDQdmeb4VS2SUchIy7kYgPP9pSsIHOAVLGQPJtAKmwfeDEvL
 XzN64Ldt1Ue017tQTzZ/Ar8SD6Bw50LN0gQhJcp66YITEgeuEtpoezlvboB70RU6U0+YjfWfP
 QDASPhGe5HBWUXWRZFPhWc6s7UIflTIpE33mq02fiSf8C9V2mPtDO1sjGwYHKWoDzx2eBrzsj
 fxXb+DVT/6XDFVf3xk81UndsTrwtrC1ClyBn85p3kxcSh+eq2dS/zJaX49EKi3lrJRZZeNh2F
 hCII1onB2qz6EbJIyODq2i7PKWhLkWhgeq+ki9t+Y1Lyrqsh2g2xjExobZiUR1VKvfF0rWp2k
 2A966d4p1esXGqX2McyoqQrPTWgUJM2KYL9xLu4exnNVoJC1rJoOiUVtLffdU2L2EYJh5BIGj
 uDUd6/Ewep9nr3EOTuCPc45NSlbqjgWAUm6vvD8fvqWKpQZ/LuEiuqOJ89dOp0Mt5jEqmoSKY
 4K4KdpkSLvEXnKsrovOotELyU6cVifBSayo9Z2ytiJWUUnjSdriZ2FTfNCGSYdu6fpA54H0ke
 Pnb6zuOlZI6+81EUkxMSv6mOZoczN/ZzALhh6VYe93xgJV6R/eAQ3fgr6eGngi6NzYpdgo65k
 b8DZ00XpLdg2krjngqNtexxgKTQoIEAUcDKp/DolbXVHQP8GBTs75ssXXsbML9uZsFqWIoCuz
 JF0L6Ecuj+kOQmha+hO2CSl4/8LARB/fbU2KAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

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
(cherry picked from commit 5ea8ea2cb7f1d0db15762c9b0bb9e7330425a071)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/inet_connection_sock.h | 5 -----
 net/dccp/ipv4.c                    | 8 +-------
 net/dccp/ipv6.c                    | 2 +-
 net/ipv4/tcp_input.c               | 8 +-------
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 49dcad4fe99e..72599bbc8255 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -289,11 +289,6 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
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
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 45fd82e61e79..b0a577a79a6a 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -592,13 +592,7 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
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
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 0bf41faeffc4..18bb2a42f0d1 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -324,7 +324,7 @@ static int dccp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (inet_csk_reqsk_queue_is_full(sk))
 		goto drop;
 
-	if (sk_acceptq_is_full(sk) && inet_csk_reqsk_queue_young(sk) > 1)
+	if (sk_acceptq_is_full(sk))
 		goto drop;
 
 	req = inet_reqsk_alloc(&dccp6_request_sock_ops, sk, true);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1aff93d76f24..b320fa9f834a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6305,13 +6305,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
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
 		NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_LISTENOVERFLOWS);
 		goto drop;
 	}
-- 
2.20.0

