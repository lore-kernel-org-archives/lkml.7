Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8780FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658AC20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfIELrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:47:08 -0400
Received: from foss.arm.com ([217.140.110.172]:43252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbfIELrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:47:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57BF8337;
        Thu,  5 Sep 2019 04:47:07 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4BB63F718;
        Thu,  5 Sep 2019 04:47:05 -0700 (PDT)
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com> <20190830174944.21741-2-subhra.mazumdar@oracle.com> <20190905083127.GA2332@hirez.programming.kicks-ass.net> <87r24v2i14.fsf@arm.com> <20190905104616.GD2332@hirez.programming.kicks-ass.net> <87imq72dpc.fsf@arm.com> <20190905114030.GL2349@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
In-reply-to: <20190905114030.GL2349@hirez.programming.kicks-ass.net>
Date:   Thu, 05 Sep 2019 12:46:57 +0100
Message-ID: <87ef0v2cem.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 05, 2019 at 12:40:30 +0100, Peter Zijlstra wrote...

> On Thu, Sep 05, 2019 at 12:18:55PM +0100, Patrick Bellasi wrote:
>
>> Right, we have this dualism to deal with and current mainline behaviour
>> is somehow in the middle.
>> 
>> BTW, the FB requirement is the same we have in Android.
>> We want some CFS tasks to have very small latency and a low chance
>> to be preempted by the wake-up of less-important "background" tasks.
>> 
>> I'm not totally against the usage of a signed range, but I'm thinking
>> that since we are introducing a new (non POSIX) concept we can get the
>> chance to make it more human friendly.
>
> I'm arguing that signed _is_ more human friendly ;-)

... but you are not human. :)

>> Give the two extremes above, would not be much simpler and intuitive to
>> have 0 implementing the FB/Android (no latency) case and 1024 the
>> (max latency) Oracle case?
>
> See, I find the signed thing more natural, negative is a bias away from
> latency sensitive, positive is a bias towards latency sensitive.
>
> Also; 0 is a good default value ;-)

Yes, that's appealing indeed.

>> Moreover, we will never match completely the nice semantic, give that
>> a 1 nice unit has a proper math meaning, isn't something like 10% CPU
>> usage change for each step?
>
> Only because we were nice when implementing it. Posix leaves it
> unspecified and we could change it at any time. The only real semantics
> is a relative 'weight' (opengroup uses the term 'favourable').

Good to know, I was considering it a POXIS requirement.

>> Could changing the name to "latency-tolerance" break the tie by marking
>> its difference wrt prior/nice levels? AFAIR, that was also the original
>> proposal [1] by PaulT during the OSPM discussion.
>
> latency torrerance could still be a signed entity, positive would
> signify we're more tolerant of latency (ie. less sensitive) while
> negative would be less tolerant (ie. more sensitive).

Right.

>> For latency-nice instead we will likely base our biasing strategies on
>> some predefined (maybe system-wide configurable) const thresholds.
>
> I'm not quite sure; yes, for some of these things, like the idle search
> on wakeup, certainly. But say for wakeup-preemption, we could definitely
> make it a task relative attribute.

-- 
#include <best/regards.h>

Patrick Bellasi
