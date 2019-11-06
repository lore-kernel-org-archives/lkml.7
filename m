Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F0C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A3F217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="N/J9VXjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbfKFDHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40055 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbfKFDHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so17716049pfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJpEld2QKF+PvrPXqtQgZ4GmUaU4su2Lr5l8Oh0dmOY=;
        b=N/J9VXjbzzzgPuXhGSoFsZZg0ZhhFydihSzCkbqvio4bm0HYEoLAmopPSavXAhkAgH
         SF4FbBN7i4/Q71QmBR8bYcVoW8jQkOM2m6FIgRzSbmS1ttiaFHGuOUXNA2HfWtIIXHO7
         hB8Nf1Ha0LwSxmsMzO2iPixnjkqwbM2sL3ZcdJq5KXvR1bRCCSEusVxzVNhpywzeHUt8
         /NSnF3kQe6A83oqF2twFpKcSjkW6d4H5SxsxZ/mHps78VeF3MlAC8qKY1vnPPo6XWnIY
         6GCmqBCCcybYLQJT8XrSdxzp6L/wQQgxMiNSJWIasQ/BNaJGWEywKM7pgCxfN9X4crIk
         ldWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJpEld2QKF+PvrPXqtQgZ4GmUaU4su2Lr5l8Oh0dmOY=;
        b=dftTOKqZ25KO8nc5Y1gahF8j86Y7OCKWv212mKe2/yzD7ltKVfLemF+5rQt+KsGQFP
         dDB0xSxu21tex9q+Zj0MVjbx4r2zLxIVW/3ly4NMkMPKVj5lGdtwrc4OXIOBRl2RoRYK
         0jdyATgwRfKkUC1cJBPwwoHDthDSadenQ3nSLX44d9dtAMbYVrUIl2CbjhvpmOjc7V1M
         EM7XDyv/gnHCBqhFowE4aIIlGcfRMWXKz69Q3YQelqpA+0OTFQNQhWnD4RV7s3T9l1TS
         CRwVxQq2UEbJstEyqbR7Wh/XzuX5G8U6M/ZFbquWJJzPObIiFky8ikoCtrRuXK4hihBx
         iRCA==
X-Gm-Message-State: APjAAAUJ3j2dzbihGBaVzKt3Z7qyhkta+DhLPj13bYBV4L1xZpAidExQ
        rg4eJZlbc287ztzCggruaMLlNXS+Yh8=
X-Google-Smtp-Source: APXvYqxaGXp77NL5yr4M+lMKqaGSRwAsmSkMEXcFHbKCHUpY6ecqSMIJQawHJFkhGJyrHJlHU4m4fA==
X-Received: by 2002:a17:90a:f982:: with SMTP id cq2mr647143pjb.34.1573009657400;
        Tue, 05 Nov 2019 19:07:37 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:36 -0800 (PST)
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
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: [PATCH 23/50] nios2: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:14 +0000
Message-Id: <20191106030542.868541-24-dima@arista.com>
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

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/nios2/kernel/traps.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index 486db793923c..08071caa9b36 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -52,12 +52,14 @@ void _exception(int signo, struct pt_regs *regs, int code, unsigned long addr)
 }
 
 /*
- * The show_stack is an external API which we do not use ourselves.
+ * The show_stack(), show_stack_loglvl() are external API
+ * which we do not use ourselves.
  */
 
 int kstack_depth_to_print = 48;
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	unsigned long *endstack, addr;
 	int i;
@@ -72,16 +74,16 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	addr = (unsigned long) stack;
 	endstack = (unsigned long *) PAGE_ALIGN(addr);
 
-	pr_emerg("Stack from %08lx:", (unsigned long)stack);
+	printk("%sStack from %08lx:", loglvl, (unsigned long)stack);
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (stack + 1 > endstack)
 			break;
 		if (i % 8 == 0)
-			pr_emerg("\n       ");
-		pr_emerg(" %08lx", *stack++);
+			printk("%s\n       ", loglvl);
+		printk("%s %08lx", loglvl, *stack++);
 	}
 
-	pr_emerg("\nCall Trace:");
+	printk("%s\nCall Trace:", loglvl);
 	i = 0;
 	while (stack + 1 <= endstack) {
 		addr = *stack++;
@@ -97,11 +99,16 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		     (addr <= (unsigned long) _etext))) {
 			if (i % 4 == 0)
 				pr_emerg("\n       ");
-			pr_emerg(" [<%08lx>]", addr);
+			printk("%s [<%08lx>]", loglvl, addr);
 			i++;
 		}
 	}
-	pr_emerg("\n");
+	printk("%s\n", loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_EMERG);
 }
 
 void __init trap_init(void)
-- 
2.23.0

