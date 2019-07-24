Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40543C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C0022BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033341;
	bh=l9gRyO9IidlNojMDzg1+eyqr6O5J4ZzI0DHcDuMu6wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5vTYXJASJbz4sZhpTBbl/KI+6hYtXLH5h+14gQDgy+tbrngTO3+da1+mrPL6gA9v
	 vPu9FgU4KojA4EbFV4tQBQR3k8OAa+n2TOYPgqTe1QxCuU/UDMCAsqfNCaUmB+qghB
	 TbF/gsk3PtMtudXLnshGchdQtdYXZ2rVrJ8PisVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbfGYFmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390802AbfGYFmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:42:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2A222BEB;
        Thu, 25 Jul 2019 05:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033336;
        bh=l9gRyO9IidlNojMDzg1+eyqr6O5J4ZzI0DHcDuMu6wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gM8/Yf2o7PnG46GYpj2W2tA7SeppZZkK0Uqe3Hixx2Jc580w5XyqB4qV/stpPloWJ
         k+qhFUx3FFjuMCAuHDX5XGMRmenbxj+ErO2Bl9pCZ1EYwYA18bTQuJCqYrNZm3XklB
         eAoIXVPShZBOmuhAcUcuNmb0Hh5MgnOC/mcVag8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 121/271] crypto: asymmetric_keys - select CRYPTO_HASH where needed
Date:   Wed, 24 Jul 2019 21:19:50 +0200
Message-Id: <20190724191705.645389360@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
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
index f3702e533ff4..d8a73d94bb30 100644
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
@@ -34,6 +35,7 @@ config X509_CERTIFICATE_PARSER
 config PKCS7_MESSAGE_PARSER
 	tristate "PKCS#7 message parser"
 	depends on X509_CERTIFICATE_PARSER
+	select CRYPTO_HASH
 	select ASN1
 	select OID_REGISTRY
 	help
@@ -56,6 +58,7 @@ config SIGNED_PE_FILE_VERIFICATION
 	bool "Support for PE file signature verification"
 	depends on PKCS7_MESSAGE_PARSER=y
 	depends on SYSTEM_DATA_VERIFICATION
+	select CRYPTO_HASH
 	select ASN1
 	select OID_REGISTRY
 	help
-- 
2.20.1



