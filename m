Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E607C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26262218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEi55mfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392030AbfGWVYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:24:39 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:32939 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392019AbfGWVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:24:38 -0400
Received: by mail-qt1-f201.google.com with SMTP id y19so39600458qtm.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4zjV4XfUufy/ohN9fql/K25fvrQNe19KfVusxa+S+OU=;
        b=QEi55mfOxuFlP7kIfXPSbx+dxygSE6PsdAiu65v918SBDWisH1ZBMm90Vl7G99tLuN
         J50g5a0gyaMPwnKLu8iWiKON3mpzo14Pgth183t3W8QRPD7YdrkhbHZ2SJO/uSTOEMTK
         aVPQhc6fKnNyXR+nZi6HXg4HIUY1jQMGknaUmpuuoUY/aDaKD9Ywl6SY6HF45XbMwYC9
         YuxBpInkQqH9Q6hCm4VEOMZt51s0SVyjDaMp50h/EoClzSvT8p/iRCTRwL4ssQOWKOnv
         hXO8LpAXeOU2OHvHZNG/xxbn8mgeJhDUzIi/q1BaKDSSeMDgzHuSrk/qXJzWysUXK6YL
         gGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4zjV4XfUufy/ohN9fql/K25fvrQNe19KfVusxa+S+OU=;
        b=YWtw3MnYIC8L43P9oE5DqPX6+XBuBh3ap4CilwWfiFyRaer1aAH8Z6bSLjrzGPQjTO
         RXR9AS05OXMlxL5DeyW4tvYpQRoelV6PIejINDHDvGF2IbJI8cv5+CbOQ6iAEX8+UsyB
         P1mo8L6dqPT1soMWga82K727wMC+b3EK/+anPp9ySsslgpHVTxanAd+dtinnUsfUHvh7
         HMboN2m8sxHI4nMVag3iz9KH/yo5l9EKVgMM/sD9jrPXLPBSfDYQ89nYSdOJAhOgmH/W
         dkBEPdTVHHkeAaetiVHNpCBBDhmc+1obQs3wEzGIsUOD7QEpd844xdsBhYfqLYlE4SZY
         2zpg==
X-Gm-Message-State: APjAAAWC6VWdBlYbEFJAtjLyCEijjb1N381mKK5o8kM7nfXOgoSuXHM7
        LJ5uOpNyJtcriiY6hWKIxU5trygZTPcDl2hm7fE=
X-Google-Smtp-Source: APXvYqwEFc5UTGb/nQzWjw3v4tcOhLCiPXWZR7THRGiuou5L5GbAOaQxUqx9H+AvSHqenhot05Wrakvh5MYJrZsGJCM=
X-Received: by 2002:a05:620a:10bc:: with SMTP id h28mr51387214qkk.289.1563917077378;
 Tue, 23 Jul 2019 14:24:37 -0700 (PDT)
Date:   Tue, 23 Jul 2019 14:24:11 -0700
In-Reply-To: <20190723212418.36379-1-ndesaulniers@google.com>
Message-Id: <20190723212418.36379-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190723212418.36379-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3 2/2] x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
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
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Alternatively, we could put these in all in one variable and remove it
without any conditional checks (I think that's ok to do so with
CFLAGS_REMOVE).

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
index 91ef244026d2..6ef0ced59b9c 100644
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
+CFLAGS_REMOVE_sha256.o += $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_purgatory.o += $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_string.o += $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_kexec-purgatory.o += $(CC_FLAGS_FTRACE)
+endif
+
+ifdef CONFIG_STACKPROTECTOR
+CFLAGS_REMOVE_sha256.o += -fstack-protector
+CFLAGS_REMOVE_purgatory.o += -fstack-protector
+CFLAGS_REMOVE_string.o += -fstack-protector
+CFLAGS_REMOVE_kexec-purgatory.o += -fstack-protector
+endif
+
+ifdef CONFIG_STACKPROTECTOR_STRONG
+CFLAGS_REMOVE_sha256.o += -fstack-protector-strong
+CFLAGS_REMOVE_purgatory.o += -fstack-protector-strong
+CFLAGS_REMOVE_string.o += -fstack-protector-strong
+CFLAGS_REMOVE_kexec-purgatory.o += -fstack-protector-strong
+endif
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
-- 
2.22.0.709.g102302147b-goog

