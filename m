Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE31C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2592064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127852;
	bh=utyOkYxeZdrAdWhtVwFpDog/Gc2MdVCjbtEA/QjSmU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ul9I7iaHLo/mJ7Tq5A2L09WI3V/O7BNxDfeiJbugNafYBoHQQLYNtkgNRRzjkRLAG
	 4vebPbKXFdkLcQMpldPeljUt1DhQ+cIQHJRnQs2KAKY1trPBpJR1GoYdRLZRId9XWE
	 54GCRg/xpzP/FC61lKwfq9mCbhzWc7n9g0SvIJwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391729AbfDXRee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391107AbfDXRec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:32 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC5E2054F;
        Wed, 24 Apr 2019 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127271;
        bh=utyOkYxeZdrAdWhtVwFpDog/Gc2MdVCjbtEA/QjSmU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beA2hEIkPpbps+74WzRooPm6+MrpUgj4AHT6Bg+M1oNrUr5rJB06c6oK8+wTbMaw4
         ebJ3trbhtnXKoquIqLttmAVdp7eckuCYfqjmibmy151OWMZlkZF7MWzNoiUgSZYJQN
         qCgCHI+nII0eH6RJTKVVH1h2EBMA8s8jNjr9oxbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Beckett <david.beckett@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 023/115] net/tls: dont leak partially sent record in device mode
Date:   Wed, 24 Apr 2019 19:09:19 +0200
Message-Id: <20190424170926.407134357@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 35b71a34ada62c9573847a324bf06a133fe11b11 ]

David reports that tls triggers warnings related to
sk->sk_forward_alloc not being zero at destruction time:

WARNING: CPU: 5 PID: 6831 at net/core/stream.c:206 sk_stream_kill_queues+0x103/0x110
WARNING: CPU: 5 PID: 6831 at net/ipv4/af_inet.c:160 inet_sock_destruct+0x15b/0x170

When sender fills up the write buffer and dies from
SIGPIPE.  This is due to the device implementation
not cleaning up the partially_sent_record.

This is because commit a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
moved the partial record cleanup to the SW-only path.

Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Reported-by: David Beckett <david.beckett@netronome.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tls.h    |    2 ++
 net/tls/tls_device.c |    7 +++++++
 net/tls/tls_main.c   |   22 ++++++++++++++++++++++
 net/tls/tls_sw.c     |   15 +--------------
 4 files changed, 32 insertions(+), 14 deletions(-)

--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -289,6 +289,7 @@ int tls_device_sendmsg(struct sock *sk,
 int tls_device_sendpage(struct sock *sk, struct page *page,
 			int offset, size_t size, int flags);
 void tls_device_sk_destruct(struct sock *sk);
+void tls_device_free_resources_tx(struct sock *sk);
 void tls_device_init(void);
 void tls_device_cleanup(void);
 int tls_tx_records(struct sock *sk, int flags);
@@ -312,6 +313,7 @@ int tls_push_sg(struct sock *sk, struct
 		int flags);
 int tls_push_partial_record(struct sock *sk, struct tls_context *ctx,
 			    int flags);
+bool tls_free_partial_record(struct sock *sk, struct tls_context *ctx);
 
 int tls_push_pending_closed_record(struct sock *sk, struct tls_context *ctx,
 				   int flags, long *timeo);
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -219,6 +219,13 @@ void tls_device_sk_destruct(struct sock
 }
 EXPORT_SYMBOL(tls_device_sk_destruct);
 
+void tls_device_free_resources_tx(struct sock *sk)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+
+	tls_free_partial_record(sk, tls_ctx);
+}
+
 static void tls_append_frag(struct tls_record_info *record,
 			    struct page_frag *pfrag,
 			    int size)
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -220,6 +220,26 @@ int tls_push_pending_closed_record(struc
 		return tls_ctx->push_pending_record(sk, flags);
 }
 
+bool tls_free_partial_record(struct sock *sk, struct tls_context *ctx)
+{
+	struct scatterlist *sg;
+
+	sg = ctx->partially_sent_record;
+	if (!sg)
+		return false;
+
+	while (1) {
+		put_page(sg_page(sg));
+		sk_mem_uncharge(sk, sg->length);
+
+		if (sg_is_last(sg))
+			break;
+		sg++;
+	}
+	ctx->partially_sent_record = NULL;
+	return true;
+}
+
 static void tls_write_space(struct sock *sk)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
@@ -278,6 +298,8 @@ static void tls_sk_proto_close(struct so
 		kfree(ctx->tx.rec_seq);
 		kfree(ctx->tx.iv);
 		tls_sw_free_resources_tx(sk);
+	} else if (ctx->tx_conf == TLS_HW) {
+		tls_device_free_resources_tx(sk);
 	}
 
 	if (ctx->rx_conf == TLS_SW) {
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1804,20 +1804,7 @@ void tls_sw_free_resources_tx(struct soc
 	/* Free up un-sent records in tx_list. First, free
 	 * the partially sent record if any at head of tx_list.
 	 */
-	if (tls_ctx->partially_sent_record) {
-		struct scatterlist *sg = tls_ctx->partially_sent_record;
-
-		while (1) {
-			put_page(sg_page(sg));
-			sk_mem_uncharge(sk, sg->length);
-
-			if (sg_is_last(sg))
-				break;
-			sg++;
-		}
-
-		tls_ctx->partially_sent_record = NULL;
-
+	if (tls_free_partial_record(sk, tls_ctx)) {
 		rec = list_first_entry(&ctx->tx_list,
 				       struct tls_rec, list);
 		list_del(&rec->list);


