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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D72CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAFA21897
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odv3zPa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfKAWMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:36 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34362 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfKAWMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:33 -0400
Received: by mail-pg1-f201.google.com with SMTP id w9so8024093pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uZ/kQt4EYM2LvpfCusnWoxftHyD2DxgcHTICv7X7dqw=;
        b=odv3zPa4RgQ8s6dsoDxvbsmHF3EENGYKEFkki0g9WgsTtiUy1PWOo4QagxAFwNjlM5
         UaXo+6ESXS0tfN9t/uaTyImKPgoUdkbU5/6mXIU+WDuhuaMZVZlToQjZBZjUeJ+XCKaN
         AZaYtQv4cn3jcrlvgSVPiMAL2aX2o/kWtvg0ZhsbFx5XNHfG27Zn+lw1m2rgEzTuN0Qx
         AhXuI7DUwTtXfZmNooQs1nB+s/Ns/DX1LvGMoiAbd56F3AJ+mJtqGL8w4imrJ9czieHh
         o3BNgiNlRATQnbvYsOjBOz35StnAU9Usdu1hP8mnieHo1tIou+WOWs5WVmR96RMvFpMw
         BkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uZ/kQt4EYM2LvpfCusnWoxftHyD2DxgcHTICv7X7dqw=;
        b=JRsd1OoxwUo2NzT14V0OYPf6AAV4+UFk1SwrcaLYnLwKMw2LN/hXm6etAP0F+0zisR
         /gdZPPeNHrhaDqgL6QiteQRigpYKO7LNKJ9vvu6sQgZoVtD4uspI5RxjxjNKrd4CfMNx
         ZkH9qkD1dV1KAFosF9Yzh2MIvvc9CQPdNUid4o0agEfJvtvJQjyXMDfQVjxI5NIRKLym
         qth/dTi4MUv/85gPo5ABjIZVrB+EjKyBI0aS7xidPpmGUaFqNSP9RX2c0JLGcPz/JWph
         cEUGaBoPUM2BNJhr6Ofpf5WvacBK8/o/m7EN6iNm0Y11pZONGBajWv1xkuZT0cZ7song
         3YTQ==
X-Gm-Message-State: APjAAAXZP1VxjRLknhlWQ+bJcPdY0fLYaz1f7yEPFwr0bxx1/+oozgTo
        yc6yxwbBVX5Px9d2x62+Cu8n0/BZmhu6qEnaq+w=
X-Google-Smtp-Source: APXvYqxnvjccMKGZa+EMFNvyVvl4JQq0YHBc8XNC8xBIuIHK+TPnyLwR96cD6M+G58PTtTiYueuKAoyE/cNOXhTJ/L8=
X-Received: by 2002:a63:3203:: with SMTP id y3mr15810585pgy.437.1572646351983;
 Fri, 01 Nov 2019 15:12:31 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:47 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 14/17] arm64: efi: restore x18 if it was corrupted
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

If we detect a corrupted x18 and SCS is enabled, restore the register
before jumping back to instrumented code. This is safe, because the
wrapper is called with preemption disabled and a separate shadow stack
is used for interrupt handling.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 3fc71106cb2b..945744f16086 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -34,5 +34,10 @@ ENTRY(__efi_rt_asm_wrapper)
 	ldp	x29, x30, [sp], #32
 	b.ne	0f
 	ret
-0:	b	efi_handle_corrupted_x18	// tail call
+0:
+#ifdef CONFIG_SHADOW_CALL_STACK
+	/* Restore x18 before returning to instrumented code. */
+	mov	x18, x2
+#endif
+	b	efi_handle_corrupted_x18	// tail call
 ENDPROC(__efi_rt_asm_wrapper)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

