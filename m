Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0611CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7686920873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6nZNOFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfJaQrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:47:10 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52752 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfJaQrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:08 -0400
Received: by mail-pg1-f202.google.com with SMTP id e15so4767167pgh.19
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K9E/B478ig/3FT/HPhGFdlo0v28kyi4gF0t5BJVte+4=;
        b=Q6nZNOFXJobNQh66SBURqXR9jjgGc7xPtfVgiH00Q94Wq/lt68cuARge++0iJSOHbl
         oW4NMEq+9cHqz9gbyOSyiBZcNrTjy/SOh+b8CYr8g09qvaCHNujmM1eqjZChkaUIta8N
         R1Nytm89Z4g9Csz0lbSdVY2lZ5qMNHUcg9EX/BaicjSL2hYM0k+G3ChifSzc8IJFDYk1
         GpIbxO2R5s2CgPxCiu0JT+4D9XPEJ59tckUnFp1YBhgg19qHemtrJSnWnwdM64fHfqzH
         V51MYQa1MpvdRri6T2bUaJeLk+9cOeQ3PhUqIY7fT381QfU0I53VsE/DJ2wREqjXj4eZ
         2Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K9E/B478ig/3FT/HPhGFdlo0v28kyi4gF0t5BJVte+4=;
        b=IDnMs8drFicVNcmRRysV5A+QT9cNkOOjaaHEryN+kpAioyNk3n2qwjCOE/5d63k4gB
         zW3cQRcPquHgNDScC9fe3m2/ebqS1zQH5scQqBxmPINAXNck3+9fxmuSw2y4C1uE8UkA
         UqISYeBfgRpTj1VNpzjn75wC1Slcc8INK+1STxFH/gj9yH3sbkONBHZfMkQ25wgDPDDN
         WT5qUCFgorSj0aWHEnlfVyAdqkZH3pKgjEK5kFHgpEDzvVCeJVFeMD4qXoZ4s/fUYtVo
         qMJk5GTLbDwvTgNuAEntfral+jZxoq2raa8r0zbZCLFfhJhUFjYeOFrPxz7h6mM9v7mn
         Ni1g==
X-Gm-Message-State: APjAAAUlgFWrRLztyfTN2VVFpm0LumQdJqRFwDKd6uTkCAkMnocBzb75
        0OWLNy+6focToyXCcQ1VOOPAxs/ntrWHq4BXfcM=
X-Google-Smtp-Source: APXvYqzC1qzspsODaXGFhM8lzAz2Kkvitd6Mcb2OnCrnHZg+dDRsPF4zisB/iRaRWzHFab+ubKlzQJYNZnG9GZBONHw=
X-Received: by 2002:a63:e145:: with SMTP id h5mr7826628pgk.447.1572540427770;
 Thu, 31 Oct 2019 09:47:07 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:29 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 09/17] arm64: kprobes: fix kprobes without CONFIG_KRETPROBES
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows CONFIG_KRETPROBES to be disabled without disabling
kprobes entirely.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/probes/kprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index c4452827419b..98230ae979ca 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -551,6 +551,7 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 	return (void *)orig_ret_address;
 }
 
+#ifdef CONFIG_KRETPROBES
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
@@ -564,6 +565,7 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
 }
+#endif
 
 int __init arch_init_kprobes(void)
 {
-- 
2.24.0.rc0.303.g954a862665-goog

