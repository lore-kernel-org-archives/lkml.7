Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA44C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A0E208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbfEMPSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:18:46 -0400
Received: from foss.arm.com ([217.140.101.70]:59238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbfEMPSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:18:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B0BC341;
        Mon, 13 May 2019 08:18:45 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E8A93F71E;
        Mon, 13 May 2019 08:18:43 -0700 (PDT)
Date:   Mon, 13 May 2019 16:18:40 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 0/7] Add new tracepoints required for EAS testing
Message-ID: <20190513151840.fhicik6mx6lowykm@e107158-lin.cambridge.arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
 <20190513122857.GU2623@hirez.programming.kicks-ass.net>
 <20190513134203.xmw6rsjwpj5b4tj6@e107158-lin.cambridge.arm.com>
 <20190513150619.GX2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190513150619.GX2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/19 17:06, Peter Zijlstra wrote:
> On Mon, May 13, 2019 at 02:42:03PM +0100, Qais Yousef wrote:
> > On 05/13/19 14:28, Peter Zijlstra wrote:
> > > 
> > > 
> > > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > > index c8c7c7efb487..11555f95a88e 100644
> > > --- a/include/trace/events/sched.h
> > > +++ b/include/trace/events/sched.h
> > > @@ -594,6 +594,23 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
> > >  
> > >  	TP_printk("cpu=%d", __entry->cpu)
> > >  );
> > > +
> > > +/*
> > > + * Following tracepoints are not exported in tracefs and provide hooking
> > > + * mechanisms only for testing and debugging purposes.
> > > + */
> > > +DECLARE_TRACE(pelt_cfs_rq,
> > > +	TP_PROTO(struct cfs_rq *cfs_rq),
> > > +	TP_ARGS(cfs_rq));
> > > +
> > > +DECLARE_TRACE(pelt_se,
> > > +	TP_PROTO(struct sched_entity *se),
> > > +	TP_ARGS(se));
> > > +
> > > +DECLARE_TRACE(sched_overutilized,
> > > +	TP_PROTO(int overutilized),
> > > +	TP_ARGS(overutilized));
> > > +
> > 
> > If I decoded this patch correctly, what you're saying:
> > 
> > 	1. Move struct cfs_rq to the exported sched.h header
> 
> No, don't expose the structure, we want to keep that private. You can
> use unqualified pointers.
> 
> > 	2. Get rid of the fatty wrapper functions and export any necessary
> > 	   helper functions.
> 
> Right, that should get them read-only access to the members of those
> structures and avoids the tracing code itself from becoming ugleh and
> also avoids us having to export those structures (which we really don't
> want to do).
> 
> > 	3. No need for RT and DL pelt tracking at the moment.
> 
> Nah, you probably want rt,dl,irq (as Dietmar pointed out), it's just
> that your patched didn't do it right and I was lazy.
> 
> > I'm okay with this. The RT and DL might need to be revisited later but we don't
> > have immediate need for them now.
> > 
> > I'll add to this passing rd->span to sched_overutilizied.
> 
> Or pass the rd itself and add another wrapper to extract the span.

Ok got ya. Will do.

Thanks

--
Qais Yousef
