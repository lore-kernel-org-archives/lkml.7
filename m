Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8BDC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C55217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BYCbNjxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfKFDIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35327 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbfKFDIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id x6so10731596pln.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1CFwW2Lm09nRLvgyZYRXxfZ7SInie3qB3fO3E3lvMM=;
        b=BYCbNjxnCKSUWP/HkZiGt6P10evxcNKiAhL25CeoFxPbOCVkyxKFvpaSqDjbFGhUW1
         hRZTqA72lB3F6gBZLNf5Axt0itQPo8MukQ/NIKdKBi5I/Ig94XUCvV5nKsNphQDbzsic
         cN4yegmfagZJffzD2QbENFRrbayRaJz4FPrbcAAIdOHbhNHP9ThuRGC5ht6T0FcWvxbs
         8u2FvYHevA7quLveiCBHFOxAEIK08hPBRwlAEAxkiepwc88xVHoogz+azgnlgXGk8k3F
         CRyGh7VgcSZEXrYSaRXmi2SYg+3WUjuGL+cDOP7oseO8yZTWJaPoCM8m7dFcBVYYOUwu
         7guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1CFwW2Lm09nRLvgyZYRXxfZ7SInie3qB3fO3E3lvMM=;
        b=VKG3AVX4KQvbUKhSgmKVIcw4dkDGs/9l3W5UifbO+e3ezgIKqZ+ggNlMdJaQ8hqVcI
         tGbBWRcgrnKSQ7lfwuTVCyVwk0CDW+TPmFgaJemfIR5qjS20D5iqWeEAZF0SfHCBsMYk
         lt0HHWHmenaBt+Ky7cWliAJo7kd9Zueahzdpv4HPLQy6MhfddJGNbq4FhNkxBnxXfWka
         o9fjfdqK38vHwl3G7iq3bb1j8HotnLkdV3vrXCmBUvgJAjsPE7P0EtLN4HDGBT76V/kg
         6CtL2gSpwEM7viEyTMeNNy9Jrx6wZMauV/Lj146D98ipJgIJk0swlT4pLMfXE49VyOe3
         Mm/Q==
X-Gm-Message-State: APjAAAUCapueSI8zWuekC2wKFeQ8Ul8ZQg3PFQP+PpUfSWwQrbzRGgb+
        pBPtXRpShblgbookeM65JjhtTQTnDo0=
X-Google-Smtp-Source: APXvYqxmUJkYUfsMuSjwuj86fK8YwxR9TLHl3Xu9Ov3zBW+ykQ34oQjeBz2bBneBVDyZo47XtlLFoA==
X-Received: by 2002:a17:902:b48d:: with SMTP id y13mr174340plr.290.1573009730444;
        Tue, 05 Nov 2019 19:08:50 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:49 -0800 (PST)
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
Subject: [PATCH 43/50] xtensa: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:34 +0000
Message-Id: <20191106030542.868541-44-dima@arista.com>
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

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/xtensa/kernel/traps.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index cbc0d673f542..ba6c150095c6 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -502,7 +502,8 @@ static void show_trace(struct task_struct *task, unsigned long *sp,
 
 static int kstack_depth_to_print = 24;
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	int i = 0;
 	unsigned long *stack;
@@ -511,16 +512,21 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 		sp = stack_pointer(task);
 	stack = sp;
 
-	pr_info("Stack:\n");
+	printk("%sStack:\n", loglvl);
 
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(sp))
 			break;
-		pr_cont(" %08lx", *sp++);
+		printk("%s %08lx", loglvl, *sp++);
 		if (i % 8 == 7)
-			pr_cont("\n");
+			printk("%s\n", loglvl);
 	}
-	show_trace(task, stack, KERN_INFO);
+	show_trace(task, stack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_INFO);
 }
 
 DEFINE_SPINLOCK(die_lock);
-- 
2.23.0

