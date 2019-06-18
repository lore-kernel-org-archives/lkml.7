Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF3BC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6892084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfFRNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:10:57 -0400
Received: from foss.arm.com ([217.140.110.172]:40276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfFRNK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:10:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DF6E2B;
        Tue, 18 Jun 2019 06:10:56 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08E253F718;
        Tue, 18 Jun 2019 06:10:54 -0700 (PDT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave.martin@arm.com, arnd@arndb.de,
        Will Deacon <will.deacon@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] genksyms: Teach parser about 128-bit built-in types
Date:   Tue, 18 Jun 2019 14:10:48 +0100
Message-Id: <20190618131048.543-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__uint128_t crops up in a few files that export symbols to modules, so
teach genksyms about it and the other GCC built-in 128-bit integer types
so that we don't end up skipping the CRC generation for some symbols due
to the parser failing to spot them:

  | WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version
  |          generation failed, symbol will not be versioned.
  | ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against
  |     `__crc_kernel_neon_begin' can not be used when making a shared
  |     object
  | ld: arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation:
  |     unsupported relocation

Cc: Richard Henderson <rth@twiddle.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Without this patch, we're seeing arm64 build breakage in linux-next
under some configurations.

 scripts/genksyms/keywords.c | 4 ++++
 scripts/genksyms/parse.y    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/scripts/genksyms/keywords.c b/scripts/genksyms/keywords.c
index 9f40bcd17d07..f6956aa41366 100644
--- a/scripts/genksyms/keywords.c
+++ b/scripts/genksyms/keywords.c
@@ -24,6 +24,10 @@ static struct resword {
 	{ "__volatile__", VOLATILE_KEYW },
 	{ "__builtin_va_list", VA_LIST_KEYW },
 
+	{ "__int128", BUILTIN_INT_KEYW },
+	{ "__int128_t", BUILTIN_INT_KEYW },
+	{ "__uint128_t", BUILTIN_INT_KEYW },
+
 	// According to rth, c99 defines "_Bool", __restrict", __restrict__", "restrict".  KAO
 	{ "_Bool", BOOL_KEYW },
 	{ "_restrict", RESTRICT_KEYW },
diff --git a/scripts/genksyms/parse.y b/scripts/genksyms/parse.y
index 00a6d7e54971..1ebcf52cd0f9 100644
--- a/scripts/genksyms/parse.y
+++ b/scripts/genksyms/parse.y
@@ -76,6 +76,7 @@ static void record_compound(struct string_list **keyw,
 %token ATTRIBUTE_KEYW
 %token AUTO_KEYW
 %token BOOL_KEYW
+%token BUILTIN_INT_KEYW
 %token CHAR_KEYW
 %token CONST_KEYW
 %token DOUBLE_KEYW
@@ -263,6 +264,7 @@ simple_type_specifier:
 	| VOID_KEYW
 	| BOOL_KEYW
 	| VA_LIST_KEYW
+	| BUILTIN_INT_KEYW
 	| TYPE			{ (*$1)->tag = SYM_TYPEDEF; $$ = $1; }
 	;
 
-- 
2.11.0

