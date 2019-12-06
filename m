Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE90C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFBB21835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="au1NZhTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLFWOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:21 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:53182 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLFWOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:19 -0500
Received: by mail-pj1-f74.google.com with SMTP id b22so3121376pjp.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4aDgrw7n3sKpB8rlb4e1FXGpnlGkWbIPMM9nhNp+jXs=;
        b=au1NZhTF4wAsexOlDW3QvGUTHHibdiuoOGtKnmjfRLZ0pPJFJKE+opISQXIrUR97ye
         Jne0qPeQQiFimsKZER4HaK21Z32PFAMdXThycc6amcnFXyiRGqcBd7hzGtaSxtjLovKA
         MtCxYRCUfBUiozbQAY8WWFFWshKqoTOktvqXvtAigS6VHdCV5+fVo6wqlgPIj5sUrPy7
         nyM+Yj6Rc076XJ7CjGnjpbrP4L2nSj+srGB86VsKIU0Wi383uYJUprK31BiItYr5v/o2
         Pxb9DYcCbj3fcvL19VOlmfxX8nuMHZ73nI0/DFRRg8SJ94YuyFgsEVGXyEeevmK3xEjY
         Wuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4aDgrw7n3sKpB8rlb4e1FXGpnlGkWbIPMM9nhNp+jXs=;
        b=WG4oUc743RpxK/dXy84xhvNnc5oOvWVpR1/1UgauPBCTYjsr9BSzGbSYsOPyVfBdU1
         W/H4o7nFq/yzB8Vb4XNzTzysws96tpVf8fdcIw4bOYIfKIRsva1AWPcwsjpMiDyA7h3J
         0/lnaqfvxVEiwCDmjQdc5ARrYpPEnqOD1gysuJLBJ78mCVQSu/pv0JErAhSsxBrIAYyA
         GatrN0V9DbA94L0y4bytrusP7EgQQtiW+Va2SrLnyZ1fagal5P2aW2E/jD7K7kqzSclu
         i/iFMMe7/57hVP4E29QP9Ys8dT8/3qbznQaCbuCD6XJS9tAWC5RGgg68e1mLk3Tg02j/
         bE8g==
X-Gm-Message-State: APjAAAWtS+6mZL+doqCr8C4ZezWgfoomr+ai0UhkUrI53NEmCu3NOJCD
        NkBYZhyNN1R797J7GmGbJmkys0oB0fak6Mkv5ic=
X-Google-Smtp-Source: APXvYqwRlAi+m5KSot17CZFEPydPDuL4iAvmhFlppFfNB1e6R6A3XWaehHnjib1r5pVc/bUaEbkOTOtXqUzvI+1YHGE=
X-Received: by 2002:a65:518b:: with SMTP id h11mr5968857pgq.133.1575670459027;
 Fri, 06 Dec 2019 14:14:19 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:45 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 09/15] arm64: reserve x18 from general allocation with SCS
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

Reserve the x18 register from general allocation when SCS is enabled,
because the compiler uses the register to store the current task's
shadow stack pointer. Note that all external kernel modules must also be
compiled with -ffixed-x18 if the kernel has SCS enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 1fbe24d4fdb6..e69736fc1106 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -72,6 +72,10 @@ stack_protector_prepare: prepare0
 					include/generated/asm-offsets.h))
 endif
 
+ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
+KBUILD_CFLAGS	+= -ffixed-x18
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-- 
2.24.0.393.g34dc348eaf-goog

