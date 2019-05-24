Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2033C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA4F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUsAhV5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbfEXWLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:11:30 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:33399 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfEXWL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:11:29 -0400
Received: by mail-vs1-f74.google.com with SMTP id q25so2263813vsk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v92h8itBUYfDlklDlHFCcJBl3/YhqLnEEC7wTIuTHIM=;
        b=CUsAhV5X7IG2TWg3my4XjAd8N+cugOoAK2eNkVT5xhIUmLHS0BGK+qa4DRM4Z22cLx
         tIKhnYDefXMooVOqGJ9AXeNU1h5v1ryC8qLaZnMLaza9RURY7h11L2mzTjYrLav40CKr
         PoYW9InXbd01jGqMhxFZDs1kzy5+0ZInB9sshvcc6ohLa6l9WU7EO5bpDmDfw2+eQguf
         XOSuj2JDaQrbY1F01G9b2NXP/AxJEF8DKwMlFxfeaLRFwiwgelynwdfg5FT9Dxd1GOri
         M9J2A8C/rEIBYKbDjFaBoUiuUY8RBlwTEYHAGjXyKbUWW73gq8uHo2DgxuaVEySRD4il
         dt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v92h8itBUYfDlklDlHFCcJBl3/YhqLnEEC7wTIuTHIM=;
        b=iLf0BGuMY9+ASFy6HFkjJzfk5zkDMSTS1z8ddVONiouspj3NCK4wVpicd9Nn9+ZSAL
         6VUdf+3bcewVoaCThG60h8yIlkvpCUu2CQSeIIrZaX4SQ/T8zmbc4zMFgx2M2l1Wthxt
         ifSxQ1iAyIKEmqE8cMTPRHtvKarKqlkjPGsne/Uv9J7+0r9Rsjag/VE4+yU0dx0UDTbe
         CNRpremVbzV6GplTEAEbggp6SNHO6wp2ykTJkBG047UE3cJGjg7tc6xw8vL6j+17sFc1
         gjTzfVWRavstuW2P31+QeYHlCUBgtc1lWAkmc8U5g/ydeCHwWFfZC/BQVqYxrTr5719Y
         WywA==
X-Gm-Message-State: APjAAAWxu+6vVDmVNNm3rubCMh59I+Df3Rx65vtRKnrIxuWF/8d7I4NM
        1LI4d6YruZIFlT2Yn4w1a3iZyPIc4nwnws/64NU=
X-Google-Smtp-Source: APXvYqyEasMSInV7lTRAqxTR3tlK+X6lvMZOcDgfdEHMr3xXlhBiE/O5JogcdnzzcRFyPYoTDe25RsVg0qI/jFZJc7U=
X-Received: by 2002:a1f:3143:: with SMTP id x64mr8099236vkx.32.1558735887958;
 Fri, 24 May 2019 15:11:27 -0700 (PDT)
Date:   Fri, 24 May 2019 15:11:17 -0700
In-Reply-To: <20190524221118.177548-1-samitolvanen@google.com>
Message-Id: <20190524221118.177548-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190524221118.177548-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 2/3] arm64: use the correct function type in SYSCALL_DEFINE0
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
2.22.0.rc1.257.g3120a18244-goog

