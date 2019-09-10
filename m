Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F69BC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 22:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96DF21924
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 22:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quvf91+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfIJWkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 18:40:49 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56531 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfIJWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 18:40:48 -0400
Received: by mail-pl1-f201.google.com with SMTP id v4so10681600plp.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 15:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2pIcY54aZVcxnukBJ46BATE4hoyCKzJFkedwo8F5Do8=;
        b=quvf91+gy+qQudoEQnGJdOp9ILAM9BjdzkhgnM1NMwD+dj6Ps2obMvgjSwGZ1P7MUE
         0KZC/FrodtPG6HP0pzjwzawLjOx8EEXMHZhkv8cAGu0r11W4wxyKLRzNERDTgBJ3YE/b
         s1d9/iJWYjkrV4SLX1lQoPFcozr9F8CNEjHZrGlCJRtbPjx/xcCFK0wufxyzc6JKMimO
         3Tt+jLQ+qJ5tOsarxWhraFubXpNa6fEvqGAYaRKfNB92sDKcpLww0TR/XsU/6mGONOVb
         IjfRYnaQsgH1cMtWYbeUtMWF/klidZ8wUW3HL906oosy8IkvxJBc+NOFx9LghuhmpK26
         j6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2pIcY54aZVcxnukBJ46BATE4hoyCKzJFkedwo8F5Do8=;
        b=GVOJp/XA/NBQLzAfKVaj+BYTD5TwTLM1ykPVWbxiqEvbFXIWn4yquGebHydBwwW3Y2
         hKi1rBOVM1OhCIvc5OkxK00BEzQa6EaHSxxSnUB74ukRe9r59H1kXuJPlBIFBE1eo4pp
         gipQ0NlSH/n1JsmmOIp/WL6/ntmqsBTPYVyKWpRs6PSyonpEMK4UMCeua90vpgowYB41
         TccDb7jUWpH6bAODoDKnO7K7d1jTtp0/ef7Ew+yNwBP8ASNf8r34GCAuMwW+d7YX24qg
         3+OwuD0oxMRmN+iE5cN6a3DNsbNbEMhrlbvWe9arX9fc5io8ws91qH3fqaaxj/fnmB8h
         +1Mw==
X-Gm-Message-State: APjAAAUWDgCdzPOy9tnit6XEMcQjsfAQGYXAfoJtfXqkMcbf+BHUJWHo
        WG7DlVd0uyErk2Yr9qcxYcIyw1WjeDodrR93QEI=
X-Google-Smtp-Source: APXvYqyi/q1T9aPtkQ+hhOEDXxFp9zEfOxsPG9hxYklRJaTu2ZdU3PQFRjmIaA1ntnDElXtrrsHpVPy6p8kWez+qHrE=
X-Received: by 2002:a63:e306:: with SMTP id f6mr29494408pgh.39.1568155247722;
 Tue, 10 Sep 2019 15:40:47 -0700 (PDT)
Date:   Tue, 10 Sep 2019 15:40:44 -0700
Message-Id: <20190910224044.100388-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH] arm64: fix function types in COND_SYSCALL
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a weak function in COND_SYSCALL instead of a weak alias to
sys_ni_syscall, which has an incompatible type. This fixes indirect
call mismatches with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/syscall_wrapper.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index 507d0ee6bc69..06d880b3526c 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -8,6 +8,8 @@
 #ifndef __ASM_SYSCALL_WRAPPER_H
 #define __ASM_SYSCALL_WRAPPER_H
 
+struct pt_regs;
+
 #define SC_ARM64_REGS_TO_ARGS(x, ...)				\
 	__MAP(x,__SC_ARGS					\
 	      ,,regs->regs[0],,regs->regs[1],,regs->regs[2]	\
@@ -35,8 +37,11 @@
 	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);			\
 	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused)
 
-#define COND_SYSCALL_COMPAT(name) \
-	cond_syscall(__arm64_compat_sys_##name);
+#define COND_SYSCALL_COMPAT(name) 							\
+	asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs)	\
+	{										\
+		return sys_ni_syscall();						\
+	}
 
 #define COMPAT_SYS_NI(name) \
 	SYSCALL_ALIAS(__arm64_compat_sys_##name, sys_ni_posix_timers);
@@ -70,7 +75,11 @@
 #endif
 
 #ifndef COND_SYSCALL
-#define COND_SYSCALL(name) cond_syscall(__arm64_sys_##name)
+#define COND_SYSCALL(name)							\
+	asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)	\
+	{									\
+		return sys_ni_syscall();					\
+	}
 #endif
 
 #ifndef SYS_NI
-- 
2.23.0.162.g0b9fbb3734-goog

