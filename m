Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D271C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2252089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfGAJYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:24:38 -0400
Received: from foss.arm.com ([217.140.110.172]:58480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbfGAJYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:24:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E933DCFC;
        Mon,  1 Jul 2019 02:24:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94F433F718;
        Mon,  1 Jul 2019 02:24:36 -0700 (PDT)
Date:   Mon, 1 Jul 2019 10:24:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, dvyukov@google.com, namhyung@kernel.org,
        xiexiuqi@huawei.com,
        syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf: Fix race between close() and fork()
Message-ID: <20190701092429.GA10975@lakrids.cambridge.arm.com>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
 <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
 <20190308155429.GB10860@lakrids.cambridge.arm.com>
 <20190624121902.GE3436@hirez.programming.kicks-ass.net>
 <20190625084904.GY3463@hirez.programming.kicks-ass.net>
 <20190625104320.GZ3463@hirez.programming.kicks-ass.net>
 <20190628165003.GA5143@lakrids.cambridge.arm.com>
 <20190628204608.GG3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628204608.GG3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:46:08PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 05:50:03PM +0100, Mark Rutland wrote:
> > > +		/*
> > > +		 * Wake any perf_event_free_task() waiting for this event to be
> > > +		 * freed.
> > > +		 */
> > > +		smp_mb(); /* pairs with wait_var_event() */
> > > +		wake_up_var(var);
> > 
> > Huh, so wake_up_var() doesn't imply a RELEASE?
> > 
> > As an aside, doesn't that mean all callers of wake_up_var() have to do
> > likewise to ensure it isn't re-ordered with whatever prior stuff they're
> > trying to notify waiters about? Several do an smp_store_release() then a
> > wake_up_var(), but IIUC the wake_up_var() could get pulled before that
> > release...
> 
> Yah,...
> 
>   https://lkml.kernel.org/r/20190624165012.GH3436@hirez.programming.kicks-ass.net

That gets me a 404, so I'll assume that's a speculative store. ;)

> I needs to get back to that.

Ouch; sorry for reminding you of this mess!

Thanks,
Mark.
