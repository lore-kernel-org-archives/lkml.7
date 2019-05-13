Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97B0C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6C72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="21LRkYCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfEMPGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:06:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56122 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbfEMPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2/pZQCYHBRt5vZjBZiV+jXqyYA3iPhVXwNe1J6JTT5Q=; b=21LRkYCIu+9y35kAOJwzsIntS
        j1JVTBcrifsbUMBdiCv0OXnIGwa7vEcK+5xsZrnpLyiQ/qL4Ql1RazGalQTM1GcLRXPCo0K88iEUa
        Gg9AIxmVcew2xxKafQ/S1GVO4ZNEuoTHphQyUyO5q8Mawm41TDA3/7MB9kyyk1r/0TogczRIoPRbN
        zmFdPuP10/39OO136NJ2oL/vo9C53k9oaDrbuYKk143w/B1pH9XKLRwsdjy4QKkKQdNY6rJjBHniP
        QsL5XVscOxodLB0AlVgLH5BRPv0bMm6PXKb8w07anonG8Uguykd8Qg59QtOKq0vdpYRwLcE2LVUQq
        dwf5TdyWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQCWz-0007zz-7n; Mon, 13 May 2019 15:06:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAC962029FD7A; Mon, 13 May 2019 17:06:19 +0200 (CEST)
Date:   Mon, 13 May 2019 17:06:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 0/7] Add new tracepoints required for EAS testing
Message-ID: <20190513150619.GX2589@hirez.programming.kicks-ass.net>
References: <20190510113013.1193-1-qais.yousef@arm.com>
 <20190513122857.GU2623@hirez.programming.kicks-ass.net>
 <20190513134203.xmw6rsjwpj5b4tj6@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513134203.xmw6rsjwpj5b4tj6@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 02:42:03PM +0100, Qais Yousef wrote:
> On 05/13/19 14:28, Peter Zijlstra wrote:
> > 
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index c8c7c7efb487..11555f95a88e 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -594,6 +594,23 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
> >  
> >  	TP_printk("cpu=%d", __entry->cpu)
> >  );
> > +
> > +/*
> > + * Following tracepoints are not exported in tracefs and provide hooking
> > + * mechanisms only for testing and debugging purposes.
> > + */
> > +DECLARE_TRACE(pelt_cfs_rq,
> > +	TP_PROTO(struct cfs_rq *cfs_rq),
> > +	TP_ARGS(cfs_rq));
> > +
> > +DECLARE_TRACE(pelt_se,
> > +	TP_PROTO(struct sched_entity *se),
> > +	TP_ARGS(se));
> > +
> > +DECLARE_TRACE(sched_overutilized,
> > +	TP_PROTO(int overutilized),
> > +	TP_ARGS(overutilized));
> > +
> 
> If I decoded this patch correctly, what you're saying:
> 
> 	1. Move struct cfs_rq to the exported sched.h header

No, don't expose the structure, we want to keep that private. You can
use unqualified pointers.

> 	2. Get rid of the fatty wrapper functions and export any necessary
> 	   helper functions.

Right, that should get them read-only access to the members of those
structures and avoids the tracing code itself from becoming ugleh and
also avoids us having to export those structures (which we really don't
want to do).

> 	3. No need for RT and DL pelt tracking at the moment.

Nah, you probably want rt,dl,irq (as Dietmar pointed out), it's just
that your patched didn't do it right and I was lazy.

> I'm okay with this. The RT and DL might need to be revisited later but we don't
> have immediate need for them now.
> 
> I'll add to this passing rd->span to sched_overutilizied.

Or pass the rd itself and add another wrapper to extract the span.
