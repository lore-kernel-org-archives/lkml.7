Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B61EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE11921734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625118;
	bh=GI7f8oxnGKNMvPYBJch+PdzbwEuT7WfPKxWDxpYXwgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GY7gL8DjIe6Rb/W5m42WtwhPJd4Gm6SeiC3o7b3erxHZBcB1EudmWuQH9UNJ014h1
	 EOybDetlhI8AGIZjbADuzcFdVNQPGH4AYAGBnUJY06yltOYOXoB2svOfRkzfi+4gCD
	 lg+vQb5vXTZmAn7+c2NMn/qIDWxHwBTFk5DWA+/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfD3Lv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731468AbfD3Lvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A2A21670;
        Tue, 30 Apr 2019 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625113;
        bh=GI7f8oxnGKNMvPYBJch+PdzbwEuT7WfPKxWDxpYXwgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJeBMUIramEu1jWNvZ51s2DSYbg4rnsdf1gDOkB2fu7Pjw2s6QgyJsLOAF0MN1jLT
         L5IE+V/XEZLj6t6ZssxSWHrBsh4Ix2vKlMLOC1e6njPh9b9NIYM3j2qMi85vVJWjCo
         S1Y9i48bdiW+zNZUCa2shPyaGsgcN6Q0bK8jJ/E4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 89/89] net/tls: dont leak IV and record seq when offload fails
Date:   Tue, 30 Apr 2019 13:39:20 +0200
Message-Id: <20190430113613.975297817@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 12c7686111326148b4b5db189130522a4ad1be4a ]

When device refuses the offload in tls_set_device_offload_rx()
it calls tls_sw_free_resources_rx() to clean up software context
state.

Unfortunately, tls_sw_free_resources_rx() does not free all
the state tls_set_sw_offload() allocated - it leaks IV and
sequence number buffers.  All other code paths which lead to
tls_sw_release_resources_rx() (which tls_sw_free_resources_rx()
calls) free those right before the call.

Avoid the leak by moving freeing of iv and rec_seq into
tls_sw_release_resources_rx().

Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c |    2 --
 net/tls/tls_main.c   |    5 +----
 net/tls/tls_sw.c     |    3 +++
 3 files changed, 4 insertions(+), 6 deletions(-)

--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -921,8 +921,6 @@ void tls_device_offload_cleanup_rx(struc
 	}
 out:
 	up_read(&device_offload_lock);
-	kfree(tls_ctx->rx.rec_seq);
-	kfree(tls_ctx->rx.iv);
 	tls_sw_release_resources_rx(sk);
 }
 
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -304,11 +304,8 @@ static void tls_sk_proto_close(struct so
 #endif
 	}
 
-	if (ctx->rx_conf == TLS_SW) {
-		kfree(ctx->rx.rec_seq);
-		kfree(ctx->rx.iv);
+	if (ctx->rx_conf == TLS_SW)
 		tls_sw_free_resources_rx(sk);
-	}
 
 #ifdef CONFIG_TLS_DEVICE
 	if (ctx->rx_conf == TLS_HW)
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1830,6 +1830,9 @@ void tls_sw_release_resources_rx(struct
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 
+	kfree(tls_ctx->rx.rec_seq);
+	kfree(tls_ctx->rx.iv);
+
 	if (ctx->aead_recv) {
 		kfree_skb(ctx->recv_pkt);
 		ctx->recv_pkt = NULL;


