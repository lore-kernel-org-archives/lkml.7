Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F88C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C46922C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033463;
	bh=UAT+q+C9fLF2gVA8Wem4B9ofZ2A4vYpfQrcX8dNgek8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bn8od7n3TiJkhtpJ2X/SlOhSxJ1A06jU8zYAM3CuIlbA70Y2DipWRXT6E+kPgfPbQ
	 4DhOsISyBLkTe/n3lraO0i9HuRfcPdVRUEq/mlM5XYkTiYA4myBGO5b8biISEPYSoI
	 lNkYacL68U3BOySYbErjN0/v/iJnHFF5XQuQiT4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbfGYFoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391211AbfGYFoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:44:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F45422C7C;
        Thu, 25 Jul 2019 05:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033455;
        bh=UAT+q+C9fLF2gVA8Wem4B9ofZ2A4vYpfQrcX8dNgek8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysH16oFQbV+tSK00d66Fp1ilm2bIgStQo3cxghWmdhuC9PViq9QjGhWS8PBccni8W
         rSpYDYjesmQKJPM6lqeUWAX5wYcy3Yyf6psYqA+sKOUgMx6QnLc5vXT+Kr1JiG1Ha4
         +bktepOEbRD9Bue/sqB1hEBq3SBugtjSD9y+KiCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elena Petrova <lenaptr@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 174/271] crypto: arm64/sha1-ce - correct digest for empty data in finup
Date:   Wed, 24 Jul 2019 21:20:43 +0200
Message-Id: <20190724191710.091478547@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elena Petrova <lenaptr@google.com>

commit 1d4aaf16defa86d2665ae7db0259d6cb07e2091f upstream.

The sha1-ce finup implementation for ARM64 produces wrong digest
for empty input (len=0). Expected: da39a3ee..., result: 67452301...
(initial value of SHA internal state). The error is in sha1_ce_finup:
for empty data `finalize` will be 1, so the code is relying on
sha1_ce_transform to make the final round. However, in
sha1_base_do_update, the block function will not be called when
len == 0.

Fix it by setting finalize to 0 if data is empty.

Fixes: 07eb54d306f4 ("crypto: arm64/sha1-ce - move SHA-1 ARMv8 implementation to base layer")
Cc: stable@vger.kernel.org
Signed-off-by: Elena Petrova <lenaptr@google.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/crypto/sha1-ce-glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/crypto/sha1-ce-glue.c
+++ b/arch/arm64/crypto/sha1-ce-glue.c
@@ -54,7 +54,7 @@ static int sha1_ce_finup(struct shash_de
 			 unsigned int len, u8 *out)
 {
 	struct sha1_ce_state *sctx = shash_desc_ctx(desc);
-	bool finalize = !sctx->sst.count && !(len % SHA1_BLOCK_SIZE);
+	bool finalize = !sctx->sst.count && !(len % SHA1_BLOCK_SIZE) && len;
 
 	if (!may_use_simd())
 		return crypto_sha1_finup(desc, data, len, out);


