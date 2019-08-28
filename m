Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D948C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C35920644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IAgXANXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfH1S0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:26:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39094 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfH1S0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:26:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so168184pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZ3/HRnCHQe+XyNK1hE0wDq1hKDWRVGKFXrsRvw+dRA=;
        b=IAgXANXyGR5PVXWHS79Z4ccBFA5/ChlBzQI2tIFNaEFvyC+hqblWWmrGdXZd5oHoOy
         hH1e6dt0Bjs1jz6a1FdBbN5uKBj5BgFnBMr5AwB6y0oOCbm7Th6Iz23Qu6YWvQmh+5DB
         llZld8RlLB2s5PrWT9d6tVazOJrmxr4qmGX8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZ3/HRnCHQe+XyNK1hE0wDq1hKDWRVGKFXrsRvw+dRA=;
        b=JWsiQGavBCcX7utpuFB8ciWxzMmF0M/SmdRrRefnKLqkPuic4d81UDtT7WCVXOfMLc
         lTcfZf68tPxxb0atZntokECWinil3yAqWRn9MFsyv5iIwZq8z9f8tQzHPZXaC/cdn9Ic
         aEmcOObWvK0jSG4E0DYOmc9KnuRTmgq4IwHJZedlITYqeFXv7Plf/B0d2qNYS6jyAQuC
         2bgbq+56ZzTMbw4/J+0zkgPtWNd4l4xelpVdDzLnOmSki5f5KzjD4zMWTGyLmbgBZClt
         MXvpsDsumBResITSz3mBcTCN/vTE+L6Al5vbsP+aLKUouPZY6lcIE/F3TRjXZh9oxt52
         /37w==
X-Gm-Message-State: APjAAAX87tyR4ugLVSB3LC84mzp87KOm1e+nGZVdlBpChQf56J/2hQYy
        tsnCabHx2hyrD6Ytcmh/GsfqOo+ABw0=
X-Google-Smtp-Source: APXvYqw9hPh56bJPohT8x3/1DCryoAZyRxSsLjKVc6arKocRvaCgWTedb8ZQfqfVEKRAqxtItHbRdA==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr4779141pge.453.1567016781250;
        Wed, 28 Aug 2019 11:26:21 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b30sm7082pfr.117.2019.08.28.11.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 11:26:20 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, paulmck@kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] rcu/dyntick-idle: Add better tracing
Date:   Wed, 28 Aug 2019 14:26:13 -0400
Message-Id: <20190828182613.37715-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828001146.GM26530@linux.ibm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dyntick-idle traces are a bit confusing. This patch makes it simpler
and adds some missing cases such as EQS-enter because user vs idle mode.

Following are the changes:
(1) Add a new context field to trace_rcu_dyntick tracepoint. This
    context field can be "USER", "IDLE" or "IRQ".

(2) Remove the "++=" and "--=" strings and replace them with
   "StillNonIdle". This is much easier on the eyes, and the -- and ++
   are easily apparent in the dynticks_nesting counters we are printing
   anyway.

This patch is based on the previous patches to simplify rcu_dyntick
counters [1] and with these traces, I have verified the counters are
working properly.

[1]
Link: https://lore.kernel.org/patchwork/patch/1120021/
Link: https://lore.kernel.org/patchwork/patch/1120022/

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 13 ++++++++-----
 kernel/rcu/tree.c          | 17 +++++++++++------
 2 files changed, 19 insertions(+), 11 deletions(-)

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
index 1465a3e406f8..1a65919ec800 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -570,7 +570,8 @@ static void rcu_eqs_enter(bool user)
 	}
 
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
+	trace_rcu_dyntick(TPS("Start"), (user ? TPS("USER") : TPS("IDLE")),
+			  rdp->dynticks_nesting, 0, rdp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
@@ -642,15 +643,17 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (rdp->dynticks_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nesting,
-				  rdp->dynticks_nesting - 2, rdp->dynticks);
+		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
+				  rdp->dynticks_nesting, rdp->dynticks_nesting - 2,
+				  rdp->dynticks);
 		WRITE_ONCE(rdp->dynticks_nesting, /* No store tearing. */
 			   rdp->dynticks_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nesting, 0, rdp->dynticks);
+	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nesting, 0,
+			  rdp->dynticks);
 	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
@@ -733,7 +736,8 @@ static void rcu_eqs_exit(bool user)
 	rcu_dynticks_task_exit();
 	rcu_dynticks_eqs_exit();
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
+	trace_rcu_dyntick(TPS("End"), (user ? TPS("USER") : TPS("IDLE")),
+			  rdp->dynticks_nesting, 1, rdp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 
@@ -825,7 +829,8 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
 
-	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
+	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
+			  TPS("IRQ"),
 			  rdp->dynticks_nesting,
 			  rdp->dynticks_nesting + incby, rdp->dynticks);
 
-- 
2.23.0.187.g17f5b7556c-goog

