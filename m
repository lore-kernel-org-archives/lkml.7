Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1119DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5759213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354648;
	bh=SJ3bvGNHGX5MTf8QAP45iUrPWgiuSOwtd791qLhdx14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oYfqOOMhS5nVThPSuOJ80kKsixVzWkUOM+FfDQ3hjVY5/dBwQUTNbKPoibK4/n92q
	 s2UVp+AtwFJ6SI6DhsTatwpQXSbcj16JxxhtoQf+SiacAUwHBURhGbTv3s6gXArphp
	 YAYZL7iyHi6ph2Lt1nIJccuRKs4SpKe7Dv67DE7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfETMR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387523AbfETMR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:17:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E1920815;
        Mon, 20 May 2019 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354645;
        bh=SJ3bvGNHGX5MTf8QAP45iUrPWgiuSOwtd791qLhdx14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gy6HOmiLUgPH3WsM/dnjDNx2RpSLXAs/NRq183hLfNH4pTyhI4OLntcGLHsBiWG/B
         zPeGyB0jhGnp8RhH7mxYQFgyKI2cY7LwKmaZXkjS8bkd/Wxrj+DvpZDgkvtSOon5k3
         LwvRlf3ogMI8D+GSZh9QQ/pEn3qZVfihM7kevmOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 36/44] crypto: salsa20 - dont access already-freed walk.iv
Date:   Mon, 20 May 2019 14:14:25 +0200
Message-Id: <20190520115235.316656833@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115230.720347034@linuxfoundation.org>
References: <20190520115230.720347034@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit edaf28e996af69222b2cb40455dbb5459c2b875a upstream.

If the user-provided IV needs to be aligned to the algorithm's
alignmask, then skcipher_walk_virt() copies the IV into a new aligned
buffer walk.iv.  But skcipher_walk_virt() can fail afterwards, and then
if the caller unconditionally accesses walk.iv, it's a use-after-free.

salsa20-generic doesn't set an alignmask, so currently it isn't affected
by this despite unconditionally accessing walk.iv.  However this is more
subtle than desired, and it was actually broken prior to the alignmask
being removed by commit b62b3db76f73 ("crypto: salsa20-generic - cleanup
and convert to skcipher API").

Since salsa20-generic does not update the IV and does not need any IV
alignment, update it to use req->iv instead of walk.iv.

Fixes: 2407d60872dd ("[CRYPTO] salsa20: Salsa20 stream cipher")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 crypto/salsa20_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/salsa20_generic.c
+++ b/crypto/salsa20_generic.c
@@ -186,7 +186,7 @@ static int encrypt(struct blkcipher_desc
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt_block(desc, &walk, 64);
 
-	salsa20_ivsetup(ctx, walk.iv);
+	salsa20_ivsetup(ctx, desc->info);
 
 	while (walk.nbytes >= 64) {
 		salsa20_encrypt_bytes(ctx, walk.dst.virt.addr,


