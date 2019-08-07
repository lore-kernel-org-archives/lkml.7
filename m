Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1132C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969772173C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vy0xZl3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfHGWQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:16:06 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:53276 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGWQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:16:06 -0400
Received: by mail-vs1-f73.google.com with SMTP id b23so23532171vsl.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BTH9OU52XeEKf7Mqa2TrpR96t0HPiKB7u1PceO9qGi4=;
        b=vy0xZl3mSShgz3JGBMwxgQuVZpsaYyR6IY25deU1dTWEhTr7xjVmDBky+8ZfdL1zHI
         J/+GO6boE6x0DYVbMS2zqMybhMsbHYwaUxA8FubywXajSke0u1fgmAZvZbC5P4HTbeDY
         dSJV4YQw8E9tuoI46QW0tjEqsxgVNo6Ok1UUnoVjs0SYceuXPHA6iAFviVXk8pugb177
         rpqVQz5TFKjDYEAAlRBQNkPLuAiwNzvLpEWsaRwt5xTuf4qoGFX2nZNfhhiy5DI1OSC3
         Il4Ys0t9SFbefq2GMTBlVnTdDevukPSA/8pmO2+MJT2EuwrQvY0nhe+hw7OZtdLIikj1
         +PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BTH9OU52XeEKf7Mqa2TrpR96t0HPiKB7u1PceO9qGi4=;
        b=KAc1GU++GNKN/XpMcsaSalsYhkh83TKwqSWWF3NSUNcYtoteZSetM+2ZzQobP7aWJM
         Lf9/EnUzGuAahwBF+OaEhY0z3wkj53+EworLF9qgRZWdnOmFQBFL2wknrJmhE09B2c5j
         xBbRgQ+n1UWF1FAxBkhi+NOQ8RZZTDZ9BdBJguzSX4HiN0ndPKTaue7GJudRdZ91aq2l
         4xyIXVK9EQrxIxln8RhRqJERDmQT9Pnzb4Oyb88BoPzSDakvB3C3Uzb82K1UoNPiEpHq
         PxOnsyIeMQuUBcz2L/dZESgNP1fRN7f7IMnOLKjNXSP1c/8uI0MBrckH0ITMQbF+1kAH
         YvKg==
X-Gm-Message-State: APjAAAW9y9Hy7+cX+cs1AthUoO6waUovCwFLzlS/85ZMzxNaqFZnJlwm
        +AUucLyyK4sSdyPctJF3JfAMQ0l63Gcl7Ua+xzk=
X-Google-Smtp-Source: APXvYqzR8z+KGqg+WRpDl4EWzaLU33WHQIU38qoIdy22PA0lnaDsouGaMrm9eulxgGOpGqR3j1T1vLb0M3RYV5VFW7I=
X-Received: by 2002:ac5:c2d2:: with SMTP id i18mr4433043vkk.36.1565216164900;
 Wed, 07 Aug 2019 15:16:04 -0700 (PDT)
Date:   Wed,  7 Aug 2019 15:15:33 -0700
In-Reply-To: <20190807221539.94583-1-ndesaulniers@google.com>
Message-Id: <20190807221539.94583-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190807221539.94583-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v5 2/2] x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     peterz@infradead.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org,
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

Cc: stable@vger.kernel.org
Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
---
Changes v4 -> v5:
* Add RETPOLINE_CFLAGS when CONFIG_RETPOLINE=y as per tglx.
* Add tglx's Suggested-by tag.
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
-- 
2.22.0.770.g0f2c4a37fd-goog

