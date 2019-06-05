Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF02C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18785208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfFEPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:37:49 -0400
Received: from foss.arm.com ([217.140.101.70]:33902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfFEPht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:37:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75AE0374;
        Wed,  5 Jun 2019 08:37:48 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FB373F246;
        Wed,  5 Jun 2019 08:37:45 -0700 (PDT)
Date:   Wed, 5 Jun 2019 16:37:43 +0100
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
Subject: Re: [PATCH v9 12/16] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190605153742.lusoiodrzxmpsrvd@e110439-lin>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
 <20190603122725.GB19426@darkstar>
 <20190605140324.GL374014@devbig004.ftw2.facebook.com>
 <20190605143805.olk2ta5p2jnd4mjt@e110439-lin>
 <20190605144450.GN374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605144450.GN374014@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Jun 07:44, Tejun Heo wrote:
> Hello,

Hi,

> On Wed, Jun 05, 2019 at 03:39:50PM +0100, Patrick Bellasi wrote:
> > Which means we will enforce the effective values as:
> > 
> >    /tg1/tg11:
> > 
> >          util_min.effective=0
> >             i.e. keep the child protection since smaller than parent
> > 
> >          util_max.effective=800
> >             i.e. keep parent limit since stricter than child
> >
> > Please shout if I got it wrong, otherwise I'll update v10 to
> > implement the above logic.
> 
> Everything sounds good to me.  Please note that cgroup interface files
> actually use literal "max" for limit/protection max settings so that 0
> and "max" mean the same things for all limit/protection knobs.

Lemme see if I've got it right, do you mean that we can:

 1) write the _string_ "max" into a cgroup attribute to:

    - set    0 for util_max, since it's a protection
    - set 1024 for util_min, since it's a limit

 2) write the _string_ "0" into a cgroup attribute to:

    - set 1024 for util_max, since it's a protection
    - set    0 for util_min, since it's a limit

Is that correct or it's just me totally confused?


> Thanks.
> 
> --
> tejun

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
