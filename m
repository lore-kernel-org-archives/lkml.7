Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5646C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2EA2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="teCMSlST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfH0BeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:34:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45647 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfH0BeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:34:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so12957591pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1wAPRWkZq37XZQm/Bgn6uX+vxReKLPx3TtUj2BAuk0=;
        b=teCMSlSTzppCSeSYkvC+HeTcBE5NVObuko8Vvz7CHOiFXu7foJSjVBzGM3uV4Se+wf
         WYXtne8QW1V5QS4ca9kpP01D+xmZi/5R0od2Q3C/O20uRXh2CG01qvogDOZa7QxDv7K3
         0G5Pi95XOyu7mKMFxq+CPgAWYPDc5S8kKXuYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1wAPRWkZq37XZQm/Bgn6uX+vxReKLPx3TtUj2BAuk0=;
        b=HfxDjArTTCzyAV6W6Dv6TxYcILvmoy+5KaBFjflw5LDDtUdiSiyab7LRrg2f2PqqMN
         iHWP2ZIDt07lKNvW7fPCZead12z7r2RZE6WRFdg+ZFugf/CWwt9x8UoDLGudrmCFYMfR
         twJ6lnQ2KIq/ajSbBbZ6vytdU/Y+uda7aY0jNAf0EFNsD/fBJZ5qtluJuRVwKzZmDoAV
         1mB71iY6c+M6AGq/NOwnBeYHY3DGJ8AQ0v7/Hp88PBXiwMvIiWhLk3xAmKL40NpYVUn5
         vx52Kjt+9VZHjru8ogsv/BpzM1LXP+arHkvVTRo/EvPtukxz6VxWmiocniXGuJobSJRy
         91Hw==
X-Gm-Message-State: APjAAAX2NrYfILErS8YUwdYtjsPRYhfblKUNoj2pzcHHDroKegk2MrP5
        meeAnpMb3FFITB7Gq6UjyGlKQ3uEagI=
X-Google-Smtp-Source: APXvYqw/T1H03XY+rVQ9XD1TcmE4DC3rWFkMmmLBJb8Gl38tsSxxfaRZFNzSqeBjcRUXG8HDUjE8xg==
X-Received: by 2002:aa7:9a12:: with SMTP id w18mr10829112pfj.110.1566869654342;
        Mon, 26 Aug 2019 18:34:14 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n185sm11984541pga.16.2019.08.26.18.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 18:34:13 -0700 (PDT)
Message-ID: <5d648895.1c69fb81.5e60a.fc6f@mx.google.com>
X-Google-Original-Message-ID: 156686963163@cam.corp.google.com
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC v1 1/2] rcu/tree: Clean up dynticks counter usage
Date:   Mon, 26 Aug 2019 21:33:53 -0400
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: 156686963125060@cam.corp.google.com
References: 156686963125060@cam.corp.google.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynticks counter are confusing due to crowbar writes of
DYNTICK_IRQ_NONIDLE whose purpose is to detect half-interrupts (i.e. we
see rcu_irq_enter() but not rcu_irq_exit() due to a usermode upcall) and
if so then do a reset of the dyntick_nmi_nesting counters. This patch
tries to get rid of DYNTICK_IRQ_NONIDLE while still keeping the code
working, fully functional, and less confusing. The confusion recently
has even led to patches forgetting that DYNTICK_IRQ_NONIDLE was written
to which wasted lots of time.

The patch has the following changes:

(1) Use dynticks_nesting instead of dynticks_nmi_nesting for determining
outer most "EQS exit". This is needed to detect in
rcu_nmi_enter_common() if we have already EQS-exited, such as because of
a syscall. Currently we rely on a forced write of DYNTICK_IRQ_NONIDLE
from rcu_eqs_exit() for this purpose. This is one purpose of the
DYNTICK_IRQ_NONIDLE write (other than detecting half-interrupts).
However, we do not need to do that. dyntick_nesting already tells us that
we have EQS-exited so just use that thus removing the dependence of
dynticks_nmi_nesting for this purpose.

(2) Keep dynticks_nmi_nesting around because:

  (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
      interrupt nesting level.

  (b) We need to detect half-interrupts till we are sure they're not an
      issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.

(3) Since we got rid of DYNTICK_IRQ_NONIDLE, we also do cheaper
comparisons with zero instead for the code that keeps the tick on in
rcu_nmi_enter_common().

In the next patch, both of the concerns of (2) will be addressed and
then we can get rid of dynticks_nmi_nesting, however one step at a time.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h  |  4 ----
 kernel/rcu/tree.c | 60 ++++++++++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index aeec70fda82c..046833f3784b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -12,10 +12,6 @@
 
 #include <trace/events/rcu.h>
 
-/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
-#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
-
-
 /*
  * Grace-period counter management.
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 68ebf0eb64c8..255cd6835526 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -81,7 +81,7 @@
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
+	.dynticks_nmi_nesting = 0,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 };
 struct rcu_state rcu_state = {
@@ -558,17 +558,18 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 /*
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
- * the possibility of usermode upcalls having messed up our count
- * of interrupt nesting level during the prior busy period.
  */
 static void rcu_eqs_enter(bool user)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+	/* Entering usermode/idle from interrupt is not handled. These would
+	 * mean usermode upcalls or idle entry happened from interrupts. But,
+	 * reset the counter if we warn.
+	 */
+	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
+		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
 	if (rdp->dynticks_nesting != 1) {
@@ -642,23 +643,27 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
+	WARN_ON_ONCE(rdp->dynticks_nesting <= 0);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
+	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
+		   rdp->dynticks_nmi_nesting - 1);
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (rdp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
-		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
-			   rdp->dynticks_nmi_nesting - 2);
+	if (rdp->dynticks_nesting != 1) {
+		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nesting,
+				  rdp->dynticks_nesting - 2, rdp->dynticks);
+		WRITE_ONCE(rdp->dynticks_nesting, /* No store tearing. */
+			   rdp->dynticks_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nesting, 0, rdp->dynticks);
+	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
 		rcu_prepare_for_idle();
@@ -723,10 +728,6 @@ void rcu_irq_exit_irqson(void)
 /*
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
- * allow for the possibility of usermode upcalls messing up our count of
- * interrupt nesting level during the busy period that is just now starting.
  */
 static void rcu_eqs_exit(bool user)
 {
@@ -747,8 +748,13 @@ static void rcu_eqs_exit(bool user)
 	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+
+	/* Exiting usermode/idle from interrupt is not handled. These would
+	 * mean usermode upcalls or idle exit happened from interrupts. But,
+	 * reset the counter if we warn.
+	 */
+	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
+		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
 }
 
 /**
@@ -804,6 +810,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	long incby = 2;
 
 	/* Complain about underflow. */
+	WARN_ON_ONCE(rdp->dynticks_nesting < 0);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
 
 	/*
@@ -826,16 +833,21 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
-		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		   !rdp->dynticks_nmi_nesting && rdp->rcu_urgent_qs &&
+		   !rdp->rcu_forced_tick) {
 		rdp->rcu_forced_tick = true;
 		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
+
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
+			  rdp->dynticks_nesting,
+			  rdp->dynticks_nesting + incby, rdp->dynticks);
+
+	WRITE_ONCE(rdp->dynticks_nesting, /* Prevent store tearing. */
+		   rdp->dynticks_nesting + incby);
+
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdp->dynticks_nmi_nesting + incby);
+		   rdp->dynticks_nmi_nesting + 1);
 	barrier();
 }
 
-- 
2.23.0.187.g17f5b7556c-goog

