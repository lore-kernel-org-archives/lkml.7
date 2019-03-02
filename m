Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CCFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC6120823
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTU1Dcik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCBAHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:07:30 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:38561 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCBAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:07:29 -0500
Received: by mail-yw1-f74.google.com with SMTP id v85so7912143ywc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 16:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sY3hGiIQgZlYTlKbHSQOU0k6Qj5QNj3YBWyce/UCZq0=;
        b=uTU1DcikEy+OVOBerS+CGyLCtCsZ6C3MQaviTtVmivEzJ5r63tmmMgbcVm+StM+rgX
         IP/akeHgWm3gbFcq6J3P0uP5ungxDrq30eYGT2bklh1b2/3pV0cJHNLHsCAbvNEk3VFi
         XHr0TgS+Ktf1lGl0ovvep0BWEY7AnkSiMNxxy2R1rDjDcqr+lJ9h6Spea3oDi59LSXa/
         VmZvi93ifi192eWEMOJqEWdYUN7Jgtf7RidPPwyf7itDIjYoVXkZsvaBcqBWEAJl4tMi
         T+MpncWGf/H8Izqr6mMuZmtt8GgB+nTA8BCKOuvCRBwGnfrx7NOBPuptOc/uhK7VaOKF
         Gk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sY3hGiIQgZlYTlKbHSQOU0k6Qj5QNj3YBWyce/UCZq0=;
        b=GLqkvB0hyExTvgm0tE+gA3eBvPDNR7ai2zLEsT5ev7xE4ZtUSA0z7qeZeEYai4PEQ4
         DThMy5wKD4j9iP1YsUY3vm9jUthaXDmZMCBrh0t+nkohr8YyGF7/MmIJalxgXK6qw9j/
         QtNndBTvOCG94CnEi5rHkg7KRbmvGS+AiOToBooQ6QazCYNLGCyD4XJJuoWCIjorllel
         SQ+keYYrGf+WrvrILfCH73A7jhccuX7iVMLgIW0p5NnUKsFQCe+TEaz1JJgNWvSq6bq4
         D4pHaS3x6Dlpg1PTlSa6jcoAhNEFGtfwnzvusbQpNp6phpB3w24B1E11qlo1h331iEGM
         OlLQ==
X-Gm-Message-State: APjAAAUyaxkKCeplzJMqCC3f0sbILBMUhaLaEJqtnaNvu0uvySl53BPz
        0/l3gSIZpIXU790EGK51EyNnWg3RMZleWA97LjU=
X-Google-Smtp-Source: APXvYqz1UgSGqP/RyELmF6xskUISKJa403HIZ69yuRkwAYNfMeXjoDRWissCUdIXshx2lIyc8UklpCx5zkCPanAbJ28=
X-Received: by 2002:a25:9c04:: with SMTP id c4mr3431904ybo.64.1551485248456;
 Fri, 01 Mar 2019 16:07:28 -0800 (PST)
Date:   Fri,  1 Mar 2019 16:07:14 -0800
Message-Id: <20190302000715.130116-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH] x86/boot: clean up headers
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bp@alien8.de
Cc:     natechancellor@gmail.com, niravd@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inclusion of <linux/kernel.h> was causing issue as the definition of
__arch_hweight64 from arch/x86/include/asm/arch_hweight.h eventually gets
included. The definition is problematic when compiled with -m16 (all code
in arch/x86/boot/ is) as the "D" inline assembly constraint is rejected
by both compilers when passed an argument of type long long (regardless
of signedness, anything smaller is fine).

Because GCC performs inlining before semantic analysis, and
__arch_hweight64 is dead in this translation unit, GCC does not report
any issues at compile time.  Clang does the semantic analysis in the
front end, before inlining (run in the middle) can determine the code is
dead. I consider this another case of PR33587, which I think we can do
more work to solve.

It turns out that arch/x86/boot/string.c doesn't actually need
linux/kernel.h, simply linux/limits.h and linux/compiler.h. Include them,
and sort the headers alphabetically.

Link: https://bugs.llvm.org/show_bug.cgi?id=33587
Link: https://github.com/ClangBuiltLinux/linux/issues/347
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Note that this only regresses for us on linux-next (not mainline).

 arch/x86/boot/string.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 315a67b8896b..f149316116d0 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -12,10 +12,11 @@
  * Very basic string functions
  */
 
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
 #include <asm/asm.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/limits.h>
+#include <linux/types.h>
 #include "ctype.h"
 #include "string.h"
 
-- 
2.21.0.352.gf09ad66450-goog

