Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CCECA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC52222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZOVdcpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442946AbfJRQLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:00 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41358 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442937AbfJRQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:10:59 -0400
Received: by mail-pl1-f201.google.com with SMTP id b10so4032543pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SzRVhVCQSEs4UpxvfljRvYSxQu5VFVx82TZExeQC7I8=;
        b=TZOVdcpBJiow5T4VOPKVfmYmovhUmd2ZBG9xflMRKW8S5BQ2L7yu5g6JY0/TCCHH+I
         XufZXerCCZfchS8x9jnvOoLMze/QWKGKm/0eGk215XJdEA1kME5jv8jnjb92Pb1eVWkw
         yiTgUjP8Rao1lkPZ3wsgn20YfPu5vdw09AcOGQOKuwSW35OqEXFlPzTQhP7pZvaCNMAW
         MWtaplAUSr+50SFN34KRGzFF9OlQtJcKYXSWZanQMwKs4H+DZ9A3MX4sVyK4cRYJFJ+w
         rlR21WxyyCXlD1Tc/Mn6bTnrGGsiH8nauEVx60lyfrl/C39gDgUhzHfYMSQ6uZ9ljLwO
         QH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SzRVhVCQSEs4UpxvfljRvYSxQu5VFVx82TZExeQC7I8=;
        b=R3Qxzdx0DRgYjw7UYw8BRDlmWDBUZc0Hvb95sh9dyDRH/M9iBeMvPUECWOdmNqJM5J
         UpkIRTa92koufrNqfyjCURLoyGeyT6BL6hAEvxxPH3shBdtjrpZH7DK3Zm86dLUV2IPF
         UBEEj/diZoeYUsOiAMVFYdhIVO05vtq6lNiMuw6WdKuVXL3/q1asoIGPqajGoM8KUguB
         GzIi2bou0RJLjkiEozIwlujGrXwtFHb6BDghFYv7MP+KPUou8SOo8lXuzKo6W8gmJBfK
         gnmGz7rt+/B67q3D9SjHxI7+1+WtcZ7xqW9qOzhaE8qF4Fn70SkWO8VbJ9uf9HeMjbEc
         P/Og==
X-Gm-Message-State: APjAAAWhLq/P86jLJOjEw/fPS5kWZtXQ3nfUZ2OwP0Ej2VOXMRE5U+9M
        pRptgrE1Oa0ewt/B/C9VDpuDirbTLg8Ldn/Ey8c=
X-Google-Smtp-Source: APXvYqymenYk+Nj4KHMBe+/txGcAk8emmf58ZAJAVtmISgexrXgZK+srN7qpXD3xJ732mL5rywUz419mv8CrbkTon24=
X-Received: by 2002:a65:68c2:: with SMTP id k2mr10843389pgt.241.1571415058696;
 Fri, 18 Oct 2019 09:10:58 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:19 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 04/18] arm64: kernel: avoid x18 as an arbitrary temp register
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The code in __cpu_soft_restart() uses x18 as an arbitrary temp register,
which will shortly be disallowed. So use x8 instead.

Link: https://patchwork.kernel.org/patch/9836877/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
2.23.0.866.gb869b98d4c-goog

