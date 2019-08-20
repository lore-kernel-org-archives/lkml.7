Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25572C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AF3214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="iK7u8B7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfHTOQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:16:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42429 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfHTOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:16:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so4593279qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HlnA5cT3MhoLNI4slqKCgpslm+Om/tdvlPyUFbt4pJo=;
        b=iK7u8B7lX8okJIabQspvE76rFRTcLBghvgSdbU77cGp09kyJ/u0B6dqPJfk+N6mWor
         50ldG3KwN2JYHaFsR0S86hTVWo3uy6QPIdWlHjMEz7V2UrroIIFLeFs43rhnrZXL8ZOV
         3nP7TENIcCsrUgeos3TnuDubqVEVhgf7XI4o50Q84Ye+GXNsQ9FUUZ/vjvEA9pwfyiWG
         gDHkUfs2c0gV92qVcdSZborgHKza3d8TxG6z74CjH0kynqdr3ofwOSw1c03KWBWI5tyn
         pLL/SZwyejoI/c+SZcWkuRhsNWY+XysL7iJk19c9G+A3/GJdoPyfOAtFxmB1L/etPsSJ
         yC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HlnA5cT3MhoLNI4slqKCgpslm+Om/tdvlPyUFbt4pJo=;
        b=MlOghrEfgBNPOENsO9MY5Anu2VYqEfcDhtBVY0croPHtQChPtyl4cRapm7k1c/a/rV
         HEwJPPUSVnHrbQ//QTbZOT++T91p8Rsp9NxE4J6h8QgiUt85XEEHGbKh9alKos0H0zrs
         rM/YPwx7U7z6z0Pa8AzMVjj3hB9CL7D9hB7hA0y2nYBIxdr9nQLot8ZhhjuJPHyQ5kYW
         tsPZh1Jkpa8ZTlzxeCMlUmSdaJNqu3+3c8VPOO4hKQL4eB9p6P6+05q2LeS6AvSMKgPA
         1j/a8yFT2kn2JVKZHTHRHpu0eiXhb11fsyBUMHkcK2fvlKCktwjsPYJqn6Q3inEZh6fa
         LSIw==
X-Gm-Message-State: APjAAAX0vMX4zQgi3YU/Ryjz4lMJM5YOJe+gGWKFiuqcmX6xGHUM6uI9
        Si1AWNB03sEHcFBMFsqSgRCPs3VYPYI=
X-Google-Smtp-Source: APXvYqyhCOg43T9k6UY4W+1a8m3D76TKytIXHr2jOJWaBQFbRfgPY/gjc/lIRdo8noDyP7NtFsNLgA==
X-Received: by 2002:a37:71c7:: with SMTP id m190mr26539444qkc.47.1566310581515;
        Tue, 20 Aug 2019 07:16:21 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a2sm8637862qkd.76.2019.08.20.07.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 07:16:20 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, chiluk+linux@indeed.com, pauld@redhat.com,
        bsegall@google.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] sched/fair: fix -Wunused-but-set-variable warnings
Date:   Tue, 20 Aug 2019 10:15:58 -0400
Message-Id: <1566310558-29584-1-git-send-email-cai@lca.pw>
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
 kernel/sched/fair.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84959d3285d1..43d6eb033ca8 100644
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
@@ -4989,15 +4984,12 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
-	u64 overrun;
-
 	lockdep_assert_held(&cfs_b->lock);
 
 	if (cfs_b->period_active)
 		return;
 
 	cfs_b->period_active = 1;
-	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
-- 
1.8.3.1

