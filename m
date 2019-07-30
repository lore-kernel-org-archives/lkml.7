Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4991C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1A82087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hk0Bac0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbfG3TN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:13:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45429 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbfG3TNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so30327122pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCFi9VKfA/regOH6ME0h7V2OJPrhlZ4OE3HFuZl/Mr4=;
        b=hk0Bac0aiWQasaW/82OqlXyeS+zRRbeGWMF9iYoYCCjmyk5hKfhbErMAfoM104i7Br
         TdpwZFEl9pU+frxz1cazoSP6L1BNAC+8jncLJVwuFEsDynqzb3OP7vNis0EU/ikkPW8m
         /LeN2upB3IFugt/kUzhj6IfHluZI3rXDFFkRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCFi9VKfA/regOH6ME0h7V2OJPrhlZ4OE3HFuZl/Mr4=;
        b=LxYznkYhsYURI7Gr7kA7OCQGQ86v/MM0SiYU2AFWtT6YACaha4Nw2W3bfB4FUVdUMo
         5nWmZDbdgznIGT3L0lN+OI+5EPQQIqPSkOAM0hM0Y36flM8FSkXpRHAVHEMabdAfizkg
         6JYzL4EejFVUivEmQ8zfhB1cxSyHZQoXw8GET5Xnv4q2IPZBoyrwLfmEzpdlICVAzxI3
         7nJabwACSH1+QmriAJSiWRFqR1YXlExzHQcoflHlI7eqcpBbg2YnAiVdt+eidT9OUMWF
         gPwK8bVUE2LIZVM0FK+tmaBogrFKWRemo5ae6eVIJ2eNYmeSjC1+4Sis5uH7CzBmURU1
         DJMw==
X-Gm-Message-State: APjAAAV1RdPL8qvzXip/yJfpaM2WcA/thNqba50ADEw/ikZ6uVUXYnYw
        eEgreNJJQpzl1qAAIjD495z4mw==
X-Google-Smtp-Source: APXvYqyTpbQ7f3xITrwKbyFWcIPqfOysYAwjkN9vIf84u+eLPDg/LwjNFZLDtMcMgZUrWQ+iiuxmZg==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr113599135pgr.52.1564514003446;
        Tue, 30 Jul 2019 12:13:23 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:23 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/11] x86/power/64: Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:53 -0700
Message-Id: <20190730191303.206365-10-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index a4d5eb0a7ece..796cd19d575b 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -23,7 +23,7 @@
 #include <asm/frame.h>
 
 ENTRY(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -114,7 +114,7 @@ ENTRY(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
-- 
2.22.0.770.g0f2c4a37fd-goog

