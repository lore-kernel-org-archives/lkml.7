Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F297C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587252186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TMnwcD8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfH3Q0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:26:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41665 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfH3Q0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:26:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so3786076pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4Xumn32c++DuTngrPtSgVUwVPnwQ8ZdYWFRevsnuJA=;
        b=TMnwcD8TRNtrtXaAO3zDN7mqKxsLejkolhcrS5xtzLyBBcyP+lN5caJI/pcn7m7ZPc
         hM8N2F5Nn7DOHAj4/Z6SpCjPDsoNmMejiBng1sRwVZ59JObqVwsgx6W526o4qJ51RE/M
         y4pShjmf8VTlKZ0qIIA3r0n5wEiU0R7RYVZUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4Xumn32c++DuTngrPtSgVUwVPnwQ8ZdYWFRevsnuJA=;
        b=tKCnupwCqEfwqsjBfdCp9wk8F8IQTnq3UV0rz1asdwj/TCmw+5jtnn3co2cCFrT9OT
         a8Ubj4IwKxauM5h30AzsrcZHN1hRhO3Ggo+AoeJ4Npzgk7gg3+ic+QZd8quAaCVR9SlC
         d0E2QY9QntDTmZpKMw2RN18APIhrulf6qYOa8398fnfu9CAvHpd6cywYs6wjkfU60pVt
         OlU8PXAoFPR2GQzBfQ+lcJLtNBLSARMerXqFn2iuWZ7yJeIS4LpyYt6Sk/bedZ1gQQs2
         fV1va+OG6iyrByVxMIeV2px4pz/4g3oWeGRzKWJoZvMplaM/ZO6z/kMEv8iK2auW22jx
         G09w==
X-Gm-Message-State: APjAAAXlxti4D2t3MXNtoLX7aGYrKJttPloZtS8FtKHG6DAOv7I/8E2N
        ErZXTesEBXBQ8mAHV5iDIQrU6gwKh1E=
X-Google-Smtp-Source: APXvYqzXK1HUr8uJBtorSgAh8Tqp8JcNZSCsWl0aI9agScz3T3T2Xw3H73sGQ9qk3KMYxQUa3hOmiw==
X-Received: by 2002:a63:6a81:: with SMTP id f123mr14031441pgc.348.1567182400939;
        Fri, 30 Aug 2019 09:26:40 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o3sm21012782pje.1.2019.08.30.09.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:26:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 -rcu dev 2/2] rcu/dyntick-idle: Add better tracing
Date:   Fri, 30 Aug 2019 12:26:28 -0400
Message-Id: <20190830162628.232306-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830162628.232306-1-joel@joelfernandes.org>
References: <20190830162628.232306-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dyntick-idle traces are a bit confusing. This patch makes it simpler
and adds some missing cases such as EQS-enter due to user vs idle mode.

Following are the changes:
(1) Add a new context field to trace_rcu_dyntick tracepoint. This
    context field can be "USER", "IDLE" or "IRQ".

(2) Remove the "++=" and "--=" strings and replace them with
   "StillNonIdle". This is much easier on the eyes, and the -- and ++
   are easily apparent in the dynticks_nesting counters we are printing
   anyway.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 13 ++++++++-----
 kernel/rcu/tree.c          | 19 +++++++++++++------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 66122602bd08..474c1f7e7104 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -449,12 +449,14 @@ TRACE_EVENT_RCU(rcu_fqs,
  */
 TRACE_EVENT_RCU(rcu_dyntick,
 
-	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
+	TP_PROTO(const char *polarity, const char *context, long oldnesting,
+		 long newnesting, atomic_t dynticks),
 
-	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
+	TP_ARGS(polarity, context, oldnesting, newnesting, dynticks),
 
 	TP_STRUCT__entry(
 		__field(const char *, polarity)
+		__field(const char *, context)
 		__field(long, oldnesting)
 		__field(long, newnesting)
 		__field(int, dynticks)
@@ -462,14 +464,15 @@ TRACE_EVENT_RCU(rcu_dyntick,
 
 	TP_fast_assign(
 		__entry->polarity = polarity;
+		__entry->context = context;
 		__entry->oldnesting = oldnesting;
 		__entry->newnesting = newnesting;
 		__entry->dynticks = atomic_read(&dynticks);
 	),
 
-	TP_printk("%s %lx %lx %#3x", __entry->polarity,
-		  __entry->oldnesting, __entry->newnesting,
-		  __entry->dynticks & 0xfff)
+	TP_printk("%s %s %lx %lx %#3x", __entry->polarity,
+		__entry->context, __entry->oldnesting, __entry->newnesting,
+		__entry->dynticks & 0xfff)
 );
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 417dd00b9e87..463407762b5a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -533,7 +533,8 @@ static void rcu_eqs_enter(bool user)
 	}
 
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
+	trace_rcu_dyntick(TPS("Start"), (user ? TPS("USER") : TPS("IDLE")),
+			  rdp->dynticks_nesting, 0, rdp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
@@ -606,14 +607,17 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
+		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
+				  rdp->dynticks_nmi_nesting,
+				  rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
+	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nmi_nesting,
+			  0, rdp->dynticks);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
@@ -700,7 +704,8 @@ static void rcu_eqs_exit(bool user)
 	rcu_dynticks_task_exit();
 	rcu_dynticks_eqs_exit();
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
+	trace_rcu_dyntick(TPS("End"), (user ? TPS("USER") : TPS("IDLE")),
+			  rdp->dynticks_nesting, 1, rdp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -787,9 +792,11 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		rdp->rcu_forced_tick = true;
 		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
-	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  rdp->dynticks_nmi_nesting,
+
+	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
+			  TPS("IRQ"), rdp->dynticks_nmi_nesting,
 			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
+
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
-- 
2.23.0.187.g17f5b7556c-goog

