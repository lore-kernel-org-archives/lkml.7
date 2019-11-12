Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F3CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DA1206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKLRmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:42:47 -0500
Received: from foss.arm.com ([217.140.110.172]:38298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfKLRmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:42:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B61A30E;
        Tue, 12 Nov 2019 09:42:47 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF9143F534;
        Tue, 12 Nov 2019 09:42:45 -0800 (PST)
Subject: Re: [PATCH] sched/fair: add comments for group_type and balancing at
 SD_NUMA level
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de
Cc:     bsegall@google.com
References: <1573570243-1903-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7325dac4-bb26-9fcb-75bc-15b68d35b62d@arm.com>
Date:   Tue, 12 Nov 2019 17:42:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573570243-1903-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 12/11/2019 14:50, Vincent Guittot wrote:
> Add comments to describe each state of goup_type and to add some details
> about the load balance at NUMA level.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Suggestions/nits below. There's a bit of duplication with existing
comments (e.g. the nice blob atop sg_imbalanced()), but I think it can't
hurt to have the few extra lines you're introducing.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfdcaf91b325..ec93ebd02352 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6955,28 +6955,26 @@ enum fbq_type { regular, remote, all };
  * group. see update_sd_pick_busiest().
  */
 enum group_type {
-	/*
-	 * The group has spare capacity that can be used to process more work.
-	 */
+	/* The group isn't significantly pressured and can be used to process more work */
 	group_has_spare = 0,
 	/*
 	 * The group is fully used and the tasks don't compete for more CPU
-	 * cycles. Nevetheless, some tasks might wait before running.
+	 * cycles. Nevertheless, some tasks might wait before running.
 	 */
 	group_fully_busy,
 	/*
-	 * One task doesn't fit with CPU's capacity and must be migrated on a
-	 * more powerful CPU.
+	 * (SD_ASYM_CPUCAPACITY only) One task doesn't fit on its CPU's
+	 * capacity and must be migrated to a CPU of higher capacity.
 	 */
 	group_misfit_task,
 	/*
-	 * One local CPU with higher capacity is available and task should be
-	 * migrated on it instead on current CPU.
+	 * (SD_ASYM_PACKING only) One local CPU with higher capacity is
+	 * available and task should be migrated to it.
 	 */
 	group_asym_packing,
 	/*
-	 * The tasks affinity prevents the scheduler to balance the load across
-	 * the system.
+	 * The tasks affinity previously prevented the scheduler from balancing
+	 * load across the system.
 	 */
 	group_imbalanced,
 	/*
