Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C455120857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCSKAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:00:45 -0400
Received: from foss.arm.com ([217.140.101.70]:48428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfCSKAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:00:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FE3A1650;
        Tue, 19 Mar 2019 03:00:44 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B71C3F575;
        Tue, 19 Mar 2019 03:00:41 -0700 (PDT)
Date:   Tue, 19 Mar 2019 10:00:35 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v7 11/15] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190319100035.mzuuynaobp7hrbtf@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-12-patrick.bellasi@arm.com>
 <20190214154817.GN50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214154817.GN50184@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Feb 07:48, Tejun Heo wrote:
> Hello,

Hi Tejun,

> On Fri, Feb 08, 2019 at 10:05:50AM +0000, Patrick Bellasi wrote:
> > a) are available only for non-root nodes, both on default and legacy
> >    hierarchies, while system wide clamps are defined by a generic
> >    interface which does not depends on cgroups
> > 
> > b) do not enforce any constraints and/or dependencies between the parent
> >    and its child nodes, thus relying:
> >    - on permission settings defined by the system management software,
> >      to define if subgroups can configure their clamp values
> >    - on the delegation model, to ensure that effective clamps are
> >      updated to consider both subgroup requests and parent group
> >      constraints
> 
> I'm not sure about this hierarchical behavior.

Yes, the above paragraph is misleading and it fails in properly
document what the code really does.

I'll update it on v8 to be more clear.

> 
> > c) have higher priority than task-specific clamps, defined via
> >    sched_setattr(), thus allowing to control and restrict task requests
> 
> and I have some other concerns about the interface, but let's discuss
> them once the !cgroup portion is settled.

Sure, looking forward to get some more feedbacks from you on that
part.

For the time being I'll keep adding the cgroups bits on top of
the core ones just to follow the principle of "share early, share
often" and to give interested people a more complete picture of our
final goal.

I'm sure Peter will let you know when it's worth for you to be
more actively involved with the review ;)

> Thanks.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
