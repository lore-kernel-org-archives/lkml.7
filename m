Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CA0229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996689;
	bh=CsWXcgn08I4mWMWGsG8L3PA7QZFTJ2l3Vf4NjxU9boE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GqmcaYRnBR0R2bF2aiv+uwatl7hNjUJ/MZVvEvXTGSGCWH9LQk4mkw+Z0ZBVpXT4v
	 4JfFv0NF0dzN7a2VQy+jT6FxDLvN4Hm87LWQgp5VwSL8i2+HUAiQ23/vxOa5qtFBVP
	 fnH/T+Ua51Ct091ry22SDd9+l6qoTm4qmq1VVxsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfGXTb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388468AbfGXTbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:31:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8CE229F4;
        Wed, 24 Jul 2019 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996680;
        bh=CsWXcgn08I4mWMWGsG8L3PA7QZFTJ2l3Vf4NjxU9boE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2JaDDMlD+1d34fLH8CuryzvcFvjMO19PqPYIBw4Zs8b7XKw8qSNvUG5GvOm876/S
         1ycLGxA7QNECMEzZLlYYCGvo+oM839QcoI5S/7PM5wW0z9+DvlasOE6rPdfqN4KH2/
         wMNaGj6QDRF5sxJs+zapYW8q74SI+kAhAPsVdGgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 181/413] crypto: asymmetric_keys - select CRYPTO_HASH where needed
Date:   Wed, 24 Jul 2019 21:17:52 +0200
Message-Id: <20190724191747.763814357@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 90acc0653d2bee203174e66d519fbaaa513502de ]

Build testing with some core crypto options disabled revealed
a few modules that are missing CRYPTO_HASH:

crypto/asymmetric_keys/x509_public_key.o: In function `x509_get_sig_params':
x509_public_key.c:(.text+0x4c7): undefined reference to `crypto_alloc_shash'
x509_public_key.c:(.text+0x5e5): undefined reference to `crypto_shash_digest'
crypto/asymmetric_keys/pkcs7_verify.o: In function `pkcs7_digest.isra.0':
pkcs7_verify.c:(.text+0xab): undefined reference to `crypto_alloc_shash'
pkcs7_verify.c:(.text+0x1b2): undefined reference to `crypto_shash_digest'
pkcs7_verify.c:(.text+0x3c1): undefined reference to `crypto_shash_update'
pkcs7_verify.c:(.text+0x411): undefined reference to `crypto_shash_finup'

This normally doesn't show up in randconfig tests because there is
a large number of other options that select CRYPTO_HASH.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/asymmetric_keys/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index be70ca6c85d3..1f1f004dc757 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -15,6 +15,7 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select MPILIB
 	select CRYPTO_HASH_INFO
 	select CRYPTO_AKCIPHER
+	select CRYPTO_HASH
 	help
 	  This option provides support for asymmetric public key type handling.
 	  If signature generation and/or verification are to be used,
@@ -65,6 +66,7 @@ config TPM_KEY_PARSER
 config PKCS7_MESSAGE_PARSER
 	tristate "PKCS#7 message parser"
 	depends on X509_CERTIFICATE_PARSER
+	select CRYPTO_HASH
 	select ASN1
 	select OID_REGISTRY
 	help
@@ -87,6 +89,7 @@ config SIGNED_PE_FILE_VERIFICATION
 	bool "Support for PE file signature verification"
 	depends on PKCS7_MESSAGE_PARSER=y
 	depends on SYSTEM_DATA_VERIFICATION
+	select CRYPTO_HASH
 	select ASN1
 	select OID_REGISTRY
 	help
-- 
2.20.1



