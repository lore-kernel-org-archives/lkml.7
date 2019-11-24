Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB8C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C02207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKXTwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 14:52:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34536 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKXTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:52:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so15008430wrr.1;
        Sun, 24 Nov 2019 11:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nAjjktBsryRv/PVaxm3tkWTCzqkwFEjwFqTsY62waUM=;
        b=r0guWQb+8Sf8kZQQFlfojCnX7kjlj0Cs4J4P6Ysmgn4S78Wf8z5rw96Lo/4J1IRQmy
         YpC1EDFoP+zke+u1N+roOiaVqYjLh5A/TdL7PNLsepYi+5Ci4UMd8TwM5Mp7w00wcw/T
         vO1otmEjb1gZOUxcCVWUcfmeRg/sBwQZkX6AwAI3qUfoL0bi8/BzuSReeCEVRx9oYE/+
         0rQNxFjC9h930TXaZTVKKfPtl8q9j0SEdW03LfIHepMwDKGO7VG01XJj7rpNrn+AkSzf
         jpDyTWwiT/2jsgG4IZTYTpOsPvRUM4J+Z4vz/00Q5IhIV2S2D0+PT4ZzU2fAYWHp4Ipp
         6y0Q==
X-Gm-Message-State: APjAAAWkyYIDCycqCpdPHXRszWwPD6dX6FW/yekxIhW+U/3LenI2zLVn
        xYYZZ7stEf+MKc99MTnGgv6BQFXiHhE=
X-Google-Smtp-Source: APXvYqzLJqeKFX6DyEuA160m+YBl7o+fydNwXxhs4kSJD352hs7vVgA+RYTAgDTXLjPL8do5xNGcjQ==
X-Received: by 2002:adf:9124:: with SMTP id j33mr7915726wrj.357.1574625164352;
        Sun, 24 Nov 2019 11:52:44 -0800 (PST)
Received: from localhost.localdomain (2001-1c06-18c6-e000-94a8-bf38-d78b-3abb.cable.dynamic.v6.ziggo.nl. [2001:1c06:18c6:e000:94a8:bf38:d78b:3abb])
        by smtp.gmail.com with ESMTPSA id i127sm6265844wma.35.2019.11.24.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 11:52:43 -0800 (PST)
From:   Kars de Jong <jongk@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Kars de Jong <jongk@linux-m68k.org>,
        linux-m68k@vger.kernel.org
Subject: [PATCH] m68k: Wire up clone3() syscall
Date:   Sun, 24 Nov 2019 20:52:25 +0100
Message-Id: <20191124195225.31230-1-jongk@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the clone3() syscall for m68k. The special entry point is done in
assembler as was done for clone() as well. This is needed because all
registers need to be saved. The C wrapper then calls the generic
sys_clone3() with the correct arguments.

Tested on A1200 using the simple test program from:

  https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/

Cc: linux-m68k@vger.kernel.org
Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
---
 arch/m68k/include/asm/unistd.h        |  1 +
 arch/m68k/kernel/entry.S              |  7 +++++++
 arch/m68k/kernel/process.c            | 13 ++++++++++++-
 arch/m68k/kernel/syscalls/syscall.tbl |  2 +-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 2e0047cf86f8..4ae52414cd9d 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -30,5 +30,6 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_CLONE3
 
 #endif /* _ASM_M68K_UNISTD_H_ */
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 97cd3ea5f10b..9dd76fbb7c6b 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -69,6 +69,13 @@ ENTRY(__sys_vfork)
 	lea     %sp@(24),%sp
 	rts
 
+ENTRY(__sys_clone3)
+	SAVE_SWITCH_STACK
+	pea	%sp@(SWITCH_STACK_SIZE)
+	jbsr	m68k_clone3
+	lea	%sp@(28),%sp
+	rts
+
 ENTRY(sys_sigreturn)
 	SAVE_SWITCH_STACK
 	movel	%sp,%sp@-		  | switch_stack pointer
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 4e77a06735c1..22e6b8f4f958 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -30,8 +30,9 @@
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
 #include <linux/rcupdate.h>
-
+#include <linux/syscalls.h>
 #include <linux/uaccess.h>
+
 #include <asm/traps.h>
 #include <asm/machdep.h>
 #include <asm/setup.h>
@@ -119,6 +120,16 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
 		       (int __user *)regs->d3, (int __user *)regs->d4);
 }
 
+/*
+ * Because extra registers are saved on the stack after the sys_clone3()
+ * arguments, this C wrapper extracts them from pt_regs * and then calls the
+ * generic sys_clone3() implementation.
+ */
+asmlinkage int m68k_clone3(struct pt_regs *regs)
+{
+	return sys_clone3((struct clone_args __user *)regs->d1, regs->d2);
+}
+
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		 unsigned long arg, struct task_struct *p)
 {
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index a88a285a0e5f..a00a5d0db602 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -434,4 +434,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
-# 435 reserved for clone3
+435	common	clone3				__sys_clone3
-- 
2.17.1

