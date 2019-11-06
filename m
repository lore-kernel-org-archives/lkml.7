Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC91AC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB79217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PpfjGJAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfKFDJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:09:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43827 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388466AbfKFDIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so17718143pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khH3jrRzWOA8KXT9/T2oBYupKLoCJRNbsOsZHkrh+kA=;
        b=PpfjGJAFs3zWDKErSpq0MTUlUYX7mP8i+6S/IRuW7aPEabYOWq08DK+7ZcT+1fnBb2
         c47KZdGJON2I9mKihJmiUF1co06gjLugZ7i0gwEKBNZD4pfSgPelc1yS9Ys4wrYdMtyO
         gXUlpk9ZANNA9hKj+8VWbXv5Lur/n3bS3f8jdooN0NG/3MsiPGnt4gZFrNVbiQKHUB8A
         Wy7fd4OR07v4KPLMpIwzQaDCoi1Ydk1a5lDiJgJ2WLx0dshYiQY0wa2Ieu0fSlPzXV0/
         I0QOajhCqM7Uk6CD4U2mzdnPmEktgc7BGe2YxbecCqBTvsO6IMkA7oxG5kyfbs4HBXBn
         abbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khH3jrRzWOA8KXT9/T2oBYupKLoCJRNbsOsZHkrh+kA=;
        b=TKlFw8ZfexuR2okmyfJ5jEKDpdcmcYVBrOy9RiCXlQpNw2yHb9jJdNwe42y1XJpUTc
         2ssEtwIFm/c7isdLJVKsIc2y2DKAOCEJvVwQgx0g9MsFVcXaHuwSxTX0Xok4A7yoEhtm
         L4LIY21ajCTOiNWlGn2dcUgOKPPe6Kvm4QrmhhZO418U36q+pPYIqkNzGzKA2e7ota+/
         8l4CQ2BljpBGcwohWMrPUHpDHNfwn9a/HvuA5ThBQTCFLgwz1PM7au4AX3eVu1ZibBL8
         4pdCh3RuIlrefjQWW0RT+dE2AeiY3nkhHIiGnyFTZ2zndVxIho2g/oy+Om89Rf/E0yGO
         wrFQ==
X-Gm-Message-State: APjAAAVHAMv0Y6I9FwrWI0zXC9Vby8Kcvn0elMiHIJZbO4uI0X220NaN
        nfwRlPCmJ6jBWHa9ERuHZZQCWwrXEug=
X-Google-Smtp-Source: APXvYqzvP1pWaPKxmJO5kVLOC8oAa65GWg7uhS61nLCXKZ9uMT7LujNzam1TSvzryMdhViuRD6Hbjw==
X-Received: by 2002:a63:5f44:: with SMTP id t65mr224662pgb.124.1573009726840;
        Tue, 05 Nov 2019 19:08:46 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:45 -0800 (PST)
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 42/50] xtensa: Add loglvl to show_trace()
Date:   Wed,  6 Nov 2019 03:05:33 +0000
Message-Id: <20191106030542.868541-43-dima@arista.com>
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

Add log level argument to show_trace() as a preparation for introducing
show_stack_loglvl().

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/xtensa/kernel/traps.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 4a6c495ce9b6..cbc0d673f542 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -479,20 +479,24 @@ void show_regs(struct pt_regs * regs)
 
 static int show_trace_cb(struct stackframe *frame, void *data)
 {
+	const char *loglvl = data;
+
 	if (kernel_text_address(frame->pc))
-		pr_cont(" [<%08lx>] %pB\n", frame->pc, (void *)frame->pc);
+		printk("%s [<%08lx>] %pB\n",
+			loglvl, frame->pc, (void *)frame->pc);
 	return 0;
 }
 
-void show_trace(struct task_struct *task, unsigned long *sp)
+static void show_trace(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	if (!sp)
 		sp = stack_pointer(task);
 
-	pr_info("Call Trace:\n");
-	walk_stackframe(sp, show_trace_cb, NULL);
+	printk("%sCall Trace:\n", loglvl);
+	walk_stackframe(sp, show_trace_cb, (void *)loglvl);
 #ifndef CONFIG_KALLSYMS
-	pr_cont("\n");
+	printk("%s\n", loglvl);
 #endif
 }
 
@@ -516,7 +520,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 		if (i % 8 == 7)
 			pr_cont("\n");
 	}
-	show_trace(task, stack);
+	show_trace(task, stack, KERN_INFO);
 }
 
 DEFINE_SPINLOCK(die_lock);
-- 
2.23.0

