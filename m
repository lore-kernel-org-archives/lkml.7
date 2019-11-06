Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B3C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703A0222C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U3UPaJg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbfKFDGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43824 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfKFDGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id a18so9586034plm.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4xceT58B6sbL4PhV43oCBSGVJEvO1DNZo325HcSVkg=;
        b=U3UPaJg+2y87NqfpsnwuDDEKpAogHQ3AUxQixZIutQNYD5rfoA7vZzTIL+Wd243QXP
         mBL9fQeYEt1+bO4QIY7SYhqSyra1ePH4jDwMACZsXCbmhl2yQo1oRhY7v4QTdpinYHuz
         GK3D7hxrdvZ3KaUactgAQElVQ2s6CAfVLUEqCHRsM25V4z4qa6ZPR6D/CmLuyTMpaUxn
         2EaC/jnzc+e2qN8UcInFBc9mIef6p2J19lLYVVbKE6XVpO1h2ngK3yPVEbB8GXDk2xOZ
         sKpwDTALK4MbaX2Rq4LrkGBNxOXmhl8LsikDWGzwGCe5RVjq721/u3WUUXx2rqLMK6A1
         GBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4xceT58B6sbL4PhV43oCBSGVJEvO1DNZo325HcSVkg=;
        b=eljf6m51vIUUVhZqHeIJwyGiUhh+DPEEsBtYDMJ1UMxaDDToOYpNJ4/F3pZ5fHd6VG
         5TN3WP0aL4SIpd08Uq+GhXW7zZEKA8zpy9Y2v6NS+ex4l2SumDxoQYUiD36ufC0AN61E
         GlRM35IrBh6Ua1RZHiakxjSv9mE4I8Rc5063Gj2EsUv9ca/YBG/pTZq7b02cXwIq5xEb
         mEAwn+/NhNNGJ1Rd7cu8z6P8NkK53YJSR8mNlAVpJskAa/ypdw5+dUnYOQAAe5uPX1vQ
         OzDITCcjKB3Sx+vhycYjDCxMYrUJ63+nQtxHzUHM7xBlDQNp/hC5beg07CKbaFG2ddRc
         iITQ==
X-Gm-Message-State: APjAAAWHSwvR+exdHHnv2V4N0vMoAGnpw/29hZNiicr2TBP4S02BWgQM
        Rj+gByJ2Sk83tHSapUF/awy60SUCmEs=
X-Google-Smtp-Source: APXvYqyk+jwPIxnw+WSN1kToR1F8PVjBE6uY2e4pxOa1tt6VZ8XuJUjdGnhvtrpfbvJH4vxVL4+yFw==
X-Received: by 2002:a17:902:7783:: with SMTP id o3mr132537pll.313.1573009592111;
        Tue, 05 Nov 2019 19:06:32 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:31 -0800 (PST)
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
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH 06/50] arm: Add loglvl to dump_backtrace()
Date:   Wed,  6 Nov 2019 03:04:57 +0000
Message-Id: <20191106030542.868541-7-dima@arista.com>
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

Add log level argument to dump_backtrace() as a preparation for
introducing show_stack_loglvl().

As a good side-effect __die() now prints not only "Stack:" header with
KERN_EMERG, but the backtrace itself.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/traps.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 69e35462c9e9..e4f4ec8a1899 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -200,17 +200,19 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_ARM_UNWIND
-static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+				  const char *loglvl)
 {
-	unwind_backtrace(regs, tsk, KERN_DEBUG);
+	unwind_backtrace(regs, tsk, loglvl);
 }
 #else
-static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+			   const char *loglvl)
 {
 	unsigned int fp, mode;
 	int ok = 1;
 
-	printk("Backtrace: ");
+	printk("%sBacktrace: ", loglvl);
 
 	if (!tsk)
 		tsk = current;
@@ -237,13 +239,13 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	pr_cont("\n");
 
 	if (ok)
-		c_backtrace(fp, mode, NULL);
+		c_backtrace(fp, mode, loglvl);
 }
 #endif
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
-	dump_backtrace(NULL, tsk);
+	dump_backtrace(NULL, tsk, KERN_DEFAULT);
 	barrier();
 }
 
@@ -285,7 +287,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
 			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
-		dump_backtrace(regs, tsk);
+		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
 	}
 
-- 
2.23.0

