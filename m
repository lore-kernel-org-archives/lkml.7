Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C98C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7AA206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519082;
	bh=2e8/UuLvJLNecZgC8ChFnpt7Ilo18ui9cPMWigdrHKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nCMy4a+mbgSIHhcYElxmJ0RMB5Fh/INjCM8hnEZE2BROvuBRkC5hwNIaoVLTsoc6G
	 31A5Xg24MFTZuM4WgsZCU9aMRXIUC+GGfI6ExCVf70SwGirhrnbVLhLKXixa92Ag6X
	 jd4mXloyrjybLB/zZ7fMaDfD2P6jiH/oE6+5E4rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfLPR6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbfLPR56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:57:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED18E205ED;
        Mon, 16 Dec 2019 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519078;
        bh=2e8/UuLvJLNecZgC8ChFnpt7Ilo18ui9cPMWigdrHKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHwyUURrJdSHNvH+nij4hUT84zieEIwCVNiS48B5zMh36TXXjIFq928SJ1Qr8CmgA
         nMl1ySgXR6+8UIPZ0GdGmc2axFVroS5+YzvmNWYp3NwJAGOI0aL1YXU5ex4mSH6uvE
         Y/x63fUzJ+iBp5RNDc/p+pDxAW1oeSZcJW56+ros=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 146/267] crypto: ecdh - fix big endian bug in ECC library
Date:   Mon, 16 Dec 2019 18:47:52 +0100
Message-Id: <20191216174910.473333138@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit f398243e9fd6a3a059c1ea7b380c40628dbf0c61 upstream.

The elliptic curve arithmetic library used by the EC-DH KPP implementation
assumes big endian byte order, and unconditionally reverses the byte
and word order of multi-limb quantities. On big endian systems, the byte
reordering is not necessary, while the word ordering needs to be retained.

So replace the __swab64() invocation with a call to be64_to_cpu() which
should do the right thing for both little and big endian builds.

Fixes: 3c4b23901a0c ("crypto: ecdh - Add ECDH software support")
Cc: <stable@vger.kernel.org> # v4.9+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ecc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -898,10 +898,11 @@ static void ecc_point_mult(struct ecc_po
 static inline void ecc_swap_digits(const u64 *in, u64 *out,
 				   unsigned int ndigits)
 {
+	const __be64 *src = (__force __be64 *)in;
 	int i;
 
 	for (i = 0; i < ndigits; i++)
-		out[i] = __swab64(in[ndigits - 1 - i]);
+		out[i] = be64_to_cpu(src[ndigits - 1 - i]);
 }
 
 static int __ecc_is_key_valid(const struct ecc_curve *curve,


