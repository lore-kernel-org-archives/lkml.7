Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FA9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1995E217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931560;
	bh=p+3m82tliaje6PacOgqeA/tyzrSNM4L/3dsVSIpEtfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hBP+Dcxj++iA54H5AafI/8/o9JrGwYsz1cqQ9B9ZqNGLRxre8pDBX3xYGPL7qrMVm
	 SW32UaB/dcg4CeErAv44iA9+PzfUex/DDVTCifBPEujZp+AIwlT4X61ms1po2dU9ir
	 zKmYmIWWEj90NVr3GZ93hI9lP+MwX/dJfPg8QYSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406641AbfISWTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392452AbfISWTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:19:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19690217D6;
        Thu, 19 Sep 2019 22:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931556;
        bh=p+3m82tliaje6PacOgqeA/tyzrSNM4L/3dsVSIpEtfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hfw4A2jfw8tFmr52b2gm1tu8shl9cYr2y7O8OK4AfiB75XN6/Bwlw209CMQwZpAfY
         mf11Nr9bOkJDCj1/LTU3g2YCf4TdTRXo7Ro9E3vy6weBgsUjbmJAL/1q1a3DuBN2FR
         kMHSGULV6+0zfIhhXsLfmqnK6PCxx3NxYsNvN6H8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 29/74] crypto: talitos - fix ECB algs ivsize
Date:   Fri, 20 Sep 2019 00:03:42 +0200
Message-Id: <20190919214807.728469404@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
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


