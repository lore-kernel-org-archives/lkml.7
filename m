Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1E9C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80715217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UBC7Y7/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbfKFDHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37802 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbfKFDHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id z24so11570555pgu.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYMXo5tm1vSQYBY7oCGznRMKQHPJSlsp16NmNOYCIiM=;
        b=UBC7Y7/xFdaEvQmFoWJTKNH293yye4eq68qOdzP3p96qK6trmKAtFgWI7p+yPjecB2
         VuPcXJRSd7HFwSy1Qqkrt76lOr8lcRCcDpDnlxWPlNOGGZJNpTJ3v+mrB790s3AxfX9K
         ldC3iVk1goR79u5DeB0Loj0Cm9Vn40BxP7a9Q2OXSTcYEd7kqdTMopZaulv2xUToK4uY
         exLvjgFCPpcrUHyVd+hdP3U4N6Ek6ml0kGlEI/sqG0DJezwZwmjA0AiefSAWkBzt7rP8
         xc405ddbuIVxOV+7PhgwrfMz7x00eGNPHXN9cW7QSB0gUgdr2m1aeCmMFxBPKsdT9NDN
         SENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYMXo5tm1vSQYBY7oCGznRMKQHPJSlsp16NmNOYCIiM=;
        b=b1CwHrSSeX+GHOrlKiCFGFRpdwUP2C6RG8fa6jNyI3yzdLoIpTkhP4JMWkRqL6ROeL
         ZQH0zjhoPPe6gGhtbmuMO8YqESUz2AZmcmtYFsKa3FU5s1M3k/8ia+w33NC+nQciBM/r
         mXwY/50T30QIRMOwNe22CzMm9gtHW71yLB3cHgB6ilY4cKuZsokbE50GvdukRM89nJNs
         Dstk/iIbnYJ4ezyk3MxG/jbvxPOnZl5rmsS3vAgtcNyidfz+fKhv5cM5wn9tWl6eodWd
         J88F558ER+pseLblEphN5aw5tOMU78XvoazyoDE/KNT9KwefPTSVD6kBQtJxhvcKqUMw
         9LYQ==
X-Gm-Message-State: APjAAAUYgJv24at1UP2IzTX+qwFilmMWHOKAUWXU9oJl64aisru2w9mJ
        SwQj3/J7G+AGJfys97HpcqDuHTyqgmM=
X-Google-Smtp-Source: APXvYqwSml+8c3NmlSxGjro0cUsOMkTRgIB3xXs1VkWvcbapnFuLRoapTW0RCYHtNLRu/j52+hnloQ==
X-Received: by 2002:a62:2a41:: with SMTP id q62mr414892pfq.131.1573009664696;
        Tue, 05 Nov 2019 19:07:44 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:43 -0800 (PST)
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
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org
Subject: [PATCH 25/50] parisc: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:16 +0000
Message-Id: <20191106030542.868541-26-dima@arista.com>
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

Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/parisc/kernel/traps.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 82fc01189488..c2411de3730f 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -49,7 +49,7 @@
 #include "../math-emu/math-emu.h"	/* for handle_fpe() */
 
 static void parisc_show_stack(struct task_struct *task,
-	struct pt_regs *regs);
+	struct pt_regs *regs, const char *loglvl);
 
 static int printbinary(char *buf, unsigned long x, int nbits)
 {
@@ -155,7 +155,7 @@ void show_regs(struct pt_regs *regs)
 		printk("%s IAOQ[1]: %pS\n", level, (void *) regs->iaoq[1]);
 		printk("%s RP(r2): %pS\n", level, (void *) regs->gr[2]);
 
-		parisc_show_stack(current, regs);
+		parisc_show_stack(current, regs, KERN_DEFAULT);
 	}
 }
 
@@ -170,37 +170,43 @@ static DEFINE_RATELIMIT_STATE(_hppa_rs,
 }
 
 
-static void do_show_stack(struct unwind_frame_info *info)
+static void do_show_stack(struct unwind_frame_info *info, const char *loglvl)
 {
 	int i = 1;
 
-	printk(KERN_CRIT "Backtrace:\n");
+	printk("%sBacktrace:\n", loglvl);
 	while (i <= MAX_UNWIND_ENTRIES) {
 		if (unwind_once(info) < 0 || info->ip == 0)
 			break;
 
 		if (__kernel_text_address(info->ip)) {
-			printk(KERN_CRIT " [<" RFMT ">] %pS\n",
-				info->ip, (void *) info->ip);
+			printk("%s [<" RFMT ">] %pS\n",
+				loglvl, info->ip, (void *) info->ip);
 			i++;
 		}
 	}
-	printk(KERN_CRIT "\n");
+	printk("%s\n", loglvl);
 }
 
 static void parisc_show_stack(struct task_struct *task,
-	struct pt_regs *regs)
+	struct pt_regs *regs, const char *loglvl)
 {
 	struct unwind_frame_info info;
 
 	unwind_frame_init_task(&info, task, regs);
 
-	do_show_stack(&info);
+	do_show_stack(&info, loglvl);
+}
+
+void show_stack_loglvl(struct task_struct *t, unsigned long *sp,
+		       const char *loglvl)
+{
+	parisc_show_stack(t, NULL, loglvl);
 }
 
 void show_stack(struct task_struct *t, unsigned long *sp)
 {
-	parisc_show_stack(t, NULL);
+	show_stack_loglvl(t, sp, KERN_CRIT)
 }
 
 int is_valid_bugaddr(unsigned long iaoq)
@@ -446,7 +452,7 @@ void parisc_terminate(char *msg, struct pt_regs *regs, int code, unsigned long o
 		/* show_stack(NULL, (unsigned long *)regs->gr[30]); */
 		struct unwind_frame_info info;
 		unwind_frame_init(&info, current, regs);
-		do_show_stack(&info);
+		do_show_stack(&info, KERN_CRIT);
 	}
 
 	printk("\n");
-- 
2.23.0

