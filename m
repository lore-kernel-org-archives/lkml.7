Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832DFC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529D02084D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="eLXiAiv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfILWTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:19:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41032 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfILWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:19:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id z9so25311540edq.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHXzwTj1CMARSN6ZAcRX363CWyTLc803EsOjz2eKDbI=;
        b=eLXiAiv+V7up87LlulNtqY4d4BZgs3RzhC/be0fNEvGibz4p4JUS7ZH+GQLzrI3xxk
         DSEjaPDX4yw0tRaSG8uwhdrBke3YQEil0BmmQSid+1R8bpWmSowayCBe3oAyNHhkorYX
         HLU2i7iXfKcwMwSw3vOIZ9+9HaR9e6afqVfJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHXzwTj1CMARSN6ZAcRX363CWyTLc803EsOjz2eKDbI=;
        b=oWg21UhJ29Nlg1LHYnuJ0A+JY6JxpLy9D1K19CRJqnjaKj8LgtoUEQqtHPmk8GZbff
         +lXXMmuZ8s9mhrhH+jfKWBOGED8V1eHADspkSLJ/MVIv3kHFNr+rA6spMsNUdA4m0JFQ
         B+1kngWlKimcFyavFhamk1oxtDd1CmrIuBxeFP7Pu5HYo5IvRvvAynvWXQRTEyM+8Qzk
         7tgE7wRxfvEXkOtv8yEfjF4vbOTuVQgh6Q7BNRkyOhqN/eJM9chyu/fg8qDIMO7VCI1F
         UhCgrs4A7rQc2ApPf2rCgR7/6mPp8bspgDpcybjdgNRhTVgojubEGM0PsqAgNtQ2U7Po
         YKQA==
X-Gm-Message-State: APjAAAWAz8Zkt0QLl071qxMGM4Urb93Uzzhj+fSsjtY0vN03UcaWNrY1
        LYLS7xrqbcHL2bqzj2hGcSiS74cgL5Wdlr7w
X-Google-Smtp-Source: APXvYqwvWgHUaf5oar2ImUbkkltZpPX3/U+drt+oeGFMbNPuTP7OXsfuXR2KulPOq3IS7oqNUpjQqw==
X-Received: by 2002:a17:906:4c2:: with SMTP id g2mr9548279eja.38.1568326786987;
        Thu, 12 Sep 2019 15:19:46 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id 36sm4305228edz.92.2019.09.12.15.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:19:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 4/6] compiler-types.h: add asm_inline definition
Date:   Fri, 13 Sep 2019 00:19:25 +0200
Message-Id: <20190912221927.18641-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912221927.18641-1-linux@rasmusvillemoes.dk>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an asm_inline macro which expands to "asm inline" [1] when
the compiler supports it. This is currently gcc 9.1+, gcc 8.3
and (once released) gcc 7.5 [2]. It expands to just "asm" for other
compilers.

Using asm inline("foo") instead of asm("foo") overrules gcc's
heuristic estimate of the size of the code represented by the asm()
statement, and makes gcc use the minimum possible size instead. That
can in turn affect gcc's inlining decisions.

I wasn't sure whether to make this a function-like macro or not - this
way, it can be combined with volatile as

  asm_inline volatile()

but perhaps we'd prefer to spell that

  asm_inline_volatile()

anyway.

The Kconfig logic is taken from an RFC patch by Masahiro Yamada [3].

[1] Technically, asm __inline, since both inline and __inline__
are macros that attach various attributes, making gcc barf if one
literally does "asm inline()". However, the third spelling __inline is
available for referring to the bare keyword.

[2] https://lore.kernel.org/lkml/20190907001411.GG9749@gate.crashing.org/

[3] https://lore.kernel.org/lkml/1544695154-15250-1-git-send-email-yamada.masahiro@socionext.com/

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler_types.h | 6 ++++++
 init/Kconfig                   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index ee49be6d6088..2bf316fe0a20 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -198,6 +198,12 @@ struct ftrace_likely_data {
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
 
+#ifdef CONFIG_CC_HAS_ASM_INLINE
+#define asm_inline asm __inline
+#else
+#define asm_inline asm
+#endif
+
 #ifndef __no_fgcse
 # define __no_fgcse
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..7fee5978dd73 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -30,6 +30,9 @@ config CC_CAN_LINK
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
 
+config CC_HAS_ASM_INLINE
+	def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x c - -c -o /dev/null)
+
 config CC_HAS_WARN_MAYBE_UNINITIALIZED
 	def_bool $(cc-option,-Wmaybe-uninitialized)
 	help
-- 
2.20.1

