Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E072070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258146;
	bh=LbscsWWkapzn5gVSCGhKs/TBeT5BCDK7mRgYUhxzmT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lx6+FT31ALw2rJbXcvI4i7T5Itm4ieA0fjc8NZNyjMX0ixw94yDhTv6B7dJi9IFZv
	 Xdi4BWbMvJPFFatBasnxLUCTSe4skQsCtb9diBxuy/Hec622VDMrTqKXsCQkWiyQF0
	 IOooncTt5ybLVL+L+NwDYvyuG1/ugzr7tJYZj3Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbfCVMMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733150AbfCVMMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073E621929;
        Fri, 22 Mar 2019 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256719;
        bh=LbscsWWkapzn5gVSCGhKs/TBeT5BCDK7mRgYUhxzmT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVgMjgxSTsrw/eRDNt7ivWVFIbiyw3RKADDndK/tM5unwtqG4hnXIYDQCAwpmkFbx
         RgoOdA6mDd0S/UgsJZmEMCJMvUe9jdfWIJlPSKxtRWCeeUyoYQIzHA5TcCj4exTmac
         zy/AKJpLURRbMtGGKPlF1fnH7DxfLFnYagkK7QOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 017/238] crypto: ccree - unmap buffer before copying IV
Date:   Fri, 22 Mar 2019 12:13:56 +0100
Message-Id: <20190322111259.200760885@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit c139c72e2beb3e3db5148910b3962b7322e24374 upstream.

We were copying the last ciphertext block into the IV field
for CBC before removing the DMA mapping of the output buffer
with the result of the buffer sometime being out-of-sync cache
wise and were getting intermittent cases of bad output IV.

Fix it by moving the DMA buffer unmapping before the copy.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Fixes: 00904aa0cd59 ("crypto: ccree - fix iv handling")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_cipher.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -653,6 +653,8 @@ static void cc_cipher_complete(struct de
 	unsigned int ivsize = crypto_skcipher_ivsize(sk_tfm);
 	unsigned int len;
 
+	cc_unmap_cipher_request(dev, req_ctx, ivsize, src, dst);
+
 	switch (ctx_p->cipher_mode) {
 	case DRV_CIPHER_CBC:
 		/*
@@ -682,7 +684,6 @@ static void cc_cipher_complete(struct de
 		break;
 	}
 
-	cc_unmap_cipher_request(dev, req_ctx, ivsize, src, dst);
 	kzfree(req_ctx->iv);
 
 	skcipher_request_complete(req, err);


