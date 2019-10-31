Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B603CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ABC20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwFMzJZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfJaQq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:46:58 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33949 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfJaQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:46:55 -0400
Received: by mail-pg1-f201.google.com with SMTP id w9so4795372pgl.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aHKOoX9zJAla15qSwjd99c+7iNT/pdKXHfBAM0TSbiA=;
        b=DwFMzJZ+kUlOAWN2GvdIrb0spmd3RCFaXXrjuk+n93RrGiHVTkKIE8QVClddg7kBDe
         7IeZak8mKqDEsiR3pvG5D58rS+2OmcCl2VoAJ8fblz+yYSO2P8d24syfdwx60D462Dgh
         XCr3cWY+P9lvUhF8i41PfwSmLeFuaKf2xbTVnm6vK5gGs924c4E8sqG7J+640Cc4jSv1
         COp3Hpg8QTv21PL1iF/DfTs8X6WtTvBta9g6udg3ODicYi1TP2epIsbDEj+VXTpASGOq
         p/A+gt82BwR62uCobShpcPv4dkr4CW0qj8ti60vpOnCzk1mJe/Au4gEO3Ke231E6vBr6
         8IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aHKOoX9zJAla15qSwjd99c+7iNT/pdKXHfBAM0TSbiA=;
        b=R4bvvzFyluGX/Y32ZngghoHxCRYRW4IUlbULgi/wpHg8oq5qvCtEysMrq9SM//ipUX
         ePJfYTm8BeWXM/Wy+hYzSGcT0wCn1akENntIzqA2PbWrXDXbFniVrnK980tNhTp+4Lcw
         BMzVfGu003vQZ5ueSOF7V6QiLsB811c/Pvw84NFKJtt6Tz93rmofE5eezM1OaPAxhMpt
         Eqbc5X1V2HfE85Qi/AUDnIaXInOlcD03LAnFC0vXvRovc5fBre9kgqJT7xxSD8emwl/H
         KbJYe9rTvEaSYVAnxDrgSnILdr+wPb5Q4mCTPrR/lXPl+O/2AqRk1R73KnlPQKNjseV1
         YwPg==
X-Gm-Message-State: APjAAAVPkAo3MfNgdHfBwDgMuuX8BB/0/tukXVWbXfaE90kU7ng0XPHq
        Ra83uXHuOLxJ9IXz0heFDTWQE94xE3LJMAjMSAY=
X-Google-Smtp-Source: APXvYqzWKFl/JealEA2qBs8OC840r89CQ5kizTD5lUFGsTusSG0GdYwJSJp9KVbGkb+yd42ZvImlbPdCOavSDAkzBMQ=
X-Received: by 2002:a63:1904:: with SMTP id z4mr7825364pgl.413.1572540414204;
 Thu, 31 Oct 2019 09:46:54 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:24 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 04/17] arm64: kernel: avoid x18 __cpu_soft_restart
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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

The code in __cpu_soft_restart() uses x18 as an arbitrary temp register,
which will shortly be disallowed. So use x8 instead.

Link: https://patchwork.kernel.org/patch/9836877/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/cpu-reset.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 6ea337d464c4..32c7bf858dd9 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -42,11 +42,11 @@ ENTRY(__cpu_soft_restart)
 	mov	x0, #HVC_SOFT_RESTART
 	hvc	#0				// no return
 
-1:	mov	x18, x1				// entry
+1:	mov	x8, x1				// entry
 	mov	x0, x2				// arg0
 	mov	x1, x3				// arg1
 	mov	x2, x4				// arg2
-	br	x18
+	br	x8
 ENDPROC(__cpu_soft_restart)
 
 .popsection
-- 
2.24.0.rc0.303.g954a862665-goog

