Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626F1CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C27217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFB8Vi7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfJaQrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:47:13 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:36508 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfJaQrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:11 -0400
Received: by mail-pl1-f201.google.com with SMTP id g2so2479295plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9Ao7uN2sNi3wFwgEShB4rOY2NPtO1ve2nhewvDVkd70=;
        b=MFB8Vi7TeDoI2FwYG6EbbYc+LBTOUEvRqAUAKVWlm/Y9wlKU7ujBC6awj8P8GgNg15
         SHrqse6Eby/JmzTas4YOpEbcYfE5zV02IRVEzTRd+/8pcGMuY5LmXsc1LvTsYyOPQRbj
         rWB9hKuYdsKAq5u+1gwPKMLhd3aFBv9y7s34IJD7qUWZFLaH/dCyw0RXobVGkHrXVve3
         OIoYdwBvTIcedJKnwnczA/JcOUoSjLk5Niw2NS8hRSGXfbcB1RQzOd3+hhaLOuVMzDiz
         eb9NXbVSx5Tc5HE4+fuT64N6mKP3gK4YOR6cATCVdP01/rojf3F/IcVEmTxc2qVknVy3
         MHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9Ao7uN2sNi3wFwgEShB4rOY2NPtO1ve2nhewvDVkd70=;
        b=l4j9X8ZtlWhBWrre0ytx+N1VlfUKyIIotlwlmucwpMiOTwXAyPo7S+I29aa61/ZtRy
         NNsbvalsLG5mlRtPM6qmb6bgKYFpd3K/2KHzRkqr5POPMPMLoXhKp6K6Msuq/UEqGLMN
         lMXgxy3Cyy6ie57H+AcUUn0chjJhA39jc8UQc1Ou4q6zEisQHIpuJSAwjrFTiBDzHIr8
         mfr21IZinoHdMpPsS1VY2qBP5z16a6Gb5xVDEvCwh8JvEBLGw6BcPrUjm1/D6q1VN02B
         PJFFN60or3RyeUiXE1BLbfubEH1yVubRvE6TpNFNkigscKA+dyBC8x5fq6m2ba5MPOAv
         WCFA==
X-Gm-Message-State: APjAAAXJLM1f0iLrOsnCUeJAGaU/S8iVdDjZtnzAmW5l0gOXk8Q14XjY
        ATg8MxiIVPdDbQ6+eGcJpZPpIPEc4QoGkPqqGoU=
X-Google-Smtp-Source: APXvYqyTGY27y+fXLM2c6y9Il6TlGdGiGRpFxeY59Reh3sr0g68TeqvBad+M0W7yvXKqIy6D21VCf66mb2yA9rq9620=
X-Received: by 2002:a63:d258:: with SMTP id t24mr7711243pgi.289.1572540430252;
 Thu, 31 Oct 2019 09:47:10 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:30 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 10/17] arm64: disable kretprobes with SCS
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

With CONFIG_KRETPROBES, function return addresses are modified to
redirect control flow to kretprobe_trampoline. This is incompatible
with SCS.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3f047afb982c..e7b57a8a5531 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -165,7 +165,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
-	select HAVE_KRETPROBES
+	select HAVE_KRETPROBES if !SHADOW_CALL_STACK
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
-- 
2.24.0.rc0.303.g954a862665-goog

