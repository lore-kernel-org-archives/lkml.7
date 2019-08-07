Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024FF22297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbfHGQcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:32:03 -0400
Received: from foss.arm.com ([217.140.110.172]:51612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfHGQcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:32:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3056344;
        Wed,  7 Aug 2019 09:32:02 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7A453F694;
        Wed,  7 Aug 2019 09:32:00 -0700 (PDT)
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
Date:   Wed, 7 Aug 2019 18:31:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726161358.056107990@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 4:54 PM, Peter Zijlstra wrote:
> 
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[...]

> @@ -889,6 +891,8 @@ static void update_curr(struct cfs_rq *c
>  		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
>  		cgroup_account_cputime(curtask, delta_exec);
>  		account_group_exec_runtime(curtask, delta_exec);
> +		if (curtask->server)
> +			dl_server_update(curtask->server, delta_exec);
>  	}

I get a lockdep_assert_held(&rq->lock) related warning in start_dl_timer()
when running the full stack.

...
[    0.530216] root domain span: 0-5 (max cpu_capacity = 1024)
[    0.538655] devtmpfs: initialized
[    0.556485] update_curr: rq mismatch rq[0] != rq[4]
[    0.561519] update_curr: rq mismatch rq[0] != rq[4]
[    0.566497] update_curr: rq mismatch rq[0] != rq[4]
[    0.571443] update_curr: rq mismatch rq[0] != rq[4]
[    0.576762] update_curr: rq mismatch rq[2] != rq[4]
[    0.581674] update_curr: rq mismatch rq[2] != rq[4]
[    0.586569] ------------[ cut here ]------------
[    0.591220] WARNING: CPU: 2 PID: 2 at kernel/sched/deadline.c:916 start_dl_timer+0x160/0x178
[    0.599686] Modules linked in:
[    0.602756] CPU: 2 PID: 2 Comm: kthreadd Tainted: G        W         5.3.0-rc3-00013-ga33cf033cc99-dirty #64
[    0.612620] Hardware name: ARM Juno development board (r0) (DT)
[    0.618560] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.623369] pc : start_dl_timer+0x160/0x178
[    0.627572] lr : start_dl_timer+0x160/0x178
[    0.631768] sp : ffff000010013cb0
...
[    0.715075] Call trace:
[    0.717531]  start_dl_timer+0x160/0x178
[    0.721382]  update_curr_dl_se+0x108/0x208
[    0.725494]  dl_server_update+0x2c/0x38
[    0.729348]  update_curr+0x1b4/0x3b8
[    0.732934]  task_tick_fair+0x74/0xa88
[    0.736698]  scheduler_tick+0x94/0x110
[    0.740461]  update_process_times+0x48/0x60
...

Seems to be related to the fact that the rq can change:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4c14851a34c..5e3130a200ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -891,8 +891,17 @@ static void update_curr(struct cfs_rq *cfs_rq)
                trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
                cgroup_account_cputime(curtask, delta_exec);
                account_group_exec_runtime(curtask, delta_exec);
-               if (curtask->server)
+               if (curtask->server) {
+                       struct rq *rq = rq_of(cfs_rq);
+                       struct rq *rq2 = curtask->server->rq;
+
+                       if (rq != rq2) {
+                               printk("update_curr: rq mismatch rq[%d] != rq[%d]\n",
+                                      cpu_of(rq), cpu_of(rq2));
+                       }
+
                        dl_server_update(curtask->server, delta_exec);
+               }
        }

...


