Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809FAC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7F9205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfDYMru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:47:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43202 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfDYMrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:47:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44947A78;
        Thu, 25 Apr 2019 05:47:48 -0700 (PDT)
Received: from queper01-ThinkPad-T460s (unknown [10.37.8.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEDC53F5C1;
        Thu, 25 Apr 2019 05:47:45 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:47:44 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
Message-ID: <20190425124741.y5stnnf7moujmout@queper01-ThinkPad-T460s>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
 <20190425105658.q45cmfogrt6wwtih@queper01-ThinkPad-T460s>
 <CAKfTPtBvY3xiDt6tcqF7GoZki3VihD4Tz7E5ctE8hNaNzL6NPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBvY3xiDt6tcqF7GoZki3VihD4Tz7E5ctE8hNaNzL6NPA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 Apr 2019 at 14:45:57 (+0200), Vincent Guittot wrote:
> On Thu, 25 Apr 2019 at 12:57, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Tuesday 16 Apr 2019 at 15:38:39 (-0400), Thara Gopinath wrote:
> > > +/* Per cpu structure to keep track of Thermal Pressure */
> > > +struct thermal_pressure {
> > > +     unsigned long scale; /* scale reflecting average cpu max capacity*/
> > > +     unsigned long acc_scale; /* Accumulated scale for this time window */
> > > +     unsigned long old_scale; /* Scale value for the previous window */
> > > +     unsigned long raw_scale; /* Raw max capacity */
> > > +     unsigned long age_stamp; /* Last time old_scale was updated */
> > > +     unsigned long last_update; /* Last time acc_scale was updated */
> > > +     spinlock_t lock; /* Lock for protecting from simultaneous access*/
> > > +     /* Timer for periodic update of thermal pressure */
> > > +     struct timer_list timer;
> >
> > Do you actually need the periodic update ? You only really need to
> > update the 'scale' value when updating the LB stats no ? Nobody
> > accesses that value in between two LBs.
> 
> Do you mean calling a variant of sched_update_thermal_pressure() in
> update_cpu_capacity() instead of periodic update ?
> Yes , that should be enough

Right something like this, and remove all the timers. Should be a bit
cleaner I guess.

Thanks,
Quentin
