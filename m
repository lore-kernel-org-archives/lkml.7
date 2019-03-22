Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92B820850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255414;
	bh=foEC0qubLHMRy4OwNaYm9PUGpzCS43PkmOBS1b/3jAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYABYkEe9T5v0BzE/vaR+7ndIBg1+0ESwJq+XcXDOx4Ezf7VG8iFdAtPuLD7YfY4t
	 OcMqnkdENWRMHwDjpKlqU94C7qz1tO4vJdWegW/cpvLEWoHp5zGFGNfe/C5JmWXpFw
	 Xu/hJG070TQ0q6O4CTQQLw0hHLEnTiXTPiJIsoTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbfCVLuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732330AbfCVLuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9297F20850;
        Fri, 22 Mar 2019 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255409;
        bh=foEC0qubLHMRy4OwNaYm9PUGpzCS43PkmOBS1b/3jAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tgq5o5km+rA+lDQjR53Jw/1QCB4MNWZYq8RViTeN6u6QcN6mcjTCbiZxMjy8z24Xm
         NoWToxqPSroW2WUC+zLXZ0+kI0ExGBumUMuRx2b2RXrcLnapW9v8DSfXvJ0rDISO5t
         wIDCOLSztss02ZhrkquYZ0bFIHrZlQEeM+D6POmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 074/183] crypto: arm64/crct10dif - revert to C code for short inputs
Date:   Fri, 22 Mar 2019 12:15:02 +0100
Message-Id: <20190322111247.098040254@linuxfoundation.org>
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
@@ -36,26 +36,13 @@ static int crct10dif_update(struct shash
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


