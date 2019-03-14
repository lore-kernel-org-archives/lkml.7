Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6129C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB5020854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCNMNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:13:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43208 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfCNMNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:13:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E64E374;
        Thu, 14 Mar 2019 05:13:21 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271083F614;
        Thu, 14 Mar 2019 05:13:18 -0700 (PDT)
Date:   Thu, 14 Mar 2019 12:13:15 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190314121315.juqpsqu5cwouuqpp@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313134022.GB5922@hirez.programming.kicks-ass.net>
 <20190313161229.pkib2tmjass5chtb@e110439-lin>
 <20190313194838.GS2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313194838.GS2482@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Mar 20:48, Peter Zijlstra wrote:
> On Wed, Mar 13, 2019 at 04:12:29PM +0000, Patrick Bellasi wrote:
> > On 13-Mar 14:40, Peter Zijlstra wrote:
> > > On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> > > > +static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
> > > > +{
> > > > +	return clamp_value / UCLAMP_BUCKET_DELTA;
> > > > +}
> > > > +
> > > > +static inline unsigned int uclamp_bucket_value(unsigned int clamp_value)
> > > > +{
> > > > +	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
> > > 
> > > 	return clamp_value - (clamp_value % UCLAMP_BUCKET_DELTA);
> > > 
> > > might generate better code; just a single division, instead of a div and
> > > mult.
> > 
> > Wondering if compilers cannot do these optimizations... but yes, looks
> > cool and will do it in v8, thanks.
> 
> I'd be most impressed if they pull this off. Check the generated code
> and see I suppose :-)

On x86 the code generated looks exactly the same:

   https://godbolt.org/z/PjmA7k

While on on arm64 it seems the difference boils down to:
 - one single "mul" instruction
vs
 - two instructions: "sub" _plus_ one "multiply subtract"

  https://godbolt.org/z/0shU0S

So, if I din't get something wrong... perhaps the original version is
even better, isn't it?


Test code:

---8<---
#define UCLAMP_BUCKET_DELTA 52

static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
{
    return clamp_value / UCLAMP_BUCKET_DELTA;
}

static inline unsigned int uclamp_bucket_value1(unsigned int clamp_value)
{
    return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
}

static inline unsigned int uclamp_bucket_value2(unsigned int clamp_value)
{
    return clamp_value - (clamp_value % UCLAMP_BUCKET_DELTA);
}

int test1(int argc, char *argv[]) {
    return uclamp_bucket_value1(argc);
}

int test2(int argc, char *argv[]) {
    return uclamp_bucket_value2(argc);
}

int test3(int argc, char *argv[]) {
    return uclamp_bucket_value1(argc) - uclamp_bucket_value2(argc);
}
---8<---

which gives on arm64:

---8<---
test1:
        mov     w1, 60495
        movk    w1, 0x4ec4, lsl 16
        umull   x0, w0, w1
        lsr     x0, x0, 36
        mov     w1, 52
        mul     w0, w0, w1
        ret
test2:
        mov     w1, 60495
        movk    w1, 0x4ec4, lsl 16
        umull   x1, w0, w1
        lsr     x1, x1, 36
        mov     w2, 52
        msub    w1, w1, w2, w0
        sub     w0, w0, w1
        ret
test3:
        mov     w0, 0
        ret
---8<---


-- 
#include <best/regards.h>

Patrick Bellasi
