Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A1DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5C4208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f04d+Rwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfF1BS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:18:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34151 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfF1BS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:18:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so2843010lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FdrladOMf5TABxNjyjNPdPtP4U4TccCWoqjaGYv1yIk=;
        b=f04d+RwuwKIjOh+/Xm4sYT74Zia/OrkCIl3FKW0uZj5gCqKBelNXfEXlJ3opMLNpJF
         4wB/BXBaD58Qrw4FJdBh03Ih+T8vptwKo6GfVdye7hamCxR69sO897FRoz6Ga9QUTU1f
         a8QLhyi7V5TULbbkU0Czfx31iB4GXbktjzsPLkOPsxzIcscu0uFqsLRVC/LJ6Cvw+lvO
         c06DMYF+bR0ncxA1b0dFxnK7yBwEi+g2Pw2DJ+nz/qW/myo1mi7klO4yP3Q6S/qaQ499
         ObDnnJuAI7+2VkgoGV5sRY1o6UM408jZT7jmfSkOQ+8ZDNGrA1MzZT0R0ik61U3wZQa4
         8R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FdrladOMf5TABxNjyjNPdPtP4U4TccCWoqjaGYv1yIk=;
        b=i8wcl64ZwjM/74CC1ni5MrU5ypmHfHeLJcYOSUtvKwJra7QO+MYh4Ld2BX+bYTqsdT
         bMp6w+LiVcH4AJ4spt1u85pgEbAwefSWedhyVBIyAIXCLjoTeOpJ1PBo7u1y+8VKaDTr
         vlmXawE5/04vDBN1DX8TH69rne01HgHz+udp+4Qw5KrilLM1Ck/yjCydDzJF8uVSl2/Q
         tgfybfRZEo3N0N2HJsxMR6jXTsmZQDd/B5m3ttRASNsjvhWG1xalc0C/4WOCeRInlTeo
         XfAB0w3etFs/3BF7eTZllgN+Z9+6ANpOmwF5RIlMkrhb/b3x4TrLkvYER1WZ6yN10vYR
         GnxQ==
X-Gm-Message-State: APjAAAXGvrs47yFk6tt39DAQDGS3q3JHQmqq7PmOwq/hdU7o4yAf4Q4O
        3MeL5+iYF8TTnf7JfWZipt8=
X-Google-Smtp-Source: APXvYqwpC1fBG9+6KbAOWFl8V1PbiqZK9dFmzaJzp7twMSYWnWcxCpA+c6jisC7NlcimAfeOReN4Ag==
X-Received: by 2002:a19:5046:: with SMTP id z6mr3618691lfj.185.1561684705233;
        Thu, 27 Jun 2019 18:18:25 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net. (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id e26sm210150ljl.33.2019.06.27.18.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 18:18:24 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: remove arch/xtensa/include/asm/types.h
Date:   Thu, 27 Jun 2019 18:18:14 -0700
Message-Id: <20190628011814.5797-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xtensa does not define CONFIG_64BIT. The generic definition of
BITS_PER_LONG in include/asm-generic/bitsperlong.h should work.
With that definition removed from arch/xtensa/include/asm/types.h
it does nothing but including arch/xtensa/include/uapi/asm/types.h
Remove the arch/xtensa/include/asm/types.h header.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/types.h | 23 -----------------------
 1 file changed, 23 deletions(-)
 delete mode 100644 arch/xtensa/include/asm/types.h

diff --git a/arch/xtensa/include/asm/types.h b/arch/xtensa/include/asm/types.h
deleted file mode 100644
index 2b410b8c7f79..000000000000
--- a/arch/xtensa/include/asm/types.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * include/asm-xtensa/types.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-#ifndef _XTENSA_TYPES_H
-#define _XTENSA_TYPES_H
-
-#include <uapi/asm/types.h>
-
-#ifndef __ASSEMBLY__
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
-
-#define BITS_PER_LONG 32
-
-#endif
-#endif	/* _XTENSA_TYPES_H */
-- 
2.11.0

