Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1897DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCEE21934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256709;
	bh=tBP8j01uVvnOhVTgUdPCk2CQMkIxHOC6NbK0/v30Yu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LMadQIQ2sITbTyysynqKqrDlgiXxcDycSpGtwu0n71PO9BCpU+sEdEQTIuR6P1E9D
	 rxYcpNpFm7zxEwmvKGVmTNq1sZE8MNM9PcHyuXZhwtSQN1jiwN5pOYORJKl1cqCg9o
	 EwTN3yAQgRA7W0PPd26oCz8dSLQzSTmEkE6oYTj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbfCVMLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389003AbfCVMLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:11:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D501E21929;
        Fri, 22 Mar 2019 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256703;
        bh=tBP8j01uVvnOhVTgUdPCk2CQMkIxHOC6NbK0/v30Yu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzkgEawEe77U62I5cdLqfLApOtNoCdVq/kz5Zu3uKYx2Cy9QSCD2+prWqYiHQgHwH
         HaWm9ftBgQdLyuFrsKjRXbzKyBngKumqzKQYsiqC2/tN8K4rAZL3k5c+z5Rf8Fgy59
         dP5nMZVOnbMhDJ433HbU9LfDV4YTaW7LEStc8Z9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 012/238] crypto: caam - fix hash context DMA unmap size
Date:   Fri, 22 Mar 2019 12:13:51 +0100
Message-Id: <20190322111258.963703538@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Franck LENORMAND <franck.lenormand@nxp.com>

commit 65055e2108847af5e577cc7ce6bde45ea136d29a upstream.

When driver started using state->caam_ctxt for storing both running hash
and final hash, it was not updated to handle different DMA unmap
lengths.

Cc: <stable@vger.kernel.org> # v4.19+
Fixes: c19650d6ea99 ("crypto: caam - fix DMA mapping of stack memory")
Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/caamhash.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -113,6 +113,7 @@ struct caam_hash_ctx {
 struct caam_hash_state {
 	dma_addr_t buf_dma;
 	dma_addr_t ctx_dma;
+	int ctx_dma_len;
 	u8 buf_0[CAAM_MAX_HASH_BLOCK_SIZE] ____cacheline_aligned;
 	int buflen_0;
 	u8 buf_1[CAAM_MAX_HASH_BLOCK_SIZE] ____cacheline_aligned;
@@ -165,6 +166,7 @@ static inline int map_seq_out_ptr_ctx(u3
 				      struct caam_hash_state *state,
 				      int ctx_len)
 {
+	state->ctx_dma_len = ctx_len;
 	state->ctx_dma = dma_map_single(jrdev, state->caam_ctx,
 					ctx_len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(jrdev, state->ctx_dma)) {
@@ -218,6 +220,7 @@ static inline int ctx_map_to_sec4_sg(str
 				     struct caam_hash_state *state, int ctx_len,
 				     struct sec4_sg_entry *sec4_sg, u32 flag)
 {
+	state->ctx_dma_len = ctx_len;
 	state->ctx_dma = dma_map_single(jrdev, state->caam_ctx, ctx_len, flag);
 	if (dma_mapping_error(jrdev, state->ctx_dma)) {
 		dev_err(jrdev, "unable to map ctx\n");
@@ -468,12 +471,10 @@ static inline void ahash_unmap_ctx(struc
 			struct ahash_edesc *edesc,
 			struct ahash_request *req, int dst_len, u32 flag)
 {
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 
 	if (state->ctx_dma) {
-		dma_unmap_single(dev, state->ctx_dma, ctx->ctx_len, flag);
+		dma_unmap_single(dev, state->ctx_dma, state->ctx_dma_len, flag);
 		state->ctx_dma = 0;
 	}
 	ahash_unmap(dev, edesc, req, dst_len);
@@ -1446,6 +1447,7 @@ static int ahash_init(struct ahash_reque
 	state->final = ahash_final_no_ctx;
 
 	state->ctx_dma = 0;
+	state->ctx_dma_len = 0;
 	state->current_buf = 0;
 	state->buf_dma = 0;
 	state->buflen_0 = 0;


