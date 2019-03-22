Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CB52192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256803;
	bh=5ijW2TygqGamYHO6y/LTo4KgIc0uUKs31b3gskNQB20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sIPSvrozULI/UPpI+G6Ypv/jLy5p9eOISSfhudGblw47VP49eWzT/TmDo0ufoOlk8
	 0pdJpmQIg/KmB5/aerm4fXUvPQNVLwThUPCM4AOklAnAxqZvKDx+0pNmUMV9OjkSuT
	 kQ8w9eBuoaMcF/7M934FxADqtGBol0L/+0OIJl44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbfCVMNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389446AbfCVMNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A07E2082C;
        Fri, 22 Mar 2019 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256798;
        bh=5ijW2TygqGamYHO6y/LTo4KgIc0uUKs31b3gskNQB20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDcUbYYp6EHaEgM9j/DqtgsSbyz3YS229uWVeg4aMX1zKkVYC5OKniqk6lsH5uPz3
         sSA0nX02nxmSH8/aUDZBI7Fg98kstZqWn2wcHQyiFBRmSgg8+oTJhc/9T4sv3bDyaC
         8SVQnsy4VXJjG+2Giilt6d4mMOBuNN639FERCWn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 040/238] crypto: arm64/crct10dif - revert to C code for short inputs
Date:   Fri, 22 Mar 2019 12:14:19 +0100
Message-Id: <20190322111300.751457459@linuxfoundation.org>
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit d72b9d4acd548251f55b16843fc7a05dc5c80de8 upstream.

The SIMD routine ported from x86 used to have a special code path
for inputs < 16 bytes, which got lost somewhere along the way.
Instead, the current glue code aligns the input pointer to 16 bytes,
which is not really necessary on this architecture (although it
could be beneficial to performance to expose aligned data to the
the NEON routine), but this could result in inputs of less than
16 bytes to be passed in. This not only fails the new extended
tests that Eric has implemented, it also results in the code
reading past the end of the input, which could potentially result
in crashes when dealing with less than 16 bytes of input at the
end of a page which is followed by an unmapped page.

So update the glue code to only invoke the NEON routine if the
input is at least 16 bytes.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 6ef5737f3931 ("crypto: arm64/crct10dif - port x86 SSE implementation to arm64")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/crypto/crct10dif-ce-glue.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ b/arch/arm64/crypto/crct10dif-ce-glue.c
@@ -39,26 +39,13 @@ static int crct10dif_update(struct shash
 			    unsigned int length)
 {
 	u16 *crc = shash_desc_ctx(desc);
-	unsigned int l;
 
-	if (unlikely((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
-		l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
-			  ((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
-
-		*crc = crc_t10dif_generic(*crc, data, l);
-
-		length -= l;
-		data += l;
-	}
-
-	if (length > 0) {
-		if (may_use_simd()) {
-			kernel_neon_begin();
-			*crc = crc_t10dif_pmull(*crc, data, length);
-			kernel_neon_end();
-		} else {
-			*crc = crc_t10dif_generic(*crc, data, length);
-		}
+	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
+		kernel_neon_begin();
+		*crc = crc_t10dif_pmull(*crc, data, length);
+		kernel_neon_end();
+	} else {
+		*crc = crc_t10dif_generic(*crc, data, length);
 	}
 
 	return 0;


