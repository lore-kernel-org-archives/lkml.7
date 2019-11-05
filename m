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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E3C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B5F206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WX/V/VTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbfKEX4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:56:44 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36170 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387543AbfKEX4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:42 -0500
Received: by mail-pg1-f201.google.com with SMTP id h12so16350147pgd.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xr3X122JfUZTOJ9HNPiJpW+Iyor6r4hGY/b4sjNxJZA=;
        b=WX/V/VTfUhYNVK63Q6o2nwuNZuF84nG4taeFhEo17XXi/wiIq5TBNma6L2QWkkxymH
         DvQMMy0aOWkuLzcjaD/VZ7I9iJTaYKRhuhci0d1Uv1dvow1PsPAbfcG7lofjVT32BZTo
         XfopDA2vhLhs1jhnHF0BtxTMW++6XgIwcQqObAyguiG5eCzS2AdaeI/mW/++SFMdkYFO
         0sFgOE5K8+grQi8hixiOmdeRZME3HY40NRXpHJTOGJP9Yp/g21dwfZOSqMKsicYNTg7M
         PQxjmxBUU54ovXgSaLB6R/0V/BtxcVf6/NuKLrw9AecxZk0Kx+tl9gJtoHFRyt1RFLTp
         RO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xr3X122JfUZTOJ9HNPiJpW+Iyor6r4hGY/b4sjNxJZA=;
        b=X0Y8xZtZxj6VXKvXAkoQPCCmZD/EbX5KrNsE9/RaVCPct4ydbLYrpwSUDTCgm1WVrG
         9BF4lsIlUqUECOaGXvYa4R0nc3nQ8sbpMZDtI2SVSlTiHqFfNFCAPsLPWND8BVjS/Zxq
         4nTZl2u4yx6jXABiYKcJwJbpnw3aC4wxTx2vircyYoeYmwF0ssWiF2IQdxK71fAjPh+N
         VArFAEpMTcv2gyK9k2081fk5BO0zlN0NTk3HUdYhJhs/txnRblEaY6yZlQINNeDJYKEn
         pocjQH0qik9wJiCSiNI/lc+xOtGAsIye+Z6i5JbWcOZFGCTcmrC4pzogKGxgb/WTgk7k
         B2Sw==
X-Gm-Message-State: APjAAAXHDnOGrLy7Oca9NKST/l8s9X0VHWQpkaAVlf+KT62FGs1NWn2C
        LiQQBxX6/gq7RgO4vX8rYYKLopJjvaHVX8XTXh4=
X-Google-Smtp-Source: APXvYqzws/iChASYEHCRVYS8P2kdCocZTmxir9yLCAbfQ2Y76yiotnVRg74apgBfcVGe/Rb1kCjSoUo8I9YbTGAoXKw=
X-Received: by 2002:a65:5683:: with SMTP id v3mr19280245pgs.190.1572998200132;
 Tue, 05 Nov 2019 15:56:40 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:56:03 -0800
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191105235608.107702-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 09/14] arm64: reserve x18 from general allocation with SCS
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

Reserve the x18 register from general allocation when SCS is enabled,
because the compiler uses the register to store the current task's
shadow stack pointer. Note that all external kernel modules must also be
compiled with -ffixed-x18 if the kernel has SCS enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2c0238ce0551..ef76101201b2 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -72,6 +72,10 @@ stack_protector_prepare: prepare0
 					include/generated/asm-offsets.h))
 endif
 
+ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
+KBUILD_CFLAGS	+= -ffixed-x18
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

