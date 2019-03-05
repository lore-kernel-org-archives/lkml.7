Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F281520663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vvlax/fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCEAMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:12:32 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:51979 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:12:31 -0500
Received: by mail-yw1-f74.google.com with SMTP id l11so10532546ywl.18
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Xv0gLmyX/M+BKDNKE9MX0hf2Mb0FZUgj80Ns5OPor0=;
        b=Vvlax/fc6Pr+QsVm1bDw9IjzaM2+9KjOVKEXfPxTdvx/rAuQiNSyGwfBDFQ5dHiqSQ
         uiRGs8m9VHlLn27tf+U9TY9+wqCjYzb8PXy6UJkigNDUcQoj4F9QTXBzS8OL5Z9Lny0p
         pnGc6brMT+V/oCfbCPaDa4USOwY56bkErcCG0EIkavTycGloVi9L81LucMdtWis4ej+Z
         W6GrRFqXzdn0luIMZrx7kRpTya3hwco8U31i12nZdCKoeyX0eT6eK8/SvaQ2NtK+ZWy9
         EkwAnbQMFlx+BnRvlXAc+tjKcPiUzsTfDw48PxPmMwx0lFfeD4Hv63Bm2nUTcYZhzTog
         Oh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Xv0gLmyX/M+BKDNKE9MX0hf2Mb0FZUgj80Ns5OPor0=;
        b=GVor8g8twF3sWlbDbG7i6SnnTqakvDz0Ytehbz7Ch0tH6pH1yoi/vaKC9hsnyNaOIw
         v4Y71Fj20Oe04McpWIhlR1FiiViMAkEd+yqHSlFaFNnPfIpqUoJWti5hbkiG96fSYiKJ
         KpqZ2jQNacXcQ+e/iVF4Qym4C75sxWm2abrYnZ4jdW6ZbJ3YZuydYCq0Iq3ELJBDsWNE
         3aCo8I+sGaagYkYyxgBgfyNK3UWDvF6su5kbOSRiH2i3sc68jcgjsr1j4IrI9J0ra2my
         0fgNGQVZd96QXNi+JZWTcU8gwZT8Z1ZPLk+KytYlAEVW2u/pCALLJurTx73FpxZEEUWc
         8gSg==
X-Gm-Message-State: APjAAAW7PNKt9DPsT+GmPkuPEFFY66D3DvnTDZpGA2ZnHJzkyAlsOJSj
        DGASfMGd6lQpvgzcCX4ZffJeYFdJ8rjpRUq4dPs=
X-Google-Smtp-Source: APXvYqw6YRrPxjvq5cl8pBsfvBQGTXBF+aqr+DhBI3wOJduX5wZz2EYDENUf4pI79/Ew+sTJNVrTNbd3EhR5SsmHbg4=
X-Received: by 2002:a25:3249:: with SMTP id y70mr23915yby.70.1551744750439;
 Mon, 04 Mar 2019 16:12:30 -0800 (PST)
Date:   Mon,  4 Mar 2019 16:12:21 -0800
In-Reply-To: <20190305095100.243a40e3@canb.auug.org.au>
Message-Id: <20190305001221.31343-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190305095100.243a40e3@canb.auug.org.au>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH v3] x86/boot: clean up headers
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bp@alien8.de
Cc:     natechancellor@gmail.com, niravd@google.com, sfr@canb.auug.org.au,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V2 -> V3:
* keep linux/types.h

Changes V1 -> V2:
* Add Reviewed, Tested, Suggested tags.
* Drop linux/types.h; it's included in linux/limits.h.

 arch/x86/boot/string.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 315a67b8896b..90154df8f125 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -13,8 +13,9 @@
  */
 
 #include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <asm/asm.h>
 #include "ctype.h"
 #include "string.h"
-- 
2.21.0.352.gf09ad66450-goog

