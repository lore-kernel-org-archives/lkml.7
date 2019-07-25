Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C329C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F383B22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAHxJvpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGYUHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:07:08 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:45521 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGYUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:07:08 -0400
Received: by mail-vk1-f201.google.com with SMTP id x83so21971765vkx.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tN5OGADsh/gbQB0AixreGdFmpm9j6/fownra3N7HOyA=;
        b=sAHxJvpRkEMvpJPKxJwU7iLi4As7kH8MTS2ss9dHMFjBRm47kjVojaV4PcQ2HFDByy
         +V9UILVlZ1n7FObDzfpl9l3PXkqio4xuKZ0IIRJWYAfzsQEEs8fi21R5pkJYAqG4PS74
         O7PkvWIvhdbIh55P0HVKYHp6wiqTj6j3reN3OHVN+5t0C2AwDjT6BoH8PGXcxlpGhQ2C
         gmSu7ca86eKfArzkksgfLqnxFAVKFP0Xh9ylJNO0w2dpQvnSFX0+EkcbEqyF0CQOKbv0
         SDA5hKM5kSG9iu8DRY4L5eyvrSKKZ0iQPF8PkkEOH4JvQhVmrvn+5b0O9P4ooznypCyM
         iaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tN5OGADsh/gbQB0AixreGdFmpm9j6/fownra3N7HOyA=;
        b=pe4LGCFqwOhQ3I/FVN75Y/+8h6jgHV4SvnsUI4buWGeFhv7KY36SyqyAkDZZlnFP4i
         0jeYHz7wTY5nct94LexA5jFIt+REHR5Wkeng+Ixb/mX2TV3Vql9Ew+y5H32QL9f3j3u2
         Rphg9sNxTi4WO50M+P77XTrv2bX0ZcpvgmYp/0hYxsPwgtMlt0l8sUK32nggxLq4j0f9
         FeQXAKK+KRplJdPMIahn6szZI74oeqhwoh0nVGSLf36Ipzt8H2WzMcUdQe+0T6AXHvRR
         sCm7wum44tvB/AK8y2tihASJXNt5zrdl0nb7sLG7PXd9deRJASrYo0jT1cL89xYpEnYw
         U1bg==
X-Gm-Message-State: APjAAAW5IvXk6nf+WZuzm77uSjcf3Sw4rVsbacHl9nCOcNpBbDQx2PTK
        AkG2BsSEVFDtr7xaQ9lTE1b1OTJh8/IYJxLzRA0=
X-Google-Smtp-Source: APXvYqyKzYP/5c7tKmZYfuaiKRhALW+hA2Ba0X8vAl4yx03wQs/M/lWtrM4kjYnaoLcOo7J4HrcKnL2ffcfUXNwVhkk=
X-Received: by 2002:a67:7dd8:: with SMTP id y207mr59917081vsc.67.1564085224802;
 Thu, 25 Jul 2019 13:07:04 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:06:18 -0700
In-Reply-To: <20190725200625.174838-1-ndesaulniers@google.com>
Message-Id: <20190725200625.174838-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190725200625.174838-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 2/2] x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     peterz@infradead.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Tested-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
---
Changes v3 -> v4:
* Use tabs to align flags (stylistic change only).
* Drop stable tag, patch 01/02 doesn't apply earlier than 5.1.
* Add tglx's suggested by tag for the tabs.
* Carry Vaibhav's tested by tag from v3 since v4 is simply stylistic.
Changes v2 -> v3:
* Prefer $(CC_FLAGS_FTRACE) which is exported to -pg.
* Also check CONFIG_STACKPROTECTOR and CONFIG_STACKPROTECTOR_STRONG.
* Cc stable.
Changes v1 -> v2:
Rather than manually add -mno-sse, -mno-mmx, -mno-sse2, prefer to filter
-pg flags.
 arch/x86/purgatory/Makefile | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 91ef244026d2..940f043a4d97 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -20,11 +20,27 @@ KCOV_INSTRUMENT := n
 
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
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
-- 
2.22.0.709.g102302147b-goog

