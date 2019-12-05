Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27B42464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="An6EKBfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfLEAKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:10:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36160 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfLEAKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so500197pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyqJWPK5gXiDkj7pmzxZFEFTPFB7rpHSJzIvAweXZ1A=;
        b=An6EKBfYvskuNlarkZw8jmwWOHMO23mba1ZDMioIp6NWW+BYGhM0azn1Tj5l0aSL3l
         F84yQ1vmqcaKNJ8NVSbhIx2+fPjAVurVTHG7H+k9UgRIebIWnlVc93mV69v1aWfsM7R9
         PDaE08TiD3RYOGNFDjF8MurzqNd0oyu9Pza+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyqJWPK5gXiDkj7pmzxZFEFTPFB7rpHSJzIvAweXZ1A=;
        b=tAAwqw5VchKp2MYlFMrSfK+CVfgWx9scaklOpxDi6zuNVM/GhxDhC0zSJNH76q1GoS
         Fxh+fa4aYVCB0c/WmgIXZ2jQcEYc+nRUAiTBNwnee2bSTvKRpEKCJlHL8didbF9BIzyr
         6Y01Ag458AG0Z3T/XpG22gYRE9TNmqmwYuhn9oJdqbp5d/RSh27GkG6tkRTmYtxVRBRh
         oCDh040JrVDSqXVHmejU2FQVomFI+zq01eRkPHhJxR2Z0lXPoJL420A6x3XZ4EWJrEGe
         F5jf0/7xSoG0vk4lmBI8f32i/xfrLjyTYzZNQnkkjQqPPR7ZazpL7NDPaT2Dh/8nnpRl
         fzSg==
X-Gm-Message-State: APjAAAUGmyH0kvuNNWDrUezbvgWKud11orJWykp/cWi6jlMqUrtMomLP
        Zrz/fULf9clJ1H9OAZysuFA8Rw==
X-Google-Smtp-Source: APXvYqyJHl10vg4Yuv8v57HFoPF0TX9oP8AEzxMSwkMkq2tj2R127UTZp0aTC99o/y/3ahYnP/dATA==
X-Received: by 2002:a17:902:9a97:: with SMTP id w23mr6163243plp.79.1575504623796;
        Wed, 04 Dec 2019 16:10:23 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:23 -0800 (PST)
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
Subject: [PATCH v10 09/11] x86/power/64: Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:46 -0800
Message-Id: <20191205000957.112719-10-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
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
index 7918b8415f13..977b8ae85045 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -23,7 +23,7 @@
 #include <asm/frame.h>
 
 SYM_FUNC_START(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -116,7 +116,7 @@ SYM_FUNC_START(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
-- 
2.24.0.393.g34dc348eaf-goog

