Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B5BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D0424472
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185768;
	bh=t6bx2D04IYoytuycVZr10En/w9fgx4z/f8hlVwcsreI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XROSbjL57hPsInNyjvsH5+TnX80rnLI8fGWnvpyMBBq1y+ohrao/fN3BHy9Ug0Ue/
	 gfdeLtzR6msi0X0sARNeKvz4OodLvkRNGZisiSR/htZFRnUzx/pLS2SI8XbyQ4Kexr
	 47H7Pv29Zh6wicyLSZcQnuUTRUy+gD8IeI+ZPNbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfE3DJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbfE3DJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:24 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B6124471;
        Thu, 30 May 2019 03:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185764;
        bh=t6bx2D04IYoytuycVZr10En/w9fgx4z/f8hlVwcsreI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=va1uZtzJJjt9IuJT9jE41sY+AZPYSRT8YYXzNbpfshAYixb/+pWwVAt2YA+es5126
         0mVUhxfwNaoO7aYAZVK7iXr4M0Lz/vY28FoGqZ7aHPAK5BwSxJxksyyOBqUztHXk+S
         BB+MDCVX+o1QcgX8iEdc401ibrh80zwXDyCRNTRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Axtens <dja@axtens.net>,
        Nayna Jain <nayna@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.1 010/405] crypto: vmx - CTR: always increment IV as quadword
Date:   Wed, 29 May 2019 20:00:08 -0700
Message-Id: <20190530030540.936691473@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Axtens <dja@axtens.net>

commit 009b30ac7444c17fae34c4f435ebce8e8e2b3250 upstream.

The kernel self-tests picked up an issue with CTR mode:
alg: skcipher: p8_aes_ctr encryption test failed (wrong result) on test vector 3, cfg="uneven misaligned splits, may sleep"

Test vector 3 has an IV of FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD, so
after 3 increments it should wrap around to 0.

In the aesp8-ppc code from OpenSSL, there are two paths that
increment IVs: the bulk (8 at a time) path, and the individual
path which is used when there are fewer than 8 AES blocks to
process.

In the bulk path, the IV is incremented with vadduqm: "Vector
Add Unsigned Quadword Modulo", which does 128-bit addition.

In the individual path, however, the IV is incremented with
vadduwm: "Vector Add Unsigned Word Modulo", which instead
does 4 32-bit additions. Thus the IV would instead become
FFFFFFFFFFFFFFFFFFFFFFFF00000000, throwing off the result.

Use vadduqm.

This was probably a typo originally, what with q and w being
adjacent. It is a pretty narrow edge case: I am really
impressed by the quality of the kernel self-tests!

Fixes: 5c380d623ed3 ("crypto: vmx - Add support for VMS instructions by ASM")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Axtens <dja@axtens.net>
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/vmx/aesp8-ppc.pl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/vmx/aesp8-ppc.pl
+++ b/drivers/crypto/vmx/aesp8-ppc.pl
@@ -1357,7 +1357,7 @@ Loop_ctr32_enc:
 	addi		$idx,$idx,16
 	bdnz		Loop_ctr32_enc
 
-	vadduwm		$ivec,$ivec,$one
+	vadduqm		$ivec,$ivec,$one
 	 vmr		$dat,$inptail
 	 lvx		$inptail,0,$inp
 	 addi		$inp,$inp,16


