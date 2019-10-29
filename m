Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E1CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A73E21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfJ2Mqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:46:35 -0400
Received: from foss.arm.com ([217.140.110.172]:51684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfJ2Mqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:46:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D05221FB;
        Tue, 29 Oct 2019 05:46:33 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 940C43F6C4;
        Tue, 29 Oct 2019 05:46:32 -0700 (PDT)
Date:   Tue, 29 Oct 2019 12:46:30 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191029124630.ivfbpenue3fw33qt@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
 <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
 <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/19 13:20, Vincent Guittot wrote:
> > > Making big cores the default CPUs for all RT tasks is not a minor
> > > change and IMO locality should stay the default behavior when there is
> > > no uclamp constraint
> >
> > How this is affecting locality? The task will always go to the big core, so it
> > should be local.
> 
> local with the waker
> You will force rt task to run on big cluster although waker, data and
> interrupts can be on little one.
> So making big core as default is far from always being the best choice

This is loaded with assumptions IMO. AFAICT we don't know what's the best
choice.

First, the value of uclamp.min is outside of the scope of this patch. Unless
what you're saying is that when uclamp.min is 1024 then we should NOT choose a
big cpu then there's no disagreement about what this patch do. If that's what
you're objecting to please be more specific about how do you see this working
instead.

If your objection is purely based on the choice of uclamp.min then while
I agree that on modern systems the little cores are good enough for the
majority of RT tasks in average Android systems. But I don't feel confident to
reach this conclusion on low end systems where the little core doesn't have
enough grunt in many cases. So I see the current default is adequate and the
responsibility of further tweaking lies within the hands of the system admin.

--
Qais Yousef
