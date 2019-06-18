Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AEDC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3657420679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfFRMDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:03:07 -0400
Received: from foss.arm.com ([217.140.110.172]:37354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:03:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F1A2B;
        Tue, 18 Jun 2019 05:03:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9E003F246;
        Tue, 18 Jun 2019 05:03:04 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:02:59 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
Message-ID: <20190618120259.GA31041@fuggles.cambridge.arm.com>
References: <20190617104237.2082388-1-arnd@arndb.de>
 <20190617112652.GB30800@fuggles.cambridge.arm.com>
 <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com>
 <20190617161330.GD30800@fuggles.cambridge.arm.com>
 <CAKv+Gu9Fh3anh6-TeDWZ+pL7rs7EBWZqvLXASRNjicGu7k+WKw@mail.gmail.com>
 <20190617164553.GI30800@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617164553.GI30800@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Ard,

On Mon, Jun 17, 2019 at 05:45:56PM +0100, Will Deacon wrote:
> On Mon, Jun 17, 2019 at 06:32:16PM +0200, Ard Biesheuvel wrote:
> > The problem is not about the types we're *exporting*. Genksyms just
> > gives up halfway through the file, as soon as it encounters something
> > it doesn't like, and any symbol that hasn't been encountered yet at
> > that point will not have a crc generated for it.
> 
> Hmm, but it appears to be either working or failing silently for me, which
> doesn't match what Arnd is seeing. I'd prefer to fix genksyms but I'm not
> happy touching it if I can't show it's broken to begin with. If I pass '-w'
> I see it barfing on all sorts of random stuff, for example the static_assert
> in include/linux/fs.h:
> 
> 	static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);

Ok, I had some more fun with this today. First of all, we needed a new
.config, but also, the issue only appears with linux-next. With that
configuration, I can hit the issue.

What seems to occur is that when parsing:

	static __uint128_t arm64_cpu_to_le128(__uint128_t x)
	{
		u64 a = swab64(x);
		u64 b = swab64(x >> 64);

		return ((__uint128_t)a << 64) | b;
	}

in fpsimd.c, then genksyms doesn't treate __uint128_t as a type and
therefore fails to figure out that this is a function. Consequently, it
keeps trying (and failing) to parse until it sees the end of the current
expression. This happens when it hits:

	EXPORT_SYMBOL(kernel_neon_begin);

thanks to the semi-colon.

So one nasty bodge to fix this is:


diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index bb42cd04baec..693a978f41f9 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -368,6 +368,8 @@ static __uint128_t arm64_cpu_to_le128(__uint128_t x)
 }
 #endif
 
+short of_fixing_genksyms_we_must_use_this_hack;
+
 #define arm64_le128_to_cpu(x) arm64_cpu_to_le128(x)
 
 /*


but actually, I think I've managed to hack genksyms itself. Patch below.

Will

--->8

From 6e004b8824d4eb6a4e61cd794fbc3a761b50135b Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Tue, 18 Jun 2019 12:56:49 +0100
Subject: [PATCH] genksyms: Teach parse about __uint128_t built-in type

__uint128_t crops up in a few files that export symbols to modules, so
teach genksyms about it so that we don't end up skipping the CRC
generation for some symbols due to the parser failing to spot them:

  | WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version
  |          generation failed, symbol will not be versioned.
  | ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against
  |     `__crc_kernel_neon_begin' can not be used when making a shared
  |     object
  | ld: arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation:
  |     unsupported relocation

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 scripts/genksyms/keywords.c | 1 +
 scripts/genksyms/parse.y    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/scripts/genksyms/keywords.c b/scripts/genksyms/keywords.c
index 9f40bcd17d07..6ec585febfa4 100644
--- a/scripts/genksyms/keywords.c
+++ b/scripts/genksyms/keywords.c
@@ -53,6 +53,7 @@ static struct resword {
 	{ "struct", STRUCT_KEYW },
 	{ "typedef", TYPEDEF_KEYW },
 	{ "typeof", TYPEOF_KEYW },
+	{ "__uint128_t", BUILTIN_INT_KEYW },
 	{ "union", UNION_KEYW },
 	{ "unsigned", UNSIGNED_KEYW },
 	{ "void", VOID_KEYW },
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

