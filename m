Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050AAC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DFA2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDgKQccA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfKEX42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:56:28 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:55933 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbfKEX41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:27 -0500
Received: by mail-qt1-f202.google.com with SMTP id u23so24225651qtb.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E806Ihq7Qr5kwAxZ8O8jq/5GK0i44oON304BuEfvZ08=;
        b=QDgKQccAQsH+R5h45PS8H6bNgjwH8RGSJOkAG/AGuoy5YWBicw4QukLKRyaCj/ZX4C
         S4zge4BSm47qikuijSk/1DeLDJdEzJKyjjpMkCVFyBe8iRT+BVtRIzaIEOM4Sg8kMqqp
         19PNx89unPNFUWHLbXlCN0veqqqj3T/UMrnqvSODWT2d26uSn9YoutJHq9olqlmfvgF9
         quHA5kvZggYfAPkKhiPNj+ueCkFnNP+twN85T1uWZaZ2Qu7624dIYDxVRZ2i6SnFYV+M
         zMwC8p5EGVUt8lQAk9+5QoxNLcfzBFJJ4Q7ld+hIBbOPsyda1IzIoSUjKf8hfnCm4zFw
         faOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E806Ihq7Qr5kwAxZ8O8jq/5GK0i44oON304BuEfvZ08=;
        b=KDaaHpjqn0eo66FEnhZbH0C3dKP1BVw++RMdFvmLUAe1g0AIJWviZlnVjoaNmG7kzV
         TRQw4MWTk1MhpcpIF0ZC0jM3sFp2aTZVwtV2QRpazwb9rvLNjM5mOAPK9IU0F1JBzsFB
         h4LR/on7QRYI4aTGTnlJQ412TrKxZ/SzkT7Vp4XI9ZhIXVUGrjKvcutxPQkoTudPaePx
         Ml1XYBsHbkkmihr3jJ/U2Yh1Gj3HhtruRM6jtIakMkAsyCUi8XPr0U6Yy1ae/gVDDxMY
         iXq9X60vM07Ax2Isxv6gk2GsV8JDOeH7qvNO/+78KLH6xf9wxEODeiffjkD8vFZrqLoj
         MZtQ==
X-Gm-Message-State: APjAAAVvhgBXl9lQjMsniO7fBbXmjshQFt44PTLyieRcIPH7KygXBs7P
        +l36mQmXrg3ZzvYhn5Xo4nyan8Ve6RFxqqTfmgk=
X-Google-Smtp-Source: APXvYqwY9fgInvZ1xEGl2M4KIBWFyexAkAf44oIrqVL/dQVZsayL7xfxT7jFK1V9S1zdWFVq0Hf8BYVOaqf916ictzw=
X-Received: by 2002:aed:22c8:: with SMTP id q8mr21652726qtc.0.1572998186120;
 Tue, 05 Nov 2019 15:56:26 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:55:58 -0800
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191105235608.107702-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 04/14] arm64: kernel: avoid x18 in __cpu_soft_restart
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The code in __cpu_soft_restart() uses x18 as an arbitrary temp register,
which will shortly be disallowed. So use x8 instead.

Link: https://patchwork.kernel.org/patch/9836877/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[Sami: updated commit message]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
2.24.0.rc1.363.gb1bccd3e3d-goog

