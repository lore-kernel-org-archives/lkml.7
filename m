Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D976E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255460;
	bh=alaXUz021eVBDPg3/keTevQjU2lkzuy5nHDnkELhemI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TPNY4KYn8FxGpj4Xbl/zMHCxleyIw9DxdPAb2u5ma/XLtM9hndkivLAwQ11VE4Fv1
	 QvTd657LXXzu1iTklUDJNSvEeKW0HUvU9ZSgZmXIyP8hpnsuxqcqfbQd4rl34w1wah
	 8jtgZT91ocNB/vxk7O+EehCidNX0aO3Scb/97dY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbfCVLu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732304AbfCVLu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE1E20693;
        Fri, 22 Mar 2019 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255456;
        bh=alaXUz021eVBDPg3/keTevQjU2lkzuy5nHDnkELhemI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbowCW8RCZChCvpHGFdgAgGqWLhckGGRnonyt1WGZ2RtIIHznkAOz7WHBRaU+EyZM
         CGTU8yX5R8JCoIh2R9s/fPS3lQVHrwxu3qTNlvH4qx2mO8LNC2pN7982bDJGwp5jby
         glrSU0MmP3NcywJRKzEGvjd+lFy+iw8xw6R5cUWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 078/183] crypto: arm64/aes-ccm - fix bugs in non-NEON fallback routine
Date:   Fri, 22 Mar 2019 12:15:06 +0100
Message-Id: <20190322111247.375560800@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 969e2f59d589c15f6aaf306e590dde16f12ea4b3 upstream.

Commit 5092fcf34908 ("crypto: arm64/aes-ce-ccm: add non-SIMD generic
fallback") introduced C fallback code to replace the NEON routines
when invoked from a context where the NEON is not available (i.e.,
from the context of a softirq taken while the NEON is already being
used in kernel process context)

Fix two logical flaws in the MAC calculation of the associated data.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 5092fcf34908 ("crypto: arm64/aes-ce-ccm: add non-SIMD generic fallback")
Cc: stable@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/crypto/aes-ce-ccm-glue.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -123,7 +123,7 @@ static void ccm_update_mac(struct crypto
 			abytes -= added;
 		}
 
-		while (abytes > AES_BLOCK_SIZE) {
+		while (abytes >= AES_BLOCK_SIZE) {
 			__aes_arm64_encrypt(key->key_enc, mac, mac,
 					    num_rounds(key));
 			crypto_xor(mac, in, AES_BLOCK_SIZE);
@@ -137,8 +137,6 @@ static void ccm_update_mac(struct crypto
 					    num_rounds(key));
 			crypto_xor(mac, in, abytes);
 			*macp = abytes;
-		} else {
-			*macp = 0;
 		}
 	}
 }


