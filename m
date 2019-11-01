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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46994CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C14321929
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJRBiSEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfKAWMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:30 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36833 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfKAWM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:28 -0400
Received: by mail-pg1-f202.google.com with SMTP id h12so8049596pgd.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xr3X122JfUZTOJ9HNPiJpW+Iyor6r4hGY/b4sjNxJZA=;
        b=iJRBiSEsCdhJICeToYTjV6/+ZJ3W2xifgYKJfjcL131hC2BB0cUCRbkywESPVzBlrI
         8VlR5cC+N7pMsU5+x22Aw5ne1YAMEzfVAV/3q/b7V7ZoG9tAVIz0AEgVSuh4hW3Zbj6L
         8aT4Az4vTNPYUadKRN4vE4k+cTQ9+QjgE+sNFrGD+oYFu80MiqRx6LYVU3nA2t8rpdAu
         rt0Xtr9hynaTlZ4tY88Emujp4zPpcari/k/MzTq60ei+HHRB6JOsgOHkUmAALjYf3xWu
         4VQzOKmPKCT2h1o9LllZnsSb98KxsZJ03JbNAV7PqwK8Ovk06fBR7TYZNq1DCfB0qZBz
         hFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xr3X122JfUZTOJ9HNPiJpW+Iyor6r4hGY/b4sjNxJZA=;
        b=R/ae30ri5+TIpHqS25TZ62fZyUb5K3xCniwqdgq4cf7lEI78icxXM1VJx191CBCnT9
         IvbesTlbf9wV7tTbgY4LuXoOPlYmpsyRjOTTrGFE5HCMkzzHKYJfdrJnND5QQuZv5dNr
         S+uK6MyDu1C33W/d/VYKfA7UGdXh+Myo6iQRLuMhBfg7qDEGBllOA1Q9fMIF2TiWjMB/
         ZyqZISo4HvL7+3j2DJ8xewfb3M8M1rRT2oykiDEgDVsTgMly7eMQzlbDu6hged1s/yRa
         4RCbyCvsQ0CS6PoEe/RRoP45gMj1gY5JmkAELTMVqPshK0DBsW6t9tnm2WZaeJiPJhiz
         7+hQ==
X-Gm-Message-State: APjAAAWMCfiVSi2fL1S36vhiWSmqGqQ/iVe0aPBpC5+/7sfsF1g6DHbd
        b4bBPOG29lnO0GTj9ibLN3LwFNujgJhF5uyGl+I=
X-Google-Smtp-Source: APXvYqyCFSFt+5MiVYAedclgUa3YVl6NHt+7PUMsEM4gdNt4exvKeZ9B7bS1m6sTTxVqCs+LwHo1QQUcaSTSyZAlU8w=
X-Received: by 2002:a65:47cd:: with SMTP id f13mr15511166pgs.356.1572646346250;
 Fri, 01 Nov 2019 15:12:26 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:45 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 12/17] arm64: reserve x18 from general allocation with SCS
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

