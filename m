Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA10C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138D1222D4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LJTdREc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbfKFDH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35164 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbfKFDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id q22so8509007pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOULDVVp229eplyOAAWn+UHfDCIE3Z4O68vVEhPIMFI=;
        b=LJTdREc8qlMIddKeyxapf32jwvOBzmXVY07q6OV05suodzhaMPNGQ5pbvSK4nyHs8r
         vgx7VdC0FKdjswdqiwW7ZUSxrn5/NkX3vlcI1/Co5yH28p4BfLwDq2KugVAO3TYt6FmZ
         K6Nl3oMbZgKPaAgv2LMjEqjBrcahhV6A1+3nBIr521mtTeVosaAbYZ6MLB7uh0KYKagG
         Q/bJ/zsTtVOkAARyd0KXM+rDd7RNPiGlySP39r7B15kBwjYRrkVTWQ6XbC3cPJXxzLXZ
         H4bkN2737ALQ5y4oLV7ewko0BFyb6PXhWI3ZFegt6fadKhIMOqvMFltNlRGn9+J10jLf
         6K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOULDVVp229eplyOAAWn+UHfDCIE3Z4O68vVEhPIMFI=;
        b=sm09frD3V4oWwO82ZDjDbJFjoEQ8shFUBknwq8PjLiB1sB3agfdRbX3OCWM0lhmfrv
         033idNXByIKfSBMGiImIsmpEi2PZVa/1lS7Il58C3fB57iNQ0WWWVXPj8BRWzrJqRY76
         kxFIbe76vOAgdtpUY+xgCV7rur2NG5/lTELQqMTCkLpmtkLbmvHDEJkKdU3eRvnG1+0W
         crIR/WlR3IzmxLLp0yAmbQnSlR30n7h1N3QMtBJqg/7U7xjDBW3i13aIgHI76H1RwmAp
         S2Cr6ZNT8XDbiRD+K6h4kHXzGOyaoGZX6gEbiVWM22EDadkBqDQ8DzXeOoVjoyxLgmn8
         z1dA==
X-Gm-Message-State: APjAAAXlx/pTTHLQfOYIfOIJrJP2w6FUWAWrVBpk82bpPY4fqmH4l1Ho
        PqO2oWFiAcBq/khHGs4s+qf6QVz4bKc=
X-Google-Smtp-Source: APXvYqwBFw6Tsm/Ijnd/6yPkiRSbqQC3D7z9yudMkaGkRPpN45/rvJrZlFE2aPh8qGzEC0kQoqBFWQ==
X-Received: by 2002:a63:4562:: with SMTP id u34mr157963pgk.399.1573009642935;
        Tue, 05 Nov 2019 19:07:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:21 -0800 (PST)
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
Subject: [PATCH 19/50] microblaze: Add loglvl to microblaze_unwind()
Date:   Wed,  6 Nov 2019 03:05:10 +0000
Message-Id: <20191106030542.868541-20-dima@arista.com>
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

Add log level parameter to microblaze_unwind() as a preparation to add
show_stack_loglvl().

Cc: Michal Simek <monstr@monstr.eu>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/microblaze/include/asm/unwind.h | 3 ++-
 arch/microblaze/kernel/stacktrace.c  | 4 ++--
 arch/microblaze/kernel/traps.c       | 2 +-
 arch/microblaze/kernel/unwind.c      | 6 +++---
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/unwind.h b/arch/microblaze/include/asm/unwind.h
index d248b7de4b13..7c28f8d5a243 100644
--- a/arch/microblaze/include/asm/unwind.h
+++ b/arch/microblaze/include/asm/unwind.h
@@ -23,7 +23,8 @@ extern struct trap_handler_info microblaze_trap_handlers;
 extern const char _hw_exception_handler;
 extern const char ex_handler_unhandled;
 
-void microblaze_unwind(struct task_struct *task, struct stack_trace *trace);
+void microblaze_unwind(struct task_struct *task, struct stack_trace *trace,
+		       const char *loglvl);
 
 #endif	/* __MICROBLAZE_UNWIND_H */
 
diff --git a/arch/microblaze/kernel/stacktrace.c b/arch/microblaze/kernel/stacktrace.c
index b4debe283a79..b266c4d6ed9d 100644
--- a/arch/microblaze/kernel/stacktrace.c
+++ b/arch/microblaze/kernel/stacktrace.c
@@ -20,12 +20,12 @@ void save_stack_trace(struct stack_trace *trace)
 {
 	/* Exclude our helper functions from the trace*/
 	trace->skip += 2;
-	microblaze_unwind(NULL, trace);
+	microblaze_unwind(NULL, trace, "");
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
-	microblaze_unwind(tsk, trace);
+	microblaze_unwind(tsk, trace, "");
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
diff --git a/arch/microblaze/kernel/traps.c b/arch/microblaze/kernel/traps.c
index 45bbba9d919f..be726ee120fb 100644
--- a/arch/microblaze/kernel/traps.c
+++ b/arch/microblaze/kernel/traps.c
@@ -68,7 +68,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 32, 4, (void *)fp,
 		       words_to_show << 2, 0);
 	pr_info("\n\nCall Trace:\n");
-	microblaze_unwind(task, NULL);
+	microblaze_unwind(task, NULL, KERN_INFO);
 	pr_info("\n");
 
 	if (!task)
diff --git a/arch/microblaze/kernel/unwind.c b/arch/microblaze/kernel/unwind.c
index 9a7343feadf5..74dded96c10a 100644
--- a/arch/microblaze/kernel/unwind.c
+++ b/arch/microblaze/kernel/unwind.c
@@ -286,11 +286,11 @@ static void microblaze_unwind_inner(struct task_struct *task,
  * @task  : Task whose stack we are to unwind (NULL == current)
  * @trace : Where to store stack backtrace (PC values).
  *	    NULL == print backtrace to kernel log
+ * @loglvl : Used for printk log level if (trace == NULL).
  */
-void microblaze_unwind(struct task_struct *task, struct stack_trace *trace)
+void microblaze_unwind(struct task_struct *task, struct stack_trace *trace,
+		       const char *loglvl)
 {
-	const char *loglvl = KERN_INFO;
-
 	if (task) {
 		if (task == current) {
 			const struct pt_regs *regs = task_pt_regs(task);
-- 
2.23.0

