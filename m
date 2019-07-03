Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E80FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5206B218BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGCOsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfGCOsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:48:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715B7218A4;
        Wed,  3 Jul 2019 14:48:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1higYn-0005h4-E2; Wed, 03 Jul 2019 10:48:37 -0400
Message-Id: <20190703144837.326716330@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 10:47:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [for-linus][PATCH 1/5] ftrace/x86: Remove possible deadlock between register_kprobe() and
 ftrace_run_update_code()
References: <20190703144741.181267753@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

The commit 9f255b632bf12c4dd7 ("module: Fix livepatch/ftrace module text
permissions race") causes a possible deadlock between register_kprobe()
and ftrace_run_update_code() when ftrace is using stop_machine().

The existing dependency chain (in reverse order) is:

-> #1 (text_mutex){+.+.}:
       validate_chain.isra.21+0xb32/0xd70
       __lock_acquire+0x4b8/0x928
       lock_acquire+0x102/0x230
       __mutex_lock+0x88/0x908
       mutex_lock_nested+0x32/0x40
       register_kprobe+0x254/0x658
       init_kprobes+0x11a/0x168
       do_one_initcall+0x70/0x318
       kernel_init_freeable+0x456/0x508
       kernel_init+0x22/0x150
       ret_from_fork+0x30/0x34
       kernel_thread_starter+0x0/0xc

-> #0 (cpu_hotplug_lock.rw_sem){++++}:
       check_prev_add+0x90c/0xde0
       validate_chain.isra.21+0xb32/0xd70
       __lock_acquire+0x4b8/0x928
       lock_acquire+0x102/0x230
       cpus_read_lock+0x62/0xd0
       stop_machine+0x2e/0x60
       arch_ftrace_update_code+0x2e/0x40
       ftrace_run_update_code+0x40/0xa0
       ftrace_startup+0xb2/0x168
       register_ftrace_function+0x64/0x88
       klp_patch_object+0x1a2/0x290
       klp_enable_patch+0x554/0x980
       do_one_initcall+0x70/0x318
       do_init_module+0x6e/0x250
       load_module+0x1782/0x1990
       __s390x_sys_finit_module+0xaa/0xf0
       system_call+0xd8/0x2d0

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(text_mutex);
                               lock(cpu_hotplug_lock.rw_sem);
                               lock(text_mutex);
  lock(cpu_hotplug_lock.rw_sem);

It is similar problem that has been solved by the commit 2d1e38f56622b9b
("kprobes: Cure hotplug lock ordering issues"). Many locks are involved.
To be on the safe side, text_mutex must become a low level lock taken
after cpu_hotplug_lock.rw_sem.

This can't be achieved easily with the current ftrace design.
For example, arm calls set_all_modules_text_rw() already in
ftrace_arch_code_modify_prepare(), see arch/arm/kernel/ftrace.c.
This functions is called:

  + outside stop_machine() from ftrace_run_update_code()
  + without stop_machine() from ftrace_module_enable()

Fortunately, the problematic fix is needed only on x86_64. It is
the only architecture that calls set_all_modules_text_rw()
in ftrace path and supports livepatching at the same time.

Therefore it is enough to move text_mutex handling from the generic
kernel/trace/ftrace.c into arch/x86/kernel/ftrace.c:

   ftrace_arch_code_modify_prepare()
   ftrace_arch_code_modify_post_process()

This patch basically reverts the ftrace part of the problematic
commit 9f255b632bf12c4dd7 ("module: Fix livepatch/ftrace module
text permissions race"). And provides x86_64 specific-fix.

Some refactoring of the ftrace code will be needed when livepatching
is implemented for arm or nds32. These architectures call
set_all_modules_text_rw() and use stop_machine() at the same time.

Link: http://lkml.kernel.org/r/20190627081334.12793-1-pmladek@suse.com

Fixes: 9f255b632bf12c4dd7 ("module: Fix livepatch/ftrace module text permissions race")
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
[
  As reviewed by Miroslav Benes <mbenes@suse.cz>, removed return value of
  ftrace_run_update_code() as it is a void function.
]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c |  3 +++
 kernel/trace/ftrace.c    | 10 +---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0927bb158ffc..33786044d5ac 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/memory.h>
 
 #include <trace/syscall.h>
 
@@ -35,6 +36,7 @@
 
 int ftrace_arch_code_modify_prepare(void)
 {
+	mutex_lock(&text_mutex);
 	set_kernel_text_rw();
 	set_all_modules_text_rw();
 	return 0;
@@ -44,6 +46,7 @@ int ftrace_arch_code_modify_post_process(void)
 {
 	set_all_modules_text_ro();
 	set_kernel_text_ro();
+	mutex_unlock(&text_mutex);
 	return 0;
 }
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 38277af44f5c..576c41644e77 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -34,7 +34,6 @@
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
 #include <linux/kprobes.h>
-#include <linux/memory.h>
 
 #include <trace/events/sched.h>
 
@@ -2611,12 +2610,10 @@ static void ftrace_run_update_code(int command)
 {
 	int ret;
 
-	mutex_lock(&text_mutex);
-
 	ret = ftrace_arch_code_modify_prepare();
 	FTRACE_WARN_ON(ret);
 	if (ret)
-		goto out_unlock;
+		return;
 
 	/*
 	 * By default we use stop_machine() to modify the code.
@@ -2628,9 +2625,6 @@ static void ftrace_run_update_code(int command)
 
 	ret = ftrace_arch_code_modify_post_process();
 	FTRACE_WARN_ON(ret);
-
-out_unlock:
-	mutex_unlock(&text_mutex);
 }
 
 static void ftrace_run_modify_code(struct ftrace_ops *ops, int command,
@@ -5784,7 +5778,6 @@ void ftrace_module_enable(struct module *mod)
 	struct ftrace_page *pg;
 
 	mutex_lock(&ftrace_lock);
-	mutex_lock(&text_mutex);
 
 	if (ftrace_disabled)
 		goto out_unlock;
@@ -5846,7 +5839,6 @@ void ftrace_module_enable(struct module *mod)
 		ftrace_arch_code_modify_post_process();
 
  out_unlock:
-	mutex_unlock(&text_mutex);
 	mutex_unlock(&ftrace_lock);
 
 	process_cached_mods(mod->name);
-- 
2.20.1


