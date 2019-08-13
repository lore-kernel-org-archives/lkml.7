Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821C1C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 01:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDC620665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 01:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pqX+AsGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfHMBeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 21:34:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45590 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfHMBeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 21:34:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id a30so12525719lfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 18:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhOMsZgraPbofDXHGlEAPblhYgeF7xROTk8w4FSX/Q8=;
        b=pqX+AsGxsOOmro0DhzbCC8yIL18XGXrlTdxb1jh2O7AQ4Zpxtc3qR66hu/oqhESsq7
         lruMije3Zt2EqNSnR5czmrGtEA4wnN5fIAo2BEK7CYe5z3SQ4bs1oCx/sSg8LmGpwP6Q
         RCNhUECyMsRJmV5xsX8q48Aq7xOvj0C7qZw6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhOMsZgraPbofDXHGlEAPblhYgeF7xROTk8w4FSX/Q8=;
        b=F9Z9IJWmFCrKNet/mEpstAzCMSF9u7qiPMOR5hoR5p9LHZubOFYtEdsEcv/NM3mN/D
         xlhhrm3mjrbzoZn4Y9ZQKTt+epOoeEdpOGer0IVE6WmUrr6vv18c/g2O2na22+nSYiZR
         sO0CIMQXyG1dqf2cgbRegU9hjRMaLd5qUYXw/DdUxvmEtBFh1UwNIb6+vkarmZIl9n6y
         Ec/UmkA0awgUWjgHbZIa8ApwHluDbVVbgZaxMELoOakRxXC43jdOnWozrn9abejmrcq1
         9pj+Ra1NDHhgeKY8ok48SYNiIjc0DzZEB8/mYDFOkyxVVTIaHAfW/Hd3VYdkov0icvq/
         RHtQ==
X-Gm-Message-State: APjAAAW0uyQeQOLZuySi2xcFMIgej3yOout9ghzwVetTyL+oT2+/EWJU
        3L4EHoH1v8g1cVl56hODqiNQTJo3sA88dexom5O8BQ==
X-Google-Smtp-Source: APXvYqywVV126qBkpvCj9wilDgs7/ubL/o2+AGR81L9EPWfdcToV8DH6PE+74TIUSlJiAqOlP4zxXU+RTHhqUSv+3kY=
X-Received: by 2002:ac2:5394:: with SMTP id g20mr22731532lfh.112.1565660042882;
 Mon, 12 Aug 2019 18:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190802151435.GA1081@linux.ibm.com> <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190812210232.GA3648@lenoir> <20190812232316.GT28441@linux.ibm.com>
In-Reply-To: <20190812232316.GT28441@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 12 Aug 2019 21:33:51 -0400
Message-ID: <CAEXW_YRm6cBp-J3tPeRH+Jx=38LaAtNoCM9f0FeFG+ZBZKBH6w@mail.gmail.com>
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 7:23 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Mon, Aug 12, 2019 at 11:02:33PM +0200, Frederic Weisbecker wrote:
> > On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> > > The multi_cpu_stop() function relies on the scheduler to gain control from
> > > whatever is running on the various online CPUs, including any nohz_full
> > > CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
> > > interrupt on such CPUs can delay multi_cpu_stop() for several minutes
> > > and can also result in RCU CPU stall warnings.  This commit therefore
> > > causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
> > > online CPUs.
> > >
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > ---
> > >  kernel/stop_machine.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> > > index b4f83f7bdf86..a2659f61ed92 100644
> > > --- a/kernel/stop_machine.c
> > > +++ b/kernel/stop_machine.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/smpboot.h>
> > >  #include <linux/atomic.h>
> > >  #include <linux/nmi.h>
> > > +#include <linux/tick.h>
> > >  #include <linux/sched/wake_q.h>
> > >
> > >  /*
> > > @@ -187,15 +188,19 @@ static int multi_cpu_stop(void *data)
> > >  {
> > >     struct multi_stop_data *msdata = data;
> > >     enum multi_stop_state curstate = MULTI_STOP_NONE;
> > > -   int cpu = smp_processor_id(), err = 0;
> > > +   int cpu, err = 0;
> > >     const struct cpumask *cpumask;
> > >     unsigned long flags;
> > >     bool is_active;
> > >
> > > +   for_each_online_cpu(cpu)
> > > +           tick_nohz_dep_set_cpu(cpu, TICK_DEP_MASK_RCU);
> >
> > Looks like it's not the right fix but, should you ever need to set an
> > all-CPUs (system wide) tick dependency in the future, you can use tick_set_dep().
>
> Indeed, I have dropped this patch, but I now do something similar in
> RCU's CPU-hotplug notifiers.  Which does have an effect, especially on
> the system that isn't subject to the insane-latency cpu_relax().
>
> Plus I am having to put a similar workaround into RCU's quiescent-state
> forcing logic.
>
> But how should this really be done?
>
> Isn't there some sort of monitoring of nohz_full CPUs for accounting
> purposes?  If so, would it make sense for this monitoring to check for
> long-duration kernel execution and enable the tick in this case?  The
> RCU dyntick machinery can be used to remotely detect the long-duration
> kernel execution using something like the following:
>
>         int nohz_in_kernel_snap = rcu_dynticks_snap_cpu(cpu);
>
>         ...
>
>         if (rcu_dynticks_in_eqs_cpu(cpu, nohz_in_kernel_snap)
>                 nohz_in_kernel_snap = rcu_dynticks_snap_cpu(cpu);
>         else
>                 /* Turn on the tick! */

This solution does make sense to me and is simpler than the
rcu_nmi_exit_common() solution you proposed in the other thread.

Though I am not sure about the intricacies of remotely enabling the
timer tick for a CPU. But overall, the above solution does seem
simpler.

thanks,

 - Joel
