Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF929C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A477F2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DGvYhSgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfGANoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:44:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfGANoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w0VI24MunDSPULjn1w4xJ2RakkuV8gfIqZVFxUPHrOA=; b=DGvYhSgfU3SNTQxT9W023jL+W
        IDOzDEXTEqB6mo2GHK7m8awhXIJRyGFoznTAeBSXVjtRdDOxZFktbNdblf9FvWaRZhgdv6wdlqXi1
        SX7/VTmP+B+mFHF900CIHUn5XrTaPGzymXe5auc8yZTlh+ZXA/nKp4+aCQ+Qe52JO3eszB5FpbijT
        leNaNOxCRnr56gK+v5f/+fmxEw9tuq1JxsbPYdsZn6GX3huoB9W+9RI4Wjs6Zb2rWiLdLxbuIj1Zf
        mHJ+MpQmjaRC6il1CgrJEATXIAk5AIP96Erx5Zm3aNttlPkeDzm45rY5J5/Ayxi2WKAzcZy7ygRhz
        hjQ7/t2OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhwav-00066b-TU; Mon, 01 Jul 2019 13:43:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F9AB20A18921; Mon,  1 Jul 2019 15:43:43 +0200 (CEST)
Date:   Mon, 1 Jul 2019 15:43:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com,
        songliubraving@fb.com
Subject: Re: [PATCH V3 0/2] sched/fair: Fallback to sched-idle CPU in absence
 of idle CPUs
Message-ID: <20190701134343.GT3402@hirez.programming.kicks-ass.net>
References: <cover.1561523542.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561523542.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:36:28AM +0530, Viresh Kumar wrote:
> Hi,
> 
> We try to find an idle CPU to run the next task, but in case we don't
> find an idle CPU it is better to pick a CPU which will run the task the
> soonest, for performance reason.
> 
> A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> should be a good target based on this criteria as any normal fair task
> will most likely preempt the currently running SCHED_IDLE task
> immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
> shall give better results as it should be able to run the task sooner
> than an idle CPU (which requires to be woken up from an idle state).
> 
> This patchset updates both fast and slow paths with this optimization.

So this basically does the trivial SCHED_IDLE<-* wakeup preemption test;
one could consider doing the full wakeup preemption test instead.

Now; the obvious argument against doing this is cost; esp. the cgroup
case is very expensive I suppose. But it might be a fun experiment to
try.

That said; I'm tempted to apply these patches..
