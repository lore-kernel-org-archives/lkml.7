Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862EEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0F2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199853;
	bh=k/xVOyM0I0xVwuzQ+tzfU7zBmoYP57drWfdquu2hkQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x1UrBh+ADet5X+DktgwBQAfqqjewj/EbwR39ble2XfrMo64JD0yxXPy5vXHVdSQIe
	 jwupaRVu24ibsUBzlcCK/5iTwHBtUYrWraCrcO1PYPhpUTm4Cn4ZTSiDX7zF7Ava9R
	 f2aQLm9U4zVAwkO7uv0/OnfjTmaOV0tEEnFAqCoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbfGOOKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731456AbfGOOKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:10:48 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E9C21530;
        Mon, 15 Jul 2019 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199847;
        bh=k/xVOyM0I0xVwuzQ+tzfU7zBmoYP57drWfdquu2hkQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nffz52FeHCmmZEGJUmVn0BkjZPjMYKYtb+VPNwgo8H8cZ9H8GzTU6syt+k8BJHKWm
         0E2y70V4gsTkWK6XsH0RhTIN8ezJAvkv6tqZgVbMnxfqmya86lfSNUvnInMaEdlw0R
         zw58VP2bqHWmLEqf2vv8xF4yfFn/D9w8yddI3Sng=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 124/219] ipsec: select crypto ciphers for xfrm_algo
Date:   Mon, 15 Jul 2019 10:02:05 -0400
Message-Id: <20190715140341.6443-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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

