Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711B9C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F7720836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXpjKC1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGBIfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:35:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44532 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGBIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fzuDJRp1GS1NXqeYiBlRbpLNKor0YyYTWdJKqC2k2W8=; b=PXpjKC1L/ZQH0U3MH0ew5Q0iK
        os1DO7nXa0YF3DvR3UAKHdnl5aSdcQuyZXCfpwrLiluTdN8qF8R8OYhWM4OF7PHHM6X7K90YzsLOQ
        YXKR2fbV0djPsUSJcC4KrRu8ZQ1Yyvg0anITTN4hJbUs6Hx80Pefga6eWGjv+BhBhcykOKFaYJWO6
        rwAPWEprtgnH7zHRSyJ9YdVWyHLhepjeBsd0Jc2voDAyv5iWnYRj2N23jcuIwLypT/ibnvz7Qdqp6
        XaqEW5IK/ZYFc37G3Zrzd7VNsGSAC1tLvI2Kwqu6/eMVbh4qYrTf7ojQCdmXINo4fMxZjkVU2kPN3
        axIs56tHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiEG0-0005ZG-5y; Tue, 02 Jul 2019 08:35:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8063F20ADAD55; Tue,  2 Jul 2019 10:35:17 +0200 (CEST)
Date:   Tue, 2 Jul 2019 10:35:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, songliubraving@fb.com
Subject: Re: [PATCH V3 2/2] sched/fair: Fallback to sched-idle CPU if idle
 CPU isn't found
Message-ID: <20190702083517.GY3419@hirez.programming.kicks-ass.net>
References: <cover.1561523542.git.viresh.kumar@linaro.org>
 <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
 <32bd769c-b692-8896-5cc9-d19ab0a23abb@oracle.com>
 <20190701080349.homlsgia4fuaitek@vireshk-i7>
 <aeaa0dd5-8512-1b60-eb10-6a4aecfaaca3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeaa0dd5-8512-1b60-eb10-6a4aecfaaca3@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 03:08:41PM -0700, Subhra Mazumdar wrote:
> On 7/1/19 1:03 AM, Viresh Kumar wrote:
> > On 28-06-19, 18:16, Subhra Mazumdar wrote:
> > > On 6/25/19 10:06 PM, Viresh Kumar wrote:

> > > > @@ -5376,6 +5376,15 @@ static struct {
> > > >    #endif /* CONFIG_NO_HZ_COMMON */
> > > > +/* CPU only has SCHED_IDLE tasks enqueued */
> > > > +static int sched_idle_cpu(int cpu)
> > > > +{
> > > > +	struct rq *rq = cpu_rq(cpu);
> > > > +
> > > > +	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
> > > > +			rq->nr_running);
> > > > +}
> > > > +
> > > Shouldn't this check if rq->curr is also sched idle?
> > Why wouldn't the current set of checks be enough to guarantee that ?
> I thought nr_running does not include the on-cpu thread.

It very much does.

> > > And why not drop the rq->nr_running non zero check?
> > Because CPU isn't sched-idle if nr_running and idle_h_nr_running are both 0,
> > i.e. it is an IDLE cpu in that case. And so I thought it is important to have
> > this check as well.
> > 
> idle_cpu() not only checks nr_running is 0 but also rq->curr == rq->idle

idle_cpu() will try very hard to declare a CPU !idle. But I don't see
how that it relevant. sched_idle_cpu() will only return true if there
are only SCHED_IDLE tasks on the CPU. Viresh's test is simple and
straight forward.

