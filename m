Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A7FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC59320656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240784;
	bh=wcNHCg9F7FpYEqALIUNXbgJbhQtuZRaL7o0Io3RAl10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FiO7jSpepWDGyEC50p5HYCAPyfk7Qtvd51vwS1MAaTUL60bD1a0gOBEFTyIizIriM
	 cr9K2rVEPmH9fbbcYcj30uchqy8fkleLXu6EZjLTE/5xFsVJuZpD9Db8la5nh7uimz
	 5vCt6S9ztKwn8bRbCFsQV5w3qAXtgigHSPwdNP5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbfKHTTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389449AbfKHTAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04452224FE;
        Fri,  8 Nov 2019 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239557;
        bh=wcNHCg9F7FpYEqALIUNXbgJbhQtuZRaL7o0Io3RAl10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhVA6r3n2Ow/oD9N4gwJjvUP3Z5XNUANKMuqIrEpN39Rh9NhaQTw2WRD/rH40uowT
         GzxiBifrK5JGXlVm2Ug0B58qKcLxL90vXRgmpwxwpcPZbun5meqp/hXVUGeP4MzMj+
         2J2pbDkXCx5JjmQiL7RV4f8wmao2T1Os0paHeWUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 44/62] net: use skb_queue_empty_lockless() in poll() handlers
Date:   Fri,  8 Nov 2019 19:50:32 +0100
Message-Id: <20191108174750.303877583@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3ef7cf57c72f32f61e97f8fa401bc39ea1f1a5d4 ]

Many poll() handlers are lockless. Using skb_queue_empty_lockless()
instead of skb_queue_empty() is more appropriate.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/capi/capi.c     |    2 +-
 net/atm/common.c             |    2 +-
 net/bluetooth/af_bluetooth.c |    4 ++--
 net/caif/caif_socket.c       |    2 +-
 net/core/datagram.c          |    4 ++--
 net/ipv4/tcp.c               |    2 +-
 net/ipv4/udp.c               |    2 +-
 net/nfc/llcp_sock.c          |    4 ++--
 net/phonet/socket.c          |    4 ++--
 net/sctp/socket.c            |    4 ++--
 net/tipc/socket.c            |    4 ++--
 net/unix/af_unix.c           |    6 +++---
 net/vmw_vsock/af_vsock.c     |    2 +-
 13 files changed, 21 insertions(+), 21 deletions(-)

--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -743,7 +743,7 @@ capi_poll(struct file *file, poll_table
 
 	poll_wait(file, &(cdev->recvwait), wait);
 	mask = POLLOUT | POLLWRNORM;
-	if (!skb_queue_empty(&cdev->recvqueue))
+	if (!skb_queue_empty_lockless(&cdev->recvqueue))
 		mask |= POLLIN | POLLRDNORM;
 	return mask;
 }
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -667,7 +667,7 @@ unsigned int vcc_poll(struct file *file,
 		mask |= POLLHUP;
 
 	/* readable? */
-	if (!skb_queue_empty(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 		mask |= POLLIN | POLLRDNORM;
 
 	/* writable? */
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -460,7 +460,7 @@ unsigned int bt_sock_poll(struct file *f
 	if (sk->sk_state == BT_LISTEN)
 		return bt_accept_poll(sk);
 
-	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= POLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? POLLPRI : 0);
 
@@ -470,7 +470,7 @@ unsigned int bt_sock_poll(struct file *f
 	if (sk->sk_shutdown == SHUTDOWN_MASK)
 		mask |= POLLHUP;
 
-	if (!skb_queue_empty(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 		mask |= POLLIN | POLLRDNORM;
 
 	if (sk->sk_state == BT_CLOSED)
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -953,7 +953,7 @@ static unsigned int caif_poll(struct fil
 		mask |= POLLRDHUP;
 
 	/* readable? */
-	if (!skb_queue_empty(&sk->sk_receive_queue) ||
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
 		(sk->sk_shutdown & RCV_SHUTDOWN))
 		mask |= POLLIN | POLLRDNORM;
 
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -844,7 +844,7 @@ unsigned int datagram_poll(struct file *
 	mask = 0;
 
 	/* exceptional events? */
-	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= POLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? POLLPRI : 0);
 
@@ -854,7 +854,7 @@ unsigned int datagram_poll(struct file *
 		mask |= POLLHUP;
 
 	/* readable? */
-	if (!skb_queue_empty(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 		mask |= POLLIN | POLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -574,7 +574,7 @@ unsigned int tcp_poll(struct file *file,
 	}
 	/* This barrier is coupled with smp_wmb() in tcp_reset() */
 	smp_rmb();
-	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= POLLERR;
 
 	return mask;
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2550,7 +2550,7 @@ unsigned int udp_poll(struct file *file,
 	unsigned int mask = datagram_poll(file, sock, wait);
 	struct sock *sk = sock->sk;
 
-	if (!skb_queue_empty(&udp_sk(sk)->reader_queue))
+	if (!skb_queue_empty_lockless(&udp_sk(sk)->reader_queue))
 		mask |= POLLIN | POLLRDNORM;
 
 	sock_rps_record_flow(sk);
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -567,11 +567,11 @@ static unsigned int llcp_sock_poll(struc
 	if (sk->sk_state == LLCP_LISTEN)
 		return llcp_accept_poll(sk);
 
-	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= POLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? POLLPRI : 0);
 
-	if (!skb_queue_empty(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 		mask |= POLLIN | POLLRDNORM;
 
 	if (sk->sk_state == LLCP_CLOSED)
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -352,9 +352,9 @@ static unsigned int pn_socket_poll(struc
 
 	if (sk->sk_state == TCP_CLOSE)
 		return POLLERR;
-	if (!skb_queue_empty(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 		mask |= POLLIN | POLLRDNORM;
-	if (!skb_queue_empty(&pn->ctrlreq_queue))
+	if (!skb_queue_empty_lockless(&pn->ctrlreq_queue))
 		mask |= POLLPRI;
 	if (!mask && sk->sk_state == TCP_CLOSE_WAIT)
 		return POLLHUP;
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7371,7 +7371,7 @@ unsigned int sctp_poll(struct file *file
 	mask = 0;
 
 	/* Is there any exceptional events?  */
-	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= POLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? POLLPRI : 0);
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
@@ -7380,7 +7380,7 @@ unsigned int sctp_poll(struct file *file
 		mask |= POLLHUP;
 
 	/* Is it readable?  Reconsider this code with TCP-style support.  */
-	if (!skb_queue_empty(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 		mask |= POLLIN | POLLRDNORM;
 
 	/* The association is either gone or not ready.  */
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -714,14 +714,14 @@ static unsigned int tipc_poll(struct fil
 		/* fall thru' */
 	case TIPC_LISTEN:
 	case TIPC_CONNECTING:
-		if (!skb_queue_empty(&sk->sk_receive_queue))
+		if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 			mask |= (POLLIN | POLLRDNORM);
 		break;
 	case TIPC_OPEN:
 		if (!tsk->cong_link_cnt)
 			mask |= POLLOUT;
 		if (tipc_sk_type_connectionless(sk) &&
-		    (!skb_queue_empty(&sk->sk_receive_queue)))
+		    (!skb_queue_empty_lockless(&sk->sk_receive_queue)))
 			mask |= (POLLIN | POLLRDNORM);
 		break;
 	case TIPC_DISCONNECTING:
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2665,7 +2665,7 @@ static unsigned int unix_poll(struct fil
 		mask |= POLLRDHUP | POLLIN | POLLRDNORM;
 
 	/* readable? */
-	if (!skb_queue_empty(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 		mask |= POLLIN | POLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
@@ -2693,7 +2693,7 @@ static unsigned int unix_dgram_poll(stru
 	mask = 0;
 
 	/* exceptional events? */
-	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= POLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? POLLPRI : 0);
 
@@ -2703,7 +2703,7 @@ static unsigned int unix_dgram_poll(stru
 		mask |= POLLHUP;
 
 	/* readable? */
-	if (!skb_queue_empty(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
 		mask |= POLLIN | POLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -880,7 +880,7 @@ static unsigned int vsock_poll(struct fi
 		 * the queue and write as long as the socket isn't shutdown for
 		 * sending.
 		 */
-		if (!skb_queue_empty(&sk->sk_receive_queue) ||
+		if (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN)) {
 			mask |= POLLIN | POLLRDNORM;
 		}


