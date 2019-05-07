Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A21120675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2z3ioa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfEGGB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:01:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41724 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfEGGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:01:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so7600029pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IoCMWJTQvR4GggXgHZA8O1rN2KIKna3QE6ynjptghSc=;
        b=I2z3ioa/d/Bk3EBZbQ+y0PEKdPz97b1edC2v7ylI/CC6or7o1t9swjDovqjrCFbxXs
         X4srAnyi4sgIZlhXd+YcAVUgqlEmrQvPNWOnsM2YWSDNDCAVPqRGaPBzZ47gM4nvUGlQ
         POKJ/AQc44kU3/day+mrjSKYBhBFycA0TsNY+c8mKhdoBRZ2mjfLv4oNTWzRlL4YHYN5
         r0kNAdXqEmf4wQia6qnHI037XROPQDAFYgl6NEMLYAQvrEF4Rt9PXQzXuqcG+Xuxn3Ip
         lLiABQHtk+FEILnr6YDG8zEm+0HESQ37ElrFZVkcwujBC9Kq7GB9fiBKrS4Pg2zXUxbq
         bnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IoCMWJTQvR4GggXgHZA8O1rN2KIKna3QE6ynjptghSc=;
        b=UonliMpl0f/5LxjtJbuVMS9/m2jL9AvuskCWIWWmK2ytabJmCRbOEa0qmNX9Ir1UGt
         bx1rbzTgnif9ZEWNm/Z8wL5j7nancsqvEjCXG2kqJxmKiKYxvw+cCkjNxghftU9s5rza
         oEQqkrv8xRDK0d/2DTEtc8gaZ4P6l8fZ6AZEifByNhWanm01hrIpWMt9Tl/ofrPJ6iW/
         6aLhcfmN8a0UsYzm9t0c36GSJ0G37LU7GBzTgdrb+IizdZqz7NfA/tGFfne8VDBFHVSe
         LuSw2VqfzFTWlK1gatkSGgxOQxJMqc1AlymnWQcrhi7tbvdKiHuxuS3ioXOa1mqvYH+W
         5GEA==
X-Gm-Message-State: APjAAAVN8c5WRAT988RKRlA7Hp7nx3KQNk/PGPxzvMMWnkQNMhkptWOE
        ecZiTj0PCzhK5Wjhnv2FWNV0PqQ=
X-Google-Smtp-Source: APXvYqxJuU40Uy1gtqUu7ce9cVwa7CyzWFcWPiBKS9V3FJDE2o09dc2EWuNA0llIDlwJvPKHWSDQFA==
X-Received: by 2002:a17:902:100c:: with SMTP id b12mr15110281pla.230.1557208881438;
        Mon, 06 May 2019 23:01:21 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b18sm8997409pfp.32.2019.05.06.23.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 23:01:20 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/boot: push console_init forward
Date:   Tue,  7 May 2019 14:01:00 +0800
Message-Id: <1557208860-12846-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557208860-12846-1-git-send-email-kernelfans@gmail.com>
References: <1557208860-12846-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the very early boot stage, early console is badly needed. Push its
initialization as early as possible, just after stack is ready.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/compressed/early_serial_console.c | 7 +++++++
 arch/x86/boot/compressed/head_64.S              | 4 ++++
 arch/x86/boot/compressed/misc.c                 | 1 -
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/early_serial_console.c b/arch/x86/boot/compressed/early_serial_console.c
index 624e334..223954a 100644
--- a/arch/x86/boot/compressed/early_serial_console.c
+++ b/arch/x86/boot/compressed/early_serial_console.c
@@ -3,3 +3,10 @@
 int early_serial_base = -1;
 
 #include "../early_serial_console.c"
+
+void early_console_init(void *rmode)
+{
+	boot_params = rmode;
+	console_init();
+	debug_putstr("early console is ready\n");
+}
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fafb75c..e4a25f9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -323,6 +323,10 @@ ENTRY(startup_64)
 	subq	$1b, %rdi
 
 	call	adjust_got
+	pushq	%rsi
+	movq	%rsi, %rdi
+	call	early_console_init
+	popq	%rsi
 
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index cafc6aa..475a3c6 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -368,7 +368,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	lines = boot_params->screen_info.orig_video_lines;
 	cols = boot_params->screen_info.orig_video_cols;
 
-	console_init();
 	debug_putstr("early console in extract_kernel\n");
 
 	free_mem_ptr     = heap;	/* Heap */
-- 
2.7.4

