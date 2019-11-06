Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E09C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E5B2247A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ea8bjYdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbfKFDHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37731 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfKFDHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so11569514pgu.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H43inSVya3VCDwWaDYTI7d9/na6K2xNSDWV/2tcumxU=;
        b=Ea8bjYdw+c4PRd0Et2vac6g2WeLV5XWL2W2XE1hw8UGnvxAJ+K7GMeD+bBKlDbN6qE
         I+34B35Y2klZEhDeAlq5fymh+yHSslcfHiGYLwL7owD/vBGRZPzcXsfnKMef7yojCVBv
         4/ceAW7UK8ezifyuvVzDwkPWrV7Y7Cb4t8x1mP6IxhrRotrmX8bmV/YQNDBKrD7+23zx
         x82MhQ4zia/h7PUhSzrPqAB59bEmC56W0rnUaQkloDnjHKi5t0IdJKzz4x0nsitSGNjQ
         cBWb7jkxLgiiEz+LRQsT3hmVEHpaqL9VMUfFLJBk4iNgXdwip0Vqibl1NWb1wLCkNFJy
         swpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H43inSVya3VCDwWaDYTI7d9/na6K2xNSDWV/2tcumxU=;
        b=Xd/kJSmONxQSsN9wsahMVmwm6hv+eBloqlPEkHNR+RZF8uIo6Hs9WH6/4cBDYd4ZYU
         lYQtfvvd1RCe6ajW5ZHyh3+jHY3PbhYPJbVfMJrh+NL9uTGE3a1NEJ1ghJ4dxFFf1TWj
         KWOaUTUGwGM7UkkS/i7GzMbHOGVSn19JC4VvJvlOhkuzp7tmf6ByuviNOAQT1gUXGaZ1
         nRArZ5F6BiNdnudzDPUBakS7PUJiY2ho8Jdqg/uANzCyeLaP3y663jHMS9ev8Bwz69f/
         Y0/VlNeEsjnMQcgaPeD+E2QK2QQ9zjKpF3vSsok7ABhn1jPRpcQRK/d22u/uUVSo1lKJ
         eJVA==
X-Gm-Message-State: APjAAAWuwvDYG4wDS6ye++R4NXqKe+dL3fz5On4tV71/2GPFUDH7NAd7
        TLxid+gPPd5Fzs6cE2FlgzdUBaewHvU=
X-Google-Smtp-Source: APXvYqwtv3lTi2Axl6UKMvPFe/LXcA76DBmr+c2Ggdlt4M8lFe60EDfAUaGfwxQJl720CHP57lXqWQ==
X-Received: by 2002:a17:90a:3522:: with SMTP id q31mr659667pjb.18.1573009620981;
        Tue, 05 Nov 2019 19:07:00 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:59 -0800 (PST)
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH 13/50] h8300: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:04 +0000
Message-Id: <20191106030542.868541-14-dima@arista.com>
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/h8300/kernel/traps.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
index e47a9e0dc278..6362446563d6 100644
--- a/arch/h8300/kernel/traps.c
+++ b/arch/h8300/kernel/traps.c
@@ -115,7 +115,8 @@ void die(const char *str, struct pt_regs *fp, unsigned long err)
 
 static int kstack_depth_to_print = 24;
 
-void show_stack(struct task_struct *task, unsigned long *esp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
+		       const char *loglvl)
 {
 	unsigned long *stack,  addr;
 	int i;
@@ -125,17 +126,17 @@ void show_stack(struct task_struct *task, unsigned long *esp)
 
 	stack = esp;
 
-	pr_info("Stack from %08lx:", (unsigned long)stack);
+	printk("%sStack from %08lx:", loglvl, (unsigned long)stack);
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (((unsigned long)stack & (THREAD_SIZE - 1)) >=
 		    THREAD_SIZE-4)
 			break;
 		if (i % 8 == 0)
-			pr_info(" ");
+			printk("%s ", loglvl);
 		pr_cont(" %08lx", *stack++);
 	}
 
-	pr_info("\nCall Trace:\n");
+	printk("%s\nCall Trace:\n", loglvl);
 	i = 0;
 	stack = esp;
 	while (((unsigned long)stack & (THREAD_SIZE - 1)) < THREAD_SIZE-4) {
@@ -150,10 +151,15 @@ void show_stack(struct task_struct *task, unsigned long *esp)
 		 */
 		if (check_kernel_text(addr)) {
 			if (i % 4 == 0)
-				pr_info("       ");
+				printk("%s       ", loglvl);
 			pr_cont(" [<%08lx>]", addr);
 			i++;
 		}
 	}
-	pr_info("\n");
+	printk("%s\n", loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	show_stack_loglvl(task, esp, KERN_INFO);
 }
-- 
2.23.0

