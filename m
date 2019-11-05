Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A96FC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B72F21A49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfiPTkyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfKEX4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:56:54 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38941 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387601AbfKEX4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:49 -0500
Received: by mail-qk1-f202.google.com with SMTP id s3so22994756qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oB4lIvjzdBiHgRAUphuiQVPgI+jp2K5bMoUCGUiH4hk=;
        b=QfiPTkylKak2JP/fA92kLS2kHYHGvI0ROKKMGBuahal4YLtzvGBJN27XjNyiQH8HG6
         yGlyTyrU/unO2GWm0Nv4aMpTNLKbJN+tCvpwionJjZcpDaxtYqxpVnIYWW0enJwD9cGu
         H3LPc6bHWpLSwRsuEbG1JVtUql2ni5CS0AKG2Gtvj/sOGcnFyVzwIGABxUDq4hnShW0d
         YrnkM62CleNkLuir4Rfyub+T9Qd7Ss628T/1ROy/StYjkO1JBGOTm6WgyQ7LRFXQEEsm
         JL468RJSiozD/j2M3Vi+OnMGSwmwEQH4MedG0ZFkg+53Rwgl2MeC2pLijfEUHj7jkGJ/
         9N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oB4lIvjzdBiHgRAUphuiQVPgI+jp2K5bMoUCGUiH4hk=;
        b=aWdSA4bBnIxObWUPueebOcM/c3yN36wZRYeE7vp1ldJymhD/MkUTRa3+W2YYTrLk7E
         c7D5mYBvN3BKu9vJd/PxXkUH6rjx9o1LsZJh0k12XrLChs+FQXUY62RjsgW5UFHpp0mB
         aIFhFrujw02OJqaygPvHZ8LUOBJZN7nBkprrdwqetjw4IYffg9ReHOLPYDJNcPFWlQQF
         O9PnaNJ8wVlG9jqkePHEuEw3cn47So2x/ng++C1FZmOYLdJGSpzEWFcQEzM31tDH1EuK
         PrPqEy0mQsA8cFHXAq9mJ0pKe0PGeNlSwNjghdSNWdIVBBlEo/+sVEG37KnyR1ESbHXh
         Sa0A==
X-Gm-Message-State: APjAAAXreAC1oIVw2A6NVv6doCvuE9G34UJBgILlIe+GUJ1m4OVVLBD3
        3mZlh2BeT+qyTkpYkCi3cHXZppP4EoSunfzkMg8=
X-Google-Smtp-Source: APXvYqzD4X/kPtbk+w3gExO5Bezjz7X/3F/Tl84XtD5Pt1TYYSMyOibW/2GJGTtsQO1axnooT5H2E3H7HeWsFEsu76A=
X-Received: by 2002:ac8:4543:: with SMTP id z3mr20376230qtn.41.1572998208364;
 Tue, 05 Nov 2019 15:56:48 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:56:06 -0800
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191105235608.107702-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 12/14] arm64: vdso: disable Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
2.24.0.rc1.363.gb1bccd3e3d-goog

