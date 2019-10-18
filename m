Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6790CCA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D33221D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/jDfxdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442925AbfJRQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:10:53 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43829 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442647AbfJRQKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:10:51 -0400
Received: by mail-pf1-f202.google.com with SMTP id i187so4977090pfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jUS0dhIzgmFNCiOAuEUXvcuYNkuGL56ryAS+MUv7C/I=;
        b=i/jDfxdkcHMKcb5mbJursCxkiE0tLbcAT50ryu4atkNnzE9tZW2TQb4DunSXt4JOkt
         hyqhR6jkusYNpX0FQ9xmE9MPM+OkoO9XULEt54Q1eChfRkMXo6zH0LLx5BfDV9XxTViq
         ZY4f/W9+YSMQLmVbr5Hvv7U5xrLsx6ePGTXBQJ2GfNYSLJa/kqRf7pp4MN5xmr1Pm9vV
         U0cyLViFkAWt3zk7EDLd8J6L/oTDFeTktzFlIC0dgmBDCYk0vOIQhRFpRS9l6HZ8lGvH
         d40Qs4Z3TDODrADDi1vpWtmXBnOPWrst+YFdZPhbhVcTVQ3PCuWW86qVwWdHqVcy9DgV
         E2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jUS0dhIzgmFNCiOAuEUXvcuYNkuGL56ryAS+MUv7C/I=;
        b=JXuBKFif+pWIf0lK0lMRWwIg+1gvrbYTy75XnOrs4D+mYaQ2kbGNNKlzAzlUTQIYn4
         t3piV5I4baXMHNBMeVGhgDVeY/R1RCdfx5LgVAX73LGZnjSRZHjWr8iE4h/PLkS0LzU1
         xyoDbssfCUmKvC4BPMywP1pzh8nA376Go5fNv/taryG9Va1TkyAUQdhpBsIkRIZmjgGF
         ygcUoB/rbFBz7wbjlCnfU8COQB//ve1wbnuYmUfNcerslNv4KWEcy5S5hQ8Qpowoaijp
         uaWzvDAIt4mYc/EV3BOD9mVtNACdKWE9NjqhjRn9y5yUJ2xjUNrOm+lgvCgTrtgKdOl+
         5I8A==
X-Gm-Message-State: APjAAAV8y12pmPNKuMRBgUiD1t0wngVABdjbkEDVcQeRgF68bQw3NiE9
        qBUwXoZFHoXSjGAQrPQs2WFsK+bXC8I1sSgCLsA=
X-Google-Smtp-Source: APXvYqz/HNu+DPymnhir5Vk43GMqjgbnDJ4wWnLMl8QOvY1mBOlys6EjB+4bJm7Ch3Zb+wSpV6DGjPmmablFROD07lw=
X-Received: by 2002:a63:3201:: with SMTP id y1mr10741272pgy.174.1571415050913;
 Fri, 18 Oct 2019 09:10:50 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:17 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 02/18] arm64/lib: copy_page: avoid x18 register in assembler code
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
2.23.0.866.gb869b98d4c-goog

