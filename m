Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A3EC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FE821900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5sBWcpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbfGVVdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:33:47 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:36783 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfGVVdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:33:46 -0400
Received: by mail-pl1-f201.google.com with SMTP id a5so20620208pla.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lRY0zisiksIF5oLsqk7SdFjADDPWr38y9Kmpdd3lLF8=;
        b=M5sBWcpBd2bTR6EdJX1ZTfns6OrNG5/wUzgqOKykycN9ggYpd0DCEnzUcr7zlTRkID
         krH5qM8cY9GKF1awcF4kNgRYDn5cOrTTHAMYFgdOtZAkCRJWhmYJi9vhzQVk8JYZzlGO
         A4PxoOUbmnZdRhEzicMJg2lRXanY234OsACFhdboH06Z/BfUC9YVYYxPHyf4TaB8ush5
         qLFqrmPahyS22GDG0bQkIzdE6EFBy3vjMSWbpHYINyxRyhbOJxhvV43HgxvprYosTi+D
         0nW+Q9WMdczgo5ouvIYIyIt0XI3+eJx0ZprRyT4ZzLkNQDcXYO9RYFUq2bybvwxtBV7/
         KRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lRY0zisiksIF5oLsqk7SdFjADDPWr38y9Kmpdd3lLF8=;
        b=I8S0S/MXPYXmo/UOZg8wkFm4gDckLITRbvcTEYb+pWhxP4u46cQVEkaxHcDtgENUsF
         oTtoL7V6CpZeuZv6OFhBQT3nQBFaR1IUQFenmSAZPMDiPNWmOrtPFB5VbVoTcZD6QcL2
         Ws9RfHOZO5ytrCHSTUc5MY1nUSfWH94dCMp5bayNRZKR18y+2nqQCEKpArxnBTS7Q6j0
         7dqgrfvslYuXPoPzalRYlUUle612KRBEPJqW2/9WoQtvxfgyydTMrpwG63m6MolhCpAO
         hG0ptmm5i6b/TVs/Uik2KPsNMDAlgPcwdtqptqRh0aNtRjVH/EdX2uzifAaxHDqTbYWr
         GJpg==
X-Gm-Message-State: APjAAAVmGUKxSeBg0Pmx+6MKDcgvhT2yeQPCq8Go9jMj77QNDpPI9uQH
        qA9Ur5LzTwdMLg0u5gk76iQOWTqcumxBHF034wk=
X-Google-Smtp-Source: APXvYqyzNB097kR91D608MO63iKM8dBAGny7yBh0/Zp1ng4QB5WHGj6CGNg1fSCg29O9ow0oKyFE3nNURHsSKlRGXsw=
X-Received: by 2002:a63:f50d:: with SMTP id w13mr73259220pgh.411.1563831225390;
 Mon, 22 Jul 2019 14:33:45 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:32:45 -0700
In-Reply-To: <20190722213250.238685-1-ndesaulniers@google.com>
Message-Id: <20190722213250.238685-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190722213250.238685-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2 2/2] x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     peterz@infradead.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KBUILD_CFLAGS is very carefully built up in the top level Makefile,
particularly when cross compiling or using different build tools.
Resetting KBUILD_CFLAGS via := assignment is an antipattern.

The comment above the reset mentions that -pg is problematic.  Other
Makefiles like arch/x86/xen/vdso/Makefile use
`CFLAGS_REMOVE_file.o = -pg` when CONFIG_FUNCTION_TRACER is set. Prefer
that pattern to wiping out all of the important KBUILD_CFLAGS then
manually having to re-add them.

Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Rather than manually add -mno-sse, -mno-mmx, -mno-sse2, prefer to filter
-pg flags.

 arch/x86/purgatory/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 91ef244026d2..56bcabca283f 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -20,11 +20,13 @@ KCOV_INSTRUMENT := n
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
-# sure how to relocate those. Like kexec-tools, use custom flags.
-
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
-KBUILD_CFLAGS += -m$(BITS)
-KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
+# sure how to relocate those.
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_sha256.o = -pg
+CFLAGS_REMOVE_purgatory.o = -pg
+CFLAGS_REMOVE_string.o = -pg
+CFLAGS_REMOVE_kexec-purgatory.o = -pg
+endif
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
-- 
2.22.0.657.g960e92d24f-goog

