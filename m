Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF7C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2892086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="v/QFyJXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfHPMT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:19:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfHPMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:19:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GCJAuQ2797771
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 05:19:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GCJAuQ2797771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565957951;
        bh=BrfH1XhTznc2zALCwGSlvffGTIizJp5vG62LuP0mI1c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=v/QFyJXak1RXek35qwjE5NnR+A+eUTKgoLHGovieUjkLWlFqZJo1AcwRv2dPUl2tc
         Tj8DAqdPymLwdP/RrNGXQu6b7S8euzo++MUZl1BEQK12QdQuWCjaoVZI454uGCiVQw
         iEP2rk+g9ev/xKeo368kAYOf5GwOqcwaPyaEoLoSZBDC3rDk/wSPJgjGVRC65qboEc
         gv97PKGs5Y3BrFh7h+6vbQ1hyHTi/JTgMC4ZS4qPqEiOt2t3wv2Klm0VekofWykyf3
         L5nJK7eBzOIz5Q+jF3Ule5nP1Xngi/sRjt5e0LCwveKrINpS3qwcTOApdfJzkgwWnM
         HkBYK4mMH0kvQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GCJANk2797765;
        Fri, 16 Aug 2019 05:19:10 -0700
Date:   Fri, 16 Aug 2019 05:19:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rikard Falkeborn <tipbot@zytor.com>
Message-ID: <tip-d5a1baddf1585885868cbab55989401fb97118c6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, keescook@chromium.org,
        rikard.falkeborn@gmail.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, keescook@chromium.org,
          rikard.falkeborn@gmail.com
In-Reply-To: <20190811184938.1796-2-rikard.falkeborn@gmail.com>
References: <20190811184938.1796-2-rikard.falkeborn@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Use common BUILD_BUG_ON
Git-Commit-ID: d5a1baddf1585885868cbab55989401fb97118c6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d5a1baddf1585885868cbab55989401fb97118c6
Gitweb:     https://git.kernel.org/tip/d5a1baddf1585885868cbab55989401fb97118c6
Author:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
AuthorDate: Sun, 11 Aug 2019 20:49:36 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 16 Aug 2019 14:15:50 +0200

x86/boot: Use common BUILD_BUG_ON

Defining BUILD_BUG_ON causes redefinition warnings when adding includes of
include/linux/build_bug.h in files unrelated to x86/boot.  For example,
adding an include of build_bug.h to include/linux/bits.h shows the
following warnings:

  CC      arch/x86/boot/cpucheck.o
  In file included from ./include/linux/bits.h:22,
                   from ./arch/x86/include/asm/msr-index.h:5,
                   from arch/x86/boot/cpucheck.c:28:
  ./include/linux/build_bug.h:49: warning: "BUILD_BUG_ON" redefined
     49 | #define BUILD_BUG_ON(condition) \
        |
  In file included from arch/x86/boot/cpucheck.c:22:
  arch/x86/boot/boot.h:31: note: this is the location of the previous definition
     31 | #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
        |

The macro was added to boot.h in commit 62bd0337d0c4 ("Top header file for
new x86 setup code"). At that time, BUILD_BUG_ON was defined in
kernel.h. Presumably BUILD_BUG_ON was redefined to avoid pulling in
kernel.h. Since then, BUILD_BUG_ON and similar macros have been split to a
separate header file.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20190811184938.1796-2-rikard.falkeborn@gmail.com


---
 arch/x86/boot/boot.h | 2 --
 arch/x86/boot/main.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 19eca14b49a0..ca866f1cca2e 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -28,8 +28,6 @@
 #include "cpuflags.h"
 
 /* Useful macros */
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 
 extern struct setup_header hdr;
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index 996df3d586f0..e3add857c2c9 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -10,6 +10,7 @@
 /*
  * Main module for the real-mode kernel code
  */
+#include <linux/build_bug.h>
 
 #include "boot.h"
 #include "string.h"
