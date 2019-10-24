Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23049CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7B021A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLf+lw77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfJXWwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:41 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:43823 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbfJXWw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:28 -0400
Received: by mail-ua1-f74.google.com with SMTP id b12so117780uan.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+uiLq+iUoKYbKnLFQDjwDIIzqGudQy8o1UFEOkmkrHU=;
        b=uLf+lw77gVEoxfyZjVffG8N9AkGSFT6SZ7rKTY6igTbvtmj5tkgs6S87yKXapR9kBD
         NfJzX9FsM1QPF/BRZh7tuTNd9Bft+wBmoGpSgAiFGgU/eFojwHMx3hY/jiQo5OXG88H+
         n+2/sETYJSjx1UwcF1JDwNNf9o+ndIsqNQGNcfRmpV1CBEoxTmXgI879l/WxjZMkcbmb
         kFXbiNvmWzULL9yr6G9yxYiRMJuYM6XDRrKUuDcJ0X91UFc9CGS/3Wg/GkwQsbD/KzdG
         KcYEc9VsXZBk/vRUd/5xFUU2jMu6PAXVjvl8vJIQVZYzQ1oFFfyD8naEYVJQbR65Robs
         mdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+uiLq+iUoKYbKnLFQDjwDIIzqGudQy8o1UFEOkmkrHU=;
        b=rUGj0eWV2JM2r9c6zcVGf3mQq83CGs07WGnJAqpRgTg6gFbUgjmi3mB4NISHd+7ho+
         RcOHfy/GY81rRVgSOlWTWoGj/nkGy3/rOnEpWChN8sQVUgPJxw3890+SM1O1soGI1n16
         stmpdDuw6Uphhw8ccnaOCooDBVu+BmDXoi95iGTW+jxg+2M31e7VenbuGOqk+/i+tZnN
         Li/YZmxIAlOw6M8L9ynKQv1MFCMl/H7HBkW644HRRx402087TkVBWS/j9sQLEEMrTzFG
         f2sPGW+x2CJr3sCqPGeMFAQ7gKd4P1Wz6v8L/pTyEXccHz/JPIVokRJbm7z+DclF8K2G
         XWew==
X-Gm-Message-State: APjAAAWFKZjulMmlKNOYf1ghf8mUGE0M5tyL2HR2ssDrPRaV57zYK7R6
        e/9TDUsNKDLVxfxBSUhFdYG4FD+llFvUlTxmE3s=
X-Google-Smtp-Source: APXvYqzRSdeSSRgGBGnoZCPWuY69NwMrQK4NIj2mmmt3agCQs8uemlrog/B126rrh1wmew1IPRee+I1rJJkV4cdOR3k=
X-Received: by 2002:a9f:2271:: with SMTP id 104mr36427uad.127.1571957546730;
 Thu, 24 Oct 2019 15:52:26 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:28 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 13/17] arm64: efi: restore x18 if it was corrupted
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

