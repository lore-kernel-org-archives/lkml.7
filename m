Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673E5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396E0217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1wmzs+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfKAWM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:29 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34361 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfKAWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:26 -0400
Received: by mail-pg1-f201.google.com with SMTP id w9so8023888pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RsnQ6FRofmXv+RSRylCILajHjnEectXS/G9SmKbukAo=;
        b=o1wmzs+qUKyvyNRJXp3X9qKqVJBTuvDks2cY0wcDPQb7bIkAGC906DDkR30LW9eQqJ
         zMXXLC1USMOZgspHImZJpgDDlfNKWn8CCmJRaf8YaWLWZjkkBOjbdmCWqR0xiz2Z1E8M
         IMXajWsM2ZNytq3YJD57+AcO0W4a4BAeYhyFET+L/KsEcCvEEvcQIkNw9qARaUd3IBj+
         ++FoWxR12a+dlSA/MO5FA1lV1Ulde6ProNs5GbCiHu4RxgZbton9GSSH46BCYxqtL4td
         jIGaL3F6B2fs+2u9hLh0hFh84welR9hB0LYDeiGk0rmXfYPzPJvvptVVG6q7/+epyQDG
         9jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RsnQ6FRofmXv+RSRylCILajHjnEectXS/G9SmKbukAo=;
        b=YXwumZVQlLWViwvUPVSmPQA07dbQPsJV3ID5FgfB0rykFFy0TkPfnvtGWrvXZZWUt0
         xmDaM80uKGUWJaH6GYUziFbPBUVLlZ/t9bvkB/AFWKA9ll70tXcFpSqHf8Iaohs4jHZ5
         09nq9kzVBH9NugU7jYLnYZQfGfpzbmTtfiqjotGakacB1j7YSBJUeUG1PD443AacEu1e
         s5Qf1gkU2D6IkuphKfii0vlx0qQDq8GKbiUY4Oa2tpA3whxZexq28/NIWiygK6K3r2nQ
         SJ9PIAxtkg80gsOoz0HMvVShiONB6NnoBwpLRUhK2RCUY7F+KvOZ9+DVGziBb3iF7StC
         v5GQ==
X-Gm-Message-State: APjAAAVnG/NamYKqi8/kzl46tHWcysCXmTz+Hda0LcGLpFoBZ3vEHjlI
        swSCCFmE1vXv3uEW3w7222p6Bh+gMStF5Z/9Sr8=
X-Google-Smtp-Source: APXvYqy8xknc+AggluM5pslguFgR4jRQWMnOnFZJmuiy7zcx6A+OMKobqQMh8kuVoFD8eIIYYvO3uXQeHJhmKYfS7dA=
X-Received: by 2002:a63:8f12:: with SMTP id n18mr1357176pgd.340.1572646343780;
 Fri, 01 Nov 2019 15:12:23 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:44 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 11/17] arm64: disable function graph tracing with SCS
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
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

With CONFIG_FUNCTION_GRAPH_TRACER, function return addresses are
modified in ftrace_graph_caller and prepare_ftrace_return to redirect
control flow to ftrace_return_to_handler. This is incompatible with
SCS.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e7b57a8a5531..42867174920f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -148,7 +148,7 @@ config ARM64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER if !SHADOW_CALL_STACK
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

