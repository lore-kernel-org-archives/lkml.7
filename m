Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D511C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DB721907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4WnMjqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfIRWqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:46:24 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36602 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIRWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:46:23 -0400
Received: by mail-pg1-f201.google.com with SMTP id d19so928969pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o1kP60V+4ATGhA+2GV7Kq8/nUZ9uGq30p+omw7gFOvE=;
        b=q4WnMjqwmG39MhQ+fG2cb/pbsFDTo+RHKowHUy0iLPLD8XNFe7vn+BaNkoBOXLM60Y
         7RmWtV5nHNgjLrrghEshq/n30wUnM+RLedP3SSKfX4Yk1U7JJ5q2nvdU7YWhxwFBLQFX
         vLsSVNDW0/RXax2iE4CdNNtNGXfNfQ4Stgy2MVUb1XE5w+jUVZfbyOmFbeYtiPU7MBkg
         iWdNZ5MTCMk7OYHPXYxefMxN8WFKIUGfJ0W8/M7pxorLRojr7oiyxH+WS602dxcGZCt+
         o/JdTIr/6hwfPGFMD12GphMksXtnAZk5Vv2g46E8MwlYgJ3HhyaDqxgLxhfeukXMFLI/
         GU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o1kP60V+4ATGhA+2GV7Kq8/nUZ9uGq30p+omw7gFOvE=;
        b=neAectRy4o19t/qPxmzDTSUyYq5XU1M4bsN7dcoV3vHrzFqGEcch0o5VNLhFqDGxPR
         2o2qrbUVtXW0h5qpr/KZus4rJaWz/kjEti6+t2dZ9tCLuHGDejHpL7JKuXUTTh6c0e2Q
         MS213uI8I3myPKNsI9CW+sw1VLX6gSsIE6A2ISUYiepvZlrmNDrxO9l0PYiPDgqnh+VL
         Q2y/ziIcI3W/Kf671KxS5xiP1YKInR4xak9OqSZPck3IodLkYcBFty+XLpcuJnZaeDOH
         J90/1akYp5/8MPVMcL1P+2YiJL03+F8SQtWbNd/AZyeG80Xy+r8XOCaxoSOEwHrKeANh
         0cFg==
X-Gm-Message-State: APjAAAVfiD2o1ZJRLI+jlsVK7ylFeJrzSrAmrzoqKur63S9umGZE+EYs
        4sQ9hYPVOMrg0xr9rqnRTBk67TFldrdYQZ8bJzY=
X-Google-Smtp-Source: APXvYqz+4m5LGb0FPgu6VnLU9/8RTXVuiZafq/yLxTf2lBSuoVVcnMZhPO1d1IvTEPPOjIMKguGaSKNLCPSLTOk5sns=
X-Received: by 2002:a63:be48:: with SMTP id g8mr6060674pgo.193.1568846780982;
 Wed, 18 Sep 2019 15:46:20 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:46:04 -0700
In-Reply-To: <20190918224608.77973-1-samitolvanen@google.com>
Message-Id: <20190918224608.77973-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190918224608.77973-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v2 1/5] x86: use the correct function type in SYSCALL_DEFINE0
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although a syscall defined using SYSCALL_DEFINE0 doesn't accept
parameters, use the correct function type to avoid type mismatches
with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/syscall_wrapper.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e046a405743d..90eb70df0b18 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -48,12 +48,13 @@
  * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
  * named __ia32_sys_*()
  */
-#define SYSCALL_DEFINE0(sname)					\
-	SYSCALL_METADATA(_##sname, 0);				\
-	asmlinkage long __x64_sys_##sname(void);		\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
-	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);	\
-	asmlinkage long __x64_sys_##sname(void)
+
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
+	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
+	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);		\
+	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)						\
 	cond_syscall(__x64_sys_##name);					\
@@ -181,11 +182,11 @@
  * macros to work correctly.
  */
 #ifndef SYSCALL_DEFINE0
-#define SYSCALL_DEFINE0(sname)					\
-	SYSCALL_METADATA(_##sname, 0);				\
-	asmlinkage long __x64_sys_##sname(void);		\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
-	asmlinkage long __x64_sys_##sname(void)
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
+	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
+	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
 #endif
 
 #ifndef COND_SYSCALL
-- 
2.23.0.351.gc4317032e6-goog

