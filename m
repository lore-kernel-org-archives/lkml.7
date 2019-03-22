Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDA221929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256829;
	bh=EqN/8/BF3SsGsjsRXt687FABJk6KB7L6Echr03Vfjw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j2fdChuYgSBNhjpzGJJfivTjmsvEjMjfzK+VLlc1KcxW/G2wzfnGoIDz4PGENLGjr
	 Zd54pZWJE3jy+X3VIJ4f1Nt09PVZwsPnxNmixvJzIrcbEy4Kuy8A22GAWGruGnlvOY
	 CO6kugZwSq6U+iZmVMhxyl2Ew26xnHzgmnijpQHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbfCVMNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389803AbfCVMNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AEF62082C;
        Fri, 22 Mar 2019 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256822;
        bh=EqN/8/BF3SsGsjsRXt687FABJk6KB7L6Echr03Vfjw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7ISbMMwqw2/rszcouDafbhUSh5t6jHiVzxYCW3glKGePkV6S+KN6HguXfSAA8JjV
         GpgIjG/BhJm+uc2Fz7ZAoszrOIIDeXm7VktFL9d/i7gmFY8DdSHJL5Ol0TWs1+ji2o
         UuEoLcad+8pVzejZWHOKcAPjV+IR0YG7sZbXyIF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 047/238] crypto: x86/aesni-gcm - fix crash on empty plaintext
Date:   Fri, 22 Mar 2019 12:14:26 +0100
Message-Id: <20190322111301.176081980@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit 3af349639597fea582a93604734d717e59a0e223 upstream.

gcmaes_crypt_by_sg() dereferences the NULL pointer returned by
scatterwalk_ffwd() when encrypting an empty plaintext and the source
scatterlist ends immediately after the associated data.

Fix it by only fast-forwarding to the src/dst data scatterlists if the
data length is nonzero.

This bug is reproduced by the "rfc4543(gcm(aes))" test vectors when run
with the new AEAD test manager.

Fixes: e845520707f8 ("crypto: aesni - Update aesni-intel_glue to use scatter/gather")
Cc: <stable@vger.kernel.org> # v4.17+
Cc: Dave Watson <davejwatson@fb.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -821,11 +821,14 @@ static int gcmaes_crypt_by_sg(bool enc,
 		scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
 	}
 
-	src_sg = scatterwalk_ffwd(src_start, req->src, req->assoclen);
-	scatterwalk_start(&src_sg_walk, src_sg);
-	if (req->src != req->dst) {
-		dst_sg = scatterwalk_ffwd(dst_start, req->dst, req->assoclen);
-		scatterwalk_start(&dst_sg_walk, dst_sg);
+	if (left) {
+		src_sg = scatterwalk_ffwd(src_start, req->src, req->assoclen);
+		scatterwalk_start(&src_sg_walk, src_sg);
+		if (req->src != req->dst) {
+			dst_sg = scatterwalk_ffwd(dst_start, req->dst,
+						  req->assoclen);
+			scatterwalk_start(&dst_sg_walk, dst_sg);
+		}
 	}
 
 	kernel_fpu_begin();


