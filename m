Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A405C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C312E222C6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkeBlqOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfKEX4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:56:42 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34730 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbfKEX4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:38 -0500
Received: by mail-pf1-f202.google.com with SMTP id a1so17498601pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m4cUlF+6BFA5FNFSy/SkP+A5WQosIpsKOuqRDiNS4Fs=;
        b=MkeBlqOT1wtRB47pSUzDXD8m2gj/abIK7oOlbgO8kye4NcSoywAeU5ZtSxATJfMS2n
         sLQRqxnA5iMAtD4OVyCqAKV61xGoMEiKHHv5WZLdZGpXH5vTzfmZlcB9JqF0UIw0+fxi
         c3v/IzYD4RKwck3PyJuzlC7Jvs44fd+x/pfQVweb8C0DMCYwaLsC3QIombbYFjvnDAcI
         6fAyLaVNPBEmDJx0XgWILXvjSQ16pLXXh8OX20eaMdKqUAUb/IPjwkwA5StaodCgnT6k
         fOX3eGQKvjofeZjc0oKfmlzFJBlDBOoEIoLe2boRm/0W+bt6Nlx8c29PhG3Gh4cKijCZ
         KWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m4cUlF+6BFA5FNFSy/SkP+A5WQosIpsKOuqRDiNS4Fs=;
        b=PXXaWFqLhWjxapNG22wrCHmUqShAdkG2/8DAEoYQ2WuNTggaeyCADKuEyX5ApKIOuK
         BRoihnUmdktMc9aiIEUmib7Ym6wSqWD5kj9+tKkgftFo3XfC5raX4lHF0nnuZhG1RFNw
         7+zR9Iv1eM+0vm/qMK/uVRLUT8x3QQwGCuKXBGEMHZTHQIjeoqSHRtR6tEAK6H81DAE+
         bB1FqTA/icoZpvWit8TyJCSRqx8Ec9yYWuBtH+s2CivYAj/ZQOphdkS56jAQmtCAG6Sj
         cnJ6VMV1fVtF7xcDjfnQWrqyggYa6bwISrVJoSXZa32eXPer3BtBHMQU5k/oUi13bQdw
         XbiQ==
X-Gm-Message-State: APjAAAUCT+EMigKx6JfEqCnSwODAJ1hZMPc5FfdO2z53SbY1Y6S6qWY4
        0dVTw2BfV18GUoOp0etb58DHZUFZQNc8YKbOw1U=
X-Google-Smtp-Source: APXvYqym75lPAYmcFoKuMCRVIb2Z6qedUXVgqze3G/7tmrBj7VQss4UHqbqav7+LM2z+KkYxzkxHGz+pJ9MZsn3n848=
X-Received: by 2002:a63:c40e:: with SMTP id h14mr39330366pgd.254.1572998197596;
 Tue, 05 Nov 2019 15:56:37 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:56:02 -0800
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191105235608.107702-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 08/14] arm64: disable function graph tracing with SCS
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

The graph tracer hooks returns by modifying frame records on the
(regular) stack, but with SCS the return address is taken from the
shadow stack, and the value in the frame record has no effect. As we
don't currently have a mechanism to determine the corresponding slot
on the shadow stack (and to pass this through the ftrace
infrastructure), for now let's disable the graph tracer when SCS is
enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3f047afb982c..8cda176dad9a 100644
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

