Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17501C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2E4222D1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DJK3qR3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbfKFDHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42440 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbfKFDHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so9472131pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XK6nMSMgoI5CPnfsCi1EWzYnSHYxNAGeRVVKz6NVbP8=;
        b=DJK3qR3DeTmy595EW4kHtaKhTDd8NL200Edv9MllE+bi/Bgk3leYmNrIHRu5/CSKG8
         iYvLIC0herbNBlfYVGv/cGK8QLem32lg1jzykboLoO+u31pQEbCqxEknW88wnL5A4uoF
         P2B4lQ0ZSmany+QI/1TGvmyXD5GiS/GV1CidHZWNisbPK8uZZB+gshDa5AEpUzQLvmD9
         alqUuHvOso2HgqXZO5I10au4dN74MHEMPNl6rclM46dIgzdwGI0xzulFpD9agvEB1Z+/
         xsx3qvT0UuIFWMWBuB9vmhVEZQa9fDiZCDA2D55uNz6dmMiEs5sxJcHdA+WoJB3SpRNl
         M13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XK6nMSMgoI5CPnfsCi1EWzYnSHYxNAGeRVVKz6NVbP8=;
        b=tlSJ6ciy9DtwRsR/8LdKUW7wFu3/6oyX7OY1qe8lxc5Rdrw5GHjujcAA7oCk+0ZBs+
         rimvK04IyWPqRKjP5RlYb/fXkSX5WkTgekfvIc38qhP66NDBMEtEwHqFiyqXUO3WORay
         9889RW1UwuXbdWI5I8WIh96QVUAyIZsQGFDTAtFAA9fW4UijAYNDbVU8VsF40JLccYMt
         tqwtlatiGgX/aH/KEFSiCjOSbYHX0xjmo1oY74MXsCiQzsPhQzCVwK3Aj0yrYyElWCvK
         yxD2oMn5F459APHKRC/9RV2JM0SRObYqBunA+eotkFPxr/Gea4HBl+V6uVB9HJ4Rb8l3
         GWzA==
X-Gm-Message-State: APjAAAU4tlmPEqC9ZhS1GeixSg5NC1DHIAjU5wMs1Ptu5+4btXJ3++KY
        tEuMbMFD1roocRy+0Sj2Qyxqzrf1dCc=
X-Google-Smtp-Source: APXvYqzEBhol3jr1S91M8c9HLutoKmAHyOAvvO19cRQCNWsZ8Y41BLUvbo/QnIJgqxL7v3KYyL0TiQ==
X-Received: by 2002:aa7:82d7:: with SMTP id f23mr415790pfn.141.1573009639417;
        Tue, 05 Nov 2019 19:07:19 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:18 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH 18/50] microblaze: Add loglvl to microblaze_unwind_inner()
Date:   Wed,  6 Nov 2019 03:05:09 +0000
Message-Id: <20191106030542.868541-19-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Add log level argument to microblaze_unwind_inner() as a preparation for
introducing show_stack_loglvl().

Cc: Michal Simek <monstr@monstr.eu>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/microblaze/kernel/unwind.c | 35 ++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/microblaze/kernel/unwind.c b/arch/microblaze/kernel/unwind.c
index 4241cdd28ee7..9a7343feadf5 100644
--- a/arch/microblaze/kernel/unwind.c
+++ b/arch/microblaze/kernel/unwind.c
@@ -162,16 +162,18 @@ static void microblaze_unwind_inner(struct task_struct *task,
  */
 #ifdef CONFIG_MMU
 static inline void unwind_trap(struct task_struct *task, unsigned long pc,
-				unsigned long fp, struct stack_trace *trace)
+				unsigned long fp, struct stack_trace *trace,
+				const char *loglvl)
 {
 	/* To be implemented */
 }
 #else
 static inline void unwind_trap(struct task_struct *task, unsigned long pc,
-				unsigned long fp, struct stack_trace *trace)
+				unsigned long fp, struct stack_trace *trace,
+				const char *loglvl)
 {
 	const struct pt_regs *regs = (const struct pt_regs *) fp;
-	microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace);
+	microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace, loglvl);
 }
 #endif
 
@@ -184,11 +186,13 @@ static inline void unwind_trap(struct task_struct *task, unsigned long pc,
  *				  the caller's return address.
  * @trace : Where to store stack backtrace (PC values).
  *	    NULL == print backtrace to kernel log
+ * @loglvl : Used for printk log level if (trace == NULL).
  */
 static void microblaze_unwind_inner(struct task_struct *task,
 			     unsigned long pc, unsigned long fp,
 			     unsigned long leaf_return,
-			     struct stack_trace *trace)
+			     struct stack_trace *trace,
+			     const char *loglvl)
 {
 	int ofs = 0;
 
@@ -214,11 +218,11 @@ static void microblaze_unwind_inner(struct task_struct *task,
 			const struct pt_regs *regs =
 				(const struct pt_regs *) fp;
 #endif
-			pr_info("HW EXCEPTION\n");
+			printk("%sHW EXCEPTION\n", loglvl);
 #ifndef CONFIG_MMU
 			microblaze_unwind_inner(task, regs->r17 - 4,
 						fp + EX_HANDLER_STACK_SIZ,
-						regs->r15, trace);
+						regs->r15, trace, loglvl);
 #endif
 			return;
 		}
@@ -228,8 +232,8 @@ static void microblaze_unwind_inner(struct task_struct *task,
 			if ((return_to >= handler->start_addr)
 			    && (return_to <= handler->end_addr)) {
 				if (!trace)
-					pr_info("%s\n", handler->trap_name);
-				unwind_trap(task, pc, fp, trace);
+					printk("%s%s\n", loglvl, handler->trap_name);
+				unwind_trap(task, pc, fp, trace, loglvl);
 				return;
 			}
 		}
@@ -248,13 +252,13 @@ static void microblaze_unwind_inner(struct task_struct *task,
 		} else {
 			/* Have we reached userland? */
 			if (unlikely(pc == task_pt_regs(task)->pc)) {
-				pr_info("[<%p>] PID %lu [%s]\n",
-					(void *) pc,
+				printk("%s[<%p>] PID %lu [%s]\n",
+					loglvl, (void *) pc,
 					(unsigned long) task->pid,
 					task->comm);
 				break;
 			} else
-				print_ip_sym(KERN_INFO, pc);
+				print_ip_sym(loglvl, pc);
 		}
 
 		/* Stop when we reach anything not part of the kernel */
@@ -285,11 +289,13 @@ static void microblaze_unwind_inner(struct task_struct *task,
  */
 void microblaze_unwind(struct task_struct *task, struct stack_trace *trace)
 {
+	const char *loglvl = KERN_INFO;
+
 	if (task) {
 		if (task == current) {
 			const struct pt_regs *regs = task_pt_regs(task);
 			microblaze_unwind_inner(task, regs->pc, regs->r1,
-						regs->r15, trace);
+						regs->r15, trace, loglvl);
 		} else {
 			struct thread_info *thread_info =
 				(struct thread_info *)(task->stack);
@@ -299,7 +305,8 @@ void microblaze_unwind(struct task_struct *task, struct stack_trace *trace)
 			microblaze_unwind_inner(task,
 						(unsigned long) &_switch_to,
 						cpu_context->r1,
-						cpu_context->r15, trace);
+						cpu_context->r15,
+						trace, loglvl);
 		}
 	} else {
 		unsigned long pc, fp;
@@ -314,7 +321,7 @@ void microblaze_unwind(struct task_struct *task, struct stack_trace *trace)
 		);
 
 		/* Since we are not a leaf function, use leaf_return = 0 */
-		microblaze_unwind_inner(current, pc, fp, 0, trace);
+		microblaze_unwind_inner(current, pc, fp, 0, trace, loglvl);
 	}
 }
 
-- 
2.23.0

