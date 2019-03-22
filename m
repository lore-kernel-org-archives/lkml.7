Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627721929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256729;
	bh=jIImtb19x6wdiJJzDnn77niy0v4N6aOnTJ29y0YOIWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eoAODitVLPVCgUC5/6JRVER1Q94gBwHD3ZfCsKkKedA7NYgr+xqoaxpS3LM/HSumI
	 wb0BARHlZESSnbeTLoXNIP/d8tHzbCmtGWP1OteBwBeZ4Ccc35n7WVxtQ/Nz9TUPm2
	 husUDMS2aO0AUD/xHQxPuqlA5GIRlQU8G1MEBzF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbfCVMMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388968AbfCVMMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE74220830;
        Fri, 22 Mar 2019 12:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256723;
        bh=jIImtb19x6wdiJJzDnn77niy0v4N6aOnTJ29y0YOIWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qh3QGcoCG6Q3HpIImrhxeOHVKkIB2HNkzcU2wOA8Rfd70L+/Lqh46WTMmr9gCLlQu
         diiDlyKS5XLl6b+ZVC8eXPzOIoyiBvk79jBc9t+fAUoMc5Ex7xeIy6u+w92FR3l9O/
         ob8Sdiy6xH2aoMM0hOpGxEtbfhz1p3w8phuq581Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 018/238] crypto: ccree - dont copy zero size ciphertext
Date:   Fri, 22 Mar 2019 12:13:57 +0100
Message-Id: <20190322111259.245385243@linuxfoundation.org>
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

commit 2b5ac17463dcb2411fed506edcf259a89bb538ba upstream.

For decryption in CBC mode we need to save the last ciphertext block
for use as the next IV. However, we were trying to do this also with
zero sized ciphertext resulting in a panic.

Fix this by only doing the copy if the ciphertext length is at least
of IV size.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_cipher.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -801,7 +801,8 @@ static int cc_cipher_decrypt(struct skci
 
 	memset(req_ctx, 0, sizeof(*req_ctx));
 
-	if (ctx_p->cipher_mode == DRV_CIPHER_CBC) {
+	if ((ctx_p->cipher_mode == DRV_CIPHER_CBC) &&
+	    (req->cryptlen >= ivsize)) {
 
 		/* Allocate and save the last IV sized bytes of the source,
 		 * which will be lost in case of in-place decryption.


