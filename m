Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C29C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFA522ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998099;
	bh=YeaONwwOYtzz3Ca9+yCTMwQL28bim9Ud+LLFomi6VwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zi+6z9KNdT4LSe6/TA85NMsCjtX850NY6zhen5IHffAJqSFt0Fg/P55Vl1QvQEYTB
	 Pba/k6DuJi7qqiZhmQRvnnjPIbCXtECz7YGNEmxgRnKR4y62B+rmGTHWdn1Ix8KSDc
	 qBEB3/jnsGUNSs4b47o1ES9dCitsvgFDuBXzvIPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404470AbfGXTy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404459AbfGXTyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:54:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC8722BEB;
        Wed, 24 Jul 2019 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998094;
        bh=YeaONwwOYtzz3Ca9+yCTMwQL28bim9Ud+LLFomi6VwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgYN1UCE3jhu+LAdZgzsJhi6fDiFceLVJYR9Pfsz5stY4ik7Xiu2/yEKlxNIvAez9
         XbysdCirn0gHarEHjyzHm2Rr1JsmAv+XLSi/22y8vHaxSNPZYd+70oGZCQXoEbsX51
         oWu00O7r7zCCPCxzxobV5FE8vzPHRVg0+L2cBHPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elena Petrova <lenaptr@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.1 243/371] crypto: arm64/sha2-ce - correct digest for empty data in finup
Date:   Wed, 24 Jul 2019 21:19:55 +0200
Message-Id: <20190724191742.966959652@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elena Petrova <lenaptr@google.com>

commit 6bd934de1e393466b319d29c4427598fda096c57 upstream.

The sha256-ce finup implementation for ARM64 produces wrong digest
for empty input (len=0). Expected: the actual digest, result: initial
value of SHA internal state. The error is in sha256_ce_finup:
for empty data `finalize` will be 1, so the code is relying on
sha2_ce_transform to make the final round. However, in
sha256_base_do_update, the block function will not be called when
len == 0.

Fix it by setting finalize to 0 if data is empty.

Fixes: 03802f6a80b3a ("crypto: arm64/sha2-ce - move SHA-224/256 ARMv8 implementation to base layer")
Cc: stable@vger.kernel.org
Signed-off-by: Elena Petrova <lenaptr@google.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/crypto/sha2-ce-glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ b/arch/arm64/crypto/sha2-ce-glue.c
@@ -59,7 +59,7 @@ static int sha256_ce_finup(struct shash_
 			   unsigned int len, u8 *out)
 {
 	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
-	bool finalize = !sctx->sst.count && !(len % SHA256_BLOCK_SIZE);
+	bool finalize = !sctx->sst.count && !(len % SHA256_BLOCK_SIZE) && len;
 
 	if (!may_use_simd()) {
 		if (len)


