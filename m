Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC92C47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE64217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Hd8PtdO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbfKFDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39284 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbfKFDH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so14515943pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltvHqBOKpiD2l5ND4e2zUJLZaNbuv0rVXPgSgZl66Aw=;
        b=Hd8PtdO4WQgjJ2rZRc4lcPgXWh5Jl+NOyxQUhpCFlJ/5w+XtRMZuPAOhNgsYMeOAUQ
         KJAgOP4ckJdkVZkm83U7EVX5LWc+H/LXqs9wmjMwCAEnZbNu4kHvao4lMC6iNpj5hbzG
         F5kc5v5Nm4ct7kNDcK5fbff3sx1DouD/iQ8J9Y/mJl34ESyofu7gVM6Ro1ROaVFijim7
         olOnKD9ptcmp9Nh68d0gSGbzBiahE+C9UqxngJqIoCsFb8Ea5QPFGaL9VI5d5IyyURym
         I5UvsjyXbUSooDh0PtSLxRiSqKe6KpldH623QhAN+rMonDk3siwjmXxTC36dahgARnTV
         YbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltvHqBOKpiD2l5ND4e2zUJLZaNbuv0rVXPgSgZl66Aw=;
        b=t5jNv6emgMa/uBh7Jtp7EUPtJNn+xoxORTB0vKiNklJAKfJbqw1rMy6uiD2qB2R74w
         +UHIuPOrn/FyyOOPLJmDAVaDAqcZKsoQvafSuVJ23n8gwhcgYk2OdVC/E7sgBRzxRxZG
         0n/CbCCchzTjnIElPGzTOxeWrzZpC3AZPzOB0RCC4Y80NpgOpdFqBRGIfyyoYkAxrpCA
         wPUXUds+BUaR67l6gA5OQiyhrSOBezOhOGo9JTKAXr3yi8ZSApWkliSyQJCGqMBWik4o
         b3Q7NhtwbK38S2eSZqh3to8KYRXwwgyZTOp7LTMmeWIjxPT1UaRzEHrnmA9NoL6uoEAI
         dm/A==
X-Gm-Message-State: APjAAAWT7igZCphGs45+6VmU59BhsZKz4rhly4AYgErLR/zNq+iazmpa
        IvIq/yra5gJVRUWbML3Soh4peJeCWbo=
X-Google-Smtp-Source: APXvYqxoh7SswIGfcGLUzP2eWTaPnr/Qq6dF9alaThcEfJbeFh98Jk6bm8sZB2XHEVJZ02GQMNrwLw==
X-Received: by 2002:a17:90a:bf16:: with SMTP id c22mr570965pjs.83.1573009676053;
        Tue, 05 Nov 2019 19:07:56 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:55 -0800 (PST)
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
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 28/50] s390: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:19 +0000
Message-Id: <20191106030542.868541-29-dima@arista.com>
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

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/s390/kernel/dumpstack.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 34bdc60c0b11..1a89f0968742 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -123,20 +123,26 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 	return -EINVAL;
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	struct unwind_state state;
 
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	if (!task)
 		task = current;
 	unwind_for_each_frame(&state, task, NULL, (unsigned long) stack)
-		printk(state.reliable ? " [<%016lx>] %pSR \n" :
-					"([<%016lx>] %pSR)\n",
-		       state.ip, (void *) state.ip);
+		printk(state.reliable ? "%s [<%016lx>] %pSR \n" :
+					"%s([<%016lx>] %pSR)\n",
+		       loglvl, state.ip, (void *) state.ip);
 	debug_show_held_locks(task ? : current);
 }
 
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_DEFAULT);
+}
+
 static void show_last_breaking_event(struct pt_regs *regs)
 {
 	printk("Last Breaking-Event-Address:\n");
-- 
2.23.0

