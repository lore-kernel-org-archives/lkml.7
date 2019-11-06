Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228FAC5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D456320659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="B8+bVyjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfKFDG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36785 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfKFDG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id v19so17726573pfm.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODP7qqNbXeIjD4VfygH20iktjtkrE1E1jn2/BJe+UHI=;
        b=B8+bVyjftXfK2EMIT5BgEabVdEkLkEddLb02mCGtblHbIiBOdz1THExEvYkZl0IR5/
         6x+gdln2J6MDOUYBRKMC81Cm+1yHwTLIK+gYePCpxj/o188A6yNomdnvsH90lzuY5ALA
         f6qwJkb+FzLsAjugRiwe1UfX9zcZRMLJ361cV1hnq/1DxVeeRyS2BqWNSxDg4IIJYD0C
         ZLN0qZRVDeEInpPkCrdGd9ybmmUMXJE6W2/6vt9taHU+L/5ltCLbm2Yaqgze0XATwQms
         v/icbT8cD2tH0Pcmlxl7Fvi6ca27y/ehI777YizM0iUmB4f5kyGjqWkcK9w/MTmjicmH
         cNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODP7qqNbXeIjD4VfygH20iktjtkrE1E1jn2/BJe+UHI=;
        b=YNXu/gQTVX7yvpANf9isqg3jBaDRRbDegvgc3yNPzaONRqsYwPNnZs/i5l7NLM0UPp
         Ltp/YsJUUau6DpRHE0K1PfryyzAknqK1PxxJURDojSJjolqbKRssU3TyDaKkYW3R5l8h
         c9RNeDbTLg5TWJp0+OYObgTvZuO8sHvzMBh6c818+HQMZQvg3VpegPBgFew6+X6eGsBF
         MbAB64NQJMRNibnpUFsyIQN0wajfYfHrh8NTIH9HSUvOkYusbDytRB0ZNnr4HduFMaG4
         8XdQCwu4e6kYQTC02r1Rvu7KRzO87kIPmIQbaq74QoEfOe7YwzYCPYYxgxa6IC3pEGoS
         Z24w==
X-Gm-Message-State: APjAAAWgPlqMs9v5h6UHeeLGG4m2DS1kHXlmqINU1A6DxuS2b4Y9/heS
        GDBHFkbQprgsGfIR/Juxd50/ELcPGcY=
X-Google-Smtp-Source: APXvYqyyA48Y25S/1G12drprHmDufTNzHOcbCQaZxpOGwIai2Ww5xHqqUpMIXkintuJcC4kel23zJA==
X-Received: by 2002:a17:90a:c56:: with SMTP id u22mr645038pje.24.1573009616928;
        Tue, 05 Nov 2019 19:06:56 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:55 -0800 (PST)
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
        Guo Ren <guoren@kernel.org>
Subject: [PATCH 12/50] csky: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:03 +0000
Message-Id: <20191106030542.868541-13-dima@arista.com>
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

Cc: Guo Ren <guoren@kernel.org>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/csky/kernel/dumpstack.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
index d67f9777cfd9..c500837390d3 100644
--- a/arch/csky/kernel/dumpstack.c
+++ b/arch/csky/kernel/dumpstack.c
@@ -5,7 +5,7 @@
 
 int kstack_depth_to_print = 48;
 
-void show_trace(unsigned long *stack)
+static void show_trace(unsigned long *stack, const char *loglvl)
 {
 	unsigned long *stack_end;
 	unsigned long *stack_start;
@@ -17,7 +17,7 @@ void show_trace(unsigned long *stack)
 	stack_end = (unsigned long *) (addr + THREAD_SIZE);
 
 	fp = stack;
-	pr_info("\nCall Trace:");
+	printk("%s\nCall Trace:", loglvl);
 
 	while (fp > stack_start && fp < stack_end) {
 #ifdef CONFIG_STACKTRACE
@@ -32,7 +32,8 @@ void show_trace(unsigned long *stack)
 	pr_cont("\n");
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		const char *loglvl)
 {
 	if (!stack) {
 		if (task)
@@ -45,5 +46,10 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 #endif
 	}
 
-	show_trace(stack);
+	show_trace(stack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_INFO);
 }
-- 
2.23.0

