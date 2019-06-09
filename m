Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFBDC2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4631206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099385;
	bh=/zs1kV0ZRxtxgbKMD18C+JsRrw20wJO0yHWqfbX8Exw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ViCaMdVCB5sgWVPmx7RcV0NCRTPwT18WwumqVMAcMc0hu1kQA/OZUKhqqgWr9qi08
	 lJeXyk6inaLxO3vuQ19cmtacfC77H1+Ivvw9BzqKI/w13Z5FuAVArV0h+6OawMPNU9
	 Zj9ySBgzQdsjLy2kM7bSttBTBs8aXkgxL740GrUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbfFIQ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732956AbfFIQ4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:56:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E86C206DF;
        Sun,  9 Jun 2019 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099379;
        bh=/zs1kV0ZRxtxgbKMD18C+JsRrw20wJO0yHWqfbX8Exw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkjDLzKUfSPDMDZCoZgBLwoD0RNk/4X0Y8ephJ22ArHs9GuzfpTTPgJcIGmFS2UfM
         prLnxGMjlXlgXS9LkTbs88fHx/5W7Umfn8PJ1qfz4WU992TCW/fZlrQ3iWTOfZc6XB
         UKXZ7n52NHmG/xNSCwF8NuknusOHx6cU9InhrCvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.4 022/241] crypto: gcm - Fix error return code in crypto_gcm_create_common()
Date:   Sun,  9 Jun 2019 18:39:24 +0200
Message-Id: <20190609164148.422696674@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 9b40f79c08e81234d759f188b233980d7e81df6c upstream.

Fix to return error code -EINVAL from the invalid alg ivsize error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/gcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/gcm.c
+++ b/crypto/gcm.c
@@ -670,11 +670,11 @@ static int crypto_gcm_create_common(stru
 	ctr = crypto_skcipher_spawn_alg(&ctx->ctr);
 
 	/* We only support 16-byte blocks. */
+	err = -EINVAL;
 	if (ctr->cra_ablkcipher.ivsize != 16)
 		goto out_put_ctr;
 
 	/* Not a stream cipher? */
-	err = -EINVAL;
 	if (ctr->cra_blocksize != 1)
 		goto out_put_ctr;
 


