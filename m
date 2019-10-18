Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56033CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BDE22466
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTWmB+YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442957AbfJRQLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:05 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:47476 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442937AbfJRQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:03 -0400
Received: by mail-vs1-f73.google.com with SMTP id r26so1566823vsq.14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=soVi6argGh8CkyJ/tZS/XQoN8aAv6F/7ncnrrIAGrbI=;
        b=RTWmB+YRhbyTrupTegTePDqh83wahNiLo24V/vkd3XNh2/VjRfOzsP8l9UA07iBYVh
         cNCOrmz1KApedjuZfTuf+oEAy7uJ9vOjlPpxsg7OkJReg5LlWaNnJSadKKQxT6uV8oo9
         DYHGRvWBz3/GUdtlA0wIAJuRmYFSW5vXFhnZ39LEFxcVI9DqpO8eIN9kDWvp9NjS8BGy
         xN5pkbK5dusYfEE++LF7k5cNY+Cu1x/v4ps1Ft2zcALY7q2NKOD2KsdADykKFGjX/ek9
         pgnN2RfC3QCLk3Iaa8HyaKxHiBf6citZAP2zBGFrT6GXMyCWAMsRsDGnPTlW+RbabIhg
         vExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=soVi6argGh8CkyJ/tZS/XQoN8aAv6F/7ncnrrIAGrbI=;
        b=fzmkheGA7ta/bA4L4nyFJeMhCP2jGDqdw084+96IHN+nSqSEXsMYU3RNJvvwdnUv16
         YU3DUp0AwYOTc5XBxKc4oIiA+iABk7+OefUgsclHzMJGwleUqwMrq+P1tPOC34IiK4nQ
         vvCbl1FMLrLJKcB01ltUwOXVJN9g5RJDtMFh6CxUB53jomqN6mA/bD0Jqd5HYOEtWf9/
         gpgXaTjvZCSoGybGkprdvtCXZKEjBxPN659CWOSrK6BtKxgnHojA6xQvP0GL4oBLfSpX
         VKC6Co4ejXesMN07lvoK+4aNBfbqhLHOSVgTLDZa7aiWrMcARHHA16um8goaZF7SvOjd
         h2Fg==
X-Gm-Message-State: APjAAAUNuJgVIxOyO4TA8OtUi8mB5xybtq0n0G1ShRQYW4wzH/3wWsqG
        wswO1q1QaHDXMOZlhO7VX//aElekpvMjz8M9S6A=
X-Google-Smtp-Source: APXvYqzkAvflPUA4hxOT5c7IqsE0Ybkf3fYa0ytmTSeu2hOJz51kZPeU6sdMsbUTLU2Tls8gLg9QkcQsftcMtRZzrhY=
X-Received: by 2002:a67:e34b:: with SMTP id s11mr5965401vsm.195.1571415062790;
 Fri, 18 Oct 2019 09:11:02 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:20 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 05/18] arm64: kbuild: reserve reg x18 from general allocation
 by the compiler
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Before we can start using register x18 for a special purpose (as permitted
by the AAPCS64 ABI), we need to tell the compiler that it is off limits
for general allocation. So tag it as 'fixed', and remove the mention from
the LL/SC compiler flag override.

Link: https://patchwork.kernel.org/patch/9836881/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2c0238ce0551..1c7b276bc7c5 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -55,7 +55,7 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)	\
 		   $(compat_vdso) $(cc_has_k_constraint)
-KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -ffixed-x18
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
 
-- 
2.23.0.866.gb869b98d4c-goog

