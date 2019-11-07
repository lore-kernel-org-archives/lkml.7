Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955ED21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbfKGPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:54:55 -0500
Received: from foss.arm.com ([217.140.110.172]:58446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730374AbfKGPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:54:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CF4130E;
        Thu,  7 Nov 2019 07:54:54 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14A353F71A;
        Thu,  7 Nov 2019 07:54:52 -0800 (PST)
Date:   Thu, 7 Nov 2019 15:54:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH 1/2] perf/core: Adding capability to disable PMUs event
 multiplexing
Message-ID: <20191107155445.GA7259@lakrids.cambridge.arm.com>
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-2-git-send-email-gkulkarni@marvell.com>
 <20191106112810.GA50610@lakrids.cambridge.arm.com>
 <CAKTKpr6U8gUp4C9muN2cL4wn33o2LAa5QnTO2MSmfnBz8oUc=Q@mail.gmail.com>
 <20191107145213.GB6888@lakrids.cambridge.arm.com>
 <CAKTKpr70=hFdwq43SBM-1jmbNxc1suyn3XouQhsj2m4tM+jeUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTKpr70=hFdwq43SBM-1jmbNxc1suyn3XouQhsj2m4tM+jeUg@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 07:45:07AM -0800, Ganapatrao Kulkarni wrote:
> On Thu, Nov 7, 2019 at 6:52 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Nov 06, 2019 at 03:28:46PM -0800, Ganapatrao Kulkarni wrote:
> > > Hi Peter, Mark,
> > >
> > > On Wed, Nov 6, 2019 at 3:28 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Wed, Nov 06, 2019 at 01:01:40AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> > > > > When PMUs are registered, perf core enables event multiplexing
> > > > > support by default. There is no provision for PMUs to disable
> > > > > event multiplexing, if PMUs want to disable due to unavoidable
> > > > > circumstances like hardware errata etc.
> > > > >
> > > > > Adding PMU capability flag PERF_PMU_CAP_NO_MUX_EVENTS and support
> > > > > to allow PMUs to explicitly disable event multiplexing.
> > > >
> > > > Even without multiplexing, this PMU activity can happen when switching
> > > > tasks, or when creating/destroying events, so as-is I don't think this
> > > > makes much sense.
> > > >
> > > > If there's an erratum whereby heavy access to the PMU can lockup the
> > > > core, and it's possible to workaround that by minimzing accesses, that
> > > > should be done in the back-end PMU driver.
> > >
> > > As said in errata,  If there are heavy access to memory like stream
> > > application running and along with that if PMU control registers are
> > > also accessed frequently, then CPU lockup is seen.
> >
> > Ok. So the issue is the frequency of access to those registers.
> >
> > Which registers does that apply to?
> 
> The control register which are used to start, stop the counter and the
> register which is used to set the event type.

Ok. Thanks for confirming those details.

> > Is this the case for only reads, only writes, or both?
> 
> It is write  issue, the h/w block has limited write buffers and
> overflow getting hardware in weird state, when memory transactions are
> high.

Just to confirm -- is that writes to the control registers that are
buffered, or is it that buffering of normal memory accesses goes wrong
when the control registers are under heavy load?

> > Does the frequency of access actually matter, or is is just more likely
> > that we see the issue with a greater number of accesses? i.e the
> > increased frequency increases the probability of hitting the issue.
> 
> This is one scenario.
> Any higher access to PMU register, when memory is busy needs to be controlled.

Could you explain what you mean by "higher access to PMU register"?

Is there some threshold under which this is guaranteed to be ok? Or is
it probablistic, and we need to minimize accesses at all times?

> > I'd really like a better description of the HW issue here.
> >
> > > I ran perf stat with 4 events of thuderx2 PMU as well as with 6 events
> > > for stream application.
> > > For 4 events run, there is no event multiplexing, where as for 6
> > > events run the events are multiplexed.
> > >
> > > For 4 event run:
> > > No of times pmu->add is called: 10
> > > No of times pmu->del is called: 10
> > > No of times pmu->read is called: 310
> > >
> > > For 6 events run:
> > > No of times pmu->add is called: 5216
> > > No of times pmu->del is called: 5216
> > > No of times pmu->read is called: 5216
> > >
> > > Issue happens when the add and del are called too many times as seen
> > > with 6 event case.
> >
> > Sure, but I can achieve similar by creating/destroying events in a loop.
> > Multiplexing is _one_ way to cause this behaviour, but it's not the
> > _only_ way.
> 
> I agree, there may be other use cases also, however i am trying to fix
> the common use case.

I appreciate what you're trying to do, but I think it's the wrong
approach.

Depending on the precise conditions under which this happens, I think
that we may be able to solve this entirely within the TX2 PMU driver,
handling all cases and also not breaking multiplexing.

Thanks,
Mark.
