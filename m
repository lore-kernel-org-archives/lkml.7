Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC39ECA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A327F20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfJaKPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:15:52 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:48285 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfJaKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:15:51 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id A95C81C2095
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:15:46 +0000 (GMT)
Received: (qmail 29669 invoked from network); 31 Oct 2019 10:15:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Oct 2019 10:15:46 -0000
Date:   Thu, 31 Oct 2019 10:15:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Message-ID: <20191031101544.GP3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net>
 <CAKfTPtB_6kBq69E=-YFuon6fg21CxHneMpncpbLcPGk6uoVcMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtB_6kBq69E=-YFuon6fg21CxHneMpncpbLcPGk6uoVcMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:09:17AM +0100, Vincent Guittot wrote:
> On Wed, 30 Oct 2019 at 16:45, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Fri, Oct 18, 2019 at 03:26:31PM +0200, Vincent Guittot wrote:
> > > The load_balance algorithm contains some heuristics which have become
> > > meaningless since the rework of the scheduler's metrics like the
> > > introduction of PELT.
> > >
> > > Furthermore, load is an ill-suited metric for solving certain task
> > > placement imbalance scenarios. For instance, in the presence of idle CPUs,
> > > we should simply try to get at least one task per CPU, whereas the current
> > > load-based algorithm can actually leave idle CPUs alone simply because the
> > > load is somewhat balanced. The current algorithm ends up creating virtual
> > > and meaningless value like the avg_load_per_task or tweaks the state of a
> > > group to make it overloaded whereas it's not, in order to try to migrate
> > > tasks.
> > >
> >
> > I do not think this is necessarily 100% true. With both the previous
> > load-balancing behaviour and the apparent behaviour of this patch, it's
> > still possible to pull two communicating tasks apart and across NUMA
> > domains when utilisation is low. Specifically, a load difference of less
> > than SCHED_CAPACITY_SCALE between NUMA codes can be enough too migrate
> > task to level out load.
> >
> > So, load might be ill-suited for some cases but that does not make it
> > completely useless either.
> 
> I fully agree and we keep using it in some cases.
> The goal is only to not use it when it is obviously the wrong metric to be used
> 

Understood, ideally it's be explicit why each metric (task/util/load)
is used each time for future reference and why it's the best for a given
situation. It's not a requirement for the series as the scheduler does
not have a perfect history of explaining itself.

> >
> > The type of behaviour can be seen by running netperf via mmtests
> > (configuration file configs/config-network-netperf-unbound) on a NUMA
> > machine and noting that the local vs remote NUMA hinting faults are roughly
> > 50%. I had prototyped some fixes around this that took imbalance_pct into
> > account but it was too special-cased and was not a universal win. If
> > I was reviewing my own patch I would have naked it on the "you added a
> > special-case hack into the load balancer for one load". I didn't get back
> > to it before getting cc'd on this series.
> >
> > > load_balance should better qualify the imbalance of the group and clearly
> > > define what has to be moved to fix this imbalance.
> > >
> > > The type of sched_group has been extended to better reflect the type of
> > > imbalance. We now have :
> > >       group_has_spare
> > >       group_fully_busy
> > >       group_misfit_task
> > >       group_asym_packing
> > >       group_imbalanced
> > >       group_overloaded
> > >
> > > Based on the type of sched_group, load_balance now sets what it wants to
> > > move in order to fix the imbalance. It can be some load as before but also
> > > some utilization, a number of task or a type of task:
> > >       migrate_task
> > >       migrate_util
> > >       migrate_load
> > >       migrate_misfit
> > >
> > > This new load_balance algorithm fixes several pending wrong tasks
> > > placement:
> > > - the 1 task per CPU case with asymmetric system
> > > - the case of cfs task preempted by other class
> > > - the case of tasks not evenly spread on groups with spare capacity
> > >
> >
> > On the last one, spreading tasks evenly across NUMA domains is not
> > necessarily a good idea. If I have 2 tasks running on a 2-socket machine
> > with 24 logical CPUs per socket, it should not automatically mean that
> > one task should move cross-node and I have definitely observed this
> > happening. It's probably bad in terms of locality no matter what but it's
> > especially bad if the 2 tasks happened to be communicating because then
> > load balancing will pull apart the tasks while wake_affine will push
> > them together (and potentially NUMA balancing as well). Note that this
> > also applies for some IO workloads because, depending on the filesystem,
> > the task may be communicating with workqueues (XFS) or a kernel thread
> > (ext4 with jbd2).
> 
> This rework doesn't touch the NUMA_BALANCING part and NUMA balancing
> still gives guidances with fbq_classify_group/queue.

I know the NUMA_BALANCING part is not touched, I'm talking about load
balancing across SD_NUMA domains which happens independently of
NUMA_BALANCING. In fact, there is logic in NUMA_BALANCING that tries to
override the load balancer when it moves tasks away from the preferred
node.

> But the latter could also take advantage of the new type of group. For
> example, what I did in the fix for find_idlest_group : checking
> numa_preferred_nid when the group has capacity and keep the task on
> preferred node if possible. Similar behavior could also be beneficial
> in periodic load_balance case.
> 

And this is the catch -- numa_preferred_nid is not guaranteed to be set at
all. NUMA balancing might be disabled, the task may not have been running
long enough to pick a preferred NID or NUMA balancing might be unable to
pick a preferred NID. The decision to avoid unnecessary migrations across
NUMA domains should be made independently of NUMA balancing. The netperf
configuration from mmtests is great at illustrating the point because it'll
also say what the average local/remote access ratio is. 2 communicating
tasks running on an otherwise idle NUMA machine should not have the load
balancer move the server to one node and the client to another.

Historically, we might have accounted for this with imbalance_pct which
makes sense for load and was special cased in some places, but it does
not make sense to use imbalance_pct for nr_running. Either way, I think
balancing across SD_NUMA should have explicit logic to take into account
that there is an additional cost outside of the scheduler when a task
moves cross-node.

Even if it's a case that this series does not tackle the problem now,
it'd be good to leave a TODO comment behind noting that SD_NUMA may need
to be special cased.

> > > @@ -8022,9 +8076,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> > >               /*
> > >                * No need to call idle_cpu() if nr_running is not 0
> > >                */
> > > -             if (!nr_running && idle_cpu(i))
> > > +             if (!nr_running && idle_cpu(i)) {
> > >                       sgs->idle_cpus++;
> > > +                     /* Idle cpu can't have misfit task */
> > > +                     continue;
> > > +             }
> > > +
> > > +             if (local_group)
> > > +                     continue;
> > >
> > > +             /* Check for a misfit task on the cpu */
> > >               if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> > >                   sgs->group_misfit_task_load < rq->misfit_task_load) {
> > >                       sgs->group_misfit_task_load = rq->misfit_task_load;
> >
> > So.... why exactly do we not care about misfit tasks on CPUs in the
> > local group? I'm not saying you're wrong because you have a clear idea
> > on how misfit tasks should be treated but it's very non-obvious just
> > from the code.
> 
> local_group can't do anything with local misfit tasks so it doesn't
> give any additional information compared to overloaded, fully_busy or
> has_spare
> 

Ok, that's very clear and now I'm feeling a bit stupid because I should
have spotted that. It really could do with a comment so somebody else
does not try "fixing" it :(

> > > <SNIP>
> > >
> > > @@ -8079,62 +8154,80 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> > >       if (sgs->group_type < busiest->group_type)
> > >               return false;
> > >
> > > -     if (sgs->avg_load <= busiest->avg_load)
> > > -             return false;
> > > -
> > > -     if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> > > -             goto asym_packing;
> > > -
> > >       /*
> > > -      * Candidate sg has no more than one task per CPU and
> > > -      * has higher per-CPU capacity. Migrating tasks to less
> > > -      * capable CPUs may harm throughput. Maximize throughput,
> > > -      * power/energy consequences are not considered.
> > > +      * The candidate and the current busiest group are the same type of
> > > +      * group. Let check which one is the busiest according to the type.
> > >        */
> > > -     if (sgs->sum_h_nr_running <= sgs->group_weight &&
> > > -         group_smaller_min_cpu_capacity(sds->local, sg))
> > > -             return false;
> > >
> > > -     /*
> > > -      * If we have more than one misfit sg go with the biggest misfit.
> > > -      */
> > > -     if (sgs->group_type == group_misfit_task &&
> > > -         sgs->group_misfit_task_load < busiest->group_misfit_task_load)
> > > +     switch (sgs->group_type) {
> > > +     case group_overloaded:
> > > +             /* Select the overloaded group with highest avg_load. */
> > > +             if (sgs->avg_load <= busiest->avg_load)
> > > +                     return false;
> > > +             break;
> > > +
> > > +     case group_imbalanced:
> > > +             /*
> > > +              * Select the 1st imbalanced group as we don't have any way to
> > > +              * choose one more than another.
> > > +              */
> > >               return false;
> > >
> > > -asym_packing:
> > > -     /* This is the busiest node in its class. */
> > > -     if (!(env->sd->flags & SD_ASYM_PACKING))
> > > -             return true;
> > > +     case group_asym_packing:
> > > +             /* Prefer to move from lowest priority CPU's work */
> > > +             if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> > > +                     return false;
> > > +             break;
> > >
> >
> > Again, I'm not seeing what prevents a !SD_ASYM_PACKING domain checking
> > sched_asym_prefer.
> 
> the test is done when collecting group's statistic in update_sg_lb_stats()
> /* Check if dst cpu is idle and preferred to this group */
> if (env->sd->flags & SD_ASYM_PACKING &&
>     env->idle != CPU_NOT_IDLE &&
>     sgs->sum_h_nr_running &&
>     sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> sgs->group_asym_packing = 1;
> }
> 
> Then the group type group_asym_packing is only set if
> sgs->group_asym_packing has been set
> 

Yeah, sorry. I need to get ASYM_PACKING clearer in my head.

> >
> > > <SNIP>
> > > +     case group_fully_busy:
> > > +             /*
> > > +              * Select the fully busy group with highest avg_load. In
> > > +              * theory, there is no need to pull task from such kind of
> > > +              * group because tasks have all compute capacity that they need
> > > +              * but we can still improve the overall throughput by reducing
> > > +              * contention when accessing shared HW resources.
> > > +              *
> > > +              * XXX for now avg_load is not computed and always 0 so we
> > > +              * select the 1st one.
> > > +              */
> > > +             if (sgs->avg_load <= busiest->avg_load)
> > > +                     return false;
> > > +             break;
> > > +
> >
> > With the exception that if we are balancing between NUMA domains and they
> > were communicating tasks that we've now pulled them apart. That might
> > increase the CPU resources available at the cost of increased remote
> > memory access cost.
> 
> I expect the numa classification to help and skip those runqueue
> 

It might but the "canary in the mine" is netperf. A basic pair should
not be pulled apart.

> > > @@ -8273,69 +8352,149 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> > >   */
> > >  static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
> > >  {
> > > -     unsigned long max_pull, load_above_capacity = ~0UL;
> > >       struct sg_lb_stats *local, *busiest;
> > >
> > >       local = &sds->local_stat;
> > >       busiest = &sds->busiest_stat;
> > >
> > > -     if (busiest->group_asym_packing) {
> > > -             env->imbalance = busiest->group_load;
> > > +     if (busiest->group_type == group_misfit_task) {
> > > +             /* Set imbalance to allow misfit task to be balanced. */
> > > +             env->migration_type = migrate_misfit;
> > > +             env->imbalance = busiest->group_misfit_task_load;
> > > +             return;
> > > +     }
> > > +
> > > +     if (busiest->group_type == group_asym_packing) {
> > > +             /*
> > > +              * In case of asym capacity, we will try to migrate all load to
> > > +              * the preferred CPU.
> > > +              */
> > > +             env->migration_type = migrate_task;
> > > +             env->imbalance = busiest->sum_h_nr_running;
> > > +             return;
> > > +     }
> > > +
> > > +     if (busiest->group_type == group_imbalanced) {
> > > +             /*
> > > +              * In the group_imb case we cannot rely on group-wide averages
> > > +              * to ensure CPU-load equilibrium, try to move any task to fix
> > > +              * the imbalance. The next load balance will take care of
> > > +              * balancing back the system.
> > > +              */
> > > +             env->migration_type = migrate_task;
> > > +             env->imbalance = 1;
> > >               return;
> > >       }
> > >
> > >       /*
> > > -      * Avg load of busiest sg can be less and avg load of local sg can
> > > -      * be greater than avg load across all sgs of sd because avg load
> > > -      * factors in sg capacity and sgs with smaller group_type are
> > > -      * skipped when updating the busiest sg:
> > > +      * Try to use spare capacity of local group without overloading it or
> > > +      * emptying busiest
> > >        */
> > > -     if (busiest->group_type != group_misfit_task &&
> > > -         (busiest->avg_load <= sds->avg_load ||
> > > -          local->avg_load >= sds->avg_load)) {
> > > -             env->imbalance = 0;
> > > +     if (local->group_type == group_has_spare) {
> > > +             if (busiest->group_type > group_fully_busy) {
> > > +                     /*
> > > +                      * If busiest is overloaded, try to fill spare
> > > +                      * capacity. This might end up creating spare capacity
> > > +                      * in busiest or busiest still being overloaded but
> > > +                      * there is no simple way to directly compute the
> > > +                      * amount of load to migrate in order to balance the
> > > +                      * system.
> > > +                      */
> >
> > busiest may not be overloaded, it may be imbalanced. Maybe the
> > distinction is irrelevant though.
> 
> the case busiest->group_type == group_imbalanced has already been
> handled earlier int he function
> 

Bah, of course.

-- 
Mel Gorman
SUSE Labs
