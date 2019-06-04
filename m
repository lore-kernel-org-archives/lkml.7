Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF07C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E408C20717
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ra2EEE/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFDSOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:14:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41818 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QHMRtkbg/vKvfRo8sZE/mY2gYzUHuRCKTR/YthVWl8c=; b=ra2EEE/Ob/ezj0iKYgP/I/wYc
        I3qXruB7acYxBCHDSjG5Q0+g9oP6uX/bov2hBRJXKr6aHlx17pc1ks61TmkBSHps5Ybt+uqiFojeV
        Zx2kp2oIUkzb0357uqIoShpsDBdXsit8Pwd4pNNZ6UN5xCIAlF2HcANkC4fd2eE9oFaQuUjldKKHo
        Wm82OcsT+9sV/7+wsLcLX2psc3Iug6uQRzihCDnDKPA7LwPrMiB8ZyM6uwo31kIZB3CTb1KN7WyLa
        wGjmD1GNg+C3BKy73Td+CJC5vCiEgUBeaagGFS+9c5V7KvvMOvzBYLSpwC7+UIStoYgx5cgHaw6N3
        oW30DAoiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYDx7-00082X-Al; Tue, 04 Jun 2019 18:14:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB814209638E7; Tue,  4 Jun 2019 20:14:26 +0200 (CEST)
Date:   Tue, 4 Jun 2019 20:14:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
Message-ID: <20190604181426.GH3419@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
 <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
 <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
 <20190604173853.GG3419@hirez.programming.kicks-ass.net>
 <f7f9b778-4f1a-7460-a7ae-1d4e3dd37181@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f9b778-4f1a-7460-a7ae-1d4e3dd37181@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 02:04:34PM -0400, Waiman Long wrote:
> On 6/4/19 1:38 PM, Peter Zijlstra wrote:
> > On Tue, Jun 04, 2019 at 01:30:00PM -0400, Waiman Long wrote:
> >>> That's somewhat inconsistent wrt the type. I'll make it unsigned long,
> >>> as that is what makes most sense, given there's a pointer inside.
> >> Thank for spotting that, I will fix it.
> > I fixed a whole bunch of them; please find the modified patches here:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=locking/core
> 
> Thanks for reviewing the patches.
> 
> So how do you think about the overall state of this patchset? Do you
> think it is mature enough to go into 5.3?

So far so good :-)

> Or if you want more time to think about solving the RT thread issue, we
> can merge just patches 1-16 and play with the last threes for some more
> time. I am fine with that too as improving RT tasks is not my main
> focus. I like patch 16 as it led me to discover the rwsem reader wakeup
> bug as I hit the negative dentry count WARN_ON message in my testing.

My brain gave out around patch 14.. I'll try again tomorrow. But I'm
thinking we should be able to do as you suggest and get -16 merged.

> I worked on this owner merging patch mainly to alleviate the need to use
> cmpxchg for reader lock. cmpxchg_double() is certainly one possible
> solution though it won't work on older CPUs. We can have a config option
> to use cmpxchg_double as it may increase the size of other structures
> that embedded rwsem and impose additional alignment constraint.

cmpxchg8b was introduced with the Pentium (for PAE IIRC, it enabled
atomic 64bit PTEs, but Linux never used it for that) and every Intel/AMD
thereafter has had it. AFAIK there's no x86_64 chip without cmpxchg16b.
