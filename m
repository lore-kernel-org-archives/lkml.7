Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4281C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E9E22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077014;
	bh=wytKeplqK/AKhB4cIpXTYLqEbmNYTJ0B2BTWnB98EBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YoYbxhsCW/FCRyh+sqVOhMzEFCuonThqpL03zTMluLX+2BH/kGszppRohkXVnkH7o
	 ItRb7rjt2+FeYPCJH3693qSR6fUzlJ+VDbrvm4Qi1pQixasgwjFF878blPncVCzCji
	 8c85Q0md5ZNcRl+aUIxeeX65an7yf6mTXVnRxZFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfLKPKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730700AbfLKPKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:10:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6381F22B48;
        Wed, 11 Dec 2019 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077008;
        bh=wytKeplqK/AKhB4cIpXTYLqEbmNYTJ0B2BTWnB98EBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uY5bbTU7YC4c7zUYgF+8vtS3C4wEb4/XZdg1zZsy4M65WUtqeCixty0KGrefioE9E
         vy6fmlmzM4Y62SsPeQfsu6BtLU1io3PAQClIIk7b3rTNKars3pLFcHiN3MvVCutMcK
         7UDc/2ZU0JysScYJc+/kecgGJ+HhB045IjhF5ScM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 73/92] crypto: ecdh - fix big endian bug in ECC library
Date:   Wed, 11 Dec 2019 16:06:04 +0100
Message-Id: <20191211150257.641511332@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
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
@@ -1284,10 +1284,11 @@ EXPORT_SYMBOL(ecc_point_mult_shamir);
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


