Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FCCECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2E621848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfJJCgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfJJCgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:36:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E161D2086D;
        Thu, 10 Oct 2019 02:36:39 +0000 (UTC)
Date:   Wed, 9 Oct 2019 22:36:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] ftrace/module: Allow ftrace to make only loaded module text
 read-write
Message-ID: <20191009223638.60b78727@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

In the process of using text_poke_bp() for ftrace on x86, when
performing the following action:

 # rmmod snd_hda_codec_hdmi
 # echo function > /sys/kernel/tracing/current_tracer
 # modprobe snd_hda_codec_hdmi

It triggered this:

 BUG: unable to handle page fault for address: ffffffffa03d0000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0003) - permissions violation
 PGD 2a12067 P4D 2a12067 PUD 2a13063 PMD c42bc067 PTE c58a0061
 Oops: 0003 [#1] PREEMPT SMP KASAN PTI
 CPU: 1 PID: 1182 Comm: modprobe Not tainted 5.4.0-rc2-test+ #50
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 RIP: 0010:memcpy_erms+0x6/0x10
 Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
 RSP: 0018:ffff8880a10479e0 EFLAGS: 00010246
 RAX: ffffffffa03d0000 RBX: ffffffffa03d0000 RCX: 0000000000000005
 RDX: 0000000000000005 RSI: ffffffff8363e160 RDI: ffffffffa03d0000
 RBP: ffff88807e9ec000 R08: fffffbfff407a001 R09: fffffbfff407a001
 R10: fffffbfff407a000 R11: ffffffffa03d0004 R12: ffffffff8221f160
 R13: ffffffffa03d0000 R14: ffff88807e9ec000 R15: ffffffffa0481640
 FS:  00007eff92e28280(0000) GS:ffff8880d4840000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffa03d0000 CR3: 00000000a1048001 CR4: 00000000001606e0
 Call Trace:
  ftrace_make_call+0x76/0x90
  ftrace_module_enable+0x493/0x4f0
  load_module+0x3a31/0x3e10
  ? ring_buffer_read+0x70/0x70
  ? module_frob_arch_sections+0x20/0x20
  ? rb_commit+0xee/0x600
  ? tracing_generic_entry_update+0xe1/0xf0
  ? ring_buffer_unlock_commit+0xfb/0x220
  ? 0xffffffffa0000061
  ? __do_sys_finit_module+0x11a/0x1b0
  __do_sys_finit_module+0x11a/0x1b0
  ? __ia32_sys_init_module+0x40/0x40
  ? ring_buffer_unlock_commit+0xfb/0x220
  ? function_trace_call+0x179/0x260
  ? __do_sys_finit_module+0x1b0/0x1b0
  ? __do_sys_finit_module+0x1b0/0x1b0
  ? do_syscall_64+0x58/0x1a0
  do_syscall_64+0x68/0x1a0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x7eff92f42efd

The reason is that ftrace_module_enable() is called after the module
has set its text to read-only. There's subtle reasons that this needs
to be called afterward, and we need to continue to do so.

Instead of going back to the original way of changing all modules to
read-write to update functions for a module being loaded, add two new
module helpers set_module_text_rw() and set_module_text_ro() that takes
a module as a parameter and only modifies the text for that one module.
Then move the logic for this from the architecture code in ftrace, to
the generic code, and have ftrace on module load do the modification.
It only affects the module being loaded.

Link: http://lkml.kernel.org/r/20191007081716.07616230.8@infradead.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/include/linux/module.h b/include/linux/module.h
index 6d20895e7739..143c902bcbcf 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -846,11 +846,15 @@ extern int module_sysfs_initialized;
 #define __MODULE_STRING(x) __stringify(x)
 
 #ifdef CONFIG_STRICT_MODULE_RWX
+extern void set_module_text_rw(const struct module *mod);
+extern void set_module_text_ro(const struct module *mod);
 extern void set_all_modules_text_rw(void);
 extern void set_all_modules_text_ro(void);
 extern void module_enable_ro(const struct module *mod, bool after_init);
 extern void module_disable_ro(const struct module *mod);
 #else
+static inline void set_module_text_rw(const struct module *mod) { }
+static inline void set_module_text_ro(const struct module *mod) { }
 static inline void set_all_modules_text_rw(void) { }
 static inline void set_all_modules_text_ro(void) { }
 static inline void module_enable_ro(const struct module *mod, bool after_init) { }
diff --git a/kernel/module.c b/kernel/module.c
index ff2d7359a418..8f3a18d3ac75 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2029,6 +2029,37 @@ static void module_enable_nx(const struct module *mod)
 	frob_writable_data(&mod->init_layout, set_memory_nx);
 }
 
+void set_module_text_rw(const struct module *mod)
+{
+	if (!rodata_enabled)
+		return;
+
+	mutex_lock(&module_mutex);
+	if (mod->state == MODULE_STATE_UNFORMED)
+		goto out;
+
+	frob_text(&mod->core_layout, set_memory_rw);
+	frob_text(&mod->init_layout, set_memory_rw);
+out:
+	mutex_unlock(&module_mutex);
+}
+
+void set_module_text_ro(const struct module *mod)
+{
+	if (!rodata_enabled)
+		return;
+
+	mutex_lock(&module_mutex);
+	if (mod->state == MODULE_STATE_UNFORMED ||
+	    mod->state == MODULE_STATE_GOING)
+		goto out;
+
+	frob_text(&mod->core_layout, set_memory_ro);
+	frob_text(&mod->init_layout, set_memory_ro);
+out:
+	mutex_unlock(&module_mutex);
+}
+
 /* Iterate through all modules and set each module's text as RW */
 void set_all_modules_text_rw(void)
 {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 62a50bf399d6..93506a51a308 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5815,7 +5815,7 @@ void ftrace_module_enable(struct module *mod)
 	 * so that we can modify the text.
 	 */
 	if (ftrace_start_up)
-		ftrace_arch_code_modify_prepare();
+		set_module_text_rw(mod);
 
 	do_for_each_ftrace_rec(pg, rec) {
 		int cnt;
@@ -5855,7 +5855,7 @@ void ftrace_module_enable(struct module *mod)
 
  out_loop:
 	if (ftrace_start_up)
-		ftrace_arch_code_modify_post_process();
+		set_module_text_ro(mod);
 
  out_unlock:
 	mutex_unlock(&ftrace_lock);
