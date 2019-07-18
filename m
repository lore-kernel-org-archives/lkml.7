Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBE1C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657A3208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbfGRP0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:26:40 -0400
Received: from foss.arm.com ([217.140.110.172]:59830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbfGRP0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:26:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17D87344;
        Thu, 18 Jul 2019 08:26:39 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2A643F71F;
        Thu, 18 Jul 2019 08:26:36 -0700 (PDT)
Date:   Thu, 18 Jul 2019 16:26:22 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
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
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v11 1/5] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190718152327.vmnds3kpagh2xz2r@e110439-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-2-patrick.bellasi@arm.com>
 <20190718145238.GD696309@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718145238.GD696309@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-Jul 07:52, Tejun Heo wrote:
> Hello, Patrick.
> 
> On Mon, Jul 08, 2019 at 09:43:53AM +0100, Patrick Bellasi wrote:
> > +static inline void cpu_uclamp_print(struct seq_file *sf,
> > +				    enum uclamp_id clamp_id)
> > +{
> > +	struct task_group *tg;
> > +	u64 util_clamp;
> > +	u64 percent;
> > +	u32 rem;
> > +
> > +	rcu_read_lock();
> > +	tg = css_tg(seq_css(sf));
> > +	util_clamp = tg->uclamp_req[clamp_id].value;
> > +	rcu_read_unlock();
> > +
> > +	if (util_clamp == SCHED_CAPACITY_SCALE) {
> > +		seq_puts(sf, "max\n");
> > +		return;
> > +	}
> > +
> > +	percent = uclamp_percent_from_scale(util_clamp);
> > +	percent = div_u64_rem(percent, 100, &rem);
> > +	seq_printf(sf, "%llu.%u\n", percent, rem);
> 
> "%llu.%02u" otherwise 20.01 gets printed as 20.1

Yup!... good point! :)

Since we already collected many feedbacks, I've got a v12 ready for posting.
Maybe you better wait for that before going on with the review.

Thanks,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
