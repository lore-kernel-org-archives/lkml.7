Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11293C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E481320836
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfKYRdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:33:25 -0500
Received: from foss.arm.com ([217.140.110.172]:53248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfKYRdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:33:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BADE831B;
        Mon, 25 Nov 2019 09:33:23 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F7E93F68E;
        Mon, 25 Nov 2019 09:33:22 -0800 (PST)
Subject: Re: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity"
 checks
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, morten.rasmussen@arm.com
References: <20191120175533.4672-1-valentin.schneider@arm.com>
 <20191120175533.4672-4-valentin.schneider@arm.com>
 <20191124222051.kbb62phfsln5ixg4@e107158-lin.cambridge.arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c76d2b10-c4a8-465e-9310-030efe75a64e@arm.com>
Date:   Mon, 25 Nov 2019 17:33:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191124222051.kbb62phfsln5ixg4@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2019 22:20, Qais Yousef wrote:
> On 11/20/19 17:55, Valentin Schneider wrote:
>> +static inline
>> +unsigned long uclamp_task_util(struct task_struct *p, unsigned long util)
>> +{
>> +	return clamp(util,
>> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MIN),
>> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MAX));
>> +}
> 
> uclamp_eff_value() will check if a task belongs to a cgroup, and if it does
> apply its uclamp. The funny thing about the cgroup settings is that they can
> have a uclamp_max < uclamp_min. uclamp_util_with() does check for this
> condition but this function doesn't.
> 

So according to comments, uclamp_util_with() has to check for inversion
because it is comparing task clamps with rq-wide aggregated clamps.

However I have to admit I still am not clear as to how a clamp inversion
can occur. Without cgroups, it all goes through

  __sched_setscheduler() -> uclamp_validate()

which enforces uclamp.min <= uclamp.max. So the rq-wide aggregation could
not lead to an inversion.

With cgroups, I do recall something about allowing the cgroup *knobs* to be
inverted, but AFAICT that gets sanitized when it trickles down to the
scheduler via cpu_util_update_eff():

    eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);

So I don't see how inversion could happen within uclamp_task_util().
Patrick, any chance you could light up my torch?

FWIW I gave this a spin but couldn't create an inversion inside the
scheduler (debug prints appended at the end):

  $ cgcreate -g cpu:cgtest

  $ ./loop.sh &
  $ PID=$!

  $ echo $PID > /sys/fs/cgroup/cpu/cgtest/cgroup.procs

  $ echo 20 > /sys/fs/cgroup/cpu/cgtest/cpu.uclamp.max
  [   24.442204] tg=00000000b546653d clamp_id=1 value=205
  [   24.447169] css=00000000b546653d uclamp.min=0 uclamp.max=205
  [   24.452932] p=loop.sh tg.uclamp.min=0 tg.uclamp.max=205 p.uclamp.min=0 p.uclamp.max=1024
  [   24.461021] p=loop.sh uclamp.min=0 uclamp.max=205

  $ echo 80 > /sys/fs/cgroup/cpu/cgtest/cpu.uclamp.min
  [   25.472174] tg=00000000b546653d clamp_id=0 value=819
  [   25.477135] css=00000000b546653d uclamp.min=205 uclamp.max=205
  [   25.483066] p=loop.sh tg.uclamp.min=205 tg.uclamp.max=205 p.uclamp.min=0 p.uclamp.max=1024
  [   25.491311] p=loop.sh uclamp.min=205 uclamp.max=205

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2da6a005bb3f..7b31fdc7cc90 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1088,6 +1088,17 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 			if ((0x1 << clamp_id) & clamps)
 				uclamp_update_active(p, clamp_id);
 		}
+		pr_info("p=%s tg.uclamp.min=%u tg.uclamp.max=%u "
+			"p.uclamp.min=%u p.uclamp.max=%u\n",
+			p->comm, task_group(p)->uclamp[UCLAMP_MIN].value,
+			task_group(p)->uclamp[UCLAMP_MAX].value,
+			p->uclamp_req[UCLAMP_MIN].value,
+			p->uclamp_req[UCLAMP_MAX].value);
+
+
+		pr_info("p=%s uclamp.min=%u uclamp.max=%u\n",
+			p->comm, uclamp_tg_restrict(p, UCLAMP_MIN).value,
+			uclamp_tg_restrict(p, UCLAMP_MAX).value);
 	}
 	css_task_iter_end(&it);
 }
@@ -7195,6 +7206,8 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 		/* Ensure protection is always capped by limit */
 		eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
 
+		pr_info("css=%p uclamp.min=%i uclamp.max=%i\n", css, eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
+
 		/* Propagate most restrictive effective clamps */
 		clamps = 0x0;
 		uc_se = css_tg(css)->uclamp;
@@ -7273,8 +7286,10 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	rcu_read_lock();
 
 	tg = css_tg(of_css(of));
-	if (tg->uclamp_req[clamp_id].value != req.util)
+	if (tg->uclamp_req[clamp_id].value != req.util) {
+		pr_info("tg=%p clamp_id=%i value=%llu\n", tg, clamp_id, req.util);
 		uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false);
+	}
 
 	/*
 	 * Because of not recoverable conversion rounding we keep track of the



