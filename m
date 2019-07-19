Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E380CC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EAA2189D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509352;
	bh=I0kSTxBH87xGoi/XjVBYDRILRFN52JKLEBxpQaVCfrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RgJGOhB0aQvHlWAqDDddrVQbksEjno06nMmt7XORcHBLy/ddwj/43vD87p8IwAc3y
	 Xtvfis1UOXvxx0grtaOUYx0CRrjY2LR096fu+HHFi/XphITi2gmITMKZ/pLOVRfM14
	 aKJYfPoKoubdbjd6jE54WqIyP9EAEfKk+z34AotY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfGSEJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbfGSEJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:09:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F8E2189E;
        Fri, 19 Jul 2019 04:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509346;
        bh=I0kSTxBH87xGoi/XjVBYDRILRFN52JKLEBxpQaVCfrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GC3jf0wyCQcAF21WlFXHbhE9eDNxF9c684z9VboV1tA7jfXaIF3cmmB5TJr94aaRx
         S29bH9LJqBbbSHC37wijO5oBmG+0R1CMkMKFdFVshG2r/jz8EXVRODhr+Ee/gnpIn4
         20UUrP6j+6xA7Lpl9+FLyy/+wh1QA1NXBGwf2QNc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 045/101] genksyms: Teach parser about 128-bit built-in types
Date:   Fri, 19 Jul 2019 00:06:36 -0400
Message-Id: <20190719040732.17285-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040732.17285-1-sashal@kernel.org>
References: <20190719040732.17285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit a222061b85234d8a44486a46bd4df7e2cda52385 ]

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

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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
2.20.1

