Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432B5217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCNPk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:40:59 -0400
Received: from foss.arm.com ([217.140.101.70]:46444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfCNPk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:40:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E2E5A78;
        Thu, 14 Mar 2019 08:40:58 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1743F71D;
        Thu, 14 Mar 2019 08:40:55 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:40:52 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190314154052.345v74snhtc4cqbe@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <CAJuCfpGAZ6XxJj=e-wVzGx3zmRRLPs=wXm8K0BcjWOm5hM0FcQ@mail.gmail.com>
 <20190314144600.2ulpeipad7jbxyiy@e110439-lin>
 <CAJuCfpFDVi7O+yqQ+F0DT3pRZN=BtRD8NyUH5Tys0VVkd9JAGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFDVi7O+yqQ+F0DT3pRZN=BtRD8NyUH5Tys0VVkd9JAGg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Mar 08:29, Suren Baghdasaryan wrote:
> On Thu, Mar 14, 2019 at 7:46 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > On 13-Mar 14:32, Suren Baghdasaryan wrote:
> > > On Fri, Feb 8, 2019 at 2:06 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:

[...]

> > > > The rq::uclamp::bucket[clamp_id][] array is scanned every time we need
> > > > to find a new MAX aggregated clamp value for a clamp_id. This operation
> > > > is required only when we dequeue the last task of a clamp bucket
> > > > tracking the current MAX aggregated clamp value. In these cases, the CPU
> > > > is either entering IDLE or going to schedule a less boosted or more
> > > > clamped task.

The following:

> > > > The expected number of different clamp values, configured at build time,
> > > > is small enough to fit the full unordered array into a single cache
> > > > line.

will read:

The expected number of different clamp values, configured at build time,
is small enough to fit the full unordered array into a single cache
line for the default UCLAMP_BUCKETS configuration of 7 buckets.

[...]

> Got it. From reading the documentation at the beginning my impression
> was that whatever value I choose within allowed 5-20 range it would
> still fit in a cache line. To disambiguate it might be worse
> mentioning that this is true for the default value or for values up to
> 7. Thanks!

Right, I hope the above proposed change helps to clarify that.

-- 
#include <best/regards.h>

Patrick Bellasi
