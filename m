Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5F7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CC121744
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfEHNiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:38:23 -0400
Received: from foss.arm.com ([217.140.101.70]:34668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfEHNiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:38:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27A5280D;
        Wed,  8 May 2019 06:38:23 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0FD83F5AF;
        Wed,  8 May 2019 06:38:21 -0700 (PDT)
Date:   Wed, 8 May 2019 14:38:18 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190508133818.hvgc537fpnlnefwe@e107158-lin.cambridge.arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
 <20190505115732.9844-5-qais.yousef@arm.com>
 <20190506090859.GK2606@hirez.programming.kicks-ass.net>
 <20190506091823.GF2650@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506091823.GF2650@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/19 11:18, Peter Zijlstra wrote:
> On Mon, May 06, 2019 at 11:08:59AM +0200, Peter Zijlstra wrote:
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
> ARGH, because we don't export any of those data structures (for good
> reason).. bah I hate all this.

I am not a big fan either..

FWIW struct sched_entity and struct sched_avg are exported but only used in
kernel/sched/*. Are the reasons behind not exporting struct cfs_rq and struct
rq are really different to the other 2?

Anyways. I have v2 almost ready but thought I'd ask before posting if we want
to handle this in a different way.

Thanks

--
Qais Yousef
