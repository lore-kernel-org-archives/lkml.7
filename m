Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28896CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F213821929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyshMG/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbfJXWwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:39 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38422 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbfJXWwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:30 -0400
Received: by mail-pf1-f201.google.com with SMTP id d126so340408pfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hi8Cu8vAZVRE/aapAAyha6S0ojR+GJofj/wY0IAnOZ0=;
        b=TyshMG/WpQRZO3yfd1Jd7A98WjzJgZlz5cgBusE72nESHGI4zkJTacl+id0OgkmE7h
         AxB+37xlQQGbvIrPLJi6GGLKffKR50gyLvpF58DcjcVhAty/qStODXS2I8KW40lpQKKM
         9wmdN/xJ2SVmeGa9TxRYExC5/DHlRCQ172Z/37iBv0lPikJlYqyLfQHNi9002+g83EcF
         QnIjvisbAv9L9w1EDMmGJaW060fxbyUE3ijTJ/94kINWjZTBB+Ox25zv9w+isMZbiwl1
         KW/zlOW4yuPxJVvvypFUcVHmJ7bcxVD/QaQo/xACVHNXgM04mDK3oI8qkDfcIz4+KeCX
         PBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hi8Cu8vAZVRE/aapAAyha6S0ojR+GJofj/wY0IAnOZ0=;
        b=U4us9grnLvHk+DDqqFNNmB2ZoZ1B42uvY24llsOeOtb3JKD6tZT55/OMwvwBvGjKsR
         YIGOR/djJwtYZYxiFwzmcP4roG+DTnO5ylawP0IsnaJU1qQVNK0d4h8+wJICECKrlrtW
         BKeURArN2OzYq+QMWRJQ/8lC457WgHns4EAB73FywdYO68GoABsNq3XZOF/EGx9X5jmS
         a11ti+fXthxXfAOUHLYqLgc8LYgl6LjuQiCl3lHdw4gGVFWQ2B+kncquHziTkG6xBM+4
         PzDNUBMry6yt4SZDXrg6fO2pKC34Mhx7ItBb5ZeJ7Skv1BAeRmtIdBeP7CJUl5zsnOjR
         BcTw==
X-Gm-Message-State: APjAAAXPkBOQJLUMUSzhF7f/HnhvBattBzVANk0OLbFb+6V5WZFhHke+
        A98URLkITC057mxdEVzPPs32JjmMw8Y5wYaX+XE=
X-Google-Smtp-Source: APXvYqzPFNEl9K3cGuhwxqWJUP7eMbcPYG43NyYUFqf8p2L94x9ufyqifykLbDRReVEDkpgIxS1uIAG4CEwVu64w5Yg=
X-Received: by 2002:a63:e156:: with SMTP id h22mr510399pgk.266.1571957549407;
 Thu, 24 Oct 2019 15:52:29 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:29 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 14/17] arm64: vdso: disable Shadow Call Stack
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

