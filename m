Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32795C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CD921924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389750AbfISLWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:22:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56387 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389453AbfISLWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:22:21 -0400
X-UUID: 7b0333bfc1d0494c9e342a1840d295ff-20190919
X-UUID: 7b0333bfc1d0494c9e342a1840d295ff-20190919
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 746610841; Thu, 19 Sep 2019 19:22:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 19 Sep 2019 19:22:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 19 Sep 2019 19:22:13 +0800
Message-ID: <1568892135.4892.10.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] sched/rt: avoid contend with CFS task
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 19 Sep 2019 19:22:15 +0800
In-Reply-To: <CAKfTPtC3txstND=6YkWBJ16i06cQ7xueUpD5j-j-UfuSf0-z-g@mail.gmail.com>
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
         <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com>
         <20190830145501.zadfv2ffuu7j46ft@e107158-lin.cambridge.arm.com>
         <1567689999.2389.5.camel@mtkswgap22>
         <CAKfTPtC3txstND=6YkWBJ16i06cQ7xueUpD5j-j-UfuSf0-z-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 16:01 +0200, Vincent Guittot wrote:
> Hi Jing-Ting,
> 
> On Thu, 5 Sep 2019 at 15:26, Jing-Ting Wu <jing-ting.wu@mediatek.com> wrote:
> >
> > On Fri, 2019-08-30 at 15:55 +0100, Qais Yousef wrote:
> > > On 08/29/19 11:38, Valentin Schneider wrote:
> > > > On 29/08/2019 04:15, Jing-Ting Wu wrote:
> > > > > At original linux design, RT & CFS scheduler are independent.
> > > > > Current RT task placement policy will select the first cpu in
> > > > > lowest_mask, even if the first CPU is running a CFS task.
> > > > > This may put RT task to a running cpu and let CFS task runnable.
> > > > >
> > > > > So we select idle cpu in lowest_mask first to avoid preempting
> > > > > CFS task.
> > > > >
> > > >
> > > > Regarding the RT & CFS thing, that's working as intended. RT is a whole
> > > > class above CFS, it shouldn't have to worry about CFS.
> > > >
> > > > On the other side of things, CFS does worry about RT. We have the concept
> > > > of RT-pressure in the CFS scheduler, where RT tasks will reduce a CPU's
> > > > capacity (see fair.c::scale_rt_capacity()).
> > > >
> > > > CPU capacity is looked at on CFS wakeup (see wake_cap() and
> > > > find_idlest_cpu()), and the periodic load balancer tries to spread load
> > > > over capacity, so it'll tend to put less things on CPUs that are also
> > > > running RT tasks.
> > > >
> > > > If RT were to start avoiding rqs with CFS tasks, we'd end up with a nasty
> > > > situation were both are avoiding each other. It's even more striking when
> > > > you see that RT pressure is done with a rq-wide RT util_avg, which
> > > > *doesn't* get migrated when a RT task migrates. So if you decide to move
> > > > a RT task to an idle CPU "B" because CPU "A" had runnable CFS tasks, the
> > > > CFS scheduler will keep seeing CPU "B" as not significantly RT-pressured
> > > > while that util_avg signal ramps up, whereas it would correctly see CPU
> > > > "A" as RT-pressured if the RT task previously ran there.
> > > >
> > > > So overall I think this is the wrong approach.
> > >
> > > I like the idea, but yeah tend to agree the current approach might not be
> > > enough.
> > >
> > > I think the major problem here is that on generic systems where CFS is a first
> > > class citizen, RT tasks can be hostile to them - not always necessarily for a
> > > good reason.
> > >
> > > To further complicate the matter, even among CFS tasks we can't tell which are
> > > more important than the others - though hopefully latency-nice proposal will
> > > make the situation better.
> > >
> > > So I agree we have a problem here, but I think this patch is just a temporary
> > > band aid and we need to do better. Though I have no concrete suggestion yet on
> > > how to do that.
> > >
> > > Another thing I couldn't quantify yet how common and how severe this problem is
> > > yet. Jing-Ting, if you can share the details of your use case that'd be great.
> > >
> > > Cheers
> > >
> > > --
> > > Qais Yousef
> >
> >
> > I agree that the nasty situation will happen.The current approach and this patch might not be enough.
> 
> RT task should not harm its cache hotness and responsiveness for the
> benefit of a CFS task
> 

Yes, it’s a good point to both consider cache hotness. We have revised
the implementation to select a better idle CPU in the same sched_domain
of prev_cpu (with the same cache hotness) when the RT task wakeup.

I modify the code of find_lowest_rq as following:
@@ -1648,6 +1629,9 @@ static int find_lowest_rq(struct task_struct
*task)
        struct cpumask *lowest_mask =
this_cpu_cpumask_var_ptr(local_cpu_mask);
        int this_cpu = smp_processor_id();
        int cpu      = task_cpu(task);
+       int i;
+       struct rq *prev_rq = cpu_rq(cpu);
+       struct sched_domain *prev_sd;

        /* Make sure the mask is initialized first */
        if (unlikely(!lowest_mask))
@@ -1659,6 +1643,24 @@ static int find_lowest_rq(struct task_struct
*task)
        if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask))
                return -1; /* No targets found */

+       /* Choose previous cpu if it is idle and it fits lowest_mask */
+       if (cpumask_test_cpu(cpu, lowest_mask) && idle_cpu(cpu))
+               return cpu;
+
+       rcu_read_lock();
+       prev_sd = rcu_dereference(prev_rq->sd);
+
+       if (prev_sd) {
+               /* Choose idle_cpu among lowest_mask and it is closest
to our hot cache data */
+               for_each_cpu(i, lowest_mask) {
+                       if (idle_cpu(i) && cpumask_test_cpu(i,
sched_domain_span(prev_sd))) {
+                               rcu_read_unlock();
+                               return i;
+                       }
+               }
+       }
+       rcu_read_unlock();
+
        /*
         * At this point we have built a mask of CPUs representing the
         * lowest priority tasks in the system.  Now we want to elect



> > But for requirement of performance, I think it is better to differentiate between idle CPU and CPU has CFS task.
> >
> > For example, we use rt-app to evaluate runnable time on non-patched environment.
> > There are (NR_CPUS-1) heavy CFS tasks and 1 RT Task. When a CFS task is running, the RT task wakes up and choose the same CPU.
> > The CFS task will be preempted and keep runnable until it is migrated to another cpu by load balance.
> > But load balance is not triggered immediately, it will be triggered until timer tick hits with some condition satisfied(ex. rq->next_balance).
> 
> Yes you will have to wait for the next tick that will trigger an idle
> load balance because you have an idle cpu and 2 runnable tack (1 RT +
> 1CFS) on the same CPU. But you should not wait for more than  1 tick
> 
> The current load_balance doesn't handle correctly the situation of 1
> CFS and 1 RT task on same CPU while 1 CPU is idle. There is a rework
> of the load_balance that is under review on the mailing list that
> fixes this problem and your CFS task should migrate to the idle CPU
> faster than now
> 

Period load balance should be triggered when current jiffies is behind
rq->next_balance, but rq->next_balance is not often exactly the same
with next tick. 
If cpu_busy, interval = sd->balance_interval * sd->busy_factor, and
interval is clamped by 1 to max_load_balance_interval.
By experiment, in a system with HZ=250, available_cpus = 8, the
max_load_balance_interval = HZ * available_cpus / 10 = 250 * 8 / 10 =
200 jiffies,
It would let rq->next_balance = sd->last_balance + interval, the maximum
interval = 200 jiffies, result in more than 1 sched-tick to migrate a
CFS task.



> > CFS tasks may be runnable for a long time. In this test case, it increase 332.091 ms runnable time for CFS task.
> >
> > The detailed log is shown as following, CFS task(thread1-6580) is preempted by RT task(thread0-6674) about 332ms:
> 
> 332ms is quite long and is probably not an idle load blanace but a
> busy load balance
> 
> > thread1-6580  [003] dnh2    94.452898: sched_wakeup: comm=thread0 pid=6674 prio=89 target_cpu=003
> > thread1-6580  [003] d..2    94.452916: sched_switch: prev_comm=thread1 prev_pid=6580 prev_prio=120 prev_state=R ==> next_comm=thread0 next_pid=6674 next_prio=89
> > .... 332.091ms
> > krtatm-1930  [001] d..2    94.785007: sched_migrate_task: comm=thread1 pid=6580 prio=120 orig_cpu=3 dest_cpu=1
> > krtatm-1930  [001] d..2    94.785020: sched_switch: prev_comm=krtatm prev_pid=1930 prev_prio=100 prev_state=S ==> next_comm=thread1 next_pid=6580 next_prio=120
> 
> your CFS task has not moved on the idle CPU but has replaced another task
> 

I think it is minor and reasonable, because CPU1 has triggered idle
balance (when krtatm task is the last task leaving CPU1) to pull the
thread1-6580.



Best regards,
Jing-Ting Wu

> Regards,
> Vincent
> >
> > So I think choose idle CPU at RT wake up flow could reduce the CFS runnable time.
> >
> >
> > Best regards,
> > Jing-Ting Wu
> >
> >


