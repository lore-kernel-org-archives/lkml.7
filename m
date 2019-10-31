Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD5CCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC6E208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P67vDmmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfJaQr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:47:28 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49876 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfJaQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:24 -0400
Received: by mail-pl1-f202.google.com with SMTP id q13so4256343pls.16
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hi8Cu8vAZVRE/aapAAyha6S0ojR+GJofj/wY0IAnOZ0=;
        b=P67vDmmf7l8iN6O8NA0rTRghuQ+TRNhS1arwHEnYxr1ViR1HY50ozBsDIgmKlmnXOV
         md0XEh+hEaxcVLZPP1QTlLYLvdf0FZ5h5YQ+hUhhwDYcR//ZTfxu2AYXNsiA1wS45nTi
         SVUQGq6SEiGtWg0iKnZxq+hsmFHJd94RUh0NNXXCkm0GrJaiN4pxdntxDEe2SE7qvN8R
         1E85Ba2ueIH7RNmmMjNsZslAzajrycwYYcrlzySe7vhPJyXlXhUCKyZb31QYebgcsA/j
         hbzgteQSWbLyHD9/3p76Xl00fiAX0l+Zr68AJyUeyf5tCJXRfOLQIH0Q1QaNskmKKaMW
         A+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hi8Cu8vAZVRE/aapAAyha6S0ojR+GJofj/wY0IAnOZ0=;
        b=rPo8uhjjFj2Rw9+qAF2Jb6qQvOqC0sMCQjg+4eOw9n4VxZ0Xm+vK2KZzVfC9OJkzED
         kefUVlQ5fbX1uNHHXVLhwsHlh6TmZpOTkuCyZxFnH+wAHKc04543ke1BgUFgfsk58coC
         YbvtMqch+OaL9h7KnIq74vB6eh0fCemmar6EpI4JO8lvbvI8FOmEZz6APo00lcw1ft5T
         zTnImlxEwLedqrz0A/A3OQw1XZ5ALrhA9f2eIGhvpGQpiWaYPq4q3rPUutaWcTQbOoBm
         ufNu3j2jtXeIDSnWHSonrc7dGnI1FqHoYoGveEPlAM0mLqQGv7B/buJYdtx2OlqLXTzn
         dMGw==
X-Gm-Message-State: APjAAAXTYu0CjqToyerM4VXpKiJJChHLNL1tRrrJVD9cECT18lhGqTpU
        mGHCRoI0L7nCXKIRp3qbRO6R9gR0KaiZ4/e8urs=
X-Google-Smtp-Source: APXvYqz6YRDXL8kUecfGxnqeQq30ocBHNq/zxXBU9i1Pelv7UcRC8hJJlGnCkmCBQjmZ8Y0bj93wNqvrOEFGlVoQDyk=
X-Received: by 2002:a63:134a:: with SMTP id 10mr7622711pgt.441.1572540443216;
 Thu, 31 Oct 2019 09:47:23 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:35 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 15/17] arm64: vdso: disable Shadow Call Stack
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

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
2.24.0.rc0.303.g954a862665-goog

