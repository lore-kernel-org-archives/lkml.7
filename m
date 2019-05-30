Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC53C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A443B24825
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186345;
	bh=JiKLfGdF1GBvxS/NHn/yixWD70lJRE3tN76wzctWgYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0hCdiQ8Tj5FbrBjJ/2GrRGwymtTafjGhZos2ReYHr/29Bnuls9MnHqdweFj8DOstV
	 mB3PuqR7CHJSvLtklcftzb3TCpWvl1Z+f0+bYu9jrJlMD5Pgtj1nMPAqNdX3geXxi7
	 ik+vqx0rdNSYQM50jaHGVrdMR3hYRt67ZBDhCJaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfE3DTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbfE3DPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:06 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7BD824598;
        Thu, 30 May 2019 03:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186105;
        bh=JiKLfGdF1GBvxS/NHn/yixWD70lJRE3tN76wzctWgYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXPuWqiLtD2+4wv5fZErVOiJNosnlYFCF1kjzFUR3PsPRgzxnkyUc07rr/rrzbO4p
         e/OICiSLn61AA3zDNpyM2oH9usTTqBlR5L2gHZnH0KDrLL7PS3ueeMIUcHWOACsqUf
         uJKqBxMmi3nvC+FVxQXly0nWGJfLMjWO/Fd8ztsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 246/346] sh: sh7786: Add explicit I/O cast to sh7786_mm_sel()
Date:   Wed, 29 May 2019 20:05:19 -0700
Message-Id: <20190530030553.484917608@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8440bb9b944c02222c7a840d406141ed42e945cd ]

When compile-testing on arm:

    arch/sh/include/cpu-sh4/cpu/sh7786.h: In function ‘sh7786_mm_sel’:
    arch/sh/include/cpu-sh4/cpu/sh7786.h:135:21: warning: passing argument 1 of ‘__raw_readl’ makes pointer from integer without a cast [-Wint-conversion]
      return __raw_readl(0xFC400020) & 0x7;
			 ^~~~~~~~~~
    In file included from include/linux/io.h:25:0,
		     from arch/sh/include/cpu-sh4/cpu/sh7786.h:14,
		     from drivers/pinctrl/sh-pfc/pfc-sh7786.c:15:
    arch/arm/include/asm/io.h:113:21: note: expected ‘const volatile void *’ but argument is of type ‘unsigned int’
     #define __raw_readl __raw_readl
			 ^
    arch/arm/include/asm/io.h:114:19: note: in expansion of macro ‘__raw_readl’
     static inline u32 __raw_readl(const volatile void __iomem *addr)
		       ^~~~~~~~~~~

__raw_readl() on SuperH is a macro that casts the passed I/O address to
the correct type, while the implementations on most other architectures
expect to be passed the correct pointer type.

Add an explicit cast to fix this.

Note that this also gets rid of a sparse warning on SuperH:

    arch/sh/include/cpu-sh4/cpu/sh7786.h:135:16: warning: incorrect type in argument 1 (different base types)
    arch/sh/include/cpu-sh4/cpu/sh7786.h:135:16:    expected void const volatile [noderef] <asn:2>*<noident>
    arch/sh/include/cpu-sh4/cpu/sh7786.h:135:16:    got unsigned int

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/include/cpu-sh4/cpu/sh7786.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7786.h b/arch/sh/include/cpu-sh4/cpu/sh7786.h
index 8f9bfbf3cdb10..d6cce65b48713 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7786.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7786.h
@@ -132,7 +132,7 @@ enum {
 
 static inline u32 sh7786_mm_sel(void)
 {
-	return __raw_readl(0xFC400020) & 0x7;
+	return __raw_readl((const volatile void __iomem *)0xFC400020) & 0x7;
 }
 
 #endif /* __CPU_SH7786_H__ */
-- 
2.20.1



