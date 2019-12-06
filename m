Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA237C2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB52F2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ndn1mcgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLFWOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:49 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36290 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLFWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:17 -0500
Received: by mail-pf1-f201.google.com with SMTP id y127so4827584pfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l4zxu+Ve1HL3tnwJkQPbvyP6wBLrUpssPL9/jgnN43M=;
        b=Ndn1mcggyHBtKAX2XvpEyO1cvzn5t5Rt5EL74f5oQNI8xON9HZdOIOpGfCHheh4ROb
         ZMN247KbIgaMPUDc6e3RJ7DYNG8PST7u+oWWP+k1N+jSEe2J/d2Hj+oq/JPjyElDDN0s
         1bajoDV+ePEiqhlZBkx0JT+WTHRbNVJ9xUb/RgEkuqCSSWGQ87CELue3gJUsVkVLLj1/
         jMc9JOE96jedSwbK6Jh+owxavogPTbBQc3Lm1+HVnkCfDUu1/SEqZVkaAo5gGN3APpx7
         /ziJCrqylxkp6ltt8RGxlVAjAuQ46tyN3U7+ZPVlmKLcHn2gKg0ggIkQts840wwlTABV
         1Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l4zxu+Ve1HL3tnwJkQPbvyP6wBLrUpssPL9/jgnN43M=;
        b=ID3532JPXsuA/KNoL3CJDniYUvvKcXziSN/OKn80tzn2JKOY1WvRSNq0E5OZR5i1/N
         xyZBiXp/CVPXaQH6mqzKqk0Epz4EZ9seuWn+N6a6utfmNHsHKB/1VX13hMLDWM2cy1OP
         YFysIU07L4ncq6oh69W7s5mIKQhSe8ne3HN9ViM4lFXaVld3mmAwm1Iukywdu8ARyFQm
         b5IiBrWT0rlFROG7rzkPht1A0VEwlU9bEId4bTMVTaR9pDV0DCR50MVtqtdmI9mQCn8+
         ahRB57QCso9Z/1hZulPQ8IBHXCzbR1PrFLv2qtk+nvqzSQROieXvgR/eOf6+wyGGjYNk
         9VqA==
X-Gm-Message-State: APjAAAXWSkrBxbYhfUAJQ3OUblZRmwi+mbXyai9UICQjoNll6b3xBe78
        iJ+OqRHtAWdB6+x0BiwCh+EIf67i75M38o2+eAE=
X-Google-Smtp-Source: APXvYqxNGRCIoJl/pi6uCzgUEQ/oTKWPk8JXk9O2ag4WW88WJwvi2rvTurqocnD02MdVkQxGa8htdlPNVJwyO2G3YuU=
X-Received: by 2002:a65:4345:: with SMTP id k5mr6095564pgq.252.1575670456528;
 Fri, 06 Dec 2019 14:14:16 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:44 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 08/15] arm64: disable function graph tracing with SCS
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
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

The graph tracer hooks returns by modifying frame records on the
(regular) stack, but with SCS the return address is taken from the
shadow stack, and the value in the frame record has no effect. As we
don't currently have a mechanism to determine the corresponding slot
on the shadow stack (and to pass this through the ftrace
infrastructure), for now let's disable the graph tracer when SCS is
enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1b4476ddb83..49e5f94ff4af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -149,7 +149,7 @@ config ARM64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER if !SHADOW_CALL_STACK
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
-- 
2.24.0.393.g34dc348eaf-goog

