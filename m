Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4AECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7DF20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194646;
	bh=t4wtvtqzKXPIFU5RVhiRRFk41OOfzOMQKCbB3cvZJso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kU+9MlivMSbmFPRQE3tQ3hd3sMfwy+E1df7LJeEFqkzLxL7v5OamoNouCz1vdKPWF
	 zjjPhlCcpH6jOdDmlF+3QBjz2EGdM+JHqsc1OnuYuHTo02+YNruTAGAW2/lGcAbQ5X
	 bIxzw81bRLpXbZceaFROVLGcPOadfd70xHY5H+3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbfJPC5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390708AbfJPC5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:22 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D0721835;
        Wed, 16 Oct 2019 02:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194641;
        bh=t4wtvtqzKXPIFU5RVhiRRFk41OOfzOMQKCbB3cvZJso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qb7zAKb+TlHiN7BgCOlX1OAkewcro54TTVG0Y0wW7f5hhb4dqx3kvAP8FkG1yy0rt
         FAvXtt9JKeHmF205s3n6XIhCnOUyxvhNcRkZJONxYwBfuNDysI9Fi8ntmBrmUoud2Z
         tmvUpx0Xz61SIjOY7Jk4j1zbkbdN/NUW5od/K9Ss=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 05/14] context_tracking: s/context_tracking_is_enabled/context_tracking_enabled()
Date:   Wed, 16 Oct 2019 04:56:51 +0200
Message-Id: <20191016025700.31277-6-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the superfluous "is" in the middle of the name. We want to
standardize the naming so that it can be expanded through suffixes:

	context_tracking_enabled()
	context_tracking_enabled_cpu()
	context_tracking_enabled_this_cpu()

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h               |  2 +-
 include/linux/context_tracking.h       | 20 ++++++++++----------
 include/linux/context_tracking_state.h |  8 ++++----
 include/linux/tick.h                   |  2 +-
 include/linux/vtime.h                  |  2 +-
 kernel/context_tracking.c              |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 515c0ceeb4a3..0789e13ece90 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -354,7 +354,7 @@ For 32-bit we have the following conventions - kernel is built with
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
 #ifdef CONFIG_JUMP_LABEL
-	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_enabled, def=0
+	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_key, def=0
 #endif
 	call enter_from_user_mode
 .Lafter_call_\@:
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 558a209c247d..f1601bac08dc 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -22,26 +22,26 @@ extern void context_tracking_user_exit(void);
 
 static inline void user_enter(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		context_tracking_enter(CONTEXT_USER);
 
 }
 static inline void user_exit(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		context_tracking_exit(CONTEXT_USER);
 }
 
 /* Called with interrupts disabled.  */
 static inline void user_enter_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_USER);
 
 }
 static inline void user_exit_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_USER);
 }
 
@@ -49,7 +49,7 @@ static inline enum ctx_state exception_enter(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (!context_tracking_is_enabled())
+	if (!context_tracking_enabled())
 		return 0;
 
 	prev_ctx = this_cpu_read(context_tracking.state);
@@ -61,7 +61,7 @@ static inline enum ctx_state exception_enter(void)
 
 static inline void exception_exit(enum ctx_state prev_ctx)
 {
-	if (context_tracking_is_enabled()) {
+	if (context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
 			context_tracking_enter(prev_ctx);
 	}
@@ -77,7 +77,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
  */
 static inline enum ctx_state ct_state(void)
 {
-	return context_tracking_is_enabled() ?
+	return context_tracking_enabled() ?
 		this_cpu_read(context_tracking.state) : CONTEXT_DISABLED;
 }
 #else
@@ -90,7 +90,7 @@ static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
 #endif /* !CONFIG_CONTEXT_TRACKING */
 
-#define CT_WARN_ON(cond) WARN_ON(context_tracking_is_enabled() && (cond))
+#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
 
 #ifdef CONFIG_CONTEXT_TRACKING_FORCE
 extern void context_tracking_init(void);
@@ -108,7 +108,7 @@ static inline void guest_enter_irqoff(void)
 	else
 		current->flags |= PF_VCPU;
 
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_GUEST);
 
 	/* KVM does not hold any references to rcu protected data when it
@@ -124,7 +124,7 @@ static inline void guest_enter_irqoff(void)
 
 static inline void guest_exit_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
 	if (vtime_accounting_cpu_enabled())
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index f4633c2c29a5..91250bdf2060 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -23,12 +23,12 @@ struct context_tracking {
 };
 
 #ifdef CONFIG_CONTEXT_TRACKING
-extern struct static_key_false context_tracking_enabled;
+extern struct static_key_false context_tracking_key;
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
-static inline bool context_tracking_is_enabled(void)
+static inline bool context_tracking_enabled(void)
 {
-	return static_branch_unlikely(&context_tracking_enabled);
+	return static_branch_unlikely(&context_tracking_key);
 }
 
 static inline bool context_tracking_cpu_is_enabled(void)
@@ -42,7 +42,7 @@ static inline bool context_tracking_in_user(void)
 }
 #else
 static inline bool context_tracking_in_user(void) { return false; }
-static inline bool context_tracking_is_enabled(void) { return false; }
+static inline bool context_tracking_enabled(void) { return false; }
 static inline bool context_tracking_cpu_is_enabled(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
diff --git a/include/linux/tick.h b/include/linux/tick.h
index f92a10b5e112..7e050a356cc5 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -174,7 +174,7 @@ extern cpumask_var_t tick_nohz_full_mask;
 
 static inline bool tick_nohz_full_enabled(void)
 {
-	if (!context_tracking_is_enabled())
+	if (!context_tracking_enabled())
 		return false;
 
 	return tick_nohz_full_running;
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index d9160ab3667a..0fc7f11f7aa4 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -28,7 +28,7 @@ extern void vtime_task_switch(struct task_struct *prev);
  */
 static inline bool vtime_accounting_enabled(void)
 {
-	return context_tracking_is_enabled();
+	return context_tracking_enabled();
 }
 
 static inline bool vtime_accounting_cpu_enabled(void)
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index be01a4d627c9..0296b4bda8f1 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -25,8 +25,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE(context_tracking_enabled);
-EXPORT_SYMBOL_GPL(context_tracking_enabled);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
+EXPORT_SYMBOL_GPL(context_tracking_key);
 
 DEFINE_PER_CPU(struct context_tracking, context_tracking);
 EXPORT_SYMBOL_GPL(context_tracking);
@@ -192,7 +192,7 @@ void __init context_tracking_cpu_set(int cpu)
 
 	if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
-		static_branch_inc(&context_tracking_enabled);
+		static_branch_inc(&context_tracking_key);
 	}
 
 	if (initialized)
-- 
2.23.0

