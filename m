Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B0CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD048222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XB6QWz3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502660AbfJRQL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:27 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54281 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502587AbfJRQLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:25 -0400
Received: by mail-pl1-f202.google.com with SMTP id j9so4008498plk.21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J6SOPI1rQkBRz/oAhlc59Qnl/pEg0yYrtpuJkIBOBkk=;
        b=XB6QWz3NWtjFWDb+Z+2Cr8pmFgRAQYSnL3Uid2Hg1L3X4a6VceEhm2xwPy1aK+VoSw
         9aDveAT40bEva7mRzlDierznfNSbLqDMAgSgjhFynz+GencRC+yEXI9GlTtBT22sGU3p
         BgssCzMTgiVVKQ7dMBIH2LGWSYP103Svydpv/Qk8+Xt+dKrQ9nOnszXcbv17KY+4wwg4
         NXeKJ9olZaMc5VRteVjdV9T7bI7kUuufX9b3S6ryE8d0aJM7RC3oqJ3jQ0cSx2x8TLsX
         ddVquFcsQoFiGmYXXscZ5m21z4LgANVA4sAoVnGTE5uNuWZVS07mkE/xs/dMfJWy0ygM
         tC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J6SOPI1rQkBRz/oAhlc59Qnl/pEg0yYrtpuJkIBOBkk=;
        b=d3s/LM5NCbT6k4G08B9W2QgBEV2MauKAnz6igiRiUi8myGS99vfY3MljHDppDGmBn8
         lYl93lF6ZSiqN62eXgF/oo7jhGYyY5MzgVvB48L9JYByUMWXz/Yyw/iDcIWmwejt49B8
         IDaOuK6/ZOyA0sCmbghOhKEOGFykVMEciEM/c9owe2EPBRBJUSRpteZkr/V28iVEKZze
         XLR7CmlBWLu7LCI1MBKkOQfsN9QSPv66BLOlbbayqB02x/j5ikiOVw4H47Wx4mWsfxvl
         1N3GhfNc5+f4K41rgVwLLo6i2b9JtSa48X1ZIBHny1kqrjFXiKQ8I7FhW1EIIbXpRsEM
         siWg==
X-Gm-Message-State: APjAAAVGvjoZ1Avds71JK+Lknxw7AruxKtTFxI8pTXtoqsXy41xAxf3a
        g0C6GkgnfjNqtF8URTTBRR5ULTBWzuKvCDYvBXw=
X-Google-Smtp-Source: APXvYqx8PtU7/rtmLemGGFK39JXzIOz2FvaCxezwKfcFnavxjhOconPajgJzRwBjZVVbgrCp+Uo7fSkc9snzmg9De7Q=
X-Received: by 2002:a63:1e59:: with SMTP id p25mr10856086pgm.361.1571415082807;
 Fri, 18 Oct 2019 09:11:22 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:28 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 13/18] arm64: preserve x18 when CPU is suspended
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

Don't lose the current task's shadow stack when the CPU is suspended.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/mm/proc.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index fdabf40a83c8..9a8bd4bc8549 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -73,6 +73,9 @@ alternative_endif
 	stp	x8, x9, [x0, #48]
 	stp	x10, x11, [x0, #64]
 	stp	x12, x13, [x0, #80]
+#ifdef CONFIG_SHADOW_CALL_STACK
+	stp	x18, xzr, [x0, #96]
+#endif
 	ret
 ENDPROC(cpu_do_suspend)
 
@@ -89,6 +92,9 @@ ENTRY(cpu_do_resume)
 	ldp	x9, x10, [x0, #48]
 	ldp	x11, x12, [x0, #64]
 	ldp	x13, x14, [x0, #80]
+#ifdef CONFIG_SHADOW_CALL_STACK
+	ldp	x18, x19, [x0, #96]
+#endif
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
-- 
2.23.0.866.gb869b98d4c-goog

