Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173F8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE881222D4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGaZKiG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443006AbfJRQLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:47 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36963 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502621AbfJRQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:26 -0400
Received: by mail-pf1-f201.google.com with SMTP id p2so4979962pff.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OMV7GU+CS755gzThihulnjNw1pxqVtHrVsdKKTavPQY=;
        b=FGaZKiG+Ux25snyrOJrBiRd7RwQxjjLhUDr+StQE9m6QImfqUDq6yp6j+8Toagonr0
         9TtbMLb3ay20pI9YbGG7nJzzM0vR4AyRpchI4t/ZYgICefWGJVsG/b/aJxIHIw5w9UV3
         EIJDiPWiyVwP1F234VZ4D2+fA00WZK8lZRp8IvN7MdZJh8XNzU3kgbsv5o54oZ+iiZsI
         KghuQJd7vpAsaqImv6J86r3heyO3yrp6I8mcuRhzR5+TbYZJ39FxxZRefwS+iHZszAKS
         nursS3e3ycHoRmOFQHS1v/YDrqGB9JFjdDc8idnF+2J0IDA0s0+5SNkcUWwuinwq2OFT
         V+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OMV7GU+CS755gzThihulnjNw1pxqVtHrVsdKKTavPQY=;
        b=fNWj7cV/ZI0dkj13cb8ltsPxFvmU+WkaLyDP2xqJFt858Ir21209aOh4czi77mHK+z
         954dFCVq7n5pWldVdeK8MiPlp3UmAqw9hNQwF0oJJwGpXsYihglxDAvzgoMR2W7GwgJD
         pk1lGQpbMnJHl6X5O8ejzzT3QH/JExNJ+fySjrfxvnFs6pcj+WTThc6pG8hlQ4Apf+Sp
         MPOTQYEHjgSsJOvAJnVlY1Y3RqqmzJFeAv4M0f/jDqON4VWQyzT0wlL/HeDWAejV/BtF
         EvuLOs7ZvEVsvGBIM/tNUqeea9WVjG05R4mLYz/siB4hLov9T2uzsBCB/anf7rMw4x15
         KH0Q==
X-Gm-Message-State: APjAAAUcu1WrVn7h4rJm8ZYo3Hnb5gYdZXZPQrgwIr9V1PO4cCNtA+1r
        OB6yXrNvCYxbWR0qrLyvdo9VWlUv1UfpWHn5aGc=
X-Google-Smtp-Source: APXvYqycxw3zlWpqg/6yGEhb7CgOxW1rmJc0Y43aPOFAV6KRrpZHK92ZxBUvHsBpIOsv4SiMThIv0qzjvIsHF4JRnyI=
X-Received: by 2002:a63:1904:: with SMTP id z4mr11066720pgl.413.1571415085386;
 Fri, 18 Oct 2019 09:11:25 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:29 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 14/18] arm64: efi: restore x18 if it was corrupted
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

If we detect a corrupted x18 and SCS is enabled, restore the register
before jumping back to instrumented code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
2.23.0.866.gb869b98d4c-goog

