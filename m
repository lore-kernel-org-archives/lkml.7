Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD1C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8F620679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405875AbfHBJuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:50:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404933AbfHBJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:50:35 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htUCg-0001sw-HD; Fri, 02 Aug 2019 11:50:26 +0200
Date:   Fri, 2 Aug 2019 11:50:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Qais Yousef <qais.yousef@arm.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/5] Fix FIFO-99 abuse
In-Reply-To: <20190802093244.GF2332@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1908021149110.3924@nanos.tec.linutronix.de>
References: <20190801111348.530242235@infradead.org> <20190801131707.5rpyydznnhz474la@e107158-lin.cambridge.arm.com> <20190802093244.GF2332@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019, Peter Zijlstra wrote:
> On Thu, Aug 01, 2019 at 02:17:07PM +0100, Qais Yousef wrote:
> > On 08/01/19 13:13, Peter Zijlstra wrote:
> > > I noticed a bunch of kthreads defaulted to FIFO-99, fix them.
> > > 
> > > The generic default is FIFO-50, the admin will have to configure the system
> > > anyway.
> > > 
> > > For some the purpose is to be above OTHER and then FIFO-1 really is sufficient.
> > 
> > I was looking in this area too and was thinking of a way to consolidate the
> > creation of RT/DL tasks in the kernel and the way we set the priority.
> > 
> > Does it make sense to create a new header for RT priorities for kthreads
> > created in the kernel so that we can easily track and rationale about the
> > relative priorities of in-kernel RT tasks?
> > 
> > When working in the FW world such a header helped a lot in understanding what
> > runs at each priority level and how to reason about what priority level makes
> > sense for a new item. It could be a nice single point of reference; even for
> > admins.
> 
> Well, SCHED_FIFO is a broken scheduler model; that is, it is
> fundamentally incapable of resource management, which is the one thing
> an OS really should be doing.
> 
> This is of course the reason it is limited to privileged users only.
> 
> Worse still; it is fundamentally impossible to compose static priority
> workloads. You cannot take two correctly working static prio workloads
> and smash them together and still expect them to work.
> 
> For this reason 'all' FIFO tasks the kernel creates are basically at:
> 
>   MAX_RT_PRIO / 2
> 
> The administrator _MUST_ configure the system, the kernel simply doesn't
> know enough information to make a sensible choice.
> 
> Now, Geert suggested so make make a define for that, but how about we do
> something like:
> 
> /*
>  * ${the above explanation}
>  */
> int kernel_setscheduler_fifo(struct task_struct *p)
> {
> 	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 };
> 	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
> }
> 
> And then take away sched_setscheduler*().

Yes, please.

     tglx

