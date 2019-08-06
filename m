Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399052173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dk1prkSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHFVNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:13:30 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:44415 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfHFVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:13:29 -0400
Received: by mail-yb1-f201.google.com with SMTP id w200so55995220ybg.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UVpUeXdaVWlLept+Hu3Wkl51XQasQpyZNFOpCvXTNnY=;
        b=Dk1prkSlnQfCJq916fJbcMHckmHHEUsgrGQI/pkWrcLzNo7nt1N+vh0d54QFBKeMFL
         v1BiuSx7UL/rlmQqrJGuNdmmRxQg49Y/x7D5qf+G3mh8UleVpt9P3rVuJ4TvRQ3I5V18
         D1697E6VqAKvVAWps7LSAavCJKgo2hHkSYSRMoExRqILQFThHCu2nOM9OD6hDxR6anLa
         vi1euguQz+abDoyHDpjygC6a2F9qZ161mj/ePfNmhw9yHdtfaSMSBb3a3GQfh7M5xFj7
         FOnxgb1+rwwVqdQ0jCrpptFEX887hnWI0p3AaXJ+Ip19EU+5R3szVMBjrNwzrPUvRslt
         lo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UVpUeXdaVWlLept+Hu3Wkl51XQasQpyZNFOpCvXTNnY=;
        b=Pmgo0xHNeyScCr+d4zsYhghjscHVRhWbUmJ5dxMY9NdI/dP6jUdErYhgmrUnUt9MgD
         uOcn9R34gOawWgWHJtIznMkizMc8+6ck08MlmnJeawfhlhz8w+8CblGnrxPiNHD2YPvO
         Ao4mNgfhPtJIyv5wH2Huzh9CZjtVK7iycOxGLH8u5U468jer5JptdUys5ST8BsiscVam
         f+Cpi+suIi1dlvGHbwObTFzLgutRQdJE2dip9x3PtdjZqc/Cz3gvzC3XztSNlMvo76FX
         /n00s/C+LGFEeBDLIsjwFbxL8I2heDSygsA6RaVSKqwCiLuUM6z7Oz3VDHYrXagiNA0B
         O86w==
X-Gm-Message-State: APjAAAX/9PqL1ms2zNkpjyL66WmCqrno5b91PV3muaFtXTe1BQwvUnHv
        gLO0Vs+iq2+LJ3IZb0fvoQOHeuj2Mg==
X-Google-Smtp-Source: APXvYqyfAoegNnsAB8KkiuNIOS+lqGjRkbmY++NEU2inMnp+QXMTEuxoR+R/PE27sNT5jwk1IDgM7Bs40Q==
X-Received: by 2002:a0d:d881:: with SMTP id a123mr3910898ywe.254.1565126008538;
 Tue, 06 Aug 2019 14:13:28 -0700 (PDT)
Date:   Tue,  6 Aug 2019 14:10:47 -0700
In-Reply-To: <20190806211047.232709-1-nhuck@google.com>
Message-Id: <20190806211047.232709-2-nhuck@google.com>
Mime-Version: 1.0
References: <20190806211047.232709-1-nhuck@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [RFC PATCH 2/2] Add clang-tidy irq-balancing annotations for arm64
From:   Nathan Huckleberry <nhuck@google.com>
To:     mark.rutland@arm.com
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not intended to be merged.  It simply shows the scale of
the effort involved in applying annotations in the case of intentionally
unbalanced calls to local_irq_disable.

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/arm64/kernel/debug-monitors.c  | 1 +
 arch/arm64/kernel/machine_kexec.c   | 1 +
 arch/arm64/kernel/process.c         | 4 ++++
 arch/arm64/kernel/smp.c             | 1 +
 drivers/tty/sysrq.c                 | 1 +
 include/linux/compiler_attributes.h | 7 +++++++
 init/main.c                         | 1 +
 kernel/irq/handle.c                 | 1 +
 kernel/power/suspend.c              | 2 ++
 kernel/sched/core.c                 | 1 +
 kernel/sched/fair.c                 | 1 +
 kernel/sched/idle.c                 | 6 ++++++
 kernel/stop_machine.c               | 1 +
 mm/migrate.c                        | 1 +
 net/core/dev.c                      | 1 +
 15 files changed, 30 insertions(+)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index f8719bd30850..13552daeadd7 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -221,6 +221,7 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
 }
 NOKPROBE_SYMBOL(call_step_hook);
 
+__unbalanced_irq
 static void send_user_sigtrap(int si_code)
 {
 	struct pt_regs *regs = current_pt_regs();
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0df8493624e0..7880c3d336d5 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -258,6 +258,7 @@ static void machine_kexec_mask_interrupts(void)
 /**
  * machine_crash_shutdown - shutdown non-crashing cpus and save registers
  */
+__unbalanced_irq
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	local_irq_disable();
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 9856395ccdb7..30cec11dc82b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -111,6 +111,7 @@ void cpu_do_idle(void)
 /*
  * This is our default idle handler.
  */
+__unbalanced_irq
 void arch_cpu_idle(void)
 {
 	/*
@@ -149,6 +150,7 @@ void machine_shutdown(void)
  * activity (executing tasks, handling interrupts). smp_send_stop()
  * achieves this.
  */
+__unbalanced_irq
 void machine_halt(void)
 {
 	local_irq_disable();
@@ -162,6 +164,7 @@ void machine_halt(void)
  * achieves this. When the system power is turned off, it will take all CPUs
  * with it.
  */
+__unbalanced_irq
 void machine_power_off(void)
 {
 	local_irq_disable();
@@ -179,6 +182,7 @@ void machine_power_off(void)
  * executing pre-reset code, and using RAM that the primary CPU's code wishes
  * to use. Implementing such co-ordination would be essentially impossible.
  */
+__unbalanced_irq
 void machine_restart(char *cmd)
 {
 	/* Disable interrupts first */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6dcf9607d770..78da6f7b5bcd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -852,6 +852,7 @@ static void ipi_cpu_stop(unsigned int cpu)
 static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
 #endif
 
+__unbalanced_irq
 static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
 #ifdef CONFIG_KEXEC_CORE
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 573b2055173c..53bac6cb39c3 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -146,6 +146,7 @@ static struct sysrq_key_op sysrq_crash_op = {
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
+__unbalanced_irq
 static void sysrq_handle_reboot(int key)
 {
 	lockdep_off();
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a74..e2aaff9a2017 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -253,4 +253,11 @@
  */
 #define __weak                          __attribute__((__weak__))
 
+
+#if __has_attribute(__annotate__)
+# define __unbalanced_irq               __attribute__((annotate("ignore_irq_balancing")))
+#else
+# define __unbalanced_irq
+#endif
+
 #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
diff --git a/init/main.c b/init/main.c
index 66a196c5e4c3..360a2714afe3 100644
--- a/init/main.c
+++ b/init/main.c
@@ -902,6 +902,7 @@ static inline void do_trace_initcall_finish(initcall_t fn, int ret)
 }
 #endif /* !TRACEPOINTS_ENABLED */
 
+__unbalanced_irq
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index a4ace611f47f..a74309c071b7 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -134,6 +134,7 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	wake_up_process(action->thread);
 }
 
+__unbalanced_irq
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags)
 {
 	irqreturn_t retval = IRQ_NONE;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 096211299c07..41bc4b9b4f0e 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -380,12 +380,14 @@ static int suspend_prepare(suspend_state_t state)
 }
 
 /* default implementation */
+__unbalanced_irq
 void __weak arch_suspend_disable_irqs(void)
 {
 	local_irq_disable();
 }
 
 /* default implementation */
+__unbalanced_irq
 void __weak arch_suspend_enable_irqs(void)
 {
 	local_irq_enable();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..465d4ef60e1a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3366,6 +3366,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  * WARNING: must be called with preemption disabled!
  */
+__unbalanced_irq
 static void __sched notrace __schedule(bool preempt)
 {
 	struct task_struct *prev, *next;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..9f147a2239ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9334,6 +9334,7 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
  * least 1 task to be running on each physical CPU where possible, and
  * avoids physical / logical imbalances.
  */
+__unbalanced_irq
 static int active_load_balance_cpu_stop(void *data)
 {
 	struct rq *busiest_rq = data;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..b2174f71f1aa 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -52,6 +52,7 @@ static int __init cpu_idle_nopoll_setup(char *__unused)
 __setup("hlt", cpu_idle_nopoll_setup);
 #endif
 
+__unbalanced_irq
 static noinline int __cpuidle cpu_idle_poll(void)
 {
 	rcu_idle_enter();
@@ -74,6 +75,7 @@ void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
 void __weak arch_cpu_idle_dead(void) { }
+__unbalanced_irq
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll = 1;
@@ -85,6 +87,7 @@ void __weak arch_cpu_idle(void)
  *
  * To use when the cpuidle framework cannot be used.
  */
+__unbalanced_irq
 void __cpuidle default_idle_call(void)
 {
 	if (current_clr_polling_and_test()) {
@@ -96,6 +99,7 @@ void __cpuidle default_idle_call(void)
 	}
 }
 
+__unbalanced_irq
 static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		      int next_state)
 {
@@ -126,6 +130,7 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
  * set, and it returns with polling set.  If it ever stops polling, it
  * must clear the polling bit.
  */
+__unbalanced_irq
 static void cpuidle_idle_call(void)
 {
 	struct cpuidle_device *dev = cpuidle_get_device();
@@ -222,6 +227,7 @@ static void cpuidle_idle_call(void)
  *
  * Called with polling cleared.
  */
+__unbalanced_irq
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2b5a6754646f..1ff5f63b5f85 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -178,6 +178,7 @@ static void ack_state(struct multi_stop_data *msdata)
 }
 
 /* This is the cpu_stop function which stops the CPU. */
+__unbalanced_irq
 static int multi_cpu_stop(void *data)
 {
 	struct multi_stop_data *msdata = data;
diff --git a/mm/migrate.c b/mm/migrate.c
index f2ecc2855a12..bf2fd8e2c0f4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -396,6 +396,7 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
  * 2 for pages with a mapping
  * 3 for pages with a mapping and PagePrivate/PagePrivate2 set.
  */
+__unbalanced_irq
 int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, enum migrate_mode mode,
 		int extra_count)
diff --git a/net/core/dev.c b/net/core/dev.c
index d6edd218babd..04906dc6bd00 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5885,6 +5885,7 @@ static void net_rps_send_ipi(struct softnet_data *remsd)
  * net_rps_action_and_irq_enable sends any pending IPI's for rps.
  * Note: called with local irq disabled, but exits with local irq enabled.
  */
+__unbalanced_irq
 static void net_rps_action_and_irq_enable(struct softnet_data *sd)
 {
 #ifdef CONFIG_RPS
-- 
2.22.0.709.g102302147b-goog

