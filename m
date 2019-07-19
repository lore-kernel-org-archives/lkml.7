Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFA0C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3226A2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510000;
	bh=uDexvjbjNcUsM9NywNHmASlS28zuNCaffm46xWjs7TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XKHR39CD/0U3xT1qsA7DOg5CxKRy1le5xUgK6oDDTd8IadUrw7Z9wDZ/O/LrGMlar
	 CxrGPP177iPCRDfykDT/2p6jS2Y978YCFIx2imtvUX8IMSxiEK07fe39KMkWy/8k/O
	 +jFkmXIb1C5/+uHLXui3wc07c83jKW3NoQvpHpmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfGSET6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388223AbfGSEMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:12:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6606218D4;
        Fri, 19 Jul 2019 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509571;
        bh=uDexvjbjNcUsM9NywNHmASlS28zuNCaffm46xWjs7TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwqaWFunhKPQ3e0s8ZO3L6qZA9fAzBSVtjOfa097Fe0xDhHObC7RInnYeEyDHIbLZ
         zZ+zaudYbNbDvzsSyG9C6eHK6H/UmOidPZTVPMWmX7LD4Ufhp7zNSznBsVYjyotpHe
         NkJ8mg7WXSmlfu4Z4UUJx4LsjsDvrIyMxDIXu4FM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-sh@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 54/60] sh: prevent warnings when using iounmap
Date:   Fri, 19 Jul 2019 00:11:03 -0400
Message-Id: <20190719041109.18262-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041109.18262-1-sashal@kernel.org>
References: <20190719041109.18262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>

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
index 98cb8c802b1a..0ae60d680000 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -371,7 +371,11 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 
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

