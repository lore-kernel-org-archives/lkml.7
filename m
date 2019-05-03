Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ECF216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXvz8tMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfECTMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:12:34 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43710 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfECTMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:12:31 -0400
Received: by mail-pf1-f202.google.com with SMTP id t1so3622030pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OzS8VIItIe7gOmrqJiPkmma/CofpEbEo7MDgNzxP7EU=;
        b=vXvz8tMV6K7ewdBjEgreqwG3r4srSHPabxZ+NglYP1hxf44UZwW/kSCKdYQv9AFeWv
         nxg16dVtjVyvFPzy2XSDPqL8pjdgBk/aUwM+GMNO5LLWfBhKKFDCvwV90oDe5Ul+fs5k
         WcRngQQwJtgRHdUdUk9Skv0kf9IhZ80LYgg2akYzT+8ZLxJl3hLXbfFc02ceWHkHJoiZ
         vmYjsVvz14B2DAAO6Cpy3+IZfR+Myqwk/5UWD3T1w7zYngP6WRRFr9NE3T9SnzXMFsSZ
         3hkddRRZcZj0L4fE5BDmRLiDriKu8Umv4fXufsGJEOswkIk5fI5CljAsgkJpG5zOmz6z
         /rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OzS8VIItIe7gOmrqJiPkmma/CofpEbEo7MDgNzxP7EU=;
        b=X6Sfe0cNozjlW/o6wbdj1SBgdFoA+Aupxv8WvmqvaGY7xBDrOhpjNhSnBkhwniA9pw
         kteo2mmhhqO1kZF+3Yqdou8OMSzXe14Hbk3eMwYHtuW7hu4EksP2YA7TGYceEBEPh/l1
         897UxKyW7CDXKORxWqN0fozZkMlHeE5Ca01SLvX42YKUJKY6ICme3x3BwA1Nv4yuC8Qn
         fQfr7ZC7gZRiK8OrCCobUdV+B9ERy2r+bkbQ1jQG9MbFTUmERjRrI7fd/cG7NfBmEj9m
         X2r39iulNAzMzFXMwtAB4brLERZZBkW+TSvHQjr7ZtTTGLRh+Jw1gBthiWdNSN7P5UCC
         Wi1Q==
X-Gm-Message-State: APjAAAVrDow7jbaVVx2X7N1B2hSBIdiyk7Pd3WRj2zLk6wRjhaLVQ3hy
        gzbCNbsbVfetOp9/1LR/4DGRnr+vmjD4vWwjDOk=
X-Google-Smtp-Source: APXvYqxQx7thUnTUgZM+XBCR4KVnQE9clWl9Q6r+UsURp2RX6n5rRRQc1xX2h68jKqk6eL23yArIwNASAHgXHhzbcHc=
X-Received: by 2002:a63:2ac5:: with SMTP id q188mr3683977pgq.388.1556910750760;
 Fri, 03 May 2019 12:12:30 -0700 (PDT)
Date:   Fri,  3 May 2019 12:12:23 -0700
In-Reply-To: <20190503191225.6684-1-samitolvanen@google.com>
Message-Id: <20190503191225.6684-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190503191225.6684-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2 1/3] arm64: fix syscall_fn_t type
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
index a179df3674a1a..6206ab9bfcfc5 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -20,7 +20,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 
-typedef long (*syscall_fn_t)(struct pt_regs *regs);
+typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
 extern const syscall_fn_t sys_call_table[];
 
-- 
2.21.0.1020.gf2820cf01a-goog

