Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6291FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3658A20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAbDJJ6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfIMVA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:00:27 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:56353 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:00:26 -0400
Received: by mail-ua1-f74.google.com with SMTP id x15so6353122uaj.23
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IkMFW/HZqrwACvoX16r6MJOeyU823vz6AhfGdBq2D+k=;
        b=TAbDJJ6+M5jDONPu2QoasJ7COxibqpWIa/B+vZyIqqh9uomI3sXfYDxYON1kmjyTvX
         IegSP+l8ucDKAIiMIcGmHgJfIurKXrNU0lFICnSZP/jvt8NDndWHIMFTR+PM3H4cHk/j
         ek1HiFSD1nDu94BDiJ6gImatVMiKhSR/kRaBduUW+hG3OEuOixjBzZXDu4xsIaP4hVvG
         DoeC6PhaEuYNOgP1M0dFHeAKlBU/Nqy8QvmiXBmDGHI1J/i1Bf6AGJhZYINr3rjjoorr
         AYxCqtIC2zA2aqQCx+D2VARRxbeCfaH/hVULKwCbA8FQsHZh54DRH1p0jnpQ5UbmFqFe
         /FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IkMFW/HZqrwACvoX16r6MJOeyU823vz6AhfGdBq2D+k=;
        b=QobHQ1l0isYXClDLdjfkHHnBvEvxv+B8x/M/hD2tAuoFNnXt0ir9ieSG0M17QEwcJ5
         91tmiN6JGDfJ8Odt6yjFRNWfmfWyBJTPZzfDsGYinMwOZaVO1sr+1XWq4Km2dgw6Tpe4
         j51bCU66rVHVUWkRhXB5+QyF2X3rtAb/NFA5l7U5+mYrFbyKV2M3yU3O9RNKMZHtO/v5
         9RWjo/54zISEGgGPlFg3BYZFs6dv1EDaKdfop1fZlAeeAsd91zcFXuli3kV564wvMiAv
         7R/qyqInw2QlSAkdTNPI8ZQkrb/K+EpjRGt2L+xA3XVJt7eYHPpGG0v8xTvk9xwAwFa6
         8rng==
X-Gm-Message-State: APjAAAWOFYKlceG3S0PcDpj9GwbnM1xGVH1UXVwfJM9Y5CEhFP29qK3f
        NFjKSe40+B2MiePLTQrAtp+RnfXQC40k5uOM2aA=
X-Google-Smtp-Source: APXvYqwcPCQrN9CFiqhh3x5Y5skfK+Lb4JQx5Lv05EdPcnMO5hwybKZwfCQQSZXZt2MUmOWpAWSMmtM+30GvmH/AurI=
X-Received: by 2002:a1f:9b53:: with SMTP id d80mr24302280vke.69.1568408425801;
 Fri, 13 Sep 2019 14:00:25 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:00:15 -0700
In-Reply-To: <20190913210018.125266-1-samitolvanen@google.com>
Message-Id: <20190913210018.125266-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH 1/4] x86: use the correct function type in SYSCALL_DEFINE0
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
2.23.0.237.gc6a4ce50a0-goog

