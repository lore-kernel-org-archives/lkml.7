Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BC2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725A520675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/lwEiye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfCFL1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:27:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41858 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EahDqupL8oBYszAwGCUMMzKRqHs84xSr9hfXbSuWqpQ=; b=c/lwEiyez7yrEoVb/ngAtQEam
        IuUTHWyfv0neqEgJ2lvlFAcTAt6fZpV3bKdH4qYWmF+TqNGc5z5FJE5z/sUlh08GgqdxKueYbkpHU
        AgHU8KD+3SFfBZZx1gCQU2Ysg1T+G9CPSqaMjlJ+GL7mATS1ZBKEDu7Oe5GZnc58TP5jfEkoHfAl6
        FKhDm4M1kwEEx5VSF+Hn66w+ON3VdFhP0/IdGi1Ye5fUtd7CN0jPS4y23lWkJxVhcocabpQeMEBD1
        uVZYEKzAHqlpBcbZElPXE15SZ1fW8NwqSQ201jz0fszvoMWZtYRFJp8ZiKNX8O17cfzy2PK3W9ut5
        x2ceBYSJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1UhZ-00022z-Lr; Wed, 06 Mar 2019 11:27:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10CF820288BA3; Wed,  6 Mar 2019 12:27:07 +0100 (CET)
Date:   Wed, 6 Mar 2019 12:27:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
Message-ID: <20190306112707.GU32477@hirez.programming.kicks-ass.net>
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
 <20190306100907.GT32477@hirez.programming.kicks-ass.net>
 <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 06:15:39PM +0800, Yafang Shao wrote:
> On Wed, Mar 6, 2019 at 6:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 06, 2019 at 04:43:46PM +0800, Yafang Shao wrote:
> > > When I'm using trace_sched_stat_{iowait, blocked, wait, sleep} to
> > > measure how long the processes are stalled, there's always no output from
> > > trace_pipe while there're really some tasks in uninterruptible sleep
> > > state. That makes me confused, so I try to investigate why.
> > > Finally I find the reason is that CONFIG_SCHEDSTATS is not set.
> > >
> > > To avoid such kind of confusion, we should not expose these tracepoints
> > > if CONFIG_SCHEDSTATS is not set.
> >
> > Yeah, lets not sprinkle #ifdef. Big fat NAK.
> >
> > Also, the below seem to indicate your compiler is stupid. Without
> > CONFIG_SCHEDSTAT, schedstat_enabled() should be a constant 0 and DCE
> > should delete all code.
> >
> 
> My compiler is GCC-7.3.0.
> I don't know which comipler could be smart enough to remove the
> definition of these tracepoints.
> Could you pls. tell me what compiler you are using ?

Just look at the generated code...
