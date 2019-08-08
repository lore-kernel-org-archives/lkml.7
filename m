Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00300C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93F52184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="snfI2scr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfHHGcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:32:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHGcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:32:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x786W2rN3013649
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 7 Aug 2019 23:32:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x786W2rN3013649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565245923;
        bh=VswMpHWj24ULQnUBPrNnj+j7MNQWdOP+qKX2/mk60D0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=snfI2scraBP8d+ZCZQLgOfGvDiGnPQOl5xvoQ7enyUAjelJgfiM7pmwQABJG5qRB0
         CUAUrzu2uiL+JRjEh36KTe9xNtIhFlewO4SmrlN6BmbcIqOUnNn6HhcTa+f/56Q3gR
         ElBCl87MvNtmDK5xm2Amw6y9w6QvPoe2RJcetpBB7h6FoqIoPW/HHL0ypwwVWKFFGH
         UVLeEY33j4/MyvN/BnTijMlREaoY2v0qv3BHHN9i2dx6UzWwbEUxI2qB0p/Hw+UnhM
         LSaJKNK2Ya2K2YI3R5rsJm9tlbBF023uipSHtXM3oJ0xJUMgp3wsDrOETnmrNfJsJM
         SCZPWeItg9pCQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x786W2XH3013646;
        Wed, 7 Aug 2019 23:32:02 -0700
Date:   Wed, 7 Aug 2019 23:32:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-b059f801a937d164e03b33c1848bb3dca67c0b04@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, vaibhavrustagi@google.com
Reply-To: vaibhavrustagi@google.com, linux-kernel@vger.kernel.org,
          ndesaulniers@google.com, mingo@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20190807221539.94583-2-ndesaulniers@google.com>
References: <20190807221539.94583-2-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/purgatory: Use CFLAGS_REMOVE rather than reset
 KBUILD_CFLAGS
Git-Commit-ID: b059f801a937d164e03b33c1848bb3dca67c0b04
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

Commit-ID:  b059f801a937d164e03b33c1848bb3dca67c0b04
Gitweb:     https://git.kernel.org/tip/b059f801a937d164e03b33c1848bb3dca67c0b04
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Wed, 7 Aug 2019 15:15:33 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Aug 2019 08:25:53 +0200

x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS

KBUILD_CFLAGS is very carefully built up in the top level Makefile,
particularly when cross compiling or using different build tools.
Resetting KBUILD_CFLAGS via := assignment is an antipattern.

The comment above the reset mentions that -pg is problematic.  Other
Makefiles use `CFLAGS_REMOVE_file.o = $(CC_FLAGS_FTRACE)` when
CONFIG_FUNCTION_TRACER is set. Prefer that pattern to wiping out all of
the important KBUILD_CFLAGS then manually having to re-add them. Seems
also that __stack_chk_fail references are generated when using
CONFIG_STACKPROTECTOR or CONFIG_STACKPROTECTOR_STRONG.

Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190807221539.94583-2-ndesaulniers@google.com

---
 arch/x86/purgatory/Makefile | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 91ef244026d2..8901a1f89cf5 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -20,11 +20,34 @@ KCOV_INSTRUMENT := n
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
-# sure how to relocate those. Like kexec-tools, use custom flags.
-
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
-KBUILD_CFLAGS += -m$(BITS)
-KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
+# sure how to relocate those.
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_sha256.o		+= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_purgatory.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_string.o		+= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_kexec-purgatory.o	+= $(CC_FLAGS_FTRACE)
+endif
+
+ifdef CONFIG_STACKPROTECTOR
+CFLAGS_REMOVE_sha256.o		+= -fstack-protector
+CFLAGS_REMOVE_purgatory.o	+= -fstack-protector
+CFLAGS_REMOVE_string.o		+= -fstack-protector
+CFLAGS_REMOVE_kexec-purgatory.o	+= -fstack-protector
+endif
+
+ifdef CONFIG_STACKPROTECTOR_STRONG
+CFLAGS_REMOVE_sha256.o		+= -fstack-protector-strong
+CFLAGS_REMOVE_purgatory.o	+= -fstack-protector-strong
+CFLAGS_REMOVE_string.o		+= -fstack-protector-strong
+CFLAGS_REMOVE_kexec-purgatory.o	+= -fstack-protector-strong
+endif
+
+ifdef CONFIG_RETPOLINE
+CFLAGS_REMOVE_sha256.o		+= $(RETPOLINE_CFLAGS)
+CFLAGS_REMOVE_purgatory.o	+= $(RETPOLINE_CFLAGS)
+CFLAGS_REMOVE_string.o		+= $(RETPOLINE_CFLAGS)
+CFLAGS_REMOVE_kexec-purgatory.o	+= $(RETPOLINE_CFLAGS)
+endif
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
