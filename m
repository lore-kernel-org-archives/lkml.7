Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DE2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5A42067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564740317;
	bh=LAmkjEwhid63sirkScRRXNDpcozyqShGeB5vrWUB9zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RzW5ID7wkl2E88lL6BsR7HjuZyTMwq+6XIx/QP61JPoJDMoRFL0GuNA6CtYFcCX8l
	 K24OPDrKBM57+Q+EEh09POoP1e/Mt3of+HZOE7uLPdo54aca0aaPAmFUn1bCIdLu3L
	 9dMLLT5xaMjMTRGtwsiWwN1RkC9RDne+GLNuo5NE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391284AbfHBJcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391265AbfHBJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:32:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4F721773;
        Fri,  2 Aug 2019 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738359;
        bh=LAmkjEwhid63sirkScRRXNDpcozyqShGeB5vrWUB9zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAB89I3FL60Got6OHMOZ2ykMydHYHYYYx/fZzhAPeYCMU6Ly1YlSJp/S6ENsNafH4
         7tsTNA6NqQ442GfUqanq61vst0qiCg1+Ycb33ttD8s08Dk9QKuiQBbf0EL9KWwJhKT
         M4lUWoyJylu0951BR/4e89UVkuvH6WoOXk6bCjSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elena Petrova <lenaptr@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 056/158] crypto: arm64/sha1-ce - correct digest for empty data in finup
Date:   Fri,  2 Aug 2019 11:27:57 +0200
Message-Id: <20190802092215.428821019@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
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
@@ -50,7 +50,7 @@ static int sha1_ce_finup(struct shash_de
 			 unsigned int len, u8 *out)
 {
 	struct sha1_ce_state *sctx = shash_desc_ctx(desc);
-	bool finalize = !sctx->sst.count && !(len % SHA1_BLOCK_SIZE);
+	bool finalize = !sctx->sst.count && !(len % SHA1_BLOCK_SIZE) && len;
 
 	/*
 	 * Allow the asm code to perform the finalization if there is no


