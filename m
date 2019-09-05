Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81DC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1221848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfIELrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:47:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731660AbfIELrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:47:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40605344;
        Thu,  5 Sep 2019 04:47:30 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74FF13F718;
        Thu,  5 Sep 2019 04:47:28 -0700 (PDT)
Date:   Thu, 5 Sep 2019 12:47:26 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <20190905113002.GK2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905113002.GK2349@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/19 13:30, Peter Zijlstra wrote:
> On Thu, Sep 05, 2019 at 12:13:47PM +0100, Qais Yousef wrote:
> > On 09/05/19 12:46, Peter Zijlstra wrote:
> 
> > > This is important because we want to be able to bias towards less
> > > importance to (tail) latency as well as more importantance to (tail)
> > > latency.
> > > 
> > > Specifically, Oracle wants to sacrifice (some) latency for throughput.
> > > Facebook OTOH seems to want to sacrifice (some) throughput for latency.
> > 
> > Another use case I'm considering is using latency-nice to prefer an idle CPU if
> > latency-nice is set otherwise go for the most energy efficient CPU.
> > 
> > Ie: sacrifice (some) energy for latency.
> > 
> > The way I see interpreting latency-nice here as a binary switch. But
> > maybe we can use the range to select what (some) energy to sacrifice
> > mean here. Hmmm.
> 
> It cannot be binary, per definition is must be ternary, that is, <0, ==0
> and >0 (or middle value if you're of that persuasion).

I meant I want to use it as a binary.

> 
> In your case, I'm thinking you mean >0, we want to lower the latency.

Yes. As long as there's an easy way to say: does this task care about latency
or not I'm good.

> 
> Anyway; there were a number of things mentioned at OSPM that we could
> tie into this thing and finding sensible mappings is going to be a bit
> of trial and error I suppose.
> 
> But as patrick said; we're very much exporting a BIAS knob, not a set of
> behaviours.

Agreed. I just wanted to say that the way this range is going to be
interpreted will differ from path to path and we need to consider that in the
final mapping. Especially from the final user's perspective of what setting
this value ultimately means to them.

--
Qais Yousef
