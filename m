Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3122AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028652087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RS0ZYF2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfHTSlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:41:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38375 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfHTSlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:41:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so7240761qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MG3l9rEXBrKvMk+xD99XUyBz4E+5WGKpJnljJWrHJFA=;
        b=RS0ZYF2OOcsxS3xbjVN2oofRm1fQLY2ZZEhzQiRGgM/pN0Ee2r4O38SjF6zzaBTlPJ
         EQ1WtELiymVeoJkrvRhM0Q7gmSPwlGsWK3a+ipZWxzTYUnvVHRoQiX4pf2Gek89kFgke
         A1quiuCxfg8JDbghwR6mZv73ZZUHNdYPTFxnklbJqmoyKDho5HbVuFwwcIGLhw1sUPVL
         9y6qEun2JDMFjhOmrierWD25dx8XOKHFNi9maHkJaW1dePiV3ff9t0CPuUfFomNT3Bna
         w1QcqvFsY0SecN/1/cgrdIh3P50OEewkE6DJPZe+RbigFty+MNwmoJKr/cMc0NwVm0Y9
         AhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MG3l9rEXBrKvMk+xD99XUyBz4E+5WGKpJnljJWrHJFA=;
        b=io75Bor73CmLQq40q6PjNOeHvBVhA9E2HV/tgv3J7uoGax8RXW67t7RhKiA3pzIrpy
         0lNOynrGycsgy6aweONmcZIbWWiZ3rl4+qtJ2/APWTToPsiIcBzGKmy48Y0tXjwiL3rG
         t8IHg2pIZXdK/XFParKLGjfcxh346NCyfGl2l5ba6S5qQ9dL3snolSJMyFB1A2tmAW+E
         UrG2Qx7/qBoUwMxC09PA0pjPzsmgQjuJ3gq/Rcgd1aTuDguCyYp1kJ/R1dnn7SA+Ev1w
         FhNkmScqWsCe0P8UVtOHwoiEmA5klRAJNql8YZxHtUVtYxzGuChYLqKyaQH8/+q0n/rh
         gTXA==
X-Gm-Message-State: APjAAAUQ+AZYAyy3wBkyee3gUV8JgsPa6opiTw300lXltTPGuQKlIqJl
        D0SH8zwjiG6CVMDBc3FpW3nwiQ==
X-Google-Smtp-Source: APXvYqyXSBqWN+6s7vOjR0TeY4O7IZlOeFslLk8wgzK2uz/NubiPsQLZroUqaoaNhytP6PqhY+ZzpQ==
X-Received: by 2002:ac8:5547:: with SMTP id o7mr27972988qtr.297.1566326472036;
        Tue, 20 Aug 2019 11:41:12 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r4sm10614319qta.93.2019.08.20.11.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:41:11 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     bsegall@google.com, chiluk+linux@indeed.com, pauld@redhat.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable warnings
Date:   Tue, 20 Aug 2019 14:40:55 -0400
Message-Id: <1566326455-8038-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "sched/fair: Fix low cpu usage with high
throttling by removing expiration of cpu-local slices" [1] introduced a
few compilation warnings,

kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
[-Wunused-but-set-variable]
kernel/sched/fair.c: In function 'start_cfs_bandwidth':
kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used
[-Wunused-but-set-variable]

Also, __refill_cfs_bandwidth_runtime() does no longer update the
expiration time, so fix the comments accordingly.

[1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux@indeed.com/

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Keep hrtimer_forward_now() in start_cfs_bandwidth() per Ben.

 kernel/sched/fair.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84959d3285d1..06782491691f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4354,21 +4354,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
 }
 
 /*
- * Replenish runtime according to assigned quota and update expiration time.
- * We use sched_clock_cpu directly instead of rq->clock to avoid adding
- * additional synchronization around rq->lock.
+ * Replenish runtime according to assigned quota. We use sched_clock_cpu
+ * directly instead of rq->clock to avoid adding additional synchronization
+ * around rq->lock.
  *
  * requires cfs_b->lock
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
-	u64 now;
-
-	if (cfs_b->quota == RUNTIME_INF)
-		return;
-
-	now = sched_clock_cpu(smp_processor_id());
-	cfs_b->runtime = cfs_b->quota;
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_b->runtime = cfs_b->quota;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4989,15 +4984,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
-	u64 overrun;
-
 	lockdep_assert_held(&cfs_b->lock);
 
 	if (cfs_b->period_active)
 		return;
 
 	cfs_b->period_active = 1;
-	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
-- 
1.8.3.1

