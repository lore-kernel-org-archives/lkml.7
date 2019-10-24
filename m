Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED92CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9096221D82
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2431xJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfJXWwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:18 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:43682 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbfJXWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:15 -0400
Received: by mail-yw1-f73.google.com with SMTP id y200so398907ywg.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R+pagykxtiUayWbEADuJoiydRcDW6HSTgqXK05LN0/E=;
        b=I2431xJR5AtRuX5qoSiIk24z/5OCLlzSdjGi52dpOv12+bHMiaLVBU12PGCDes+r8X
         wAjuAIWuv6ZomAao/O113wncVLizdeeBSlEx1bsxh2/lzn4uD6epbHPViDUva3cOvsU0
         /UNdmDsfJIMrSw5i/0SaDjUj5Es5bVAzDEP1qir0eAi1qvv8mC+P/O4o1w4HC3L6pF50
         AQP27T022w3AaGsGKKMo5gVcBxRaoqeynh9ofqgqyGFYUY3HeancjS86aO6xkUTlSXJv
         nGykeYWoGX6nqGCK04zTzj6lvvXPcGONfsDAOADFXZa+d2m7LYp8SgIBde5lho4ylCuw
         NBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R+pagykxtiUayWbEADuJoiydRcDW6HSTgqXK05LN0/E=;
        b=ikr7Cb+lo3GX1tLMIDd1EGY0V1mGmYO7qsW+wnFbiusA66UHteI2ab96c1cd9NCi1h
         BoWq5KFKGdWu6rKEnB9MO5BCX+ritsx/jy4LXVyXSd8xa1EBqcObC5MG1hA3XQ9c0gOM
         rwkeCpuQKyWsF5DYm7pobRZpFBDb9XoghxDCP8+vV6ePmkoVvjVbnfknxQcmvgn34k9k
         fKUUovAQh9wzzRr4Flxc7AvO0pAvPSQcfTfUp70Y1EXHvoL7QPpxy30Lfo0zZeE7Kfcl
         3Zp3ei4fGIJ+wdGy/4dgxH84Syt3Np660iBIKzN7Qt2WHAI1eegdBhe3V1CtwGe+bq/K
         c7gw==
X-Gm-Message-State: APjAAAV2x6ogxah6YZcC4e+/qi4fxnfNQkV2KJ0DrY7UjGY7FonkB2K+
        2VXe8hYBdGhCNapTXNdgnjWQUUe9MSrA6x1+Bts=
X-Google-Smtp-Source: APXvYqxu3PYbJO97f2mzp9DNQTcnJCAUNKZZIOqlBzTc4OuUnzwTI3m0AgfuJaiQwAi1b2GOeoccGn5nuZqvAM1i7Q0=
X-Received: by 2002:a25:cc87:: with SMTP id l129mr704884ybf.48.1571957534881;
 Thu, 24 Oct 2019 15:52:14 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:25 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 10/17] arm64: disable kretprobes with SCS
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
index 8cda176dad9a..42867174920f 100644
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

