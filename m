Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB63214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfEHG0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:26:21 -0400
Received: from mail.sssup.it ([193.205.80.98]:29721 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfEHG0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:26:21 -0400
Received: from [195.57.117.251] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138914029; Wed, 08 May 2019 08:26:18 +0200
Date:   Wed, 8 May 2019 08:26:05 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 6/6] sched/dl: Try not to select a too fast core
Message-ID: <20190508082605.623ed4d5@nowhere>
In-Reply-To: <20190507155732.7ravrnld54rb6k5a@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
        <20190506044836.2914-7-luca.abeni@santannapisa.it>
        <20190507155732.7ravrnld54rb6k5a@queper01-lin>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, 7 May 2019 16:57:34 +0100
Quentin Perret <quentin.perret@arm.com> wrote:

> On Monday 06 May 2019 at 06:48:36 (+0200), Luca Abeni wrote:
> > From: luca abeni <luca.abeni@santannapisa.it>
> > 
> > When a task can fit on multiple CPU cores, try to select the slowest
> > core that is able to properly serve the task. This avoids useless
> > future migrations, leaving the "fast cores" idle for more
> > heavyweight tasks.  
> 
> But only if the _current_ capacity of big CPUs (at the current freq)
> is higher than the current capacity of the littles, is that right ?
> So we don't really have a guarantee to pack small tasks on little
> cores ...

Yes, the capacity is estimated at the current frequency, so this is a
potential problem.


> What is the rationale for looking at the current freq in
> dl_task_fit() ?

Mainly two reasons: the first one is to try to reduce frequency
switches (I did not perform measurements on the hikey960, I remember
that on other CPUs a frequency switch can take a considerable amount of
time).

Then, I wanted to have a mechanism that can work with all the possible
cpufreq governors... So, I did not assume that the frequency can change
(for example, I remember that without considering the current
frequency I had issues when using the "userspace" governor).


Maybe I just do not know this kernel subsystem well enough, but I did
not find any way to know the maximum frequency that the current
governor can set (I mean, I found a "maximum frequency" field that
tells me the maximum frequency that the cpufreq driver can set, but I
do not know if the governor will be able to set it --- again, consider
the "userspace" governor).

If there is a way to know this value, then I can use it for checking if
a task can fit in a core.



			Thanks,
				Luca



> Energy reasons ? If so, I'd argue you should look at
> the energy model to break the tie between CPU candidates ... ;)
> 
> And in the mean time, you could just look at arch_scale_cpu_capacity()
> to check if a task fits ?
> 
> > Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> > ---
> >  kernel/sched/cpudeadline.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> > index 2a4ac7b529b7..897ed71af515 100644
> > --- a/kernel/sched/cpudeadline.c
> > +++ b/kernel/sched/cpudeadline.c
> > @@ -143,17 +143,24 @@ int cpudl_find(struct cpudl *cp, struct
> > task_struct *p, struct cpumask *later_mask)
> >  {
> >  	const struct sched_dl_entity *dl_se = &p->dl;
> > +	struct cpumask tmp_mask;  
> 
> Hmm, these can get pretty big, so not sure about having one on the
> stack ...
> 
> >  
> >  	if (later_mask &&
> > -	    cpumask_and(later_mask, cp->free_cpus,
> > &p->cpus_allowed)) {
> > +	    cpumask_and(&tmp_mask, cp->free_cpus,
> > &p->cpus_allowed)) { int cpu, max_cpu = -1;
> > -		u64 max_cap = 0;
> > +		u64 max_cap = 0, min_cap = SCHED_CAPACITY_SCALE *
> > SCHED_CAPACITY_SCALE; 
> > -		for_each_cpu(cpu, later_mask) {
> > +		cpumask_clear(later_mask);
> > +		for_each_cpu(cpu, &tmp_mask) {
> >  			u64 cap;
> >  
> > -			if (!dl_task_fit(&p->dl, cpu, &cap))
> > -				cpumask_clear_cpu(cpu, later_mask);
> > +			if (dl_task_fit(&p->dl, cpu, &cap) && (cap
> > <= min_cap)) {
> > +				if (cap < min_cap) {
> > +					min_cap = cap;
> > +					cpumask_clear(later_mask);
> > +				}
> > +				cpumask_set_cpu(cpu, later_mask);
> > +			}
> >  
> >  			if (cap > max_cap) {
> >  				max_cap = cap;
> > -- 
> > 2.20.1
> >   
> 
> Thanks,
> Quentin

