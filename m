Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB11ACA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D32208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjwr8ND7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfJaQrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:47:24 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52419 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbfJaQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:21 -0400
Received: by mail-pf1-f201.google.com with SMTP id 20so4987190pfp.19
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+uiLq+iUoKYbKnLFQDjwDIIzqGudQy8o1UFEOkmkrHU=;
        b=kjwr8ND7m1cv4iSNuEZOGhNW0Jvsmvr2aFrQFvCwGpKkkbxdVb8El383SJnvJL4kdI
         iUDB/VVToctJt6509RMF+oFsBcmbyjOjvFn9KZDRf7pUssUIl1plh0aaN7R1AxB1fYrG
         hVxnJ8tSwgg+2SqSgKWSR+qrYYrzF4/c+dAi5buVvIC0R4crMHKtWJhzr9H5KMHgiHKt
         Yi8bhEI9jYa9tcUZiNkBfQ5fzHUOBy9Tpz2CR4BwPRaTdxRCiczEcBH+q/e/DZVOR+5O
         j3GZxAU0PHjXfHImzbELWB2v0FfyOuNABYuHhuZD/+DaNds085oMgYh3IsgJGrFnX19+
         vt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+uiLq+iUoKYbKnLFQDjwDIIzqGudQy8o1UFEOkmkrHU=;
        b=IqiQfOEKVrIkmGsxn//8aGner45Sw4g3guz4p+nrubjQFOzEdjsyMMZ/krXTxpmNpA
         c+92AYp73NdAJja77OVrnJ+2uLEoW0hF53C+J7Lh2F+WiFyYbEEDYRCYbo7rfWQF2o1G
         AeUP2rPlJOPTP2/8PA+KPlQ4aQ261tPxQdY524LGDRk+Z0bZIASDjnwPH4h36ae6+2Rp
         r0dTElqHL+J/o5vslYN0DLri9zliTsyNrPGNvs1yc+tNBeqT2+MV4OA4geFLjTJneOE9
         eUEO9crdzwG05LcJOzm74N/68eO3AlpDADeacIe7A2VDkHbEyZjPzvzz+3pt9EY9kqvT
         4kmw==
X-Gm-Message-State: APjAAAW5m3hAOadoaqKMzEoAXvx+ibndrK+vTTdySR660NHqhAieORKD
        460iQ++eUx0NzFpCqR3lT+RBhv1QotknYloGLBw=
X-Google-Smtp-Source: APXvYqzlFxyF121CIe85RASYbsEhGryD+IkK99FgQ3Ziz6Hy8dGPnJj8WzzVEyeNtwDP9s/uUld1eg/MwcrX7ost1fA=
X-Received: by 2002:a63:64c4:: with SMTP id y187mr1758578pgb.150.1572540440772;
 Thu, 31 Oct 2019 09:47:20 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:34 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 14/17] arm64: efi: restore x18 if it was corrupted
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

If we detect a corrupted x18 and SCS is enabled, restore the register
before jumping back to instrumented code. This is safe, because the
wrapper is called with preemption disabled and a separate shadow stack
is used for interrupt handling.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 3fc71106cb2b..945744f16086 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -34,5 +34,10 @@ ENTRY(__efi_rt_asm_wrapper)
 	ldp	x29, x30, [sp], #32
 	b.ne	0f
 	ret
-0:	b	efi_handle_corrupted_x18	// tail call
+0:
+#ifdef CONFIG_SHADOW_CALL_STACK
+	/* Restore x18 before returning to instrumented code. */
+	mov	x18, x2
+#endif
+	b	efi_handle_corrupted_x18	// tail call
 ENDPROC(__efi_rt_asm_wrapper)
-- 
2.24.0.rc0.303.g954a862665-goog

