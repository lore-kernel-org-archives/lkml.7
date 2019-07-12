Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDB8C742BB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E83208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934357;
	bh=N+Y9qxi6MPnG3VpMI98wdfm1lWSTyn7eeINjyhf+uY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gtXd8RNv3GLDHPklK8K9BPaWyq1Eb6I8JCURi6SWAraxkVbbe+/uLmnHobiQfkwq2
	 6XqKmEXD5oY8YthF0rx0Gve5IN208QuL5C/MhFAEon6XNKL/jMoo6T/bbRpX0C9hAB
	 2uZYQANnuJCmQbMGUS1lNXZga1TELbIWjooUWC3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfGLMZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbfGLMZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:25:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B562084B;
        Fri, 12 Jul 2019 12:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934350;
        bh=N+Y9qxi6MPnG3VpMI98wdfm1lWSTyn7eeINjyhf+uY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkM+7JRYu/MpXwC2S14eOcHmt1dbMKl7/fPzwZposhLVgRRTKzWWDvosGOde3R1WS
         RS5hhaqtOybxdBF44tmLqSI2yuUmtMLhUQBMiCMcEAPPnwITFLeBsAsN+vylLNj4WF
         Axdn8tMkiECpLDwt0L2oAtsjLdklJG+3le0XJab0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.1 003/138] crypto: talitos - rename alternative AEAD algos.
Date:   Fri, 12 Jul 2019 14:17:47 +0200
Message-Id: <20190712121628.865516968@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit a1a42f84011fae6ff08441a91aefeb7febc984fc upstream.

The talitos driver has two ways to perform AEAD depending on the
HW capability. Some HW support both. It is needed to give them
different names to distingish which one it is for instance when
a test fails.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 7405c8d7ff97 ("crypto: talitos - templates for AEAD using HMAC_SNOOP_NO_AFEU")
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2299,7 +2299,7 @@ static struct talitos_alg_template drive
 			.base = {
 				.cra_name = "authenc(hmac(sha1),cbc(aes))",
 				.cra_driver_name = "authenc-hmac-sha1-"
-						   "cbc-aes-talitos",
+						   "cbc-aes-talitos-hsna",
 				.cra_blocksize = AES_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_ASYNC,
 			},
@@ -2343,7 +2343,7 @@ static struct talitos_alg_template drive
 				.cra_name = "authenc(hmac(sha1),"
 					    "cbc(des3_ede))",
 				.cra_driver_name = "authenc-hmac-sha1-"
-						   "cbc-3des-talitos",
+						   "cbc-3des-talitos-hsna",
 				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_ASYNC,
 			},
@@ -2385,7 +2385,7 @@ static struct talitos_alg_template drive
 			.base = {
 				.cra_name = "authenc(hmac(sha224),cbc(aes))",
 				.cra_driver_name = "authenc-hmac-sha224-"
-						   "cbc-aes-talitos",
+						   "cbc-aes-talitos-hsna",
 				.cra_blocksize = AES_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_ASYNC,
 			},
@@ -2429,7 +2429,7 @@ static struct talitos_alg_template drive
 				.cra_name = "authenc(hmac(sha224),"
 					    "cbc(des3_ede))",
 				.cra_driver_name = "authenc-hmac-sha224-"
-						   "cbc-3des-talitos",
+						   "cbc-3des-talitos-hsna",
 				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_ASYNC,
 			},
@@ -2471,7 +2471,7 @@ static struct talitos_alg_template drive
 			.base = {
 				.cra_name = "authenc(hmac(sha256),cbc(aes))",
 				.cra_driver_name = "authenc-hmac-sha256-"
-						   "cbc-aes-talitos",
+						   "cbc-aes-talitos-hsna",
 				.cra_blocksize = AES_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_ASYNC,
 			},
@@ -2515,7 +2515,7 @@ static struct talitos_alg_template drive
 				.cra_name = "authenc(hmac(sha256),"
 					    "cbc(des3_ede))",
 				.cra_driver_name = "authenc-hmac-sha256-"
-						   "cbc-3des-talitos",
+						   "cbc-3des-talitos-hsna",
 				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_ASYNC,
 			},
@@ -2641,7 +2641,7 @@ static struct talitos_alg_template drive
 			.base = {
 				.cra_name = "authenc(hmac(md5),cbc(aes))",
 				.cra_driver_name = "authenc-hmac-md5-"
-						   "cbc-aes-talitos",
+						   "cbc-aes-talitos-hsna",
 				.cra_blocksize = AES_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_ASYNC,
 			},
@@ -2683,7 +2683,7 @@ static struct talitos_alg_template drive
 			.base = {
 				.cra_name = "authenc(hmac(md5),cbc(des3_ede))",
 				.cra_driver_name = "authenc-hmac-md5-"
-						   "cbc-3des-talitos",
+						   "cbc-3des-talitos-hsna",
 				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_ASYNC,
 			},


