Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A9C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740DB206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620373;
	bh=1z0/PnKnzdrtHvrkdbZNhkIDZuCv6e19BiAJJKBBu8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDItxc76+I89qyjxMOdLbGddH9mZgHdiBf83ebg/AKC7vnednBe+UTY+cSFckvdeg
	 IJhGi1oshVNR1annqn8KYYntkyiX3arXNDR/ViiWe93olpXi7ZZpUEV/HUTEMsWzCJ
	 7CM9PocmVOyeCqxFWs1qOKKHNROKLWQb9HMvuoD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfIDSGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389393AbfIDSGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:06:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C89206B8;
        Wed,  4 Sep 2019 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620369;
        bh=1z0/PnKnzdrtHvrkdbZNhkIDZuCv6e19BiAJJKBBu8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhMAna5C9uqno85G47V1vkKYXTl1Vw1U3WGLp+mgcAUeNOsGs8SzULCjq6VXeSytW
         8+I3EYsof4D5+KloRSlL/ZtlMaqS2Dc62b39001zIoEnj4e+BhrTbvTLHHyOYmeV12
         BrEYLLcWZ21hWFYXk1nFxL+Yp4J6r6fLl/AefAsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vakul Garg <vakul.garg@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 31/93] net/tls: Fixed return value when tls_complete_pending_work() fails
Date:   Wed,  4 Sep 2019 19:53:33 +0200
Message-Id: <20190904175305.973059058@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vakul Garg <vakul.garg@nxp.com>

[ Upstream commit 150085791afb8054e11d2e080d4b9cd755dd7f69 ]

In tls_sw_sendmsg() and tls_sw_sendpage(), the variable 'ret' has
been set to return value of tls_complete_pending_work(). This allows
return of proper error code if tls_complete_pending_work() fails.

Fixes: 3c4d7559159b ("tls: kernel TLS support")
Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -354,7 +354,7 @@ int tls_sw_sendmsg(struct sock *sk, stru
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
-	int ret = 0;
+	int ret;
 	int required_size;
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	bool eor = !(msg->msg_flags & MSG_MORE);
@@ -370,7 +370,8 @@ int tls_sw_sendmsg(struct sock *sk, stru
 
 	lock_sock(sk);
 
-	if (tls_complete_pending_work(sk, tls_ctx, msg->msg_flags, &timeo))
+	ret = tls_complete_pending_work(sk, tls_ctx, msg->msg_flags, &timeo);
+	if (ret)
 		goto send_end;
 
 	if (unlikely(msg->msg_controllen)) {
@@ -505,7 +506,7 @@ int tls_sw_sendpage(struct sock *sk, str
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
-	int ret = 0;
+	int ret;
 	long timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 	bool eor;
 	size_t orig_size = size;
@@ -525,7 +526,8 @@ int tls_sw_sendpage(struct sock *sk, str
 
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
-	if (tls_complete_pending_work(sk, tls_ctx, flags, &timeo))
+	ret = tls_complete_pending_work(sk, tls_ctx, flags, &timeo);
+	if (ret)
 		goto sendpage_end;
 
 	/* Call the sk_stream functions to manage the sndbuf mem. */


