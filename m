Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DEEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EE42196E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255478;
	bh=SN2BNgOz2GGUoEe6lAsHl09HR2/qNHbB97RaSHLeTwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0y2PeUZg+q49ayo70WsquXQZIRMGCBaK9E3+/F5cGn1iiuN2V4vm5VktpRZDRrkRD
	 FNbq2KOInApCcUkcicAr7X7/5UqUirwerz8HEhyeEncBuyQuEEMPaW5YdKZ9XfKG6x
	 LV6DCfhQWX+2DXHv7c199mxHxq4s6lmadCPZdBl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbfCVLvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbfCVLvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:51:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1EC620850;
        Fri, 22 Mar 2019 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255472;
        bh=SN2BNgOz2GGUoEe6lAsHl09HR2/qNHbB97RaSHLeTwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsSwHnb/LCkcjz51IeyDfD/D6+FnpTMQGTR0sMSvDcmDRL16oU52Uwsr60RrWCenE
         QG6C7hsuSVbHIliK2c3kjBMY+eGxn0sScLn3iR3lmVWAB54orE0aBrMlhH9gcF2S9V
         XPaBIHokaXIBOuiCXutvF+t+RxCRE4sWxP/cn9Zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 073/183] crypto: arm/crct10dif - revert to C code for short inputs
Date:   Fri, 22 Mar 2019 12:15:01 +0100
Message-Id: <20190322111247.018335697@linuxfoundation.org>
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

commit 62fecf295e3c48be1b5f17c440b93875b9adb4d6 upstream.

The SIMD routine ported from x86 used to have a special code path
for inputs < 16 bytes, which got lost somewhere along the way.
Instead, the current glue code aligns the input pointer to permit
the NEON routine to use special versions of the vld1 instructions
that assume 16 byte alignment, but this could result in inputs of
less than 16 bytes to be passed in. This not only fails the new
extended tests that Eric has implemented, it also results in the
code reading past the end of the input, which could potentially
result in crashes when dealing with less than 16 bytes of input
at the end of a page which is followed by an unmapped page.

So update the glue code to only invoke the NEON routine if the
input is at least 16 bytes.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 1d481f1cd892 ("crypto: arm/crct10dif - port x86 SSE implementation to ARM")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/crypto/crct10dif-ce-core.S |   14 +++++++-------
 arch/arm/crypto/crct10dif-ce-glue.c |   23 ++++++-----------------
 2 files changed, 13 insertions(+), 24 deletions(-)

--- a/arch/arm/crypto/crct10dif-ce-core.S
+++ b/arch/arm/crypto/crct10dif-ce-core.S
@@ -124,10 +124,10 @@ ENTRY(crc_t10dif_pmull)
 	vext.8		q10, qzr, q0, #4
 
 	// receive the initial 64B data, xor the initial crc value
-	vld1.64		{q0-q1}, [arg2, :128]!
-	vld1.64		{q2-q3}, [arg2, :128]!
-	vld1.64		{q4-q5}, [arg2, :128]!
-	vld1.64		{q6-q7}, [arg2, :128]!
+	vld1.64		{q0-q1}, [arg2]!
+	vld1.64		{q2-q3}, [arg2]!
+	vld1.64		{q4-q5}, [arg2]!
+	vld1.64		{q6-q7}, [arg2]!
 CPU_LE(	vrev64.8	q0, q0			)
 CPU_LE(	vrev64.8	q1, q1			)
 CPU_LE(	vrev64.8	q2, q2			)
@@ -167,7 +167,7 @@ CPU_LE(	vrev64.8	q7, q7			)
 _fold_64_B_loop:
 
 	.macro		fold64, reg1, reg2
-	vld1.64		{q11-q12}, [arg2, :128]!
+	vld1.64		{q11-q12}, [arg2]!
 
 	vmull.p64	q8, \reg1\()h, d21
 	vmull.p64	\reg1, \reg1\()l, d20
@@ -238,7 +238,7 @@ _16B_reduction_loop:
 	vmull.p64	q7, d15, d21
 	veor.8		q7, q7, q8
 
-	vld1.64		{q0}, [arg2, :128]!
+	vld1.64		{q0}, [arg2]!
 CPU_LE(	vrev64.8	q0, q0		)
 	vswp		d0, d1
 	veor.8		q7, q7, q0
@@ -335,7 +335,7 @@ _less_than_128:
 	vmov.i8		q0, #0
 	vmov		s3, arg1_low32		// get the initial crc value
 
-	vld1.64		{q7}, [arg2, :128]!
+	vld1.64		{q7}, [arg2]!
 CPU_LE(	vrev64.8	q7, q7		)
 	vswp		d14, d15
 	veor.8		q7, q7, q0
--- a/arch/arm/crypto/crct10dif-ce-glue.c
+++ b/arch/arm/crypto/crct10dif-ce-glue.c
@@ -35,26 +35,15 @@ static int crct10dif_update(struct shash
 			    unsigned int length)
 {
 	u16 *crc = shash_desc_ctx(desc);
-	unsigned int l;
 
-	if (!may_use_simd()) {
-		*crc = crc_t10dif_generic(*crc, data, length);
+	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
+		kernel_neon_begin();
+		*crc = crc_t10dif_pmull(*crc, data, length);
+		kernel_neon_end();
 	} else {
-		if (unlikely((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
-			l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
-				  ((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
-
-			*crc = crc_t10dif_generic(*crc, data, l);
-
-			length -= l;
-			data += l;
-		}
-		if (length > 0) {
-			kernel_neon_begin();
-			*crc = crc_t10dif_pmull(*crc, data, length);
-			kernel_neon_end();
-		}
+		*crc = crc_t10dif_generic(*crc, data, length);
 	}
+
 	return 0;
 }
 


