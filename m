Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB3C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF45A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCERyyEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfJGVOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:14:24 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:46284 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfJGVOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:14:24 -0400
Received: by mail-vk1-f201.google.com with SMTP id n124so7328820vkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fBfJjWCRhUxG21Ng89HEbOaecnd7jMgx3odQFdBCxJ0=;
        b=LCERyyEkhTVAeNgqdkbiDeOz17qS0c6prgo+IvWGSyIjN8hlkJkU4bQhVGDLEkrtt/
         9OL9NgQsbq9SBZUzrNmTqIsk7KMbjS2osBcrPpAD7ZuIqgqpzDPWuGVaZQsQHtjm34+0
         /K3CKdKSNK+SxDcnbtLwnZRbwKLxrTVfQUjkcEWQcwKZQwH6A8t73p44wUFGJA89Vkvv
         /cMpjXtjzgqNIhBnYpUe9ZUO5yChcsmOGIxU8VIpVzlPzwL4nkzgZ/VkY8kIqJbC8G6Q
         iFyskXJpjfzO0ifcz1tB7LWzOMwxadjuaVOwwfpv9GZsbjwIL+05pwr/ypfjwDcmW5Qm
         xB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fBfJjWCRhUxG21Ng89HEbOaecnd7jMgx3odQFdBCxJ0=;
        b=bM7q4JjsXdcqdkmDzj9GHjHxqRUaMqju5BrGc6aD1+ZhWhpG+DXC5+cXa8iWJMWZSs
         bkYb+md9qehX4NGtvhYcS4x/PulNTaQcPQ527uNm6nVaMPw/KqlTiMNum01O79vd5twI
         lixy23nkAVkdos5kaH7JolE3uET2rWfm1gdsqJDNq/ooMZJuuO10GEfdqKpsGwdWRhgm
         dhjGAXZmPo+ySv886k9Mwkk4we0sn9z/CjGQHnW5H914htY9CblaMq5JYmoXOTR9gVj1
         e4rrOpSQQrfc/Cd7Ye1N1aviXAr4cUl0DUtINFdY1XUZIgTJhDiwH6zvm+ct01qWp562
         eKtA==
X-Gm-Message-State: APjAAAX7b0zOD4cYYvVVG1d32jx7obiYr0sL9Ds0R31EfZuHQ+f6UrI8
        oUyNPz46IAcexTS0Y7Wng41kj+UYygorWPj/AWs=
X-Google-Smtp-Source: APXvYqxF+3FXrWI0F1JhQsVjGtNovxca74xNOx0v6Tym1VjSkx5iVmESuRaQIaxUUjlmnakmGlvpseIpPCngOR9kjVw=
X-Received: by 2002:a67:2e01:: with SMTP id u1mr17012140vsu.44.1570482862813;
 Mon, 07 Oct 2019 14:14:22 -0700 (PDT)
Date:   Mon,  7 Oct 2019 14:14:18 -0700
Message-Id: <20191007211418.30321-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] arm64: fix alternatives with LLVM's integrated assembler
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM's integrated assembler fails with the following error when
building KVM:

  <inline asm>:12:6: error: expected absolute expression
   .if kvm_update_va_mask == 0
       ^
  <inline asm>:21:6: error: expected absolute expression
   .if kvm_update_va_mask == 0
       ^
  <inline asm>:24:2: error: unrecognized instruction mnemonic
          NOT_AN_INSTRUCTION
          ^
  LLVM ERROR: Error parsing inline asm

These errors come from ALTERNATIVE_CB and __ALTERNATIVE_CFG,
which test for the existence of the callback parameter in inline
assembly using the following expression:

  " .if " __stringify(cb) " == 0\n"

This works with GNU as, but isn't supported by LLVM. This change
splits __ALTERNATIVE_CFG and ALTINSTR_ENTRY into separate macros
to fix the LLVM build.

Link: https://github.com/ClangBuiltLinux/linux/issues/472
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/alternative.h | 32 ++++++++++++++++++----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index b9f8d787eea9..324e7d5ab37e 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -35,13 +35,16 @@ void apply_alternatives_module(void *start, size_t length);
 static inline void apply_alternatives_module(void *start, size_t length) { }
 #endif
 
-#define ALTINSTR_ENTRY(feature,cb)					      \
+#define ALTINSTR_ENTRY(feature)					              \
 	" .word 661b - .\n"				/* label           */ \
-	" .if " __stringify(cb) " == 0\n"				      \
 	" .word 663f - .\n"				/* new instruction */ \
-	" .else\n"							      \
+	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
+	" .byte 662b-661b\n"				/* source len      */ \
+	" .byte 664f-663f\n"				/* replacement len */
+
+#define ALTINSTR_ENTRY_CB(feature, cb)					      \
+	" .word 661b - .\n"				/* label           */ \
 	" .word " __stringify(cb) "- .\n"		/* callback */	      \
-	" .endif\n"							      \
 	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
 	" .byte 662b-661b\n"				/* source len      */ \
 	" .byte 664f-663f\n"				/* replacement len */
@@ -62,15 +65,14 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
  *
  * Alternatives with callbacks do not generate replacement instructions.
  */
-#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled, cb)	\
+#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
 	".if "__stringify(cfg_enabled)" == 1\n"				\
 	"661:\n\t"							\
 	oldinstr "\n"							\
 	"662:\n"							\
 	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature,cb)					\
+	ALTINSTR_ENTRY(feature)						\
 	".popsection\n"							\
-	" .if " __stringify(cb) " == 0\n"				\
 	".pushsection .altinstr_replacement, \"a\"\n"			\
 	"663:\n\t"							\
 	newinstr "\n"							\
@@ -78,17 +80,25 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	".popsection\n\t"						\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
 	".org	. - (662b-661b) + (664b-663b)\n"			\
-	".else\n\t"							\
+	".endif\n"
+
+#define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\
+	".if "__stringify(cfg_enabled)" == 1\n"				\
+	"661:\n\t"							\
+	oldinstr "\n"							\
+	"662:\n"							\
+	".pushsection .altinstructions,\"a\"\n"				\
+	ALTINSTR_ENTRY_CB(feature, cb)					\
+	".popsection\n"							\
 	"663:\n\t"							\
 	"664:\n\t"							\
-	".endif\n"							\
 	".endif\n"
 
 #define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
-	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
+	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
 
 #define ALTERNATIVE_CB(oldinstr, cb) \
-	__ALTERNATIVE_CFG(oldinstr, "NOT_AN_INSTRUCTION", ARM64_CB_PATCH, 1, cb)
+	__ALTERNATIVE_CFG_CB(oldinstr, ARM64_CB_PATCH, 1, cb)
 #else
 
 #include <asm/assembler.h>
-- 
2.23.0.581.g78d2f28ef7-goog

