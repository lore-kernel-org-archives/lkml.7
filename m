Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A84C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003D0205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258052;
	bh=ZSwrl96Xr1v4YYwi0F0JgY/WI1NJ4Qc+BK4q12KfaXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mdiDx5BmzNL4sOXeMJjWIvFXM/T2m1pM+oa8zT9MfQxiK0lv9hpp4exIOM4KO/QCS
	 IAtMu4y0UTxPCzGSQuZymuw7ktEzfRDukMJNHxyVaH2nfi8WTjhTSb9dQmkjw/YzXc
	 j2+p2DoJU++csULrFqwNl3ztFt82jMJPizGib9Fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbfCVMeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389491AbfCVMN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC0E2082C;
        Fri, 22 Mar 2019 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256835;
        bh=ZSwrl96Xr1v4YYwi0F0JgY/WI1NJ4Qc+BK4q12KfaXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXImdiKIXh76zS3gGCzQLQdkubQATnZ5oHS+qrN7h/BdzAtiOT2/VvssiXCWG1LRh
         Khs+67o4SJ7/TkBb+CDcZLKy+qbC2zhjABEIqHXLEhkQ1J1OPiJoKZYo0wFPdWDzZ6
         /4aVOOhs4rfP0Fvzwrie8flX+n8rPocsE5niYqYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 050/238] crypto: arm64/aes-ccm - fix bugs in non-NEON fallback routine
Date:   Fri, 22 Mar 2019 12:14:29 +0100
Message-Id: <20190322111301.369581443@linuxfoundation.org>
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
@@ -125,7 +125,7 @@ static void ccm_update_mac(struct crypto
 			abytes -= added;
 		}
 
-		while (abytes > AES_BLOCK_SIZE) {
+		while (abytes >= AES_BLOCK_SIZE) {
 			__aes_arm64_encrypt(key->key_enc, mac, mac,
 					    num_rounds(key));
 			crypto_xor(mac, in, AES_BLOCK_SIZE);
@@ -139,8 +139,6 @@ static void ccm_update_mac(struct crypto
 					    num_rounds(key));
 			crypto_xor(mac, in, abytes);
 			*macp = abytes;
-		} else {
-			*macp = 0;
 		}
 	}
 }


