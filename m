Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D341BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6EE21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259504;
	bh=EjuAWUyvynv0if+5A+TqtjuNuKuLELApTDMVnoEKqHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZUOIHkut5OCnnnPk3lkHvR2c4vSY7QGvaXBGhP3e3B8PpqpZI+G/mqqvu+y0RfMz
	 ZGSPLFEb6cgDhLDRqsuPsMq2CIvPnpYEN5TL0fU+MoC/UNEyzc2hEgtFPxWz/OImh4
	 F0jT9SgwuEytCUSzBS6jAgWzXZcOqlAh/q6/9oMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbfCVM6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbfCVLqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C62218B0;
        Fri, 22 Mar 2019 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255203;
        bh=EjuAWUyvynv0if+5A+TqtjuNuKuLELApTDMVnoEKqHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgRM2Xr5TMVrQ0uXqxAznDAYfL03K6UQab5bmOjfKHvUGTkh67Kapr5wv8b7+8bPW
         4KUoJWQNQo4A0adIyNaXM+DuwQmr0fMu0bjCYxeFpAwJlhWpKrKtqvx6mtVHLDGkJb
         9ccKKVJOw6hwp8QGQlAI8+D9tk/+03d6e9Rzj2a4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 007/183] crypto: ahash - fix another early termination in hash walk
Date:   Fri, 22 Mar 2019 12:13:55 +0100
Message-Id: <20190322111242.318186951@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 77568e535af7c4f97eaef1e555bf0af83772456c upstream.

Hash algorithms with an alignmask set, e.g. "xcbc(aes-aesni)" and
"michael_mic", fail the improved hash tests because they sometimes
produce the wrong digest.  The bug is that in the case where a
scatterlist element crosses pages, not all the data is actually hashed
because the scatterlist walk terminates too early.  This happens because
the 'nbytes' variable in crypto_hash_walk_done() is assigned the number
of bytes remaining in the page, then later interpreted as the number of
bytes remaining in the scatterlist element.  Fix it.

Fixes: 900a081f6912 ("crypto: ahash - Fix early termination in hash walk")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ahash.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -86,17 +86,17 @@ static int hash_walk_new_entry(struct cr
 int crypto_hash_walk_done(struct crypto_hash_walk *walk, int err)
 {
 	unsigned int alignmask = walk->alignmask;
-	unsigned int nbytes = walk->entrylen;
 
 	walk->data -= walk->offset;
 
-	if (nbytes && walk->offset & alignmask && !err) {
-		walk->offset = ALIGN(walk->offset, alignmask + 1);
-		nbytes = min(nbytes,
-			     ((unsigned int)(PAGE_SIZE)) - walk->offset);
-		walk->entrylen -= nbytes;
+	if (walk->entrylen && (walk->offset & alignmask) && !err) {
+		unsigned int nbytes;
 
+		walk->offset = ALIGN(walk->offset, alignmask + 1);
+		nbytes = min(walk->entrylen,
+			     (unsigned int)(PAGE_SIZE - walk->offset));
 		if (nbytes) {
+			walk->entrylen -= nbytes;
 			walk->data += walk->offset;
 			return nbytes;
 		}
@@ -116,7 +116,7 @@ int crypto_hash_walk_done(struct crypto_
 	if (err)
 		return err;
 
-	if (nbytes) {
+	if (walk->entrylen) {
 		walk->offset = 0;
 		walk->pg++;
 		return hash_walk_next(walk);


