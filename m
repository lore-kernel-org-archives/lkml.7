Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B6C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129372464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPqQmv4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfLFWOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:03 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48377 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfLFWOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:01 -0500
Received: by mail-pg1-f202.google.com with SMTP id p188so4542171pgp.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8cEo3bnB2JOErtud3GvPd9W0QqVJKhLYL3PxcgBL0pc=;
        b=CPqQmv4WqCQBFArArM8RhJECBGvYc1DYgdPm0u6MVe0Oqz9fNy0AzMgv/8cEGG/BAU
         aAtkoPugaKUj5l+B6gmWuX+5yxOs+N3ZWs/7Q39Wy7REQEzECblVDxd+is2N3naPmb+Z
         AqE5JEDUA8ZArMaJifiVfToRBNBcxgJbfiPhEMzN4QT7addM2NEiDmiH+MHpEUOrpMuY
         5mCBPj6zphQUPpZkvQxiKNqQZVXSG5ZKCqPY/yDTZAouky3k/+Eg/at4qlCky/F1/OE5
         FKwHQSFj6kwEepxRANrOWOQ7iDHcCUd0e0fNHAJuNQWb5uPQ20sY1xVXRPXlBPWsO0w5
         mmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8cEo3bnB2JOErtud3GvPd9W0QqVJKhLYL3PxcgBL0pc=;
        b=NKosL1b35FzYQHAZqEjTBpaMWC0mpL1+tAAnLRYQU4M2LTmuf/854kUxmDnDE2znAj
         Ma3qdMeZvQ8dLvrUWDe7zdm2PBOL7sLph1GSPdObhFtWZnDMI3bUutpMwq2tWL7rJuyK
         GxvU12+Lbn96WIlNhrVekufY3ta9AnnHgc48Y3mBhD6aefLceIS9I4Ew1VbdOu2VTiKL
         jiD/FXWK+s1EY0t3CsCBxXd8sLtC5iGKr8NuXzOXATXlQ+OzIoKLUpwEd90e/Pidy+O1
         kUzG785bDjksdmp87lFcyvRWpTmnDYyrjHnZRy8JZoSTjnoAbOzY+7UxlF+E27MxAgUo
         ZGzQ==
X-Gm-Message-State: APjAAAWFU8ataknMMTbzEO6jftSwZKB1Kuop0CX0akcx60Sjt6REE0Bs
        33Qaxf6PG2sXDZJ0siTDaVDbpKOMwPgFcHvS3lE=
X-Google-Smtp-Source: APXvYqyRfdS5aqE39eaRAOxLgcN4AWsr5dwZL7gm38UAYSLZ0IPRBNt46Y6TodltgXxQPThKbmHblBbcL2qiJvc2D0M=
X-Received: by 2002:a63:184d:: with SMTP id 13mr6053846pgy.132.1575670440912;
 Fri, 06 Dec 2019 14:14:00 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:38 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 02/15] arm64/lib: copy_page: avoid x18 register in
 assembler code
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Register x18 will no longer be used as a caller save register in the
future, so stop using it in the copy_page() code.

Link: https://patchwork.kernel.org/patch/9836869/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[Sami: changed the offset and bias to be explicit]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/lib/copy_page.S | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index bbb8562396af..290dd3c5266c 100644
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
+	stnp	x4, x5, [x0, #16 - 256]
 	ldp	x4, x5, [x1, #16]
-	stnp	x6, x7, [x0, #32]
+	stnp	x6, x7, [x0, #32 - 256]
 	ldp	x6, x7, [x1, #32]
-	stnp	x8, x9, [x0, #48]
+	stnp	x8, x9, [x0, #48 - 256]
 	ldp	x8, x9, [x1, #48]
-	stnp	x10, x11, [x0, #64]
+	stnp	x10, x11, [x0, #64 - 256]
 	ldp	x10, x11, [x1, #64]
-	stnp	x12, x13, [x0, #80]
+	stnp	x12, x13, [x0, #80 - 256]
 	ldp	x12, x13, [x1, #80]
-	stnp	x14, x15, [x0, #96]
+	stnp	x14, x15, [x0, #96 - 256]
 	ldp	x14, x15, [x1, #96]
-	stnp	x16, x17, [x0, #112]
+	stnp	x16, x17, [x0, #112 - 256]
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
+	stnp	x4, x5, [x0, #16 - 256]
+	stnp	x6, x7, [x0, #32 - 256]
+	stnp	x8, x9, [x0, #48 - 256]
+	stnp	x10, x11, [x0, #64 - 256]
+	stnp	x12, x13, [x0, #80 - 256]
+	stnp	x14, x15, [x0, #96 - 256]
+	stnp	x16, x17, [x0, #112 - 256]
 
 	ret
 ENDPROC(copy_page)
-- 
2.24.0.393.g34dc348eaf-goog

