Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0454214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997870;
	bh=ndzLM6M8u3qe2hiuEhJuqUhrKW/gwDN8XSWkEotxou4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yHzFXzFhzJjVZM2DlpHJ8OaCMhhbm9c8qg8MT6ssE9ghqeRpBPP23pBwnu4CHKEZm
	 gUEAPGF/8YarvdBcmuiwzqWVXHoGKmjWtUVIFeao5vYMuEsKyjgju+ec67JIazMwPI
	 XgDv9BaysBS5S39ob85qVri8iVoVIVhY4xhdbyfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391614AbfGXTvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391040AbfGXTvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:51:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBDAD21873;
        Wed, 24 Jul 2019 19:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997860;
        bh=ndzLM6M8u3qe2hiuEhJuqUhrKW/gwDN8XSWkEotxou4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Tg8sD/JKgws53fiIQC+X5CnPh6G/H5/fngSyCjRrBM052+3LbhhlIj4ROHuGdpYB
         FTzGcbx2lQZYB1Aqfs7Ljm2PMeOcnnk7iiFTCo8cDYsB0viEK5OXU4HHntHnoshipG
         joLx8zTISTPFyu7gfrPSk3FaoRhACmWl+BmXj7R0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 126/371] ipsec: select crypto ciphers for xfrm_algo
Date:   Wed, 24 Jul 2019 21:17:58 +0200
Message-Id: <20190724191734.360978628@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
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
index 5d43aaa17027..831668ee8229 100644
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



