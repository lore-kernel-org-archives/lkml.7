Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B121FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4B021530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfEHISG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:18:06 -0400
Received: from mail.sssup.it ([193.205.80.98]:27196 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHISG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:18:06 -0400
Received: from [83.43.182.198] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138918824; Wed, 08 May 2019 10:18:03 +0200
Date:   Wed, 8 May 2019 10:17:57 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
Message-ID: <20190508101757.1245ab84@nowhere>
In-Reply-To: <20190508080436.GF6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
        <20190506044836.2914-3-luca.abeni@santannapisa.it>
        <20190508080436.GF6551@localhost.localdomain>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 10:04:36 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Hi Luca,
> 
> On 06/05/19 06:48, Luca Abeni wrote:
> > From: luca abeni <luca.abeni@santannapisa.it>
> > 
> > Currently, the SCHED_DEADLINE scheduler uses a global EDF scheduling
> > algorithm, migrating tasks to CPU cores without considering the core
> > capacity and the task utilization. This works well on homogeneous
> > systems (SCHED_DEADLINE tasks are guaranteed to have a bounded
> > tardiness), but presents some issues on heterogeneous systems. For
> > example, a SCHED_DEADLINE task might be migrated on a core that has
> > not enough processing capacity to correctly serve the task (think
> > about a task with runtime 70ms and period 100ms migrated to a core
> > with processing capacity 0.5)
> > 
> > This commit is a first step to address the issue: When a task wakes
> > up or migrates away from a CPU core, the scheduler tries to find an
> > idle core having enough processing capacity to serve the task.
> > 
> > Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> > ---
> >  kernel/sched/cpudeadline.c | 31 +++++++++++++++++++++++++++++--
> >  kernel/sched/deadline.c    |  8 ++++++--
> >  kernel/sched/sched.h       |  7 ++++++-
> >  3 files changed, 41 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> > index 50316455ea66..d21f7905b9c1 100644
> > --- a/kernel/sched/cpudeadline.c
> > +++ b/kernel/sched/cpudeadline.c
> > @@ -110,6 +110,22 @@ static inline int cpudl_maximum(struct cpudl
> > *cp) return cp->elements[0].cpu;
> >  }
> >  
> > +static inline int dl_task_fit(const struct sched_dl_entity *dl_se,
> > +			      int cpu, u64 *c)
> > +{
> > +	u64 cap = (arch_scale_cpu_capacity(NULL, cpu) *
> > arch_scale_freq_capacity(cpu)) >> SCHED_CAPACITY_SHIFT;
> > +	s64 rel_deadline = dl_se->dl_deadline;
> > +	u64 rem_runtime  = dl_se->dl_runtime;  
> 
> This is not the dynamic remaining one, is it?

Right; I preferred to split this in two patches so that if we decide to
use only the static task parameters (dl_deadline and dl_runtime) I can
simply drop a patch ;-)


				Luca

> 
> I see however 4/6.. lemme better look at that.
> 
> Best,
> 
> - Juri

