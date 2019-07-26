Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC081C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEEE2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155238;
	bh=GzdrERlVciSo6HfVAEApRX/1niK8SDg3s81xyoCbM6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jrH3C4dJIgbEMOtkuhSg9L5meZ+XNmRrYwVol558zphY7F0EpYHhuxwv6uTfSEB0b
	 2ZiuJqgFXXjP51pJZEiUmrZImd1aehgu876zuR5JuV5wTZgX34/PriXm3sijYJizo1
	 0jWG49bWWEocvNMUPaqFgazRx58mdE2YWzOExSwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbfGZPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389733AbfGZPdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:33:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B19F2054F;
        Fri, 26 Jul 2019 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155233;
        bh=GzdrERlVciSo6HfVAEApRX/1niK8SDg3s81xyoCbM6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yBkG49qb4BxH66oRCCiMN0caqzrsvw7y4lnQUUfuCAB2iY5cmjfoGnj/19se//Y0e
         MqIpsOjKh0akgDWApGRvN8vVMM/dWZquAKMsNT4/l/d9HeEJTLcg/WtUOLN9YmUpO2
         r1PI8s+DHBxriG76vYQG+zUHDvNJ2lAaVNpeB8dE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 30/50] net/tls: make sure offload also gets the keys wiped
Date:   Fri, 26 Jul 2019 17:25:05 +0200
Message-Id: <20190726152303.707657736@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152300.760439618@linuxfoundation.org>
References: <20190726152300.760439618@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit acd3e96d53a24d219f720ed4012b62723ae05da1 ]

Commit 86029d10af18 ("tls: zero the crypto information from tls_context
before freeing") added memzero_explicit() calls to clear the key material
before freeing struct tls_context, but it missed tls_device.c has its
own way of freeing this structure. Replace the missing free.

Fixes: 86029d10af18 ("tls: zero the crypto information from tls_context before freeing")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tls.h    |    1 +
 net/tls/tls_device.c |    2 +-
 net/tls/tls_main.c   |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -234,6 +234,7 @@ struct tls_offload_context_rx {
 	(ALIGN(sizeof(struct tls_offload_context_rx), sizeof(void *)) + \
 	 TLS_DRIVER_STATE_SIZE)
 
+void tls_ctx_free(struct tls_context *ctx);
 int wait_on_pending_writer(struct sock *sk, long *timeo);
 int tls_sk_query(struct sock *sk, int optname, char __user *optval,
 		int __user *optlen);
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -61,7 +61,7 @@ static void tls_device_free_ctx(struct t
 	if (ctx->rx_conf == TLS_HW)
 		kfree(tls_offload_ctx_rx(ctx));
 
-	kfree(ctx);
+	tls_ctx_free(ctx);
 }
 
 static void tls_device_gc_task(struct work_struct *work)
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -241,7 +241,7 @@ static void tls_write_space(struct sock
 	ctx->sk_write_space(sk);
 }
 
-static void tls_ctx_free(struct tls_context *ctx)
+void tls_ctx_free(struct tls_context *ctx)
 {
 	if (!ctx)
 		return;


