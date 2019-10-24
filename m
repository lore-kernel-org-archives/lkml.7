Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A35E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8RCJ99r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbfJXWvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:51:52 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38936 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbfJXWvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:51:51 -0400
Received: by mail-qk1-f202.google.com with SMTP id s3so381251qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8uBb3Aen2dVYsBIXAkNtXm49lkX7BN4KRJO1G4p19Vk=;
        b=W8RCJ99rqMNSxca++LAfzgn9Hg5nsdw/jcT/ymNLnIomChmMSfpKy/5K4o/1k/cope
         pvdfHAJKVdtQEPr2YqdFjda4aW3t79WTLfMMzcOvvEvdTD0U6EqtgfbfxYWZVO9sjiY+
         zEnGfPJbe8LS/N7vf7ALrv6LHSVfoFuWhv+dbTHpfvLSDUZ/YLX4oFvgdgo0OnugGkrj
         JKW1QHjgeqgxAUA740iXA+/IxD/7imuI7v3wbag+0mF+zuCp6Z2P20cdm1A7O2WfTUdI
         +qfMO3ffD91g9GAotg+kdf7w1pgyq08sMv2uL337HBaayPhI0S+ZBH9XK9yfohm5gvtd
         xHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8uBb3Aen2dVYsBIXAkNtXm49lkX7BN4KRJO1G4p19Vk=;
        b=TEFJmOPtpOYApWghqIRM1adS/OtWkbTCyIb7u6SGVidW8OWBpQwgyGN1VY5jmi52hM
         kU5UrVBc6EMieCuh0ETLKL0ZLogvFFzxgK29HtQS34u5H+SzfNuNSpK+yKTIDtGfUyYA
         zeKCJCZmFGMz7X+7A0yFEzuzi9OZTIdDCio8021zGIJWz7cKJIOMuy6PCC5XhI76Hj+o
         KXuURgcw+koUbv/0PQlGjYFJJ93vozqpJPMjuNVeBFanTmyZIjrv4+xc6980t7qYZuzd
         Ow66ATeoRk+u56QE0QSMyD5cZ1yNV7vFI2LMxvW1WWRZA6zyeGx5DO09M7AaD20hNCOY
         gM8g==
X-Gm-Message-State: APjAAAU0NsBO3oZX1eNCMCXo0Xw4M7ATVyijPBPThVOym/OvPKKefAlU
        vUqRnF9/iq2yiOTmcIDxb6rpds0BEg4dZtQsqEI=
X-Google-Smtp-Source: APXvYqyAW+odimb8mqBZPHs6TqxZmYsSpEILNj2+T210mEYVsUKBCmHHKxuatkppUxskg81WnKWCamKvy9hzbbiUomY=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr127821qkf.283.1571957510607;
 Thu, 24 Oct 2019 15:51:50 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:19 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 04/17] arm64: kernel: avoid x18 as an arbitrary temp register
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The code in __cpu_soft_restart() uses x18 as an arbitrary temp register,
which will shortly be disallowed. So use x8 instead.

Link: https://patchwork.kernel.org/patch/9836877/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/cpu-reset.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 6ea337d464c4..32c7bf858dd9 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -42,11 +42,11 @@ ENTRY(__cpu_soft_restart)
 	mov	x0, #HVC_SOFT_RESTART
 	hvc	#0				// no return
 
-1:	mov	x18, x1				// entry
+1:	mov	x8, x1				// entry
 	mov	x0, x2				// arg0
 	mov	x1, x3				// arg1
 	mov	x2, x4				// arg2
-	br	x18
+	br	x8
 ENDPROC(__cpu_soft_restart)
 
 .popsection
-- 
2.24.0.rc0.303.g954a862665-goog

