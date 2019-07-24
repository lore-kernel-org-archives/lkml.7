Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B68121841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998793;
	bh=2M4ooQivExEbMVUwtjPGPDaINoKmziMxiUP6jwkKcOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q0yo6XB8+idsB0a4qJmv2uEGVzarpxtwyLOIseLC3rs5p9FkKIc2SLonF10e7EvAq
	 oYw5AS5ugOwOsrSJ1FJDEfaPRj+fMt+k7mvE6YW9IavPI7vAFrh5twtbPZQxhpxGMl
	 8Yz6Gvb0Uwo91GwAR9Wgog0A4U0P+/ou06OFRoTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405682AbfGXUF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392654AbfGXUFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:05:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E862147A;
        Wed, 24 Jul 2019 20:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998723;
        bh=2M4ooQivExEbMVUwtjPGPDaINoKmziMxiUP6jwkKcOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztwa3oDn7vOMiKzgO8LLSwIHYc13SgBlPawT8GqzzzrUTLKMXbuinkV7PDTMbOyez
         AXy2uwEV1Lrij9/vuss0n+8UvXvjhKszg9dS168wiXRL3rVKaBDsr/+ZZu3/07k0FB
         K5ROfT1RkeH9rTAyW2DMd86yT7+Cy3XaPcB3ay8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/271] ipsec: select crypto ciphers for xfrm_algo
Date:   Wed, 24 Jul 2019 21:19:21 +0200
Message-Id: <20190724191703.113780617@linuxfoundation.org>
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

[ Upstream commit 597179b0ba550bd83fab1a9d57c42a9343c58514 ]

kernelci.org reports failed builds on arc because of what looks
like an old missed 'select' statement:

net/xfrm/xfrm_algo.o: In function `xfrm_probe_algs':
xfrm_algo.c:(.text+0x1e8): undefined reference to `crypto_has_ahash'

I don't see this in randconfig builds on other architectures, but
it's fairly clear we want to select the hash code for it, like we
do for all its other users. As Herbert points out, CRYPTO_BLKCIPHER
is also required even though it has not popped up in build tests.

Fixes: 17bc19702221 ("ipsec: Use skcipher and ahash when probing algorithms")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 4a9ee2d83158..372c91faa283 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -14,6 +14,8 @@ config XFRM_ALGO
 	tristate
 	select XFRM
 	select CRYPTO
+	select CRYPTO_HASH
+	select CRYPTO_BLKCIPHER
 
 config XFRM_USER
 	tristate "Transformation user configuration interface"
-- 
2.20.1



