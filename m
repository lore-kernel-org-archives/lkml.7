Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF3C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216A4217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MJQ+MkQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbfKFDIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38407 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388356AbfKFDIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so17725806pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sIzkO5kYggGdSP+AXFZYDpC0rKW1CQK742piJnh1v30=;
        b=MJQ+MkQkiDDjrghCG7lt6ZBr34kb4tA5zVhYfWBP/JoTVpiIKV417rS9Q27zC26LXS
         wjsyUpxc/Dszts1GiMmIIoidpXHgoE+v+Sq+nheZo942y2h/gGEglbdbnpCTHQk5SSD0
         kOMkfksOsedyuJ9cVpegUprJdfv65LYDreMc+heu+XCe31pVfq1P2xwswn9UY+bgcANA
         hePcEvlIXPdkBIEU5EMsGxA03Xen0+rcRNwAKOHd7UUTxhOSq/hq35ZYhKfK+QsBGYlB
         BFMWOdgpWiGOIyKryOd+Lnu8U8fdgKWS9UJgvWwswUnw22zboAVJ9FQiaUUvw2/ebyG+
         QuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIzkO5kYggGdSP+AXFZYDpC0rKW1CQK742piJnh1v30=;
        b=NYzs7Tx4ZLHl2DlI5e2LrjQL2DWOhiCYwJxWwr68YdRLJqfML+CAyH2fpIjutJXJiG
         Y9OHjd3+3GoQcDkbV55t3saCM7mIIYTg684WOuh+qtv+UkNOlwOqGHujBSLKRjAFtReX
         CP3qAwdTY0aXT3E8X9VHWu7Oon/J9LFmAaWeWLZgRXIrMaUS8a2Y1NwwnaT3D+JE0pSB
         tsV/tP1WFEJA5/yjDwNFhRfVe9AkqYjO7RmOEfo8qZrFQ+HYAWlvauwqmWJelZtOqCgM
         TpNa+xJX+rxawx0MLoW8QZiIjusr6DdKCUpOnE0S9Q34BiCVRRF1IkojQH9BGebHG8EH
         j7ow==
X-Gm-Message-State: APjAAAUKu8qWOTeqrmN5DVy3yK57o0iMy0kCF8aU9UnUCB3NxLJtYAxR
        NB1FmQIjAf2foxy7uVe/I9x3A/a3rAY=
X-Google-Smtp-Source: APXvYqwWqHBWiu66lCF+4QxOxKkogrECEHshtGAaUx/i5nFW67rrlbdUWI3L47zubM/4cZ/p0aplQg==
X-Received: by 2002:a63:e853:: with SMTP id a19mr219711pgk.192.1573009715299;
        Tue, 05 Nov 2019 19:08:35 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:34 -0800 (PST)
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
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 39/50] unicore32: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:30 +0000
Message-Id: <20191106030542.868541-40-dima@arista.com>
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

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

As a nice side-effect - print backtrace in __die() with the same log
level as the rest of function.

Cc: Guan Xuetao <gxt@pku.edu.cn>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/unicore32/kernel/traps.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index 2b7d73456865..8b1335997f50 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -135,12 +135,13 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 	set_fs(fs);
 }
 
-static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+			   const char *loglvl)
 {
 	unsigned int fp;
 	int ok = 1;
 
-	printk(KERN_DEFAULT "Backtrace: ");
+	printk("%sBacktrace: ", loglvl);
 
 	if (!tsk)
 		tsk = current;
@@ -153,25 +154,31 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		asm("mov %0, fp" : "=r" (fp) : : "cc");
 
 	if (!fp) {
-		printk("no frame pointer");
+		printk("%sno frame pointer", loglvl);
 		ok = 0;
 	} else if (verify_stack(fp)) {
-		printk("invalid frame pointer 0x%08x", fp);
+		printk("%sinvalid frame pointer 0x%08x", loglvl, fp);
 		ok = 0;
 	} else if (fp < (unsigned long)end_of_stack(tsk))
-		printk("frame pointer underflow");
-	printk("\n");
+		printk("%sframe pointer underflow", loglvl);
+	printk("%s\n", loglvl);
 
 	if (ok)
-		c_backtrace(fp, KERN_DEFAULT);
+		c_backtrace(fp, loglvl);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
-	dump_backtrace(NULL, tsk);
+	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+	show_stack_loglvl(tsk, sp, KERN_DEFAULT)
+}
+
 static int __die(const char *str, int err, struct thread_info *thread,
 		struct pt_regs *regs)
 {
@@ -196,7 +203,7 @@ static int __die(const char *str, int err, struct thread_info *thread,
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->UCreg_sp,
 			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
-		dump_backtrace(regs, tsk);
+		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
 	}
 
-- 
2.23.0

