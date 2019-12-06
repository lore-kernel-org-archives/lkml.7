Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D1C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FAE206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1Wx0pmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLFWO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:27 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:36402 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfLFWOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:25 -0500
Received: by mail-qv1-f74.google.com with SMTP id r8so764467qvp.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FhYYEjTDkPuKHbZnKePlOaf9pf8CUWO3nD3sOS+po+M=;
        b=c1Wx0pmgZzJDLcr5nKIxS6pdb72MNBZXygUHxUgHfIREUjivSfJmFNkd4nH821+c7c
         XdMpdHUqSUmAmYnv/wYcSmRCYqJtUh+jdTQ3/0TYFxbvGCg3KubysunPGfqG0BjN6R5p
         FZYsTRty1KKiwCF3GFPmHDSfqSVDKBB9Dl9Svv8Esh85iZQ6Gp8IldBOuKDVG0NAYrct
         KCNN1c4Jt5Qnd9QE5BIqwUiELeUVYdQWv32ArtiqQbBLSzZpaS8483/PTd49tfr3IpbZ
         ZlBwyqxJM8pdiJ2dTz9waDv/2F+kWZdAUGGPKaihus1bQ20pRuQajRsHhJifC3dGS/Vz
         k2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FhYYEjTDkPuKHbZnKePlOaf9pf8CUWO3nD3sOS+po+M=;
        b=N2cUY7Wp//m09h+MzwlnHTL0hygXJnpMpx2DJNKtCdwhe/KnKpdsUWfZFoPsvOq5I8
         JXUb/T/rlPkMwFWZTSUZCnL9KsZ6xG8eWfNutvZ66H+GeeRkLyOG3WQMUqafrmkseSaZ
         SmreTujOvkPQBOYA6B6+USHCmJ/2BZYe0W/DUMc524P+i5/hUSiH6+XwEKKsn2tyfTif
         6vmratKmnrje/S7fIvwrOKO740mF83DvjGakcsc3JuQGwE5/zPYI4ZTMlRHuYOqZ5L3s
         qIE3VqYobuJ6opFDj55QAT7rIQohvvD6svZRmkqxHd38L2WX430npdAPTKrcQ8KBuIyB
         GMlg==
X-Gm-Message-State: APjAAAVg24zoLLZfHWk3wFt9a/J/t9N/Ckzw9jAUTIkyaSCwre7xvnvJ
        yYNrBcqD/LMsacFN06TqnAVpur6t02yijg/7va0=
X-Google-Smtp-Source: APXvYqwZLBeooXOHcOO29WvEdpgbxookvNvj944sJ15kbZCCqA2Ea8mnulB5DEVBZW8wLWpSg85W/yQRRXH7nkmyS6o=
X-Received: by 2002:ac8:2201:: with SMTP id o1mr15071384qto.247.1575670464028;
 Fri, 06 Dec 2019 14:14:24 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:47 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 11/15] arm64: efi: restore x18 if it was corrupted
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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

If we detect a corrupted x18 and SCS is enabled, restore the register
before jumping back to instrumented code. This is safe, because the
wrapper is called with preemption disabled and a separate shadow stack
is used for interrupt handling.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 3fc71106cb2b..62f0260f5c17 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -34,5 +34,14 @@ ENTRY(__efi_rt_asm_wrapper)
 	ldp	x29, x30, [sp], #32
 	b.ne	0f
 	ret
-0:	b	efi_handle_corrupted_x18	// tail call
+0:
+#ifdef CONFIG_SHADOW_CALL_STACK
+	/*
+	 * Restore x18 before returning to instrumented code. This is
+	 * safe because the wrapper is called with preemption disabled and
+	 * a separate shadow stack is used for interrupts.
+	 */
+	mov	x18, x2
+#endif
+	b	efi_handle_corrupted_x18	// tail call
 ENDPROC(__efi_rt_asm_wrapper)
-- 
2.24.0.393.g34dc348eaf-goog

