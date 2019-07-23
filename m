Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80506C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5699321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbfGWOAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfGWOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02758811D8;
        Tue, 23 Jul 2019 14:00:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5C92A19C78;
        Tue, 23 Jul 2019 14:00:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 Jul 2019 16:00:45 +0200 (CEST)
Date:   Tue, 23 Jul 2019 16:00:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190723140043.GB8994@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
 <20190719134727.GV3463@hirez.programming.kicks-ass.net>
 <20190719143742.GA32243@redhat.com>
 <20190722195605.GI6698@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722195605.GI6698@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Jul 2019 14:00:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22, Peter Zijlstra wrote:
>
> On Fri, Jul 19, 2019 at 04:37:42PM +0200, Oleg Nesterov wrote:
> > On 07/19, Peter Zijlstra wrote:
>
> > > But I'm still confused, since in the long run, it should still end up
> > > with a proportionally divided user/system, irrespective of some short
> > > term wobblies.
> >
> > Why?
> >
> > Yes, statistically the numbers are proportionally divided.
>
> This; due to the loss in precision the distribution is like a step
> function around the actual s:u ratio line, but on average it still is
> s:u.

You know, I am no longer sure... perhaps it is even worse, I need to recheck.

> Even if it were a perfect function, we'd still see increments in stime even
> if the current program state never does syscalls, simply because it
> needs to stay on that s:u line.
>
> > but you will (probably) never see the real stime == 1000 && utime == 10000
> > numbers if you watch incrementally.
>
> See, there are no 'real' stime and utime numbers. What we have are user
> and system samples -- tick based.

Yes, yes, I know.

> Sure, we take a shortcut, it wobbles a bit, but seriously, the samples
> are inaccurate anyway, so who bloody cares :-)
...
> People always complain, just tell em to go pound sand :-)

I tried ;) this was my initial reaction to this bug report.

However,

> You can construct a program that runs 99% in userspace but has all
> system samples.

Yes, but with the current implementation you do not need to construct
such a program, this is what you can easily get "in practice". And this
confuses people.

They can watch /proc/pid/stat incrementally and (when the numbers are big)
find that a program that runs 100% in userspace somehow spends 10 minutes
almost entirely in kernel. Or at least more in kernel than in userspace.
Even if task->stime doesn't grow at all.

Oleg.

