Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877DEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561F12154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888151;
	bh=SWAWfJzmUKIYI5K513r05IPRQy5xw/PP18Nyx4gvL2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHB65RRHAK/P8z3pPVf/edmTAf9flI83O86NDIiy1KL1uvI3trbu3GsS7amcz0QuV
	 twSi5pEt99KoVcmaivK/NoxExquK6gDxDSGQ0x1XSMCWiXfdSa3JXM64hG0OHmLs86
	 rcEnKCLYbNMSECetCXauj+fiCo75qvVNsRMRhjiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfK0Uzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbfK0Uzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:55:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B442154A;
        Wed, 27 Nov 2019 20:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888147;
        bh=SWAWfJzmUKIYI5K513r05IPRQy5xw/PP18Nyx4gvL2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdxutCGDrWol8MkXPyYtXmnAKMRUSCPSTnvBJQNjPlZ62Ywv3TBqkCfJN3h1rEFY7
         QEGYf7H0XgawhIUxqcDg1tjIDEBKC63rpvnSXXkbymuEmOUVoAxgbsjpDrQnhKQSCI
         OL4GZh9CfHGaMhxaEpszFeGfyUcAA2TKrsGTtv/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schupikov <michael@schupikov.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 023/306] crypto: testmgr - fix sizeof() on COMP_BUF_SIZE
Date:   Wed, 27 Nov 2019 21:27:53 +0100
Message-Id: <20191127203116.384045764@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Schupikov <michael@schupikov.de>

[ Upstream commit 22a8118d329334833cd30f2ceb36d28e8cae8a4f ]

After allocation, output and decomp_output both point to memory chunks of
size COMP_BUF_SIZE. Then, only the first bytes are zeroed out using
sizeof(COMP_BUF_SIZE) as parameter to memset(), because
sizeof(COMP_BUF_SIZE) provides the size of the constant and not the size of
allocated memory.

Instead, the whole allocated memory is meant to be zeroed out. Use
COMP_BUF_SIZE as parameter to memset() directly in order to accomplish
this.

Fixes: 336073840a872 ("crypto: testmgr - Allow different compression results")

Signed-off-by: Michael Schupikov <michael@schupikov.de>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/testmgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 3664c26f4838e..13cb2ea99d6a5 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -1400,8 +1400,8 @@ static int test_comp(struct crypto_comp *tfm,
 		int ilen;
 		unsigned int dlen = COMP_BUF_SIZE;
 
-		memset(output, 0, sizeof(COMP_BUF_SIZE));
-		memset(decomp_output, 0, sizeof(COMP_BUF_SIZE));
+		memset(output, 0, COMP_BUF_SIZE);
+		memset(decomp_output, 0, COMP_BUF_SIZE);
 
 		ilen = ctemplate[i].inlen;
 		ret = crypto_comp_compress(tfm, ctemplate[i].input,
@@ -1445,7 +1445,7 @@ static int test_comp(struct crypto_comp *tfm,
 		int ilen;
 		unsigned int dlen = COMP_BUF_SIZE;
 
-		memset(decomp_output, 0, sizeof(COMP_BUF_SIZE));
+		memset(decomp_output, 0, COMP_BUF_SIZE);
 
 		ilen = dtemplate[i].inlen;
 		ret = crypto_comp_decompress(tfm, dtemplate[i].input,
-- 
2.20.1



