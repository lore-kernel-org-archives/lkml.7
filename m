Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED57C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9020D2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fq0xrXkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfCHSnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:43:24 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:48460 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfCHSnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:43:23 -0500
Received: by mail-io1-f74.google.com with SMTP id w19so16089787ioa.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KOFnefpWm/MGJVRwB1q3IBuYjFO05z5JkA9pY57L9o8=;
        b=Fq0xrXkGnIBrB8IPGplA3ONIgs9/AtsDhXfa957pzUu8VveDvKt9hXCBFa4g03sXKf
         RfWWaxlEQ4HMi5vxnjFLw0BKcyO38p2v6BTsg3bUqecPc73aVEV+OsaDwDNDaCJH+wWy
         INLmlffLQotYNi+/k8wdjfNeG3pHvI1zRa3+65vy9XYgbxHRqsdmJIZ65avsqwaIYnCV
         +NEYwgx7MeOOuLV0XrUYK5/r0T2bYFqkh10ng3mN4+EvqUVSn8H/Zq8rxGvGY4cJDq1t
         SRBPt0IdkWFekzJX7pCy5JUaQRUXNXYgt9SSXeiLuvF1MmrTFVn6uK34PQ+Nv20lBiQ3
         aQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KOFnefpWm/MGJVRwB1q3IBuYjFO05z5JkA9pY57L9o8=;
        b=UNwmG+eu2/w5RRURn1TBNSCLDHa6stXGK3k1TTWP4Bd8y0kYi4H25zW4MY9frPRCTk
         YWOnT704TE2Sr3qHv8H8l4eR73D/CyHBvS5gd71I71Bi5uuJVHDZEC3ZjU5judA5KGfM
         e6C+rlHfvKC+Vhii8AQktIsDFkO/tu+zYEetLklA03JW5jLxZFrHezv5/N1rzDFhLr05
         YcUxfEUUBH64L/31RHX3T1e0uC8D25jyDIXrZ0XE7fEVxTNf/N5vIu+q9LPCHzMFADd5
         LrW4B7cLzlBX/coLqK4xb9Qq1DrsO74Ma+jx3LLYDC8Fndku53Zb7K3I0sew4nAe6qim
         QAzg==
X-Gm-Message-State: APjAAAX9lUVlnG1bvJIXnKzbu6GFBqj6xp4G1ur1oGqeheMR9CpMB4PL
        AIwLm+8+/mQ4vZZXOaEDc7lK1MdVaI8=
X-Google-Smtp-Source: APXvYqzVQIDO3zH6/Mcc0ykLp0T9S36f2LzzA98NkiJ7Xxv2hG0pOuBW+mRWBRsSFt8RyW5EjF/qZ8iyxt4=
X-Received: by 2002:a24:8088:: with SMTP id g130mr13087838itd.28.1552070601978;
 Fri, 08 Mar 2019 10:43:21 -0800 (PST)
Date:   Fri,  8 Mar 2019 10:43:05 -0800
In-Reply-To: <20190308184311.144521-1-surenb@google.com>
Message-Id: <20190308184311.144521-2-surenb@google.com>
Mime-Version: 1.0
References: <20190308184311.144521-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v5 1/7] psi: introduce state_mask to represent stalled psi states
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The psi monitoring patches will need to determine the same states as
record_times().  To avoid calculating them twice, maintain a state mask
that can be consulted cheaply.  Do this in a separate patch to keep the
churn in the main feature patch at a minimum.

This adds 4-byte state_mask member into psi_group_cpu struct which results
in its first cacheline-aligned part becoming 52 bytes long.  Add explicit
values to enumeration element counters that affect psi_group_cpu struct
size.

Link: http://lkml.kernel.org/r/20190124211518.244221-4-surenb@google.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/psi_types.h |  9 ++++++---
 kernel/sched/psi.c        | 29 +++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 2cf422db5d18..762c6bb16f3c 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -11,7 +11,7 @@ enum psi_task_count {
 	NR_IOWAIT,
 	NR_MEMSTALL,
 	NR_RUNNING,
-	NR_PSI_TASK_COUNTS,
+	NR_PSI_TASK_COUNTS = 3,
 };
 
 /* Task state bitmasks */
@@ -24,7 +24,7 @@ enum psi_res {
 	PSI_IO,
 	PSI_MEM,
 	PSI_CPU,
-	NR_PSI_RESOURCES,
+	NR_PSI_RESOURCES = 3,
 };
 
 /*
@@ -41,7 +41,7 @@ enum psi_states {
 	PSI_CPU_SOME,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES,
+	NR_PSI_STATES = 6,
 };
 
 struct psi_group_cpu {
@@ -53,6 +53,9 @@ struct psi_group_cpu {
 	/* States of the tasks belonging to this group */
 	unsigned int tasks[NR_PSI_TASK_COUNTS];
 
+	/* Aggregate pressure state derived from the tasks */
+	u32 state_mask;
+
 	/* Period time sampling buckets for each state of interest (ns) */
 	u32 times[NR_PSI_STATES];
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 0e97ca9306ef..22c1505ad290 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -213,17 +213,17 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 static void get_recent_times(struct psi_group *group, int cpu, u32 *times)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
-	unsigned int tasks[NR_PSI_TASK_COUNTS];
 	u64 now, state_start;
+	enum psi_states s;
 	unsigned int seq;
-	int s;
+	u32 state_mask;
 
 	/* Snapshot a coherent view of the CPU state */
 	do {
 		seq = read_seqcount_begin(&groupc->seq);
 		now = cpu_clock(cpu);
 		memcpy(times, groupc->times, sizeof(groupc->times));
-		memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
+		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
 	} while (read_seqcount_retry(&groupc->seq, seq));
 
@@ -239,7 +239,7 @@ static void get_recent_times(struct psi_group *group, int cpu, u32 *times)
 		 * (u32) and our reported pressure close to what's
 		 * actually happening.
 		 */
-		if (test_state(tasks, s))
+		if (state_mask & (1 << s))
 			times[s] += now - state_start;
 
 		delta = times[s] - groupc->times_prev[s];
@@ -407,15 +407,15 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 	delta = now - groupc->state_start;
 	groupc->state_start = now;
 
-	if (test_state(groupc->tasks, PSI_IO_SOME)) {
+	if (groupc->state_mask & (1 << PSI_IO_SOME)) {
 		groupc->times[PSI_IO_SOME] += delta;
-		if (test_state(groupc->tasks, PSI_IO_FULL))
+		if (groupc->state_mask & (1 << PSI_IO_FULL))
 			groupc->times[PSI_IO_FULL] += delta;
 	}
 
-	if (test_state(groupc->tasks, PSI_MEM_SOME)) {
+	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
 		groupc->times[PSI_MEM_SOME] += delta;
-		if (test_state(groupc->tasks, PSI_MEM_FULL))
+		if (groupc->state_mask & (1 << PSI_MEM_FULL))
 			groupc->times[PSI_MEM_FULL] += delta;
 		else if (memstall_tick) {
 			u32 sample;
@@ -436,10 +436,10 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		}
 	}
 
-	if (test_state(groupc->tasks, PSI_CPU_SOME))
+	if (groupc->state_mask & (1 << PSI_CPU_SOME))
 		groupc->times[PSI_CPU_SOME] += delta;
 
-	if (test_state(groupc->tasks, PSI_NONIDLE))
+	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
@@ -448,6 +448,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
+	enum psi_states s;
+	u32 state_mask = 0;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
@@ -480,6 +482,13 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (set & (1 << t))
 			groupc->tasks[t]++;
 
+	/* Calculate state mask representing active states */
+	for (s = 0; s < NR_PSI_STATES; s++) {
+		if (test_state(groupc->tasks, s))
+			state_mask |= (1 << s);
+	}
+	groupc->state_mask = state_mask;
+
 	write_seqcount_end(&groupc->seq);
 }
 
-- 
2.21.0.360.g471c308f928-goog

