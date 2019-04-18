Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6832186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610813;
	bh=G1k/rT4FKjTfW3Gc/UC15CayqXhRNRSKY8i8zQ4tNlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WjgIxXP7eRioqXx4D+gkn27PgMajpwXP73bFWcdBI4HjEHk2/yXPYfnOWSSN5F3fn
	 6qmmqZw6KQq/b/o0AlCZEb1ksaq82ZzWj5VFBdjt090/vYJXx5iEtohEPbW9qn7XdX
	 sherv46rXcPKVgmtMWIdFrj8QtgUPlE2ilER4lGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391175AbfDRSGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391163AbfDRSGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B81218AF;
        Thu, 18 Apr 2019 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610802;
        bh=G1k/rT4FKjTfW3Gc/UC15CayqXhRNRSKY8i8zQ4tNlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxN1r7+x1oB5XZahKoGfaqPnNsn6L1SMPL7ytxGCqXe/9wVrvdToyg4d5xMtracMu
         uXucmbZIqcQ9fWT9V0zoxCEj7gISeFf8fFNBdAlAB3TZTCD0FKeQLMzvKnapZhcUyT
         rgr5LIVljL5Jj1VpaRAcbgc+Ahmn3E+ifLqhdw+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 72/92] dm: disable CRYPTO_TFM_REQ_MAY_SLEEP to fix a GFP_KERNEL recursion deadlock
Date:   Thu, 18 Apr 2019 19:57:30 +0200
Message-Id: <20190418160436.475787141@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 432061b3da64e488be3403124a72a9250bbe96d4 ]

There's a XFS on dm-crypt deadlock, recursing back to itself due to the
crypto subsystems use of GFP_KERNEL, reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=200835

* dm-crypt calls crypt_convert in xts mode
* init_crypt from xts.c calls kmalloc(GFP_KERNEL)
* kmalloc(GFP_KERNEL) recurses into the XFS filesystem, the filesystem
	tries to submit some bios and wait for them, causing a deadlock

Fix this by updating both the DM crypt and integrity targets to no
longer use the CRYPTO_TFM_REQ_MAY_SLEEP flag, which will change the
crypto allocations from GFP_KERNEL to GFP_ATOMIC, therefore they can't
recurse into a filesystem.  A GFP_ATOMIC allocation can fail, but
init_crypt() in xts.c handles the allocation failure gracefully - it
will fall back to preallocated buffer if the allocation fails.

The crypto API maintainer says that the crypto API only needs to
allocate memory when dealing with unaligned buffers and therefore
turning CRYPTO_TFM_REQ_MAY_SLEEP off is safe (see this discussion:
https://www.redhat.com/archives/dm-devel/2018-August/msg00195.html )

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/md/dm-crypt.c     | 10 +++++-----
 drivers/md/dm-integrity.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 0d2005e5b24c..94b8d81f6020 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -334,7 +334,7 @@ static int crypt_iv_essiv_init(struct crypt_config *cc)
 
 	sg_init_one(&sg, cc->key, cc->key_size);
 	ahash_request_set_tfm(req, essiv->hash_tfm);
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+	ahash_request_set_callback(req, 0, NULL, NULL);
 	ahash_request_set_crypt(req, &sg, essiv->salt, cc->key_size);
 
 	err = crypto_ahash_digest(req);
@@ -609,7 +609,7 @@ static int crypt_iv_lmk_one(struct crypt_config *cc, u8 *iv,
 	int i, r;
 
 	desc->tfm = lmk->hash_tfm;
-	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	desc->flags = 0;
 
 	r = crypto_shash_init(desc);
 	if (r)
@@ -771,7 +771,7 @@ static int crypt_iv_tcw_whitening(struct crypt_config *cc,
 
 	/* calculate crc32 for every 32bit part and xor it */
 	desc->tfm = tcw->crc32_tfm;
-	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	desc->flags = 0;
 	for (i = 0; i < 4; i++) {
 		r = crypto_shash_init(desc);
 		if (r)
@@ -1254,7 +1254,7 @@ static void crypt_alloc_req_skcipher(struct crypt_config *cc,
 	 * requests if driver request queue is full.
 	 */
 	skcipher_request_set_callback(ctx->r.req,
-	    CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+	    CRYPTO_TFM_REQ_MAY_BACKLOG,
 	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
 }
 
@@ -1271,7 +1271,7 @@ static void crypt_alloc_req_aead(struct crypt_config *cc,
 	 * requests if driver request queue is full.
 	 */
 	aead_request_set_callback(ctx->r.req_aead,
-	    CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+	    CRYPTO_TFM_REQ_MAY_BACKLOG,
 	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req_aead));
 }
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index da4baea9cf83..036379a23499 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -493,7 +493,7 @@ static void section_mac(struct dm_integrity_c *ic, unsigned section, __u8 result
 	unsigned j, size;
 
 	desc->tfm = ic->journal_mac;
-	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	desc->flags = 0;
 
 	r = crypto_shash_init(desc);
 	if (unlikely(r)) {
@@ -637,7 +637,7 @@ static void complete_journal_encrypt(struct crypto_async_request *req, int err)
 static bool do_crypt(bool encrypt, struct skcipher_request *req, struct journal_completion *comp)
 {
 	int r;
-	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				      complete_journal_encrypt, comp);
 	if (likely(encrypt))
 		r = crypto_skcipher_encrypt(req);
-- 
2.19.1



