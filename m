Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C45C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BF9206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfGPH2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 03:28:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbfGPH2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:28:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79E83B123;
        Tue, 16 Jul 2019 07:28:34 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>,
        Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/2] printk/panic/x86: Allow to access printk log buffer after crash_smp_send_stop()
Date:   Tue, 16 Jul 2019 09:28:05 +0200
Message-Id: <20190716072805.22445-3-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190716072805.22445-1-pmladek@suse.com>
References: <20190716072805.22445-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crash_smp_send_stop() is a special variant of smp_send_stop(). It is
used when crash_kexec_post_notifiers are enabled. CPUs are stopped
but cpu_online_mask is not updated so that the original information is
visible in crashdump. See the commit 0ee59413c967c35a6dd ("x86/panic:
replace smp_send_stop() with kdump friendly version in panic path")
for more details.

crash_smp_send_stop() uses NMI to stop the CPUs. Then logbuf_lock
might stay locked but printk_bust_lock_safe() does not know that
CPUs are stopped.

Solution is to force logbuf_lock re-initialization from
crash_smp_send_stop().

Note that x86 seems to be the only architecture that implements
crash_smp_send_stop() and uses NMI at the same time. Other
architectures could not guarantee that the CPUs were really stopped.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/x86/kernel/crash.c     | 6 +++++-
 include/linux/printk.h      | 4 ++--
 kernel/panic.c              | 2 +-
 kernel/printk/printk_safe.c | 8 +++++---
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2bf70a2fed90..9a497eb37bf7 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -99,7 +99,11 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 void kdump_nmi_shootdown_cpus(void)
 {
 	nmi_shootdown_cpus(kdump_nmi_callback);
-
+	/*
+	 * CPUs are stopped but it is not visible via cpus_online
+	 * bitmap. Bust logbuf_lock to make kmsg_dump() working.
+	 */
+	printk_bust_lock_safe(true);
 	disable_local_APIC();
 }
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4d15a0eda9c6..c050f1dafc32 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -202,7 +202,7 @@ __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack(void) __cold;
-extern int printk_bust_lock_safe(void);
+extern int printk_bust_lock_safe(bool kdump_smp_stop);
 extern void printk_safe_init(void);
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
@@ -270,7 +270,7 @@ static inline void dump_stack(void)
 {
 }
 
-static inline int printk_bust_lock_safe(void)
+static inline int printk_bust_lock_safe(bool kdump_smp_stop)
 {
 	return 0;
 }
diff --git a/kernel/panic.c b/kernel/panic.c
index aa50cdb75022..54fae99e7a7e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -274,7 +274,7 @@ void panic(const char *fmt, ...)
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
 	/* Call flush even twice. It tries harder with a single online CPU */
-	printk_blocked = printk_bust_lock_safe();
+	printk_blocked = printk_bust_lock_safe(false);
 	if (!printk_blocked) {
 		printk_safe_flush_on_panic();
 		kmsg_dump(KMSG_DUMP_PANIC);
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 71d4b763f811..e26304277886 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -255,16 +255,18 @@ void printk_safe_flush(void)
 
 /**
  * printk_try_bust_lock - make printk log accessible when safe
+ * @kdump_smp_stop: true when called after kdump stopped CPUs via NMI
+ *	but did not update the number of online CPUs.
  *
  * Return 0 when the log is accessible. Return -EWOULDBLOCK when
  * it is not safe and likely to cause a deadlock.
  */
-int printk_bust_lock_safe(void)
+int printk_bust_lock_safe(bool kdump_smp_stop)
 {
 	if (!raw_spin_is_locked(&logbuf_lock))
 		return 0;
 
-	if (num_online_cpus() == 1) {
+	if (num_online_cpus() == 1 || kdump_smp_stop)  {
 		debug_locks_off();
 		raw_spin_lock_init(&logbuf_lock);
 		return 0;
@@ -285,7 +287,7 @@ int printk_bust_lock_safe(void)
  */
 void printk_safe_flush_on_panic(void)
 {
-	if (printk_bust_lock_safe() == 0)
+	if (printk_bust_lock_safe(false) == 0)
 		printk_safe_flush();
 }
 
-- 
2.16.4

