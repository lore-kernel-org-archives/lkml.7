Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEBEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6B421655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429968;
	bh=Jl3ktDhtDoytYpouuDYTsZkHQpDwAh/XYv9EgjJON4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=030Zw8pjvG9K7/ZvJRgocLt9APkX0bIQ9alaYSDl8xdJ8j112j1VSFOpx9cqpAMKI
	 bzPP8789Mpo+5fmJpQB9oQyiT091LG3sOCxf9vyMTT53Exc7l88cziIVxYleExQK60
	 s1IhyhYvADPnehUHgcod+fP4hS85BCOp8shJZcOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403941AbfG2Twq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403920AbfG2Twj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F7621655;
        Mon, 29 Jul 2019 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429958;
        bh=Jl3ktDhtDoytYpouuDYTsZkHQpDwAh/XYv9EgjJON4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjyZfYzUDhONEVX8Mc1xkQ06hVCKYBfEJRHXJzxev7t7Ac3+TwLSa95agGyEdqoZH
         pCiUmdz1Q4EBybK+t0nj3c3Y1UK3ac33mLpHDV0T6t+di1lbrAmxuUfGXcpCWYH7Zw
         sxttMG3QFNvZZj5PZPwip0M2eRQYVoSlcQL49yy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 149/215] sh: prevent warnings when using iounmap
Date:   Mon, 29 Jul 2019 21:22:25 +0200
Message-Id: <20190729190805.570775656@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 733f0025f0fb43e382b84db0930ae502099b7e62 ]

When building drm/exynos for sh, as part of an allmodconfig build, the
following warning triggered:

  exynos7_drm_decon.c: In function `decon_remove':
  exynos7_drm_decon.c:769:24: warning: unused variable `ctx'
    struct decon_context *ctx = dev_get_drvdata(&pdev->dev);

The ctx variable is only used as argument to iounmap().

In sh - allmodconfig CONFIG_MMU is not defined
so it ended up in:

\#define __iounmap(addr)	do { } while (0)
\#define iounmap		__iounmap

Fix the warning by introducing a static inline function for iounmap.

This is similar to several other architectures.

Link: http://lkml.kernel.org/r/20190622114208.24427-1-sam@ravnborg.org
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/include/asm/io.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index c28e37a344ad..ac0561960c52 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -369,7 +369,11 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 
 #define ioremap_nocache	ioremap
 #define ioremap_uc	ioremap
-#define iounmap		__iounmap
+
+static inline void iounmap(void __iomem *addr)
+{
+	__iounmap(addr);
+}
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
-- 
2.20.1



