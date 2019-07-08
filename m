Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243BBC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8272218A0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gWdTavZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404017AbfGHRtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:49:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44920 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390712AbfGHRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so7941933pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvubPfiCRWcqYJeQKrlvplKJ87mcq6CV3rScnhJCQ5U=;
        b=gWdTavZInEF8s+f73QfuvdZZVflT//tp6s2gup+DG7rzJx++7Zxn4YR8R+P3cCQ3vg
         0XtUyooDHCqvJfLoTxIPl7CFHlSKSceFQO1IeLxzta92vXckW46gHBQduoya2pJJMyio
         nnulEIodWWvqRkpqb1gs8njfVwcB7aV8EdjTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvubPfiCRWcqYJeQKrlvplKJ87mcq6CV3rScnhJCQ5U=;
        b=sikNjAnFUPgd9IqAbhyCFYa3J2KOgd9NDoEYXhsyuRoZX6gaDsmRvIgdPIHP5MjZKf
         iolMcjoBrRieTw7hXW2cjRfWe8YQ7Mxjlk/Dy5AQtU5jLUAunKSYISXNwv2GREdwa6Zq
         R5dqlOXbadZr3LxYBtgjbIinMnAL0CMviTKRr2Arqex1bsrKr22nxecP7MBHPvMuKzEi
         DOKFbnRiazZPm3DxPZxJGMWKTTPUS0G1/5ZouGzSsssNG2Rb0AlYvuWQxGx0P2mEleKv
         qLFU9K3nWW0F06rcbdp4ynfHhRErjI2tmv4zy1jWlgqb9Mtc5UA49M9DhAVaaYu8zil3
         DSdg==
X-Gm-Message-State: APjAAAW5tEDWVVqUD7RYq660MhuPVorZahfCMJl2SaDEMCWr5hb3Jazx
        AKp7yCOI8OSbltC1lJGF6h8uwQ==
X-Google-Smtp-Source: APXvYqx8rkznkGCAzouh1iIQ84Mhjqiwd/g+Pg/qIIPvd4iT14Pzd6lYH1LAJdK/xxZzTbQTVpJPsA==
X-Received: by 2002:a63:2310:: with SMTP id j16mr26308534pgj.238.1562608179726;
        Mon, 08 Jul 2019 10:49:39 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:39 -0700 (PDT)
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
Subject: [PATCH v8 09/11] x86/power/64: Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:49:02 -0700
Message-Id: <20190708174913.123308-10-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
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
2.22.0.410.gd8fdbe21b5-goog

