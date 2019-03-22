Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFBCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDC92070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258079;
	bh=zPYD99z93EwdlKO/Dp5menfrQKWc6lMz+R1YQBC9gBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pr9irmHQkbrdjXVOZgOv7VQ1nTtl7qBnT4ZZUMO3N6JT5CKF+1VaU4GC3sU4UtfNZ
	 8SzEzyfSzNSlTqkUofFSWQefz564L8qb4liKyN0Lws0PM7gISvZBxz2GUiGAky6WjK
	 avHGkJ9F7uvbbEHeabYTq+gPIQaQoltuEN7MQ7eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbfCVMei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389206AbfCVMNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76F720830;
        Fri, 22 Mar 2019 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256796;
        bh=zPYD99z93EwdlKO/Dp5menfrQKWc6lMz+R1YQBC9gBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfYyKd2mHHGNfGml+bsMkTOHyjXfmFKWhv3kmc7KINWmKh4Tfclqx784sHryOQHS3
         IiPuAeEviHVocZTO0qj5QAuXAMFi6gWaotLct7MJZGjs/k3Ye98W2+f0Qq58C8hW1O
         BFyPQedZ/2jxCHjv46wZZXtHGHHUAo7r8K2EWSI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 039/238] crypto: arm64/aes-neonbs - fix returning final keystream block
Date:   Fri, 22 Mar 2019 12:14:18 +0100
Message-Id: <20190322111300.687588385@linuxfoundation.org>
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
 arch/arm64/crypto/aes-neonbs-core.S |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/arm64/crypto/aes-neonbs-core.S
+++ b/arch/arm64/crypto/aes-neonbs-core.S
@@ -971,18 +971,22 @@ CPU_LE(	rev		x8, x8		)
 
 8:	next_ctr	v0
 	st1		{v0.16b}, [x24]
-	cbz		x23, 0f
+	cbz		x23, .Lctr_done
 
 	cond_yield_neon	98b
 	b		99b
 
-0:	frame_pop
+.Lctr_done:
+	frame_pop
 	ret
 
 	/*
 	 * If we are handling the tail of the input (x6 != NULL), return the
 	 * final keystream block back to the caller.
 	 */
+0:	cbz		x25, 8b
+	st1		{v0.16b}, [x25]
+	b		8b
 1:	cbz		x25, 8b
 	st1		{v1.16b}, [x25]
 	b		8b


