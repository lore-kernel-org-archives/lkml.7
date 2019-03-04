Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B724206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6PKJ5Q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfCDRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:50:23 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52023 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCDRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:50:23 -0500
Received: by mail-pg1-f202.google.com with SMTP id 73so5566864pga.18
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hMt3tGFDbLeDDehwajzyxAk4kYu7hBgZncEeRwthfXc=;
        b=A6PKJ5Q+MOWvmDi+M87ZYp16ltg8tDaOfNw4b2eNTcxt6/kvNcGE+sceFFzAo+OuPs
         IH0k8WBHOqUyc5YnMogMfPgURFnZYlG4R0nHuCloXu595A8/4RmxewlCcVevWIvraLl+
         cb9sRaeFCHDyARs8a8S14IE9y+dceqzuhqd+E03z/dbrlskwhsvKw/ONkMaYsEdHe9+V
         a7EjdvOIgWLnixauFagt3LUZOL99X9ajz3vjNxlmA6gINhOx3oQO87QnQmazMx7+RykW
         8fh8nDn+nB0JHHfJb/8KnYCBYIH4Q7kX735EAlpwoyB3z036U88eXLdl8jhtnfNLJcd7
         UP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hMt3tGFDbLeDDehwajzyxAk4kYu7hBgZncEeRwthfXc=;
        b=r/b5AOtwG6znnAMJD2yRccrdNpb1y9FhoaAfZUEEt2oVM+m07CJNXnAr0/CWuERAk3
         leiZHuGY99wlbiLIJGJ7H66WHs6H3RJaNkirqgz1Jbza/5ZTdm/DxZ2s/jRUA4miOnuL
         /ZcbD3vAz7Yte+gtp9ts7r5FvMq25R8nQAr867H/wB22ZLRH1a7xFR6YzSTkUbGlyTcI
         otv99TPcW/9dKWQ04+zkIevmrvDjWYpWGBhqQHgaHQYkBbM/d6XwF6hI3uXq45c8nRJu
         ZtXXC6XYgj0pXaha062p+8Q8REmt6M5u/OThum+N4xRjxLkKK8aPo0NIRsWWba0hhtYr
         HH1A==
X-Gm-Message-State: AHQUAub3M6ca+QLN8g8i9EDSNvH8ND24l3McMuD7YS2xAKlRsoeWa9F9
        NeFdsGU6LplC6iQbMsRtFno2mmzFP/Fe8NbUZrw=
X-Google-Smtp-Source: AHgI3Ia6qfR1QC6CXSQc+PbUPMt+xKNqHzhoki7TVBxHyZQVsHcQvaf7Cp4qD87fWm3z6f+KCXIr3/PB/98HvXaixW4=
X-Received: by 2002:a62:fb03:: with SMTP id x3mr7641257pfm.130.1551721822190;
 Mon, 04 Mar 2019 09:50:22 -0800 (PST)
Date:   Mon,  4 Mar 2019 09:50:16 -0800
In-Reply-To: <20190302132750.0916adc4@canb.auug.org.au>
Message-Id: <20190304175016.40538-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190302132750.0916adc4@canb.auug.org.au>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH v2] x86/boot: clean up headers
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
Changes V1 -> V2:
* Add Reviewed, Tested, Suggested tags.
* Drop linux/types.h; it's included in linux/limits.h.

My original intention was to unsort the headers (sorted in V1), but if
we drop the out of place linux/types.h, then we can insert the two more
specific headers in alphabetic order.

 arch/x86/boot/string.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 315a67b8896b..597589cafb45 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -12,9 +12,9 @@
  * Very basic string functions
  */
 
-#include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <asm/asm.h>
 #include "ctype.h"
 #include "string.h"
-- 
2.21.0.352.gf09ad66450-goog

