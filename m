Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2132AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AFC20730
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfKTReg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:34:36 -0500
Received: from foss.arm.com ([217.140.110.172]:43606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfKTReg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:34:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6A1D1FB;
        Wed, 20 Nov 2019 09:34:35 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15EE23F703;
        Wed, 20 Nov 2019 09:34:33 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:34:31 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 11/11] sched/fair: rework find_idlest_group
Message-ID: <20191120173431.b7e4jbq44mjletfe@e107158-lin.cambridge.arm.com>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
 <CAKfTPtDh7HAv2Krx9cRKcA+Zy=erYkykyZZj4=nkRoTEdY=oFw@mail.gmail.com>
 <CAKfTPtCFP3_U_YxwR8+Gs+HYJPmqSWJg6B6nBdgccNru8Gh5QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCFP3_U_YxwR8+Gs+HYJPmqSWJg6B6nBdgccNru8Gh5QA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 17:53, Vincent Guittot wrote:
> On Wed, 20 Nov 2019 at 14:21, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Qais,
> >
> > On Wed, 20 Nov 2019 at 12:58, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > Hi Vincent
> > >
> > > On 10/18/19 15:26, Vincent Guittot wrote:
> > > > The slow wake up path computes per sched_group statisics to select the
> > > > idlest group, which is quite similar to what load_balance() is doing
> > > > for selecting busiest group. Rework find_idlest_group() to classify the
> > > > sched_group and select the idlest one following the same steps as
> > > > load_balance().
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > >
> > > LTP test has caught a regression in perf_event_open02 test on linux-next and I
> > > bisected it to this patch.
> > >
> > > That is checking out next-20191119 tag and reverting this patch on top the test
> > > passes. Without the revert the test fails.
> 
> I haven't tried linux-next yet but LTP test is passed with
> tip/sched/core, which includes this patch, on hikey960 which is arm64
> too.
> 
> Have you tried tip/sched/core on your juno ? this could help to
> understand if it's only for juno or if this patch interact with
> another branch merged in linux next

Okay will give it a go. But out of curiosity, what is the output of your run?

While bisecting on linux-next I noticed that at some point the test was
passing but all the read values were 0. At some point I started seeing
none-zero values.

--
Qais Yousef
