Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09791C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F7A207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412741;
	bh=vy21C2Jmz7+AosFAmvQpCZ90dK5eCzza5DrZjI7Yfqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CybMi5Wtt2R2SVJX1jP2DesTjEskHnu8JDB4cE4DJ6p4IZWkDamfq8Zv/nEhdlTcX
	 vjgAQvP0u7YklRQ52dZrZGsZ2VG5bDx9vVoAMSnanEh1LunM94vb+SOOj4QvueQ82r
	 HzbUNbwllGiKN/h8qHDti5U3hvt3vvtFLjiFMocA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfLCWjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:39:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbfLCWi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:38:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A81320684;
        Tue,  3 Dec 2019 22:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412738;
        bh=vy21C2Jmz7+AosFAmvQpCZ90dK5eCzza5DrZjI7Yfqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qv3Wndyt4FR3mH7F+sjswNJ/5MFnFT7bAsgaM/2M4b7Q/281EfCXxyTdvEZWpEed3
         neOq0Uw5rpnT0EqqFiqNY3Ybw05FXMQud/Wm4r90oROs13In4oYL6RpMy4AhDCcB5k
         15+SkLGKODu0Uy0j2aSSfpNMv1K/b5plrTV67YF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.4 43/46] crypto: talitos - Fix build error by selecting LIB_DES
Date:   Tue,  3 Dec 2019 23:36:03 +0100
Message-Id: <20191203212805.885503932@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

commit dbc2e87bd8b6d3cc79730b3a49c5163b4c386b49 upstream.

The talitos driver needs to select LIB_DES as it needs calls
des_expand_key.

Fixes: 9d574ae8ebc1 ("crypto: talitos/des - switch to new...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -287,6 +287,7 @@ config CRYPTO_DEV_TALITOS
 	select CRYPTO_AUTHENC
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_HASH
+	select CRYPTO_LIB_DES
 	select HW_RANDOM
 	depends on FSL_SOC
 	help


