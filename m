Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1827C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05482192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255565;
	bh=QnTdNJVIejZyVq9oWjBSTnvx7zO3eSm9n3n7P3lCSJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yM2HdQepc2X8fuh648Wi2KuWd/It4tO3maibZerhYcyq8xArQm+zWLKY9CBOaIVig
	 cDq2jEPrVEmihtaS9ES1qCn062ogLktEmF8JaxPSwN7VMV2YMtssufKSmeqDlCe/Sg
	 tDBghYDEenAFZTKgqXwkyY0il90Oq56yWi9JbKRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbfCVLwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732707AbfCVLwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:52:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8432082C;
        Fri, 22 Mar 2019 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255562;
        bh=QnTdNJVIejZyVq9oWjBSTnvx7zO3eSm9n3n7P3lCSJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghBPSQew/okc2PjkylURgW4pG2o7MzuYyFpOauFeeEl8fX0kZbe4OOtbwzGU9cg6e
         7RGWOGkM2nw1wIDn/zEcjmwby0b4SqysAEINiLC75BS7Jnlki6quAaNzX6inL4iJGi
         e1UtfowpBcDQYlsCu3nhXDCZ/ACawu9XvRInf6ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 129/183] crypto: arm64/aes-neonbs - fix returning final keystream block
Date:   Fri, 22 Mar 2019 12:15:57 +0100
Message-Id: <20190322111251.086915402@linuxfoundation.org>
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

commit 12455e320e19e9cc7ad97f4ab89c280fe297387c upstream.

The arm64 NEON bit-sliced implementation of AES-CTR fails the improved
skcipher tests because it sometimes produces the wrong ciphertext.  The
bug is that the final keystream block isn't returned from the assembly
code when the number of non-final blocks is zero.  This can happen if
the input data ends a few bytes after a page boundary.  In this case the
last bytes get "encrypted" by XOR'ing them with uninitialized memory.

Fix the assembly code to return the final keystream block when needed.

Fixes: 88a3f582bea9 ("crypto: arm64/aes - don't use IV buffer to return final keystream block")
Cc: <stable@vger.kernel.org> # v4.11+
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/crypto/aes-neonbs-core.S |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/arm64/crypto/aes-neonbs-core.S
+++ b/arch/arm64/crypto/aes-neonbs-core.S
@@ -940,7 +940,7 @@ CPU_LE(	rev		x8, x8		)
 8:	next_ctr	v0
 	cbnz		x4, 99b
 
-0:	st1		{v0.16b}, [x5]
+	st1		{v0.16b}, [x5]
 	ldp		x29, x30, [sp], #16
 	ret
 
@@ -948,6 +948,9 @@ CPU_LE(	rev		x8, x8		)
 	 * If we are handling the tail of the input (x6 != NULL), return the
 	 * final keystream block back to the caller.
 	 */
+0:	cbz		x6, 8b
+	st1		{v0.16b}, [x6]
+	b		8b
 1:	cbz		x6, 8b
 	st1		{v1.16b}, [x6]
 	b		8b


