Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1F8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DE221473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfEVOnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbfEVOne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:43:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2DA20821;
        Wed, 22 May 2019 14:43:33 +0000 (UTC)
Date:   Wed, 22 May 2019 10:43:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viktor Rosendahl <viktor.rosendahl@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190522104332.3564e82f@gandalf.local.home>
In-Reply-To: <20190522143545.GG16275@worktop.programming.kicks-ass.net>
References: <20190521120142.186487e9@gandalf.local.home>
        <20190522003014.1359-1-viktor.rosendahl@gmail.com>
        <20190522143545.GG16275@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 16:35:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > @@ -284,6 +285,7 @@ static void do_idle(void)
> >  	smp_mb__after_atomic();
> >  
> >  	sched_ttwu_pending();
> > +	/* schedule_idle() will call trace_enable_fsnotify() */
> >  	schedule_idle();
> >  
> >  	if (unlikely(klp_patch_pending(current)))  
> 
> I still hate this.. why are we doing this? We already have this
> stop_critical_timings() nonsense and are now adding more gunk.

I was thinking that this can possibly be added in the
stop_critical_timings() as that is probably where this is needed
anyway.

-- Steve
