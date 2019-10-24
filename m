Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE881CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A6E21929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgK71Gir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbfJXWw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:26 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:40522 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbfJXWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:20 -0400
Received: by mail-yb1-f201.google.com with SMTP id q127so450616ybq.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P4MEC/JNWY+R+03CT6BMcXkN4eq/H40mvA6s8gty/0o=;
        b=LgK71Giry5j2UUrcqZm8M1t7G3cAfX70fiBl3GzVzX02VQgK8Xy/2JaMhQllH7/ZPL
         nbGIhdXyHvO6fXRGrMomvZJWhyGPRIV+y5d/BACVs3jLEuafWJis56Ilg2TYMyAOMkM5
         SfUjIveEskgTQm3JvXHTwS4MAd3espod1yTXwztKlrb0HBnCQxMl0mltDYsrGzXFlpAt
         6tZqhZ8nWrGVt0cWZi2CF1EWQFTr31Hkxzp7LT+IslJa1Cl5Oy3SBFezMzAOQVF4maYG
         e9EgGYHPCM5PcJ0/rpT9DVxNu/NMQhoXs2qqn/CdhLriWJXwzW/tS3v6g8YNS9Gn2Pkb
         dSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P4MEC/JNWY+R+03CT6BMcXkN4eq/H40mvA6s8gty/0o=;
        b=ElBxoXlnEqiEvjpLv7okxKLKvDFKqR7V+XotdUo/YV0JDe9ZuxxOdeH/UbnrS2xsS4
         QSMV+XgEz8FP1K0GGOcArpYC5nk9akPJre+KR7Vo1T6b+C89vUjgV0s8XzuJU0efJAmV
         W8taLmU7k1wHC8ErGasX29tIPLjaJhlGt+fHC5MPYXbgbpdLBFdHAjETbm3kpMvOob/F
         SIkQNQiQ8C8i9Y5H9ZJY6/QBdqolUnld4Ygoi639D5YuWhBrcyn09/P7xZe++SqOGkbE
         2ZW/O1PaIIefFhSX02g9c+2l6Zd7pITMYtOth7CofOEcpsAbwrpTkU1O9uwq0GBVLBmY
         dVdQ==
X-Gm-Message-State: APjAAAVOOxXW9JKdIZbWKsPcpBNUqM+2K5yPgUImxikFP/LOImNWo3Bk
        Y478NMEOD26c+MJe/iXCCxDhmHI9DCoCM2PpAd4=
X-Google-Smtp-Source: APXvYqxj5BIdKecvMwrjzhKVp3MzlCFpXSuWCACeGyF0YdtpM7lXtWd326/xzWB6Xxpi8A45K4ijH/MY+l7rtLgFqfA=
X-Received: by 2002:a25:2a46:: with SMTP id q67mr381984ybq.123.1571957539222;
 Thu, 24 Oct 2019 15:52:19 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:26 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 11/17] arm64: reserve x18 from general allocation with SCS
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

Reserve the x18 register from general allocation when SCS is enabled,
because the compiler uses the register to store the current task's
shadow stack pointer. Note that all external kernel modules must also be
compiled with -ffixed-x18 if the kernel has SCS enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2c0238ce0551..ef76101201b2 100644
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
2.24.0.rc0.303.g954a862665-goog

