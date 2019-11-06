Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DEAC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8B0222CD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WVt6cu9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfKFDHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41786 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387753AbfKFDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so16112450pgr.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=boh/NJIo4FlpqhXcE0zFNMsc81zEd1oPhJDHew3kpDg=;
        b=WVt6cu9BD+oeG8ZJ8Tdw1e2sAStW+2Dg+JeN+GDP7OvBQNTHcYY2WHyUjeXZjbl6xA
         8hLNTS3dn1G9efjjSXeAdtpLX03PSZaWhhzR/Hs/yNHNEbqOT62750AofI1zmM2HQ5Bn
         nysgmPWQ1CHVeU7dOZhTnfHZQY75j6dCdMbWsIe3hR4dXo+9TvkxKtYOUmuoGcjo4rWj
         jTSxrBRUTRTvz4+bj90wP3kPyib2LFOYGzyBA3R7OAx0cp/612QcHys6SydA+GGP4zPB
         A/3BcJ1jQik2tPyqsHcVosb8LXAGjBo0yNjyvhuXUOrA/kh2aNKCPY8uLBBhA+/DrH+H
         jb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=boh/NJIo4FlpqhXcE0zFNMsc81zEd1oPhJDHew3kpDg=;
        b=IE7pHQsok5wKuCmh9M9O+EiMUcPnTcTMKKZ0AzSR+RRtDpaA+6L2l6+zprc+1Lwsen
         p55FsjvkM0iijn3iHLOUQTPvlGVNhmOrgx4UPiRThAcySjbkuRThBT9NOQUe5yL+GB8X
         rx8MKG3uJS4jVWtxaOwtwjvwzchTnU/GfULzTXC9ya8aNqCmiKfiJqjKDSewMl/XpUYb
         k7x91se4mRlr+mLTyR+52P2Us47e/Zy53i4MB//hbK7uTlN2uaEBHq0tFvA0iX4I02f8
         jtQGCLipA4IEeLtHLjBLFUpwelOo2oFoIJcInsV40D9eDUn0deIxb/Zx0fggFbI2CcMi
         bcJg==
X-Gm-Message-State: APjAAAUlOpuDarP+KrhyTiGI9+IBJnxGS2jcn0eklU8tiVInY1tZQgCz
        OrABE8PZXsLRws3btjud0GfPMsk00eg=
X-Google-Smtp-Source: APXvYqyy+i+KXAH8t6+6Pcp40E8ULaf25Np2v6PVLpf7xN+QmAEIKBjU781YNki6Tgl57x8fufoGlw==
X-Received: by 2002:a17:90a:fb8f:: with SMTP id cp15mr591161pjb.3.1573009628769;
        Tue, 05 Nov 2019 19:07:08 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:07 -0800 (PST)
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
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 15/50] ia64: Pass log level as arg into ia64_do_show_stack()
Date:   Wed,  6 Nov 2019 03:05:06 +0000
Message-Id: <20191106030542.868541-16-dima@arista.com>
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

Add log level argument to ia64_do_show_stack() as a preparation to
introduce show_stack_loglvl().
Also, make ia64_do_show_stack() static as it's not used outside.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/ia64/include/asm/ptrace.h |  1 -
 arch/ia64/kernel/process.c     | 13 +++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index 7ff574d56429..b3aa46090101 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -114,7 +114,6 @@ static inline long regs_return_value(struct pt_regs *regs)
   struct task_struct;			/* forward decl */
   struct unw_frame_info;		/* forward decl */
 
-  extern void ia64_do_show_stack (struct unw_frame_info *, void *);
   extern unsigned long ia64_get_user_rbs_end (struct task_struct *, struct pt_regs *,
 					      unsigned long *);
   extern long ia64_peek (struct task_struct *, struct switch_stack *, unsigned long,
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 968b5f33e725..0526cc51ff0b 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -64,12 +64,13 @@ EXPORT_SYMBOL(boot_option_idle_override);
 void (*pm_power_off) (void);
 EXPORT_SYMBOL(pm_power_off);
 
-void
+static void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
 {
 	unsigned long ip, sp, bsp;
+	const char *loglvl = arg;
 
-	printk("\nCall Trace:\n");
+	printk("%s\nCall Trace:\n", loglvl);
 	do {
 		unw_get_ip(info, &ip);
 		if (ip == 0)
@@ -77,9 +78,9 @@ ia64_do_show_stack (struct unw_frame_info *info, void *arg)
 
 		unw_get_sp(info, &sp);
 		unw_get_bsp(info, &bsp);
-		printk(" [<%016lx>] %pS\n"
+		printk("%s [<%016lx>] %pS\n"
 			 "                                sp=%016lx bsp=%016lx\n",
-			 ip, (void *)ip, sp, bsp);
+			 loglvl, ip, (void *)ip, sp, bsp);
 	} while (unw_unwind(info) >= 0);
 }
 
@@ -87,12 +88,12 @@ void
 show_stack (struct task_struct *task, unsigned long *sp)
 {
 	if (!task)
-		unw_init_running(ia64_do_show_stack, NULL);
+		unw_init_running(ia64_do_show_stack, (void *)KERN_DEFAULT);
 	else {
 		struct unw_frame_info info;
 
 		unw_init_from_blocked_task(&info, task);
-		ia64_do_show_stack(&info, NULL);
+		ia64_do_show_stack(&info, (void *)KERN_DEFAULT);
 	}
 }
 
-- 
2.23.0

