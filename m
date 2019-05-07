Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF27C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ED620989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfEGORt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:17:49 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:19645 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEGORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:17:49 -0400
Received: from [83.43.182.198] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138898218; Tue, 07 May 2019 16:17:45 +0200
Date:   Tue, 7 May 2019 16:17:33 +0200
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
Subject: Re: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
Message-ID: <20190507161733.1a26419b@nowhere>
In-Reply-To: <20190507133528.ia4p3medvtg4z5az@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
        <20190506044836.2914-3-luca.abeni@santannapisa.it>
        <20190507133528.ia4p3medvtg4z5az@queper01-lin>
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

On Tue, 7 May 2019 14:35:28 +0100
Quentin Perret <quentin.perret@arm.com> wrote:

> Hi Luca,
> 
> On Monday 06 May 2019 at 06:48:32 (+0200), Luca Abeni wrote:
> > +static inline int dl_task_fit(const struct sched_dl_entity *dl_se,
> > +			      int cpu, u64 *c)
> > +{
> > +	u64 cap = (arch_scale_cpu_capacity(NULL, cpu) *
> > arch_scale_freq_capacity(cpu)) >> SCHED_CAPACITY_SHIFT;  
> 
> I'm a little bit confused by this use of arch_scale_freq_capacity()
> here. IIUC this means you would say a big DL task doesn't fit on a big
> CPU just because it happens to be running at a low frequency when this
> function is called. Is this what we want ?

The idea of this approach was to avoid frequency switches when
possible; so, I wanted to check if the task fits on a CPU core at its
current operating frequency.


> If the frequency is low, we can (probably) raise it to accommodate
> this DL task so perhaps we should say it fits ?

In a later patch, if the task does not fit on any core (at its current
frequency), the task is moved to the core having the maximum capacity
(without considering the operating frequency --- at least, this was my
intention when I wrote the patches :)



				Luca

> 
> > +	s64 rel_deadline = dl_se->dl_deadline;
> > +	u64 rem_runtime  = dl_se->dl_runtime;
> > +
> > +	if (c)
> > +		*c = cap;
> > +
> > +	if ((rel_deadline * cap) >> SCHED_CAPACITY_SHIFT <
> > rem_runtime)
> > +		return 0;
> > +
> > +	return 1;
> > +}  
> 
> Thanks,
> Quentin

