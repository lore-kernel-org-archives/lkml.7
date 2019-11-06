Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A38C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AA0222D4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fNM1PRRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfKFDHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44704 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387870AbfKFDHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so17706904pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSBja1PzX1eNzILA0ZLExKWvVTu/iplrMb6QbHVSSFM=;
        b=fNM1PRRuP+Sq4BSIh202KWLGCkdCshItgezfLjDaG7afM0Qmu6/E13Ah+CsZGsvolq
         K9iP1P01vzpyhYahw/8D47Jj5qdnzTRaioHyG8nCPsYMLaV24QNgU8fVeUnjjAcNa+32
         +G5v/cCvhu6EAKmf9FK681FsphnwTav2pyEsdNtNLRDxkKzXreg2v7HJk8618ft48Djg
         AWSjXvW/8TJC6y4nTKf9n/+zwgZ0g/QwnpwtG2kkjNqhQGDrCb3dd0KodUR5PKh8SQUp
         zdaZ/DJrjRe0FRohtunwQegnM0eBLFw57eLVyV9VQIN/9oofyV1Mchcv8fNIPaZqr/lp
         uliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSBja1PzX1eNzILA0ZLExKWvVTu/iplrMb6QbHVSSFM=;
        b=LJZel7iYTLQqcb2qalQgBwuMdnOa6yjh30pjsPZZ6ltlvVkNzpbB4S++6MJzv+Tt0L
         Ao4BOHU341k9shILw10dS+AVACl3kVn/xNNJD6LkaWnMCPCfyEUZaEJnsqQ1GIf289RH
         6sZOJlC772Xm9uS1HIkXdcYVzoXmnpPYDxPDzU12Pj2W876RXrnAda+VVW51PIAspB56
         WZqRCv0FJPX9nsEkN4x6aSQTEkrkWyMoe8K2F3CtpttJczcxgY8vfkP3zI3Shg/V6171
         QKx970FJcC55qy65eSpOWTU6rjndrX88ZpNDLL+dtkffOWNWq6uaCtlW79M7hw6uI9ky
         +hXQ==
X-Gm-Message-State: APjAAAWULFRkHZTqnfyzRXEbTXmcKg81uG9yWw6NQAiQK0SqSdS6weki
        fIbNs4lHm2uc1cptenadGP7lBQ6rveo=
X-Google-Smtp-Source: APXvYqyRhWjPrFgKXVhRQYQt+1DQ1YiuiuEgnMDWPKq8D/1oOe/cYaDeTm9diaZJYPe5GGr3iumPAA==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr201422pgh.372.1573009653803;
        Tue, 05 Nov 2019 19:07:33 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:33 -0800 (PST)
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
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 22/50] nds32: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:13 +0000
Message-Id: <20191106030542.868541-23-dima@arista.com>
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

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/nds32/kernel/traps.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 40625760a125..90f12582c218 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -97,18 +97,19 @@ static void dump_instr(struct pt_regs *regs)
 }
 
 #define LOOP_TIMES (100)
-static void __dump(struct task_struct *tsk, unsigned long *base_reg)
+static void __dump(struct task_struct *tsk, unsigned long *base_reg,
+		   const char *loglvl)
 {
 	unsigned long ret_addr;
 	int cnt = LOOP_TIMES, graph = 0;
-	pr_emerg("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	if (!IS_ENABLED(CONFIG_FRAME_POINTER)) {
 		while (!kstack_end(base_reg)) {
 			ret_addr = *base_reg++;
 			if (__kernel_text_address(ret_addr)) {
 				ret_addr = ftrace_graph_ret_addr(
 						tsk, &graph, ret_addr, NULL);
-				print_ip_sym(KERN_EMERG, ret_addr);
+				print_ip_sym(loglvl, ret_addr);
 			}
 			if (--cnt < 0)
 				break;
@@ -124,17 +125,18 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 
 				ret_addr = ftrace_graph_ret_addr(
 						tsk, &graph, ret_addr, NULL);
-				print_ip_sym(KERN_EMERG, ret_addr);
+				print_ip_sym(loglvl, ret_addr);
 			}
 			if (--cnt < 0)
 				break;
 			base_reg = (unsigned long *)next_fp;
 		}
 	}
-	pr_emerg("\n");
+	printk("%s\n", loglvl);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long *base_reg;
 
@@ -151,10 +153,15 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 		else
 			__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(base_reg));
 	}
-	__dump(tsk, base_reg);
+	__dump(tsk, base_reg, loglvl);
 	barrier();
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+	show_stack_loglvl(tsk, sp, KERN_EMERG);
+}
+
 DEFINE_SPINLOCK(die_lock);
 
 /*
-- 
2.23.0

