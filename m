Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D300EC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 11:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A077620645
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 11:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxzM68tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFVLmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 07:42:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43467 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfFVLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 07:42:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so6822335lfk.10;
        Sat, 22 Jun 2019 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSGerT8TNFuf7M5p6FI10I27Q482DnxM3bVeQHA30Lo=;
        b=pxzM68tlLN5wQnJrAl75Ohda82kf82A2q0do/bEHnGkFDhatFhTwxctwBeKdSaXTA6
         OedjKbGghTaRJqC48RQwS5BQSwt+OUzWvm8YebC3brkO9XvrzShj8JF3U0VJoyOd2MuG
         9OqI+z8iVY0m/PyIyfx3BuAEOe7JAzcGmBMzaT62DYQJO5VfSTUdUxz/tPIVqzf0a+7V
         PHdQN0E5m2vXT82hS918xXDqAlsB8OF0LGXudStzWOK4isw7PYqPEmdIWpYkGsZfMYe2
         ppVlQCNYPUxYoJkSn+ekkLpfcULuJu14kOGEUsOVrpPllf0v1JAiri0BVGEPlovxsYNg
         uu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KSGerT8TNFuf7M5p6FI10I27Q482DnxM3bVeQHA30Lo=;
        b=oz26djtGorixhKUJKbbWgc/2g8YWKpotifqXO95txaGTnJy7AXDb+1AR/3odzInl/3
         DMmpz05/J7G9F9sdts/MWdAfyL6K1DQUNCRCiA2/R5Weil591YzvwWYoc2zJRBrj904s
         uPcen38K9fTmtCt9AUiL/SVbIrHnvqV5UElWHgFteJNatvONsYy8ioHZOLy0hkS7QWWk
         7mx6eNEbDQr39cNifIJOADyS9dUj9OCynXH6nIbmLjkEClqj4jB4gcjKFsmbx+3HwTVl
         RSqTAtVvtHPZdTZ4r3UH9tQNULiWQUTEthVAsNzPWtUAnSKzvKkTYS3VFeFn0mVrS81B
         He2w==
X-Gm-Message-State: APjAAAUZVa6Ks5M58bEmC1tXVGXMxt+VNbQUW7o/vvpMefcaqhHkgeSD
        O69Lt+NMFMsfR5yhmCmNDUt+zcuXjZxpWw==
X-Google-Smtp-Source: APXvYqwh7/l0brpnzOZ090BYqnhHQGGq5+SdHl8f91QysV7t+/7oTe8ufCVK4ESqOJelaU0qqpiFhQ==
X-Received: by 2002:ac2:5dc3:: with SMTP id x3mr11841450lfq.168.1561203759138;
        Sat, 22 Jun 2019 04:42:39 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id y62sm801672lje.100.2019.06.22.04.42.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 22 Jun 2019 04:42:38 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] sh: prevent warnings when using iounmap
Date:   Sat, 22 Jun 2019 13:42:08 +0200
Message-Id: <20190622114208.24427-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building drm/exynos for sh, as part of an allmodconfig build,
the following warning triggered:

  exynos7_drm_decon.c: In function ‘decon_remove’:
  exynos7_drm_decon.c:769:24: warning: unused variable ‘ctx’
    struct decon_context *ctx = dev_get_drvdata(&pdev->dev);

The ctx variable is only used as argument to iounmap().

In sh - allmodconfig CONFIG_MMU is not defined
so it ended up in:

\#define __iounmap(addr)	do { } while (0)
\#define iounmap		__iounmap

Fix the warning by introducing a static inline
function for iounmap.
This is similar to several other architectures.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
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

