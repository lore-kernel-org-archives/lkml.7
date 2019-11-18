Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7C9C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC0A2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574084104;
	bh=y0rS/NN2jArQkab2Mub7XvAZELe/bGniZfKB43DKdVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yf9pUxP6lqecjZD+XAN7lXJPXt2YymHe81rz3ReIPjTrYZ4XhfHwgaFBL0BoR4nMV
	 Fvgzgf09IinXFBg0qXtBaBk4FtYEKQZSh9HAx7zXQ76Q8P4BjtYBdkXJW/5RgMD4Ka
	 GVmR6uKXSFkhvcoQ0lns2o+fK8K+wuplorPyLPAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKRNfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:35:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41903 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfKRNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:35:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so18065394wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 05:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=io+9BN3faMHxghcWWMcnCh/XRTax+Va6yujBsQsxZF8=;
        b=XomshlEchJVvfUjT0EKC+2aN518pIKtOlA0vIINLz59cSTDOL8fl/Y1CGCJHclfs4O
         CbRkrxHNKV17eDBwKrIuhUHWs5ZMn+YTvcLvMAnX/7cwaDjS5CQ4hyV2uQvzbIEUuF+p
         tRtTcHj1H8Sqo+dQTtVL+ghGwzALd8DsjAEXcGB46nMdXSbxF8qJgvLwbUN20HA2NSe9
         B1OXoUhWKJyYmTpP1pITNFD+vGEcM6lWYBSwLVoe67LHy+j+uYD7IIqPLcaslfAGPwu5
         tntx0sjn1VXd96j3lDGAbWqW7vVzTgm21pRRueFkpE0zJUHo6cicnQAo0CuLe+HHH0sI
         NWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=io+9BN3faMHxghcWWMcnCh/XRTax+Va6yujBsQsxZF8=;
        b=J6R0R2XnZCEcq8SrBzRlTcMQP7IHlyg7SmcN9nSvkEuHhakaoXcjfDWIWuw6ok3FuC
         oTjhyEdZnpW3YuJwaUzbfNxNH/sLxavEe+HHb4cQnka5aHfMf1mG72zqBSIacXtWuGvk
         tbHdp3Tsg/kLbsUtfDR/NchMWDEHb3WNmSwA9muXoi1WZlO208PCCr+cbk6vFfQaSSgb
         KUutuod7FRYKXrG/qdGY/UYllDpjWcVuEjXswBxYcZDAAEkwUP4Heszg/ScvgkcO34Gq
         6yzoyjCd2sU1Hwwv/Skd6HghioxgH+w3hPgrJSVyXkccERw1cVK71h0v6HN+Jav+lzwj
         ziSw==
X-Gm-Message-State: APjAAAUf7haWiJuSHaZcZJEyNO6QUmAxBK+AOn6C1BxSiMos9l/KDcNn
        rwBWcBVDgOFnYzGbGvuCMLY=
X-Google-Smtp-Source: APXvYqzwIkgotPlVkWgcaGjiRsOLeWXBCZxhkRJ8gRrvwtZipQEtMqidNGIwVtWZLUhMGwS6tm+/bg==
X-Received: by 2002:a5d:490b:: with SMTP id x11mr29110620wrq.111.1574084100390;
        Mon, 18 Nov 2019 05:35:00 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 19sm26206787wrc.47.2019.11.18.05.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 05:34:59 -0800 (PST)
Date:   Mon, 18 Nov 2019 14:34:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
        bsegall@google.com
Subject: [PATCH v2] sched/fair: add comments for group_type and balancing at
 SD_NUMA level
Message-ID: <20191118133457.GB66833@gmail.com>
References: <1573570243-1903-1-git-send-email-vincent.guittot@linaro.org>
 <7325dac4-bb26-9fcb-75bc-15b68d35b62d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7325dac4-bb26-9fcb-75bc-15b68d35b62d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> Hi Vincent,
> 
> On 12/11/2019 14:50, Vincent Guittot wrote:
> > Add comments to describe each state of goup_type and to add some details
> > about the load balance at NUMA level.
> > 
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Suggestions/nits below. There's a bit of duplication with existing
> comments (e.g. the nice blob atop sg_imbalanced()), but I think it can't
> hurt to have the few extra lines you're introducing.
> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bfdcaf91b325..ec93ebd02352 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6955,28 +6955,26 @@ enum fbq_type { regular, remote, all };
>   * group. see update_sd_pick_busiest().
>   */
>  enum group_type {
> -	/*
> -	 * The group has spare capacity that can be used to process more work.
> -	 */
> +	/* The group isn't significantly pressured and can be used to process more work */
>  	group_has_spare = 0,
>  	/*
>  	 * The group is fully used and the tasks don't compete for more CPU
> -	 * cycles. Nevetheless, some tasks might wait before running.
> +	 * cycles. Nevertheless, some tasks might wait before running.
>  	 */
>  	group_fully_busy,
>  	/*
> -	 * One task doesn't fit with CPU's capacity and must be migrated on a
> -	 * more powerful CPU.
> +	 * (SD_ASYM_CPUCAPACITY only) One task doesn't fit on its CPU's
> +	 * capacity and must be migrated to a CPU of higher capacity.
>  	 */
>  	group_misfit_task,
>  	/*
> -	 * One local CPU with higher capacity is available and task should be
> -	 * migrated on it instead on current CPU.
> +	 * (SD_ASYM_PACKING only) One local CPU with higher capacity is
> +	 * available and task should be migrated to it.
>  	 */
>  	group_asym_packing,
>  	/*
> -	 * The tasks affinity prevents the scheduler to balance the load across
> -	 * the system.
> +	 * The tasks affinity previously prevented the scheduler from balancing
> +	 * load across the system.
>  	 */
>  	group_imbalanced,

Thanks - I did a few more fixes and updates to the comments, this is how 
it ended up looking like (full patch below):

/*
 * 'group_type' describes the group of CPUs at the moment of load balancing.
 *
 * The enum is ordered by pulling priority, with the group with lowest priority
 * first so the group_type can simply be compared when selecting the busiest
 * group. See update_sd_pick_busiest().
 */
enum group_type {
	/* The group has spare capacity that can be used to run more tasks.  */
	group_has_spare = 0,
	/*
	 * The group is fully used and the tasks don't compete for more CPU
	 * cycles. Nevertheless, some tasks might wait before running.
	 */
	group_fully_busy,
	/*
	 * SD_ASYM_CPUCAPACITY only: One task doesn't fit with CPU's capacity
	 * and must be migrated to a more powerful CPU.
	 */
	group_misfit_task,
	/*
	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
	 * and the task should be migrated to it instead of running on the
	 * current CPU.
	 */
	group_asym_packing,
	/*
	 * The tasks' affinity constraints previously prevented the scheduler
	 * from balancing the load across the system.
	 */
	group_imbalanced,
	/*
	 * The CPU is overloaded and can't provide expected CPU cycles to all
	 * tasks.
	 */
	group_overloaded
};

I also added your Acked-by, which I think was implicit? :)

Thanks,

	Ingo

=====>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 12 Nov 2019 15:50:43 +0100
Subject: [PATCH] sched/fair: Add comments for group_type and balancing at SD_NUMA level

Add comments to describe each state of goup_type and to add some details
about the load balance at NUMA level.

[ Valentin Schneider: Updates to the comments. ]
[ mingo: Other updates to the comments. ]

Reported-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1573570243-1903-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2fc08e7d9cd6..1f93d96dd06b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6980,17 +6980,40 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
 enum fbq_type { regular, remote, all };
 
 /*
- * group_type describes the group of CPUs at the moment of the load balance.
+ * 'group_type' describes the group of CPUs at the moment of load balancing.
+ *
  * The enum is ordered by pulling priority, with the group with lowest priority
- * first so the groupe_type can be simply compared when selecting the busiest
- * group. see update_sd_pick_busiest().
+ * first so the group_type can simply be compared when selecting the busiest
+ * group. See update_sd_pick_busiest().
  */
 enum group_type {
+	/* The group has spare capacity that can be used to run more tasks.  */
 	group_has_spare = 0,
+	/*
+	 * The group is fully used and the tasks don't compete for more CPU
+	 * cycles. Nevertheless, some tasks might wait before running.
+	 */
 	group_fully_busy,
+	/*
+	 * SD_ASYM_CPUCAPACITY only: One task doesn't fit with CPU's capacity
+	 * and must be migrated to a more powerful CPU.
+	 */
 	group_misfit_task,
+	/*
+	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
+	 * and the task should be migrated to it instead of running on the
+	 * current CPU.
+	 */
 	group_asym_packing,
+	/*
+	 * The tasks' affinity constraints previously prevented the scheduler
+	 * from balancing the load across the system.
+	 */
 	group_imbalanced,
+	/*
+	 * The CPU is overloaded and can't provide expected CPU cycles to all
+	 * tasks.
+	 */
 	group_overloaded
 };
 
@@ -8589,7 +8612,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 	/*
 	 * Try to use spare capacity of local group without overloading it or
-	 * emptying busiest
+	 * emptying busiest.
+	 * XXX Spreading tasks across NUMA nodes is not always the best policy
+	 * and special care should be taken for SD_NUMA domain level before
+	 * spreading the tasks. For now, load_balance() fully relies on
+	 * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
 	 */
 	if (local->group_type == group_has_spare) {
 		if (busiest->group_type > group_fully_busy) {

