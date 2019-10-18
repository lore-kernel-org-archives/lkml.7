Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6490BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C3E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sClupJ7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502615AbfJRQLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:24 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39685 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502587AbfJRQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:21 -0400
Received: by mail-pg1-f201.google.com with SMTP id m20so4589743pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K1ZhNofnBR/XSzepuNm2GXj6CjTITzvlb/GIVw7T7D4=;
        b=sClupJ7s2vyir/7TQw4u1wskJ40f2afok9L62g3bdETWOSrvPIoJbt2TUVhCDZl2Ll
         jSD1Pe1pU7jtmC4+A/khfQCqIGy7o+x3Glnf1WXjzHqx9iAelj7PV0FH9T6XgXbpgXPr
         QmyFwYa7yB+qCqYypJwWf511MkYFKNAU+aHSUjTgdgKc/LGoN7I1EdcPjslTcJn6Nsnh
         zpS9sYd2YqSiWR32qZg1jO6XyvMv14Qmysa4U0MKWEQOtGZOZsv14zS5QNAzrCYTZwhv
         xDZy49ncrITpJUlYkIIuqsGVZMQ4LMcDek2uuDnjzpOLCvDTsilhXvrJN1MvHxPElje/
         wDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K1ZhNofnBR/XSzepuNm2GXj6CjTITzvlb/GIVw7T7D4=;
        b=Ejrl83SqObZiKnxhJmhY8QnbCD61uAFHFJxnUPkCvEFBV/q0efm41Y+7BrK+PsGrqE
         ipx5F2pzh76dT8S8/2Srm38IO4K75cjTiW1yDK6EtM4aUWdpVZWgBKmxQkiEB8DCcqh7
         z3QMiWIgNImGtj+7/tQ7vL4Ej6WGxwwZMEt1QeGa1UiyT795uQE7UUP5hyi33tfqMD+1
         e0C59DbtM+AcEVEtr6Ngis0bTd9kKAU/2Dq1ioRrHyGUr82DNPhAnFr4cfRmnnF8cG4v
         jndQH8nr8mn61ATvTutBe16wx9m+O82EI7ta6RAT5DVXo17c9rjLqOH+JKdQcd+NlIOn
         wG2A==
X-Gm-Message-State: APjAAAUMY2Wv8zjfpHVzv49tvPOmA2Pn6URnQWkXD02ryhRl95j2c7TB
        iY3IczMZZwObCKrs7HlCWzbEpfHW9fIJSheIMZE=
X-Google-Smtp-Source: APXvYqxQZgJ8+dUeSHjL/X4r9AY12JB0O/dDMacaQgZEGqyCDds26CgWDH7ZPg+xHY8lSTXkA3/VdzbOvvEqn3IOjDM=
X-Received: by 2002:a63:eb52:: with SMTP id b18mr10634742pgk.205.1571415080458;
 Fri, 18 Oct 2019 09:11:20 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:27 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 12/18] arm64: reserve x18 only with Shadow Call Stack
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

Only reserve x18 with CONFIG_SHADOW_CALL_STACK. Note that all external
kernel modules must also have x18 reserved if the kernel uses SCS.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 1c7b276bc7c5..ef76101201b2 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -55,7 +55,7 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)	\
 		   $(compat_vdso) $(cc_has_k_constraint)
-KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -ffixed-x18
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
 
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
2.23.0.866.gb869b98d4c-goog

