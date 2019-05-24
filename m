Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2707DC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1507206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5NF2enZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfEXWL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:11:27 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41670 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfEXWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:11:26 -0400
Received: by mail-pf1-f202.google.com with SMTP id b127so6515898pfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KIojoAmBE/BSnpEvXcodRJ0tgdeRBs6mJX1gQekfIhA=;
        b=Q5NF2enZHYLf+khWG7iyaIncDe+9M501ZKT4rE2UiUAeFpYGD7WgEK66eMZvTUH7Fm
         NFjo29hBJwD8aQ17sgD2jVdSTVQviNfFyuaYdeHxoTd9CLowxCNXxIz2cy+nwUQiEm3n
         uPGp3zdu44K5gxoq6OI2Ne54lRPHL/OQbkVi7SzpOfZpjg/G2s5DvIObUyPgQguVwN5w
         4kirThYDoas6ku5+JgEDrJ9eG1xjIM48ovyNjRUSP+ql++kE6VXnH9k3lBvyvInJin6s
         3t0d1YsZXzeFpMdHWgOQfeW8d9YqFB/slsOyowBXtIK0kbY1f55NODRjri7AT9XVl9Lc
         DA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KIojoAmBE/BSnpEvXcodRJ0tgdeRBs6mJX1gQekfIhA=;
        b=WhesJwlgerBdU5Jg8oOZ2ilqmNIpkzHtD7An7xxO84HpTzZ3GDQgdepIXwxu//S16J
         sIxwStm81C9Vxy9VJO9U7TJCBvWD82vyEWtokqbD6QcwFp2ktzY4g/o3yAXM7H8sxUTj
         68jdsaH6k9b5g+XWpzw9qleWJB9T+E3vcboyr4Sjzh5RBh6TmGG2HwnCyQgp4G/Uu2SS
         Ti5ClszYVJcjfuegwj7JB1dgC/1EGaoAlK5m7dN6KqfT9skYzdH9UL0z82mFOR5mv2tq
         TxO06hPpfjZEmm1LFyyf5fIGr7HrorHLQY2dgUvrnBtmnaBiAPAGlJOGs+5b6AvTHf5H
         Kjkw==
X-Gm-Message-State: APjAAAUmahxiiozNKgiNbIOj5/r9meJAUPpv5T9/YH2S6bGpd6z9REaN
        SBsh5XClgNOs9ZevDbZN8sE+T6LtWaX0A+kp1lo=
X-Google-Smtp-Source: APXvYqyzCxYDZAxNhJ5uLrFZIu9zCTdanj30bKrE/Us1YXpWQ3S67zBs3LYPNicVI1QucfjHTqn4fWw8yWBsrcZD/ZE=
X-Received: by 2002:a63:a1f:: with SMTP id 31mr91586268pgk.233.1558735885221;
 Fri, 24 May 2019 15:11:25 -0700 (PDT)
Date:   Fri, 24 May 2019 15:11:16 -0700
In-Reply-To: <20190524221118.177548-1-samitolvanen@google.com>
Message-Id: <20190524221118.177548-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190524221118.177548-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 1/3] arm64: fix syscall_fn_t type
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

Syscall wrappers in <asm/syscall_wrapper.h> use const struct pt_regs *
as the argument type. Use const in syscall_fn_t as well to fix indirect
call type mismatches with Control-Flow Integrity checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index a65167f5cded8..e8bcb9ecede9b 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -20,7 +20,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 
-typedef long (*syscall_fn_t)(struct pt_regs *regs);
+typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
 extern const syscall_fn_t sys_call_table[];
 
-- 
2.22.0.rc1.257.g3120a18244-goog

