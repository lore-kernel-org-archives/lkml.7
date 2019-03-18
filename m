Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD50C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4520850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7cJKzu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCRNK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:10:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfCRNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TgbMfsPXJjgj4Z50pQoy/elFXwkStx6pafrxtqKNDPk=; b=K7cJKzu+w2xj5Ex9M1bbYA/Z5
        LJW2jkQ8f/IOJRDYkskq77pSN/5cgo2XUSMIV7ll9Ze18+JWWgjvxGynjGUgok2t4dbLlNALGz/4G
        oQ637lrkdbyE1XWfIgl9O/Pz7wq+32FNuniEXC7hg5EXn5WSloMl6xbhoO60UBNIL2x1fOfyV0uHw
        wLZakQnM1D6hN5ZDsOCrLAhOK6GvVNdsD3rFAFnH49WRFyrM78J1ct/LVVz1FG8muvSOdaAXvBZAU
        nARZfWUGaIA+bX8owxJmKyZKo1wXsXGbBBZgcQspRtiHULelt0a9eEcX2DZXcBog8oolECC9XZinN
        cDap1bc3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5s2W-0006O1-DH; Mon, 18 Mar 2019 13:10:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60C1720A0FF8A; Mon, 18 Mar 2019 14:10:50 +0100 (CET)
Date:   Mon, 18 Mar 2019 14:10:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
Subject: Re: [PATCH v7 03/15] sched/core: uclamp: Add system default clamps
Message-ID: <20190318131050.GQ6058@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-4-patrick.bellasi@arm.com>
 <20190313201821.GW2482@worktop.programming.kicks-ass.net>
 <20190318121804.tr3myhtgczvovmkq@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318121804.tr3myhtgczvovmkq@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 12:18:04PM +0000, Patrick Bellasi wrote:
> On 13-Mar 21:18, Peter Zijlstra wrote:
> > On Fri, Feb 08, 2019 at 10:05:42AM +0000, Patrick Bellasi wrote:
> > > +static void uclamp_fork(struct task_struct *p)
> > > +{
> > > +	unsigned int clamp_id;
> > > +
> > > +	if (unlikely(!p->sched_class->uclamp_enabled))
> > > +		return;
> > > +
> > > +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> > > +		p->uclamp[clamp_id].active = false;
> > > +}
> > 
> > Because in that case .active == false, and copy_process() will have done
> > thr right thing?
> 
> Don't really get what you mean here? :/

Why don't we have to set .active=false when
!sched_class->uclamp_enabled?
