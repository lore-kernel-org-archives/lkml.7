Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC78AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE86E206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffAhhKt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfECTMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:12:37 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:54897 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfECTMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:12:34 -0400
Received: by mail-vs1-f73.google.com with SMTP id f84so1569818vsd.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S1+7ldXbccx9VifBluJ2Hbus2PesdEq2ZegC+sTBE7I=;
        b=ffAhhKt9cAcHPTUZ2tGJclczIAUDihldPCkQoKdXxgGR3UrE3LICYC4UXQba7TvGmc
         kmcZnhB3oy14O3HORskZBIv11NSBkpe5sUztovk0ndFNBFIA+2oHDJ+S4IH7+avmk14t
         xLhkhmDCaBfu9ah8m6ILALz1hLD5VAmiwBneGEte606zKOp45YQ1zdcJfXQiQh0WGeLA
         SAqPxauT9XhooiLT6yN123ZoZ3icJ4J8e/Dolhkbjg13Kk0Ac7oFDHDGyfnNaaItM2Vw
         TOz+KcMX7/EJOIPPLg9BbEnlKO1DnTt8gN2xofCiCtAK3+S3Yn5enAQhZ/vhPa6STwAN
         SJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S1+7ldXbccx9VifBluJ2Hbus2PesdEq2ZegC+sTBE7I=;
        b=k0w2JZ6W9qeRYJBA0pnWr134rH9LXwaSvzF/uEJpmEX4A4qwN+HNEVho7QUQzb9rXz
         B5VxcnHyGFP4SR5DWk8bHAx8LhAV8jiXfvWQTvQjg82ZQjR/n+SsGOysQCxnRfOkbivF
         uxEU4nnkZdrMMrbOWkf0xcF9M5t/gbnPRUuulyVv9WTT82Dxd5Y0orisdMVBlxXofOhe
         8bfvSUfP93Gkkdl4/djlr4Qd7oXVyVhVOI0cuNAG4PYEUvQLTHWn8g2AFchoy8DOhgfo
         JarKDsUigkTHzDUCO3u09SuAhx1Fzf75Pu4sZl+UapMjpJwAJt1swpZpXHQLABtIzQr2
         SXPQ==
X-Gm-Message-State: APjAAAV4KKvt1maOazRtQ1V8QuE9NEw6AYKAkU6Cm5IoYNEsP5TDG1X5
        GKkD4uGkSUfVW4X60+Y6A1y11vGTx06SktRDFwQ=
X-Google-Smtp-Source: APXvYqzHAR9S75uPGiVNfRF9u6bkFml00Eh2GFxe+AnwR7DC7UoFMW+sJcWWbXuIZA58HIVw2OK0c5VUpq1QVJoWnqk=
X-Received: by 2002:a1f:96d3:: with SMTP id y202mr2514681vkd.6.1556910753220;
 Fri, 03 May 2019 12:12:33 -0700 (PDT)
Date:   Fri,  3 May 2019 12:12:24 -0700
In-Reply-To: <20190503191225.6684-1-samitolvanen@google.com>
Message-Id: <20190503191225.6684-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190503191225.6684-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2 2/3] arm64: use the correct function type in SYSCALL_DEFINE0
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although a syscall defined using SYSCALL_DEFINE0 doesn't accept
parameters, use the correct function type to avoid indirect call
type mismatches with Control-Flow Integrity checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/syscall_wrapper.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index a4477e515b798..507d0ee6bc690 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -30,10 +30,10 @@
 	}										\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
-#define COMPAT_SYSCALL_DEFINE0(sname)					\
-	asmlinkage long __arm64_compat_sys_##sname(void);		\
-	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);	\
-	asmlinkage long __arm64_compat_sys_##sname(void)
+#define COMPAT_SYSCALL_DEFINE0(sname)							\
+	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused);	\
+	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);			\
+	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL_COMPAT(name) \
 	cond_syscall(__arm64_compat_sys_##name);
@@ -62,11 +62,11 @@
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
 #ifndef SYSCALL_DEFINE0
-#define SYSCALL_DEFINE0(sname)					\
-	SYSCALL_METADATA(_##sname, 0);				\
-	asmlinkage long __arm64_sys_##sname(void);		\
-	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);	\
-	asmlinkage long __arm64_sys_##sname(void)
+#define SYSCALL_DEFINE0(sname)							\
+	SYSCALL_METADATA(_##sname, 0);						\
+	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
+	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);			\
+	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused)
 #endif
 
 #ifndef COND_SYSCALL
-- 
2.21.0.1020.gf2820cf01a-goog

