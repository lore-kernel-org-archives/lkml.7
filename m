Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FC4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9851205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HSKZk9vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfHNH74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:59:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfHNH7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:59:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7E7x17C1737910
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 14 Aug 2019 00:59:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7E7x17C1737910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565769542;
        bh=Ra+5Q0Y7zOopiP8DIbLDflo5hxndYIJyK0Q/uyRymjU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HSKZk9vHB1qCfPK9Hw7or/0oEew4hmLUMSwhvz9tIKfKvGRh84Rvq1WqbUlh6FBsv
         lCyBBB4FSsGa7Afm2ZXiMpPKz0aGa1P/4pYQpQinrj2SDnq9eeD0KIP+GplKEEdogI
         KBxGfh7sYEq+rkBciJTV0yO5Yg/9zmeYLRZcm4LKw6kynZJmFJv9rRqv9043bSPQN3
         qbtoMaxuA2hPiCOLGfy9lpQIhXVFRMEOkE8x2e8XEPgsxlGhEUMO7dzLmyi6qmI45x
         WIZ1fm50cP42Ekw3bEr6RLUkSB+HyJ+FsC2InpLOc+NFbKRG/dnG2DWh+FQRUCArCC
         IUld+admmJjVA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7E7x0QR1737907;
        Wed, 14 Aug 2019 00:59:00 -0700
Date:   Wed, 14 Aug 2019 00:59:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-41b57d1bb8a4084e651c1f9a754fca64952666a0@git.kernel.org>
Cc:     mark.rutland@arm.com, mingo@kernel.org, ard.biesheuvel@linaro.org,
        hpa@zytor.com, tglx@linutronix.de, willy@infradead.org,
        yamada.masahiro@socionext.com, colyli@suse.de,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        kent.overstreet@gmail.com, akpm@linux-foundation.org,
        arnd@arndb.de, gary.hook@amd.com,
        andriy.shevchenko@linux.intel.com, bp@suse.de
Reply-To: linux-kernel@vger.kernel.org, keescook@chromium.org,
          kent.overstreet@gmail.com, andriy.shevchenko@linux.intel.com,
          bp@suse.de, akpm@linux-foundation.org, arnd@arndb.de,
          gary.hook@amd.com, mingo@kernel.org, ard.biesheuvel@linaro.org,
          hpa@zytor.com, mark.rutland@arm.com,
          yamada.masahiro@socionext.com, colyli@suse.de,
          tglx@linutronix.de, willy@infradead.org
In-Reply-To: <20190806162539.51918-1-mark.rutland@arm.com>
References: <20190806162539.51918-1-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] lib: Remove redundant ftrace flag removal
Git-Commit-ID: 41b57d1bb8a4084e651c1f9a754fca64952666a0
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

Commit-ID:  41b57d1bb8a4084e651c1f9a754fca64952666a0
Gitweb:     https://git.kernel.org/tip/41b57d1bb8a4084e651c1f9a754fca64952666a0
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Tue, 6 Aug 2019 17:25:39 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 14 Aug 2019 09:48:58 +0200

lib: Remove redundant ftrace flag removal

Since architectures can implement ftrace using a variety of mechanisms,
generic code should always use CC_FLAGS_FTRACE rather than assuming that
ftrace is built using -pg.

Since commit:

  2464a609ded09420 ("ftrace: do not trace library functions")

... lib/Makefile has removed CC_FLAGS_FTRACE from KBUILD_CFLAGS, so ftrace is
disabled for all files under lib/.

Given that, we shouldn't explicitly remove -pg when building
lib/string.o, as this is redundant and bad form.

Clean things up accordingly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Coly Li <colyli@suse.de>
Cc: Gary R Hook <gary.hook@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://lkml.kernel.org/r/20190806162539.51918-1-mark.rutland@arm.com
---
 lib/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 095601ce371d..34f8a83b2cbd 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -21,10 +21,6 @@ KCOV_INSTRUMENT_dynamic_debug.o := n
 ifdef CONFIG_AMD_MEM_ENCRYPT
 KASAN_SANITIZE_string.o := n
 
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_string.o = -pg
-endif
-
 CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
 endif
 
