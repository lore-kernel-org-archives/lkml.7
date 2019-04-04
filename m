Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3515CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EE3217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368112;
	bh=sz7D2RuVjYEuADJKuWRC4j3xdxLaF99Ao7zLCMFUzTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NztxOhxyo2IdXxkxMJic+OdJPTOVRFavypsW3rPHpdXx3/04qwEbYG7ENJ1AVcmBY
	 gwJ/3mcpE2TPf3vN7MzBRFA3GDet37hrIuJn3pQiLwtbm6+4rbaZ97T7eTrzht/tkY
	 S0DC5L87dEFfs/PYrJ7Pf1eMFb6YDwK/OBzW2K8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfDDIzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730213AbfDDIzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9FC2171F;
        Thu,  4 Apr 2019 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368105;
        bh=sz7D2RuVjYEuADJKuWRC4j3xdxLaF99Ao7zLCMFUzTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAB155EPuKrPvoihTxScJTc5/bazpbWP/yYZDXaRydZJOALRouiiiSdksJ6P8AjZa
         eVeirEKoscwNnY3cHEBU6QezhbViTjeNYtBezjzlKbIulMF5hKiYkaLM0G9ifYWlxu
         jr+mi5D5HWs5pYkLg8HrJoPEpDx/sbQwvewTTS5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mahipal Challa <mahipalreddy2006@gmail.com>,
        Jan Glauber <jglauber@cavium.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 039/121] crypto: cavium/zip - fix collision with generic cra_driver_name
Date:   Thu,  4 Apr 2019 10:47:07 +0200
Message-Id: <20190404084547.426357179@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

[ Upstream commit 41798036430015ad45137db2d4c213cd77fd0251 ]

The cavium/zip implementation of the deflate compression algorithm is
incorrectly being registered under the generic driver name, which
prevents the generic implementation from being registered with the
crypto API when CONFIG_CRYPTO_DEV_CAVIUM_ZIP=y.  Similarly the lzs
algorithm (which does not currently have a generic implementation...)
is incorrectly being registered as lzs-generic.

Fix the naming collision by adding a suffix "-cavium" to the
cra_driver_name of the cavium/zip algorithms.

Fixes: 640035a2dc55 ("crypto: zip - Add ThunderX ZIP driver core")
Cc: Mahipal Challa <mahipalreddy2006@gmail.com>
Cc: Jan Glauber <jglauber@cavium.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/cavium/zip/zip_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/zip/zip_main.c b/drivers/crypto/cavium/zip/zip_main.c
index 1cd8aa488185..a6425a7afa7b 100644
--- a/drivers/crypto/cavium/zip/zip_main.c
+++ b/drivers/crypto/cavium/zip/zip_main.c
@@ -351,6 +351,7 @@ static struct pci_driver zip_driver = {
 
 static struct crypto_alg zip_comp_deflate = {
 	.cra_name		= "deflate",
+	.cra_driver_name	= "deflate-cavium",
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
 	.cra_ctxsize		= sizeof(struct zip_kernel_ctx),
 	.cra_priority           = 300,
@@ -365,6 +366,7 @@ static struct crypto_alg zip_comp_deflate = {
 
 static struct crypto_alg zip_comp_lzs = {
 	.cra_name		= "lzs",
+	.cra_driver_name	= "lzs-cavium",
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
 	.cra_ctxsize		= sizeof(struct zip_kernel_ctx),
 	.cra_priority           = 300,
@@ -384,7 +386,7 @@ static struct scomp_alg zip_scomp_deflate = {
 	.decompress		= zip_scomp_decompress,
 	.base			= {
 		.cra_name		= "deflate",
-		.cra_driver_name	= "deflate-scomp",
+		.cra_driver_name	= "deflate-scomp-cavium",
 		.cra_module		= THIS_MODULE,
 		.cra_priority           = 300,
 	}
@@ -397,7 +399,7 @@ static struct scomp_alg zip_scomp_lzs = {
 	.decompress		= zip_scomp_decompress,
 	.base			= {
 		.cra_name		= "lzs",
-		.cra_driver_name	= "lzs-scomp",
+		.cra_driver_name	= "lzs-scomp-cavium",
 		.cra_module		= THIS_MODULE,
 		.cra_priority           = 300,
 	}
-- 
2.19.1



