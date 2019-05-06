Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDC0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4B42053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfEFPAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:00:40 -0400
Received: from foss.arm.com ([217.140.101.70]:52768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfEFOmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:42:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B88B4A78;
        Mon,  6 May 2019 07:42:04 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E56F3F575;
        Mon,  6 May 2019 07:42:03 -0700 (PDT)
Date:   Mon, 6 May 2019 15:42:00 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190506144200.z4s63nm7untol2tr@e107158-lin.cambridge.arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
 <20190505115732.9844-5-qais.yousef@arm.com>
 <20190506090859.GK2606@hirez.programming.kicks-ass.net>
 <20190506095239.08577b3e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506095239.08577b3e@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/19 09:52, Steven Rostedt wrote:
> On Mon, 6 May 2019 11:08:59 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > These functions really should be called trace_*()
> > 
> > Also; I _really_ hate how fat they are. Why can't we do simple straight
> > forward things like:
> > 
> > 	trace_pelt_cfq(cfq);
> > 	trace_pelt_rq(rq);
> > 	trace_pelt_se(se);
> > 
> > And then have the thing attached to the event do the fat bits like
> > extract the path and whatnot.
> 
> I'd like to avoid functions called "trace_*" that are not trace events.
> It's getting confusing when I see a "trace_*()" function and then go
> look for the corresponding TRACE_EVENT() just to find out that one does
> not exist.
> 
>  sched_trace_*()  maybe?

I can control that for the wrappers I'm introducing. But the actual tracepoint
get the 'trace_' part prepended automatically by the macros.

ie DECLARE_TRACE(pelt_rq, ...) will automatically generate a function called
trace_pelt_se(...)

Or am I missing something?

Thanks

--
Qais Yousef
