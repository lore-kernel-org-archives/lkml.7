Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA22E21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgcXTTyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKHQfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:35:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38413 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:35:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so6859989wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9cms0DYa5CNrGM/YF0dAbn+5l9BfZqEAJt0kdQn5DQ4=;
        b=PgcXTTyVTk3IrLSJbMiRaeQRkItY4eI7BYnKomoqh0tAgZa6RbjIbg5UyY5t5VqFvq
         FSBEtbNVF3jWyYkDXdeBDRCq9P/ncTNbYL3KbT9+RD1AquOyxUESqUIed5uH/kK+e/J+
         EiO/uzngN4bRaxs2AUt5SoJSqDvp3KX1zBipRGPIpjLCs5spQ+h8j7QEwAsBSKdCG5Dq
         WuEGS8GAgcCKKwJLQk+gY+pfzreU3MKOMaK6gymTvWSdl/X7HYeHX331Ws9JX0KPp5zn
         IRFrfy4DOfNfjAT556aBrwgFTIzh2hMrn4/XVLAjbjWJ/q40/WzalWZQE2ZX9zEbpdIN
         iOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9cms0DYa5CNrGM/YF0dAbn+5l9BfZqEAJt0kdQn5DQ4=;
        b=t0XUV/G3RdIfDO3W6fLDxrq3SX73+ucwC9W28SR3wILl5xYAwXz0Ia0yCGEEnMfUvR
         P6b0n7vFMoE3iR1QJpbC/yse4+fIakOuKPL2Ab+8WcLI/oF/zCGVZygz7PYgNuUgwU5U
         tbDw1wZc7GGjbUVwhLpJy03HtWYA5odwPGLScrClK+3OdEBvNMTLgnI8lnkM+K3KJvAh
         Go4TEGZG+AiE6yctJVdR1VJpmEZy11qO9W4CcrxUuCLZ/yjXOI9fXghR3v6KmRbJnaEM
         iSqe/OVMIDHWAp1lG2wF2rwi4fEd1YMCxnCVE98LCt5kOpDppxGNLL5qOGzUpOlI1J/G
         NcKg==
X-Gm-Message-State: APjAAAX693x/fSyP5V0/txVv2tH5HECO4lijbS9qehB+NIkxIItO8LbG
        I1C4fZRPGqC/GWLMndwSRTNVfQ==
X-Google-Smtp-Source: APXvYqxg62CuvFx0yznMon/9cal09d9WVyIfO2Nwkdg4QqX+ZrYvFzEq/96/fMjH2qwHf/bEhIaZrA==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr9607593wme.92.1573230904957;
        Fri, 08 Nov 2019 08:35:04 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:2c7f:4532:a254:2b46])
        by smtp.gmail.com with ESMTPSA id u16sm6597095wrr.65.2019.11.08.08.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 08:35:03 -0800 (PST)
Date:   Fri, 8 Nov 2019 17:35:01 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
Message-ID: <20191108163501.GA26528@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net>
 <CAKfTPtB_6kBq69E=-YFuon6fg21CxHneMpncpbLcPGk6uoVcMQ@mail.gmail.com>
 <20191031101544.GP3016@techsingularity.net>
 <CAKfTPtByO7oLQZxF_+-FxZ9u1JhO24-rujW3j-QDqr+PFDOQ=Q@mail.gmail.com>
 <20191031114020.GQ3016@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191031114020.GQ3016@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thursday 31 Oct 2019 à 11:40:20 (+0000), Mel Gorman a écrit :
> On Thu, Oct 31, 2019 at 12:13:09PM +0100, Vincent Guittot wrote:
> > > > > On the last one, spreading tasks evenly across NUMA domains is not
> > > > > necessarily a good idea. If I have 2 tasks running on a 2-socket machine
> > > > > with 24 logical CPUs per socket, it should not automatically mean that
> > > > > one task should move cross-node and I have definitely observed this
> > > > > happening. It's probably bad in terms of locality no matter what but it's
> > > > > especially bad if the 2 tasks happened to be communicating because then
> > > > > load balancing will pull apart the tasks while wake_affine will push
> > > > > them together (and potentially NUMA balancing as well). Note that this
> > > > > also applies for some IO workloads because, depending on the filesystem,
> > > > > the task may be communicating with workqueues (XFS) or a kernel thread
> > > > > (ext4 with jbd2).
> > > >
> > > > This rework doesn't touch the NUMA_BALANCING part and NUMA balancing
> > > > still gives guidances with fbq_classify_group/queue.
> > >
> > > I know the NUMA_BALANCING part is not touched, I'm talking about load
> > > balancing across SD_NUMA domains which happens independently of
> > > NUMA_BALANCING. In fact, there is logic in NUMA_BALANCING that tries to
> > > override the load balancer when it moves tasks away from the preferred
> > > node.
> > 
> > Yes. this patchset relies on this override for now to prevent moving task away.
> 
> Fair enough, netperf hits the corner case where it does not work but
> that is also true without your series.

I run mmtest/netperf test on my setup. It's a mix of small positive or
negative differences (see below)

netperf-udp
                                    5.3-rc2                5.3-rc2
								        tip               +rwk+fix
Hmean     send-64          95.06 (   0.00%)       94.12 *  -0.99%*
Hmean     send-128        191.71 (   0.00%)      189.94 *  -0.93%*
Hmean     send-256        379.05 (   0.00%)      370.96 *  -2.14%*
Hmean     send-1024      1485.24 (   0.00%)     1476.64 *  -0.58%*
Hmean     send-2048      2894.80 (   0.00%)     2887.00 *  -0.27%*
Hmean     send-3312      4580.27 (   0.00%)     4555.91 *  -0.53%*
Hmean     send-4096      5592.99 (   0.00%)     5517.31 *  -1.35%*
Hmean     send-8192      9117.00 (   0.00%)     9497.06 *   4.17%*
Hmean     send-16384    15824.59 (   0.00%)    15824.30 *  -0.00%*
Hmean     recv-64          95.06 (   0.00%)       94.08 *  -1.04%*
Hmean     recv-128        191.68 (   0.00%)      189.89 *  -0.93%*
Hmean     recv-256        378.94 (   0.00%)      370.87 *  -2.13%*
Hmean     recv-1024      1485.24 (   0.00%)     1476.20 *  -0.61%*
Hmean     recv-2048      2893.52 (   0.00%)     2885.25 *  -0.29%*
Hmean     recv-3312      4580.27 (   0.00%)     4553.48 *  -0.58%*
Hmean     recv-4096      5592.99 (   0.00%)     5517.27 *  -1.35%*
Hmean     recv-8192      9115.69 (   0.00%)     9495.69 *   4.17%*
Hmean     recv-16384    15824.36 (   0.00%)    15818.36 *  -0.04%*
Stddev    send-64           0.15 (   0.00%)        1.17 (-688.29%)
Stddev    send-128          1.56 (   0.00%)        1.15 (  25.96%)
Stddev    send-256          4.20 (   0.00%)        5.27 ( -25.63%)
Stddev    send-1024        20.11 (   0.00%)        5.68 (  71.74%)
Stddev    send-2048        11.06 (   0.00%)       21.74 ( -96.50%)
Stddev    send-3312        61.10 (   0.00%)       48.03 (  21.39%)
Stddev    send-4096        71.84 (   0.00%)       31.99 (  55.46%)
Stddev    send-8192       165.14 (   0.00%)      159.99 (   3.12%)
Stddev    send-16384       81.30 (   0.00%)      188.65 (-132.05%)
Stddev    recv-64           0.15 (   0.00%)        1.15 (-673.42%)
Stddev    recv-128          1.58 (   0.00%)        1.14 (  28.27%)
Stddev    recv-256          4.29 (   0.00%)        5.19 ( -21.05%)
Stddev    recv-1024        20.11 (   0.00%)        5.70 (  71.67%)
Stddev    recv-2048        10.43 (   0.00%)       21.41 (-105.22%)
Stddev    recv-3312        61.10 (   0.00%)       46.92 (  23.20%)
Stddev    recv-4096        71.84 (   0.00%)       31.97 (  55.50%)
Stddev    recv-8192       163.90 (   0.00%)      160.88 (   1.84%)
Stddev    recv-16384       81.41 (   0.00%)      187.01 (-129.71%)

                     5.3-rc2     5.3-rc2
                         tip    +rwk+fix
Duration User          38.90       39.13
Duration System      1311.29     1311.10
Duration Elapsed     1892.82     1892.86
 
netperf-tcp
                               5.3-rc2                5.3-rc2
                                   tip               +rwk+fix
Hmean     64         871.30 (   0.00%)      860.90 *  -1.19%*
Hmean     128       1689.39 (   0.00%)     1679.31 *  -0.60%*
Hmean     256       3199.59 (   0.00%)     3241.98 *   1.32%*
Hmean     1024      9390.47 (   0.00%)     9268.47 *  -1.30%*
Hmean     2048     13373.95 (   0.00%)    13395.61 *   0.16%*
Hmean     3312     16701.30 (   0.00%)    17165.96 *   2.78%*
Hmean     4096     15831.03 (   0.00%)    15544.66 *  -1.81%*
Hmean     8192     19720.01 (   0.00%)    20188.60 *   2.38%*
Hmean     16384    23925.90 (   0.00%)    23914.50 *  -0.05%*
Stddev    64           7.38 (   0.00%)        4.23 (  42.67%)
Stddev    128         11.62 (   0.00%)       10.13 (  12.85%)
Stddev    256         34.33 (   0.00%)        7.94 (  76.88%)
Stddev    1024        35.61 (   0.00%)      116.34 (-226.66%)
Stddev    2048       285.30 (   0.00%)       80.50 (  71.78%)
Stddev    3312       304.74 (   0.00%)      449.08 ( -47.36%)
Stddev    4096       668.11 (   0.00%)      569.30 (  14.79%)
Stddev    8192       733.23 (   0.00%)      944.38 ( -28.80%)
Stddev    16384      553.03 (   0.00%)      299.44 (  45.86%)

                     5.3-rc2     5.3-rc2
                         tip    +rwk+fix
Duration User         138.05      140.95
Duration System      1210.60     1208.45
Duration Elapsed     1352.86     1352.90


> 
> > I agree that additional patches are probably needed to improve load
> > balance at NUMA level and I expect that this rework will make it
> > simpler to add.
> > I just wanted to get the output of some real use cases before defining
> > more numa level specific conditions. Some want to spread on there numa
> > nodes but other want to keep everything together. The preferred node
> > and fbq_classify_group was the only sensible metrics to me when he
> > wrote this patchset but changes can be added if they make sense.
> > 
> 
> That's fair. While it was possible to address the case before your
> series, it was a hatchet job. If the changelog simply notes that some
> special casing may still be required for SD_NUMA but it's outside the
> scope of the series, then I'd be happy. At least there is a good chance
> then if there is follow-up work that it won't be interpreted as an
> attempt to reintroduce hacky heuristics.
>

Would the additional comment make sense for you about work to be done
for SD_NUMA ?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ad4b21..7e4cb65 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6960,11 +6960,34 @@ enum fbq_type { regular, remote, all };
  * group. see update_sd_pick_busiest().
  */
 enum group_type {
+	/*
+	 * The group has spare capacity that can be used to process more work.
+	 */
 	group_has_spare = 0,
+	/*
+	 * The group is fully used and the tasks don't compete for more CPU
+	 * cycles. Nevetheless, some tasks might wait before running.
+	 */
 	group_fully_busy,
+	/*
+	 * One task doesn't fit with CPU's capacity and must be migrated on a
+	 * more powerful CPU.
+	 */
 	group_misfit_task,
+	/*
+	 * One local CPU with higher capacity is available and task should be
+	 * migrated on it instead on current CPU.
+	 */
 	group_asym_packing,
+	/*
+	 * The tasks affinity prevents the scheduler to balance the load across
+	 * the system.
+	 */
 	group_imbalanced,
+	/*
+	 * The CPU is overloaded and can't provide expected CPU cycles to all
+	 * tasks.
+	 */
 	group_overloaded
 };
 
@@ -8563,7 +8586,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 	/*
 	 * Try to use spare capacity of local group without overloading it or
-	 * emptying busiest
+	 * emptying busiest.
+	 * XXX Spreading tasks across numa nodes is not always the best policy
+	 * and special cares should be taken for SD_NUMA domain level before
+	 * spreading the tasks. For now, load_balance() fully relies on
+	 * NUMA_BALANCING and fbq_classify_group/rq to overide the decision.
 	 */
 	if (local->group_type == group_has_spare) {
 		if (busiest->group_type > group_fully_busy) {
-- 
2.7.4

> 
> > >
> > > > But the latter could also take advantage of the new type of group. For
> > > > example, what I did in the fix for find_idlest_group : checking
> > > > numa_preferred_nid when the group has capacity and keep the task on
> > > > preferred node if possible. Similar behavior could also be beneficial
> > > > in periodic load_balance case.
> > > >
> > >
> > > And this is the catch -- numa_preferred_nid is not guaranteed to be set at
> > > all. NUMA balancing might be disabled, the task may not have been running
> > > long enough to pick a preferred NID or NUMA balancing might be unable to
> > > pick a preferred NID. The decision to avoid unnecessary migrations across
> > > NUMA domains should be made independently of NUMA balancing. The netperf
> > > configuration from mmtests is great at illustrating the point because it'll
> > > also say what the average local/remote access ratio is. 2 communicating
> > > tasks running on an otherwise idle NUMA machine should not have the load
> > > balancer move the server to one node and the client to another.
> > 
> > I'm going to make it a try on my setup to see the results
> > 
> 
> Thanks.
> 
> -- 
> Mel Gorman
> SUSE Labs
