Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D42C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3813B2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJWOectd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfCZMOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:14:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37093 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:13:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so8163936pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s5pppG5kwucVCpvG3BjNDMQxHJefEQp2AhJAiYdaZeY=;
        b=UJWOectdJ98LF+yDZAtsMg7EhPE3usybE7TbVXmSer9AVa52Uo+QYdgRjkexf1FpED
         PYHw9AUOANwONq1E8RZg2J1sn2WbNstyMNbb5a8oPfBtKr/q87kZPAbrB2IMpbYTl3K4
         u1kbkyVU/lOPSJN9jg9kVxhYtPvJu9e4xmVmGrFzqNmbNKiONDrMC3od5yjGH0DLqKqA
         UTxXYD5BVp8s8p0L1a/db0pTyY2vtRjPaU1Bfn+RVTrb9Xmgc3zQb4cQOzWsi95g3jbF
         QonvWk3kOlwxEsArrisGVHvhZesPwNlz0rJzxMfPD3WuC5skzQ+46BxtcY48gTcCq3CG
         AQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s5pppG5kwucVCpvG3BjNDMQxHJefEQp2AhJAiYdaZeY=;
        b=apZK1E2+KquzH9FqkmrzjaLGErNoBHa9JljnOZYUrr07ugFpHOg7XojsnZzm5gCfBi
         Tkoe6ZizGqKpPhHqekbt4KGn4O8InNQuJIfhPeFTUagqIqdMo/Pdbc8B9piok5bP+FAw
         OoJ2qSpSDtu4bVW8NdbasRaP4bgwZMWztx17jLd816vNI6w3u863VVLI8LazjdmRZJyg
         DjFJdV1r8DitiIVO03kGjhNmvF9jhTB7pr1EU7gV7Q4NB3NjsM5OPhLhUp6Gq86pOvL+
         NKxhzoELJcvVk+osSFb1X4ZhBBbxjG4fruICQDazITAU3JktK1BrSOOgSulfj1L4oBbk
         wmkg==
X-Gm-Message-State: APjAAAWD7lrCCCddw+ACuQXEUxFGC2Yj0ME9w1rXvUqeeF96+nGL+PoZ
        +HmGU9qFzqlV0fQyoJevAPk=
X-Google-Smtp-Source: APXvYqxFnTav8ZEmhmPCh8mEU4d3h5gUp0VLmmrTEmMKBDKFICdTq0WHPVvnQOVkEpiudeRQKBDtUg==
X-Received: by 2002:aa7:9219:: with SMTP id 25mr30156738pfo.205.1553602438572;
        Tue, 26 Mar 2019 05:13:58 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e2sm31263881pfa.64.2019.03.26.05.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 05:13:57 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, peterz@infradead.org, paulmck@linux.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 2/3] sched/fair: do not expose some tracepoints to user if CONFIG_SCHEDSTATS is not set
Date:   Tue, 26 Mar 2019 20:13:10 +0800
Message-Id: <1553602391-11926-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
References: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
be not exposed to user if CONFIG_SCHEDSTATS is not set.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/sched.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfa..c8c7c7e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -241,7 +241,6 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 DEFINE_EVENT(sched_process_template, sched_process_free,
 	     TP_PROTO(struct task_struct *p),
 	     TP_ARGS(p));
-	     
 
 /*
  * Tracepoint for a task exiting:
@@ -336,11 +335,20 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 		  __entry->pid, __entry->old_pid)
 );
 
+
+#ifdef CONFIG_SCHEDSTATS
+#define DEFINE_EVENT_SCHEDSTAT DEFINE_EVENT
+#define DECLARE_EVENT_CLASS_SCHEDSTAT DECLARE_EVENT_CLASS
+#else
+#define DEFINE_EVENT_SCHEDSTAT DEFINE_EVENT_NOP
+#define DECLARE_EVENT_CLASS_SCHEDSTAT DECLARE_EVENT_CLASS_NOP
+#endif
+
 /*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
  */
-DECLARE_EVENT_CLASS(sched_stat_template,
+DECLARE_EVENT_CLASS_SCHEDSTAT(sched_stat_template,
 
 	TP_PROTO(struct task_struct *tsk, u64 delay),
 
@@ -363,12 +371,11 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 			(unsigned long long)__entry->delay)
 );
 
-
 /*
  * Tracepoint for accounting wait time (time the task is runnable
  * but not actually running due to scheduler contention).
  */
-DEFINE_EVENT(sched_stat_template, sched_stat_wait,
+DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_wait,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
@@ -376,7 +383,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
  * Tracepoint for accounting sleep time (time the task is not runnable,
  * including iowait, see below).
  */
-DEFINE_EVENT(sched_stat_template, sched_stat_sleep,
+DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_sleep,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
@@ -384,14 +391,14 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
  * Tracepoint for accounting iowait time (time the task is not runnable
  * due to waiting on IO to complete).
  */
-DEFINE_EVENT(sched_stat_template, sched_stat_iowait,
+DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_iowait,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
 /*
  * Tracepoint for accounting blocked time (time the task is in uninterruptible).
  */
-DEFINE_EVENT(sched_stat_template, sched_stat_blocked,
+DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_blocked,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
-- 
1.8.3.1

