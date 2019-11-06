Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C72C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A207A217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HpI4TPfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfKFDIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40457 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbfKFDIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so16120067pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=No8r/EO/m1FZDC1QSQ+DsBj1hQaAIffNpL2JoJ8sPnc=;
        b=HpI4TPfr/Sma1QdALGXcyJ2WvjFNGwre6xU8Jf7L7W7e5Z4MO855Xkj/RaWhLAn6zv
         9ahmMcFF+jdVr1xp4e/Q5kn8FkkENwKmvvR67wbUv1Tbp2+5TPvhajnRXPqGnffEA+Nx
         mp+q9+AuSwlnJky/cl6OOThTmXTSEpRUh+AfX6e7t3jt7mfvxvw+kAt/qt6TIEuGBzDx
         FEKQFW6M+kUlhkKVpTRVLvUPHHT5VFdn+L782OSjCAKQB8G64gEiwB+3Zbt4LwmKlHB6
         4LtZ6GJMjWyANjwrJNLbbH7CL2MMRfaN7uoN9DuRogupsebZsqKT7UPVFoRc06QeKZWX
         Uzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=No8r/EO/m1FZDC1QSQ+DsBj1hQaAIffNpL2JoJ8sPnc=;
        b=Q58rElUs9zOwbD4JwWkCrQIS8ywd3bNqCutLafZmkEvI1IrNEo7AGUBA5jGrnrMn1j
         l3nL+FnyBMo8eeTB6fIYeu9gq6lr0rohwMHsizckDcN/HbIR11jOuRtH73V5jk+cpWNg
         dd3fSdX2vHmp32TVHuH1iOucSG+pPByjn8SpX6Re6LUTyFZ0P7nD9AcqmF9i+X6GxnaB
         iFRlI7kny6PQPNPHwT4QHeKyy4X8YqCbZ/LxjFacMSLxwmD4/H2XNTt9h04mXN6IF1D+
         itIOt2nXxcuAZHpr526iaP8zzsMXkCjyZR8RJ5ZoAQS/4eDYHYiWhLBrtlM32POVHCwO
         JakQ==
X-Gm-Message-State: APjAAAVDvf9E/+0NVthhLs28+RaLRRoUKPWoZ9Rg/pDzQTAXmLzW0tHs
        AxltUPiIm1UnGtv+m3+7rxDY7x3dwG4=
X-Google-Smtp-Source: APXvYqzf6PYT3ec2KW1/wWm2G/IgLrYY4CCMzqepEO/ueV+HESGhFrMlPb9bZep4lOr7rRiBLUOHng==
X-Received: by 2002:aa7:8e8d:: with SMTP id a13mr389528pfr.241.1573009719265;
        Tue, 05 Nov 2019 19:08:39 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:38 -0800 (PST)
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
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 40/50] x86: Add missing const qualifiers for log_lvl
Date:   Wed,  6 Nov 2019 03:05:31 +0000
Message-Id: <20191106030542.868541-41-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Keep log_lvl const show_trace_log_lvl() and printk_stack_address()
as the new generic show_stack_loglvl() wants to have a proper const
qualifier.

And gcc rightfully produces warnings in case it's not keept:
arch/x86/kernel/dumpstack.c: In function ‘show_stack’:
arch/x86/kernel/dumpstack.c:294:37: warning: passing argument 4 of ‘show_trace_log_lv ’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  294 |  show_trace_log_lvl(task, NULL, sp, loglvl);
      |                                     ^~~~~~
arch/x86/kernel/dumpstack.c:163:32: note: expected ‘char *’ but argument is of type ‘const char *’
  163 |    unsigned long *stack, char *log_lvl)
      |                          ~~~~~~^~~~~~~

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/include/asm/stacktrace.h | 2 +-
 arch/x86/kernel/dumpstack.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 14db05086bbf..5ae5a68e469d 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -87,7 +87,7 @@ get_stack_pointer(struct task_struct *task, struct pt_regs *regs)
 }
 
 void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, char *log_lvl);
+			unsigned long *stack, const char *log_lvl);
 
 /* The form of the top of the frame on the stack */
 struct stack_frame {
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index e07424e19274..147a06ee4a48 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -65,7 +65,7 @@ bool in_entry_stack(unsigned long *stack, struct stack_info *info)
 }
 
 static void printk_stack_address(unsigned long address, int reliable,
-				 char *log_lvl)
+				 const char *log_lvl)
 {
 	touch_nmi_watchdog();
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
@@ -160,7 +160,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 }
 
 void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, char *log_lvl)
+			unsigned long *stack, const char *log_lvl)
 {
 	struct unwind_state state;
 	struct stack_info stack_info = {0};
-- 
2.23.0

