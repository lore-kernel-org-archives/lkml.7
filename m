Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01D8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07B121971
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256211;
	bh=QbvNhy8Ej3o/CvzZ4WzmYdmiQJ0Rx7RPSEEQJZ08JTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=syyXWj9ycwCOf3r11NTuh8lB+cNcdUJJ4gI3hQTJVTfoVVudRPEwcNaXHue8pkxLX
	 LzzIoTbzs9maB2c+W0cMbOZaaqBdr+6Qu2sTGnL/9ioeS97RL4c10ltmQaRHdASuA5
	 XEB9cCNT1A1bDlP0BL67NW5BYjOCyW4jvws+TRKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbfCVMDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388006AbfCVMD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:03:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEAB2192D;
        Fri, 22 Mar 2019 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256205;
        bh=QbvNhy8Ej3o/CvzZ4WzmYdmiQJ0Rx7RPSEEQJZ08JTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJXGWPT6mlWlx26XvEfCGY0jYPWhV7JRdR+qasCTzuaoiA4/OEasIih2kXrS/3MFl
         rtrPkR6iCbtr9HQBuwaZPK4qAVioEAl4hJDnNBdf/Ga+N+NU+n3LYavfQabNUM4BD2
         7n2y19d2cgcZ6JhNdXvK7YrnKxZhWjGVnpQ2GTUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 122/280] crypto: aead - set CRYPTO_TFM_NEED_KEY if ->setkey() fails
Date:   Fri, 22 Mar 2019 12:14:35 +0100
Message-Id: <20190322111315.233781299@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 6ebc97006b196aafa9df0497fdfa866cf26f259b upstream.

Some algorithms have a ->setkey() method that is not atomic, in the
sense that setting a key can fail after changes were already made to the
tfm context.  In this case, if a key was already set the tfm can end up
in a state that corresponds to neither the old key nor the new key.

For example, in gcm.c, if the kzalloc() fails due to lack of memory,
then the CTR part of GCM will have the new key but GHASH will not.

It's not feasible to make all ->setkey() methods atomic, especially ones
that have to key multiple sub-tfms.  Therefore, make the crypto API set
CRYPTO_TFM_NEED_KEY if ->setkey() fails, to prevent the tfm from being
used until a new key is set.

[Cc stable mainly because when introducing the NEED_KEY flag I changed
 AF_ALG to rely on it; and unlike in-kernel crypto API users, AF_ALG
 previously didn't have this problem.  So these "incompletely keyed"
 states became theoretically accessible via AF_ALG -- though, the
 opportunities for causing real mischief seem pretty limited.]

Fixes: dc26c17f743a ("crypto: aead - prevent using AEADs without setting key")
Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/aead.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -61,8 +61,10 @@ int crypto_aead_setkey(struct crypto_aea
 	else
 		err = crypto_aead_alg(tfm)->setkey(tfm, key, keylen);
 
-	if (err)
+	if (unlikely(err)) {
+		crypto_aead_set_flags(tfm, CRYPTO_TFM_NEED_KEY);
 		return err;
+	}
 
 	crypto_aead_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
 	return 0;


