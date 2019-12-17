Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2266AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A7B21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613503;
	bh=5OpuQU/NCapf3Ptbg6hTZ7tXSEsEVKcRv5qOuJWXRtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l9mB1FVw8dQ20hXOYVui4x/XVhGdbs+gCRD1iNud1wLrCWaDtBb6ZnQ6MoF/MURIO
	 vRIaVjwRW+3a3VgSQ9uk5PH4ONB0f4VDk8263iD+z7F8x/7QAEveVI3NA+GG9Phfbl
	 NVI2W66HMVJgOrPBJ0IPASflgTwI8u0jP3xCCZcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfLQULl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfLQULh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:11:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20F8206D8;
        Tue, 17 Dec 2019 20:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613496;
        bh=5OpuQU/NCapf3Ptbg6hTZ7tXSEsEVKcRv5qOuJWXRtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4xpegHNRY1l3TAjIe2Shceq0QYR0NZNkGHSdhscx2ahsEKfi5N1vv+dAJzhFYxRO
         1xEBwuflHul6kClely4ZB6/h6jVc0F2PQR1QySeG9HRNW9b7qO+uKUWwM+aYf9Xjfa
         k3OQDhZFy1y9juyjZV6ikG0yfrr3gSBpxfEyHTuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 10/37] net/tls: Fix return values to avoid ENOTSUPP
Date:   Tue, 17 Dec 2019 21:09:31 +0100
Message-Id: <20191217200725.029930048@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Vidic <vvidic@valentin-vidic.from.hr>

[ Upstream commit 4a5cdc604b9cf645e6fa24d8d9f055955c3c8516 ]

ENOTSUPP is not available in userspace, for example:

  setsockopt failed, 524, Unknown error 524

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c              |    8 ++++----
 net/tls/tls_main.c                |    4 ++--
 net/tls/tls_sw.c                  |    8 ++++----
 tools/testing/selftests/net/tls.c |    8 ++------
 4 files changed, 12 insertions(+), 16 deletions(-)

--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -417,7 +417,7 @@ static int tls_push_data(struct sock *sk
 
 	if (flags &
 	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (sk->sk_err)
 		return -sk->sk_err;
@@ -560,7 +560,7 @@ int tls_device_sendpage(struct sock *sk,
 	lock_sock(sk);
 
 	if (flags & MSG_OOB) {
-		rc = -ENOTSUPP;
+		rc = -EOPNOTSUPP;
 		goto out;
 	}
 
@@ -999,7 +999,7 @@ int tls_set_device_offload(struct sock *
 	}
 
 	if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
-		rc = -ENOTSUPP;
+		rc = -EOPNOTSUPP;
 		goto release_netdev;
 	}
 
@@ -1071,7 +1071,7 @@ int tls_set_device_offload_rx(struct soc
 	}
 
 	if (!(netdev->features & NETIF_F_HW_TLS_RX)) {
-		rc = -ENOTSUPP;
+		rc = -EOPNOTSUPP;
 		goto release_netdev;
 	}
 
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -482,7 +482,7 @@ static int do_tls_setsockopt_conf(struct
 	/* check version */
 	if (crypto_info->version != TLS_1_2_VERSION &&
 	    crypto_info->version != TLS_1_3_VERSION) {
-		rc = -ENOTSUPP;
+		rc = -EINVAL;
 		goto err_crypto_info;
 	}
 
@@ -778,7 +778,7 @@ static int tls_init(struct sock *sk)
 	 * share the ulp context.
 	 */
 	if (sk->sk_state != TCP_ESTABLISHED)
-		return -ENOTSUPP;
+		return -ENOTCONN;
 
 	tls_build_proto(sk);
 
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -900,7 +900,7 @@ int tls_sw_sendmsg(struct sock *sk, stru
 	int ret = 0;
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
@@ -1215,7 +1215,7 @@ int tls_sw_sendpage_locked(struct sock *
 	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
 		      MSG_NO_SHARED_FRAGS))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	return tls_sw_do_sendpage(sk, page, offset, size, flags);
 }
@@ -1228,7 +1228,7 @@ int tls_sw_sendpage(struct sock *sk, str
 
 	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
@@ -1927,7 +1927,7 @@ ssize_t tls_sw_splice_read(struct socket
 
 		/* splice does not support reading control messages */
 		if (ctx->control != TLS_RECORD_TYPE_DATA) {
-			err = -ENOTSUPP;
+			err = -EINVAL;
 			goto splice_read_end;
 		}
 
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -25,10 +25,6 @@
 #define TLS_PAYLOAD_MAX_LEN 16384
 #define SOL_TLS 282
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 FIXTURE(tls_basic)
 {
 	int fd, cfd;
@@ -1205,11 +1201,11 @@ TEST(non_established) {
 	/* TLS ULP not supported */
 	if (errno == ENOENT)
 		return;
-	EXPECT_EQ(errno, ENOTSUPP);
+	EXPECT_EQ(errno, ENOTCONN);
 
 	ret = setsockopt(sfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
 	EXPECT_EQ(ret, -1);
-	EXPECT_EQ(errno, ENOTSUPP);
+	EXPECT_EQ(errno, ENOTCONN);
 
 	ret = getsockname(sfd, &addr, &len);
 	ASSERT_EQ(ret, 0);


