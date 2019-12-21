Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BECEC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361FB20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLUCUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:20:49 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:63302 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfLUCUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 21:20:49 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id C0A33A4FEBF52BB25959;
        Sat, 21 Dec 2019 10:20:45 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id xBL2KNas037005;
        Sat, 21 Dec 2019 10:20:23 +0800 (GMT-8)
        (envelope-from chen.ying153@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019122110210580-1275864 ;
          Sat, 21 Dec 2019 10:21:05 +0800 
From:   chenying <chen.ying153@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        chenying <chen.ying153@zte.com.cn>
Subject: [PATCH] fix share rt runtime with offline rq
Date:   Sat, 21 Dec 2019 10:20:12 +0800
Message-Id: <1576894812-36688-1-git-send-email-chen.ying153@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-12-21 10:21:05,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-12-21 10:20:29,
        Serialize complete at 2019-12-21 10:20:29
X-MAIL: mse-fl1.zte.com.cn xBL2KNas037005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In my environment,cpu0-11 are online, cpu12-15 are offline, CPU2 is isolated,
sched_rt_runtime_us is 950000,and then bind a rt process with dead loop to CPU2.
We can see that CPU usage on CPU2 reaches 100%,but only one cpu is isolated,
so it can be inferred that CPU2 shares the rt runtime of offline cpu.

/ # cat /sys/devices/system/cpu/online
0-11
/ # cat /sys/devices/system/cpu/offline
12-15
/ # cat /sys/devices/system/cpu/isolated
2
/ # cat /proc/sys/kernel/sched_rt_runtime_us
950000
/ # chrt -p 357
pid 357's current scheduling policy: SCHED_FIFO
pid 357's current scheduling priority: 1

top - 15:52:12 up 4 min,  0 users,  load average: 0.92, 0.41, 0.16
Tasks: 201 total,   2 running, 199 sleeping,   0 stopped,   0 zombie
%Cpu0  :  0.3 us,  0.3 sy,  0.0 ni, 99.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu1  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu2  :100.0 us,  0.0 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu4  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu5  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu6  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu7  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu8  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu9  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu10 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
  357 root      -2   0    4044    172    136 R 100.0  0.0   2:32.99 deadloop
  366 root      20   0   22060   2404   2128 R   0.7  0.0   0:00.06 top
    1 root      20   0    2624     20      0 S   0.0  0.0   0:05.93 init
    2 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kthreadd
    3 root      20   0       0      0      0 S   0.0  0.0   0:00.00 ksoftirqd/0
    4 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0

Signed-off-by: chenying <chen.ying153@zte.com.cn>
---
 kernel/sched/rt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a532558..d20dc86 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -648,8 +648,12 @@ static void do_balance_runtime(struct rt_rq *rt_rq)
 	rt_period = ktime_to_ns(rt_b->rt_period);
 	for_each_cpu(i, rd->span) {
 		struct rt_rq *iter = sched_rt_period_rt_rq(rt_b, i);
+		struct rq *rq = rq_of_rt_rq(iter);
 		s64 diff;
 
+		if (!rq->online)
+			continue;
+
 		if (iter == rt_rq)
 			continue;
 
-- 
2.15.2

