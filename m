Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9058C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DD624673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3PF25I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLFWO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:29 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55304 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfLFWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:27 -0500
Received: by mail-pl1-f202.google.com with SMTP id 66so4244935plc.22
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ve3ap/e8LZQd2dbv+oe7rMBjURea5FcvbovcdBkDba8=;
        b=r3PF25I8b9gh7TGG4nyyWOG/IBeyi5leohyetpHGT7HVJVhKrS0Kq4x36qkr37xPQZ
         H4HOZxl0BVJe13eGlGPV1yZKSRRS5AmoOeRlUDllq58XEGXxaFeTrlkb9BrV5kcixQbm
         XbGbrkKiH70yhU3gMykfI079m4y0ZDpdOP7kIIKS/yBz18w4YMZf4Pr4H9aBR21ygtcB
         kY14G1EByPoZ/HSscjak3f91JNKl95S2IyZpSGv5MX3WaPMUnLjTgAsAI0PC749M53m0
         8RfjY0MYNA3UUEnoDTDY3HwUrUHVLuT76W4oleiH3t8Kx7xMLKek/nE2jk+/o2pgp2U5
         oBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ve3ap/e8LZQd2dbv+oe7rMBjURea5FcvbovcdBkDba8=;
        b=MbOEXIq3UQmwIJZ3vYZAP0sLb7odNbikmmlDF4+XqeWzsmiThbIQkkVvfGmlqWjyYH
         qzUxyjNUWsU9Ue2EDF/UgbnLuvupjFoWBUMzrR/mMIE4kK0kpWVT9bJ8x1Tnjau9bkKo
         87w0Hp/uDLFs/80DuT4wPeUIQUPtOFi4Pgy+vRc7aXwARMfJQ0BW8HgnbNyqT+XdWujK
         rCLTEeh3Hku6b4KaJ7GGx8qJkBHY+IABTQZo2Hj5SL5/5LySNPzbXZproA52K71qMYnJ
         s3Db4cYS/gqIPgyBJlG1Q0sLZiiQJuQKiWpmYcY+Lyuyh5IBie+wNpb0jK07r/igFJaU
         DrQw==
X-Gm-Message-State: APjAAAXc7AY8GFR16aeIoNjRoUmRIxZVa53xoDlq7qg/NrPeN1sP+ptS
        U8vFizCboDytQkvIepKIVMw0Gw94HMQyQ9HzPX0=
X-Google-Smtp-Source: APXvYqwk2eRK+EeshXSfp5tSqqdwzFGqYQg2Gt1CoIRgkLdeR9mCxHtnbRaIQkXosCwRykWO94sSQGC7aLJzBhMw49s=
X-Received: by 2002:a63:220b:: with SMTP id i11mr6011463pgi.50.1575670466460;
 Fri, 06 Dec 2019 14:14:26 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:48 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 12/15] arm64: vdso: disable Shadow Call Stack
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

Shadow stacks are only available in the kernel, so disable SCS
instrumentation for the vDSO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index dd2514bb1511..a87a4f11724e 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -25,7 +25,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Bsymbolic
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
 KBUILD_CFLAGS			+= $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.24.0.393.g34dc348eaf-goog

