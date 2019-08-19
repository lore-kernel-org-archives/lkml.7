Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FDEC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708D022CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfHSReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:34:17 -0400
Received: from foss.arm.com ([217.140.110.172]:57838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfHSReR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EA4A360;
        Mon, 19 Aug 2019 10:34:16 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351333F246;
        Mon, 19 Aug 2019 10:34:15 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Liangyan <liangyan.peng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com, pjt@google.com
References: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
 <2994a6ee-9238-5285-3227-cb7084a834c8@arm.com>
 <7C1833A8-27A4-4755-9B1E-335C20207A66@linux.alibaba.com>
 <39d1affb-9cfa-208d-8bf4-f4c802e8c7f9@arm.com>
 <c8ababc5-cb9e-58ba-2969-1e061bb564c8@arm.com>
 <02BC41EE-6653-4473-91D4-CDEE53D8703D@linux.alibaba.com>
 <ce1b05b1-d4d3-140e-b611-0482fa9fd3f5@arm.com>
Message-ID: <0004fb54-cdee-2197-1cbf-6e2111d39ed9@arm.com>
Date:   Mon, 19 Aug 2019 18:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ce1b05b1-d4d3-140e-b611-0482fa9fd3f5@arm.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2019 18:19, Valentin Schneider wrote:
[...]
> Yeah it's probably pretty stupid. IIRC throttled cfs_rq means frozen
> rq_clock, so any subsequent call to update_curr() on a throttled cfs_rq
> should lead to an early bailout anyway due to delta_exec <= 0.
> 

Did some more tracing, seems like the issue is we can make
->runtime_remaining positive in assign_cfs_rq_runtime() but not mark the
cfs_rq as unthrottled.

So AFAICT we'd need something like this:

-----8<-----
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1054d2cf6aaa..ffbb4dfc4b81 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4385,6 +4385,11 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
 	return rq_clock_task(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
 }
 
+static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
+{
+	return cfs_bandwidth_used() && cfs_rq->throttled;
+}
+
 /* returns 0 on failure to allocate runtime */
 static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
@@ -4411,6 +4416,9 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 
 	cfs_rq->runtime_remaining += amount;
 
+	if (cfs_rq->runtime_remaining > 0 && cfs_rq_throttled(cfs_rq))
+		unthrottle_cfs_rq(cfs_rq);
+
 	return cfs_rq->runtime_remaining > 0;
 }
 
@@ -4439,11 +4447,6 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	__account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
 
-static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
-{
-	return cfs_bandwidth_used() && cfs_rq->throttled;
-}
-
 /* check whether cfs_rq, or any parent, is throttled */
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
----->8-----

Does that make sense? If so we *may* want to add some ->runtime_remaining
wrappers (e.g. {add/remove}_runtime()) and have the check in there to
make sure it's not forgotten.
