Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39728C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160642080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437979AbfITJ7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:59:50 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:43404 "EHLO
        9.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437968AbfITJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:59:49 -0400
Received: from player755.ha.ovh.net (unknown [10.109.160.251])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 75CA311A5A6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:41:32 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id EB407A204CAF;
        Fri, 20 Sep 2019 09:41:19 +0000 (UTC)
Date:   Fri, 20 Sep 2019 11:41:15 +0200
From:   Quentin Perret <qperret@qperret.net>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, rjw@rjwysocki.net,
        morten.rasmussen@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, tkjos@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Speed-up energy-aware wake-ups
Message-ID: <20190920094115.GA11503@qperret.net>
References: <20190912094404.13802-1-qperret@qperret.net>
 <20190920030215.GA20250@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920030215.GA20250@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Ovh-Tracer-Id: 11442520755338894233
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddvgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On Friday 20 Sep 2019 at 08:32:15 (+0530), Pavan Kondeti wrote:
> Earlier, we are not checking the spare capacity for the prev_cpu. Now that the
> continue statement is removed, prev_cpu could also be the max_spare_cap_cpu.
> Actually that makes sense. Because there is no reason why we want to select
> another CPU which has less spare capacity than previous CPU.
> 
> Is this behavior intentional?

The intent was indeed to not compute the energy for another CPU in
prev_cpu's perf domain if prev_cpu is the one with max spare cap -- it
is useless to do so since this other CPU cannot 'beat' prev_cpu and
will never be chosen in the end.

But I did miss that we'd end up computing the energy for prev_cpu
twice ... Harmless but useless. So yeah, let's optimize that case too :)

> When prev_cpu == max_spare_cap_cpu, we are evaluating the energy again for the
> same CPU below. That could have been skipped by returning prev_cpu when
> prev_cpu == max_spare_cap_cpu.

Right, something like the patch below ? My test results are still
looking good with it applied.

Thanks for the careful review,
Quentin
---
From 7b8258287f180a2c383ebe397e8129f5f898ffbe Mon Sep 17 00:00:00 2001
From: Quentin Perret <qperret@qperret.net>
Date: Fri, 20 Sep 2019 09:07:20 +0100
Subject: [PATCH] sched/fair: Avoid redundant EAS calculation

The EAS wake-up path computes the system energy for several CPU
candidates: the CPU with maximum spare capacity in each performance
domain, and the prev_cpu. However, if prev_cpu also happens to be the
CPU with maximum spare capacity in its performance domain, the energy
calculation is still done twice, unnecessarily.

Add a condition to filter out this corner case before doing the energy
calculation.

Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Quentin Perret <qperret@qperret.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bbf68c3161..7399382bc291 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6412,7 +6412,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		}
 
 		/* Evaluate the energy impact of using this CPU. */
-		if (max_spare_cap_cpu >= 0) {
+		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
 			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
 			cur_delta -= base_energy_pd;
 			if (cur_delta < best_delta) {
-- 
2.22.1

