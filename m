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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA85ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927E62084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAbpXLe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfJXWvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:51:44 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33083 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbfJXWvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:51:42 -0400
Received: by mail-pl1-f202.google.com with SMTP id o10so195854pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NgbC4P1sZEmAi9I2/zNK/CWQSp6FGySYAm217ZB/f+0=;
        b=aAbpXLe/RbgLbT8xZhWHdVHT5dVobTWZ2zeaJn26sqghxbPOn1hyEluoVbihGwnJVX
         2sTJh9psYEdbVqtTsQnDUiirU3rSIN2iObeBn0VoMtmhqDTjev0XrK4xkkn10yZ+Q0CQ
         qQieedL1ZoyV5sNvwfuRyibtlPJYdWaoMENqlRJtjyounO1D3aNGbT5HttKX7bqJFlrS
         u+E2xmyNlChGcwv1fOgwCviR53T0OUqe0dx8eBZY2CQMQV6Rlav8ylsfWoWPViV/AVq/
         Ld3MbQPgWXnLnAh/uLGK9oGnldzg5EGbJFlCuxu9E3FIX7DkvE5hrzoYe3FszpdHZXsU
         /Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NgbC4P1sZEmAi9I2/zNK/CWQSp6FGySYAm217ZB/f+0=;
        b=GkcQL4gyGXNqtLNalqL6GJVkFirr19/IpkqVtAkWPHCofDt4QLCTTbNJcLUb+5VE0p
         fEpPRCxbbOrxZLb9nvbff2d1qGcNG0lwFg5qJeaMUr6Hj34/umNlBX/L5vGlsoUUpFuK
         GEEDFzXmKubAQ5RqHHvZ8vwUork/GwxTzgTAobWOxEtNUnCvGpOeO97E9XAWf50Pqfzf
         oSvpcBP6uGwFcVmtb9rUI/RP2weGijS+V7wpnviNN2LwPIIAMZ5Cgkg+uuzzziTSvNhx
         rAiZ9Kah2H3o/tg3cpOCc5WuHLBha1d/hhlLzOExZjiwZBp1pU8RRtqjpKKMLYnj7rk+
         uWHQ==
X-Gm-Message-State: APjAAAXcySaeBXY/Uq0X4V55vpB+deSpRP9HSj6utvX+wDPEK4fWo0JU
        eZIytDUOQ2UGPHg9o6Nqp/feq1EKTIeTY2I29Kc=
X-Google-Smtp-Source: APXvYqzw5xus5EvdHEIjmfQfA9wYtkvgKtcSQO5+TX3Njkn9NrtKNZdJ55itK1BRfXGS16EOOSbRdd4kdMnueWHGf1c=
X-Received: by 2002:a63:4104:: with SMTP id o4mr484324pga.169.1571957501557;
 Thu, 24 Oct 2019 15:51:41 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:17 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 02/17] arm64/lib: copy_page: avoid x18 register in
 assembler code
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

Register x18 will no longer be used as a caller save register in the
future, so stop using it in the copy_page() code.

Link: https://patchwork.kernel.org/patch/9836869/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/lib/copy_page.S | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index bbb8562396af..8b562264c165 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -34,45 +34,45 @@ alternative_else_nop_endif
 	ldp	x14, x15, [x1, #96]
 	ldp	x16, x17, [x1, #112]
 
-	mov	x18, #(PAGE_SIZE - 128)
+	add	x0, x0, #256
 	add	x1, x1, #128
 1:
-	subs	x18, x18, #128
+	tst	x0, #(PAGE_SIZE - 1)
 
 alternative_if ARM64_HAS_NO_HW_PREFETCH
 	prfm	pldl1strm, [x1, #384]
 alternative_else_nop_endif
 
-	stnp	x2, x3, [x0]
+	stnp	x2, x3, [x0, #-256]
 	ldp	x2, x3, [x1]
-	stnp	x4, x5, [x0, #16]
+	stnp	x4, x5, [x0, #-240]
 	ldp	x4, x5, [x1, #16]
-	stnp	x6, x7, [x0, #32]
+	stnp	x6, x7, [x0, #-224]
 	ldp	x6, x7, [x1, #32]
-	stnp	x8, x9, [x0, #48]
+	stnp	x8, x9, [x0, #-208]
 	ldp	x8, x9, [x1, #48]
-	stnp	x10, x11, [x0, #64]
+	stnp	x10, x11, [x0, #-192]
 	ldp	x10, x11, [x1, #64]
-	stnp	x12, x13, [x0, #80]
+	stnp	x12, x13, [x0, #-176]
 	ldp	x12, x13, [x1, #80]
-	stnp	x14, x15, [x0, #96]
+	stnp	x14, x15, [x0, #-160]
 	ldp	x14, x15, [x1, #96]
-	stnp	x16, x17, [x0, #112]
+	stnp	x16, x17, [x0, #-144]
 	ldp	x16, x17, [x1, #112]
 
 	add	x0, x0, #128
 	add	x1, x1, #128
 
-	b.gt	1b
+	b.ne	1b
 
-	stnp	x2, x3, [x0]
-	stnp	x4, x5, [x0, #16]
-	stnp	x6, x7, [x0, #32]
-	stnp	x8, x9, [x0, #48]
-	stnp	x10, x11, [x0, #64]
-	stnp	x12, x13, [x0, #80]
-	stnp	x14, x15, [x0, #96]
-	stnp	x16, x17, [x0, #112]
+	stnp	x2, x3, [x0, #-256]
+	stnp	x4, x5, [x0, #-240]
+	stnp	x6, x7, [x0, #-224]
+	stnp	x8, x9, [x0, #-208]
+	stnp	x10, x11, [x0, #-192]
+	stnp	x12, x13, [x0, #-176]
+	stnp	x14, x15, [x0, #-160]
+	stnp	x16, x17, [x0, #-144]
 
 	ret
 ENDPROC(copy_page)
-- 
2.24.0.rc0.303.g954a862665-goog

