Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EE2C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0E922CBF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154983;
	bh=kMt55MXTQUXL1S6ga7bIsN/YHy3xsGMr2CP2A68gwhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dvZkO5CCeSzRjp6rPDbh361X8zAvRhgVIe31jKHN9/fEdmEyzfFGU1VIRupu97bTc
	 G151a9qvhMOXf3HWSRPb6Ul1ZkOO9GLZmccVrNgdy2O224M/CyLrJFWRAC8JkwnQtM
	 e2wDEm88nsAspf2sRMgJ73Db6CEAX0gJopUjeroc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbfGZP3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388866AbfGZP3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:29:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A381922BF5;
        Fri, 26 Jul 2019 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154978;
        bh=kMt55MXTQUXL1S6ga7bIsN/YHy3xsGMr2CP2A68gwhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTILqRKo2vHwuWKFSbFhEZK3wsxt7Gt3HnuaSHJZgbkrvHH1RO4LBUMO4kOkIn4rw
         RfA27WOBiDQF9ztTWf6usbmthLk1NldwRVHyfXv1IuqO1spvEgdom3OvaB0vEeeZBP
         BEGt/vUMhfShyRUj+91a3VDg5uKQFlJFgUxoc84E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 24/62] tcp: fix tcp_set_congestion_control() use from bpf hook
Date:   Fri, 26 Jul 2019 17:24:36 +0200
Message-Id: <20190726152304.248043765@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8d650cdedaabb33e85e9b7c517c0c71fcecc1de9 ]

Neal reported incorrect use of ns_capable() from bpf hook.

bpf_setsockopt(...TCP_CONGESTION...)
  -> tcp_set_congestion_control()
   -> ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)
    -> ns_capable_common()
     -> current_cred()
      -> rcu_dereference_protected(current->cred, 1)

Accessing 'current' in bpf context makes no sense, since packets
are processed from softirq context.

As Neal stated : The capability check in tcp_set_congestion_control()
was written assuming a system call context, and then was reused from
a BPF call site.

The fix is to add a new parameter to tcp_set_congestion_control(),
so that the ns_capable() call is only performed under the right
context.

Fixes: 91b5b21c7c16 ("bpf: Add support for changing congestion control")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lawrence Brakmo <brakmo@fb.com>
Reported-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h   |    3 ++-
 net/core/filter.c   |    2 +-
 net/ipv4/tcp.c      |    4 +++-
 net/ipv4/tcp_cong.c |    6 +++---
 4 files changed, 9 insertions(+), 6 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1067,7 +1067,8 @@ void tcp_get_default_congestion_control(
 void tcp_get_available_congestion_control(char *buf, size_t len);
 void tcp_get_allowed_congestion_control(char *buf, size_t len);
 int tcp_set_allowed_congestion_control(char *allowed);
-int tcp_set_congestion_control(struct sock *sk, const char *name, bool load, bool reinit);
+int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
+			       bool reinit, bool cap_net_admin);
 u32 tcp_slow_start(struct tcp_sock *tp, u32 acked);
 void tcp_cong_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked);
 
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4211,7 +4211,7 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_so
 						    TCP_CA_NAME_MAX-1));
 			name[TCP_CA_NAME_MAX-1] = 0;
 			ret = tcp_set_congestion_control(sk, name, false,
-							 reinit);
+							 reinit, true);
 		} else {
 			struct tcp_sock *tp = tcp_sk(sk);
 
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2784,7 +2784,9 @@ static int do_tcp_setsockopt(struct sock
 		name[val] = 0;
 
 		lock_sock(sk);
-		err = tcp_set_congestion_control(sk, name, true, true);
+		err = tcp_set_congestion_control(sk, name, true, true,
+						 ns_capable(sock_net(sk)->user_ns,
+							    CAP_NET_ADMIN));
 		release_sock(sk);
 		return err;
 	}
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -332,7 +332,8 @@ out:
  * tcp_reinit_congestion_control (if the current congestion control was
  * already initialized.
  */
-int tcp_set_congestion_control(struct sock *sk, const char *name, bool load, bool reinit)
+int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
+			       bool reinit, bool cap_net_admin)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	const struct tcp_congestion_ops *ca;
@@ -368,8 +369,7 @@ int tcp_set_congestion_control(struct so
 		} else {
 			err = -EBUSY;
 		}
-	} else if (!((ca->flags & TCP_CONG_NON_RESTRICTED) ||
-		     ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))) {
+	} else if (!((ca->flags & TCP_CONG_NON_RESTRICTED) || cap_net_admin)) {
 		err = -EPERM;
 	} else if (!try_module_get(ca->owner)) {
 		err = -EBUSY;


