Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E401C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5182E21924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787722;
	bh=p+3m82tliaje6PacOgqeA/tyzrSNM4L/3dsVSIpEtfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D9DjDDu8p30jRk2f4CGuFlfEgW4rnFlG8fheaY3MIg+RJk7xYjHF2OnnkVzTIkSuA
	 jMPgRsSV6MxfjWvVT4rEszACf4HvOqJkI1t7tqEOJYqkDkNbRUpgLiFMaC8ov0EeD3
	 S1ph9hggKuGDqdfAAXC4X9KW633ANHGdOQoUgnVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfIRGWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbfIRGV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:21:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4FF21906;
        Wed, 18 Sep 2019 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787718;
        bh=p+3m82tliaje6PacOgqeA/tyzrSNM4L/3dsVSIpEtfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYWf6mj2MAvu7+rrx4XOgLabcGHLZcZOx2g85xQpy1czanABS4U0gJjZp7rL3KGQy
         E0xv78MbE7zTiS06o0Bmit/R4xTloWOV0bM1iMNLymmfWfv/f9d5z3BdZsNfbjlJcG
         vq1YzKmORCTtxaH21KqMCneVdq93uphaoRvhV2KE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 37/45] crypto: talitos - fix ECB algs ivsize
Date:   Wed, 18 Sep 2019 08:19:15 +0200
Message-Id: <20190918061227.361127776@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit d84cc9c9524ec5973a337533e6d8ccd3e5f05f2b upstream.

ECB's ivsize must be 0.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 5e75ae1b3cef ("crypto: talitos - add new crypto modes")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2666,7 +2666,6 @@ static struct talitos_alg_template drive
 			.cra_ablkcipher = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
-				.ivsize = AES_BLOCK_SIZE,
 				.setkey = ablkcipher_aes_setkey,
 			}
 		},


