Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D065C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341D8206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7Zs/eDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfJHWlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:41:04 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:36745 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfJHWlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:41:04 -0400
Received: by mail-pl1-f201.google.com with SMTP id s24so261016plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8xYYdVPDbLYWuy/r3QHNRnmZwULqpKRssQ9cASv5JWA=;
        b=G7Zs/eDVn/uanxN6w46x4YMCymXFcID0KY0Ndd5m7/kcGYFJOQrhUeK3BHikppEDnv
         zW6abxd7MEbPlZ4zrH3nsJlqU8dtsnKhDWFRsrcyKAs5PpClcNLbbS1vsdeRym97Grp6
         gAUhKX7fQcgroMjDhiU+vpBdWIaef+vVwBPNL/DluHaF6axH5u4WVzqyPZMyt+CuK8TI
         /vIEjVqVZGIa1aOkTONp1CvMdsXLMWS3BlNQqHBwDBeshWGKQfyHDVL2w8D/UTFavNF6
         pcZ2ii4wl+t+uNVL/svB3ntcdBgea48Ss4eZR7us9Ea5ICTi4+6qcYaPawLIwAHAngAl
         76wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8xYYdVPDbLYWuy/r3QHNRnmZwULqpKRssQ9cASv5JWA=;
        b=Pf7v5iHaSNZ32Hv2SVpsNhNnfsCi+mkYhe4NDRHaSkChejZ4a792KGehB78jQju3ku
         Uin0PbNKW6k4923uJ03KUaiuLQR5rU41JU9jh9BZnCIysRYSU/DR7FYhON8dtncExWyg
         B9kvX0EDrJhDdjFj639r8k/H0RzR/YO1oir0PUKU0gmkb7uXaFNF3wQNVOcRzykhGNbF
         j3WBXRy3G9qiEemuPA4GIBvrLiwuYBa+8ZNbQniaZHKw3trf+g6vWQpRGY9NVaksJjeb
         iDiq+y6hjcMrBHAmF2wwK2ojGYKV1Rf5mkFDfeDfdr7MYnEasR4TMdbBgsiHYGw+OQ4s
         Teqg==
X-Gm-Message-State: APjAAAXxZ5qXRFeZAXs6ayClK3YQaRNaR+WUHtVgimWXorD75nNaQ9Rp
        BDh/lUEkLE0DU9RhB1QI/FlGnXy4g3f/Z3fF1VI=
X-Google-Smtp-Source: APXvYqzvIfQH0j7UHo4XSoVaXhVI0bk5MEK95tRWP7OzVQT98p6JdNhNo1TJeCIRCNTLMDpxZbedcoiu9tJ9OBNKiBs=
X-Received: by 2002:a63:709:: with SMTP id 9mr773057pgh.445.1570574461652;
 Tue, 08 Oct 2019 15:41:01 -0700 (PDT)
Date:   Tue,  8 Oct 2019 15:40:45 -0700
In-Reply-To: <20191008224049.115427-1-samitolvanen@google.com>
Message-Id: <20191008224049.115427-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20191008224049.115427-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RESEND PATCH v2 1/5] x86: use the correct function type in SYSCALL_DEFINE0
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
2.23.0.581.g78d2f28ef7-goog

