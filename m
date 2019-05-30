Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF255C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8377223FC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188751;
	bh=JcgCuUVI0KmRJ06DvIXV4qPc+VcdQWGfunt/RgHyQ7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14H/y8y8OdFKUnGLbNrwH0k6P1Dy+WftWkyGC65VMAbtaM8MJuRKdJvDciwj2ViXc
	 5T9un8niEfXj9ytDCFbKoKMzNdmRLrsAx7kJuj/7wbUBxzLLdpIIOtY6Uypyaop7md
	 2eZU8J90lAGh4ZO6ayuJSTom53zjlOQETNIbqxbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbfE3D7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbfE3DSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:39 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35BD62474D;
        Thu, 30 May 2019 03:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186319;
        bh=JcgCuUVI0KmRJ06DvIXV4qPc+VcdQWGfunt/RgHyQ7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKn9cpX5KnRqaovSwX8fA8YzvpQt7i28ue1AMTl8Nb/Z3kbfTeUvks2N+ReMG5NWR
         l0+arjrKucNRyHWOEDTcpMl2dDML1c6NIv4FvxzV8flf+bF/9siUpeMipsNR05a4qx
         hu43oj8s4W4AdyLniTzjdwdtvaFktIrnUUA/gcD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Axtens <dja@axtens.net>,
        Nayna Jain <nayna@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 008/193] crypto: vmx - CTR: always increment IV as quadword
Date:   Wed, 29 May 2019 20:04:22 -0700
Message-Id: <20190530030448.316614404@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
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
@@ -1318,7 +1318,7 @@ Loop_ctr32_enc:
 	addi		$idx,$idx,16
 	bdnz		Loop_ctr32_enc
 
-	vadduwm		$ivec,$ivec,$one
+	vadduqm		$ivec,$ivec,$one
 	 vmr		$dat,$inptail
 	 lvx		$inptail,0,$inp
 	 addi		$inp,$inp,16


