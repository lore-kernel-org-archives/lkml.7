Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5857EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E35E20825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1fcWC1li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbfIELku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:40:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44324 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733010AbfIELku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/GCMw/eEaPCB+aQnlkEbRw1aCbTfAQklVoBoCdkGQgI=; b=1fcWC1lirPTUsNfUnSlStbwHA
        myzMYuAcZBgdFdGEOmhPfU8V6h3hyOvitwkcSITI3lcPpUhHzlY/yNQaXB0CvtHaHkzJ9rh3w83HD
        MlhJzPl8JaJ6xaAt3VYONJbuArO4Q8rUPyWZ8NZ24hvvkCerFWxJvBk9+hczZKaSh2jdvF6yp23rc
        IqKYKNeoTWWhHlE4ZM2jclqY2ffjkLdEnRqJOBwC6g/aVPa59xF8ZJ6HPBnbwHwIpSBwIQ6LjdORy
        5TgIL8KAbpeafke6aPPJHoe1zvle22IOfmUkOvuq2fXX+PDVXb+erm8RJ4qNDhfnbpSIaxTRbKMHk
        Mva9DSx4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5q7s-0006Z3-NR; Thu, 05 Sep 2019 11:40:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB766306053;
        Thu,  5 Sep 2019 13:39:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D498F29CBE146; Thu,  5 Sep 2019 13:40:30 +0200 (CEST)
Date:   Thu, 5 Sep 2019 13:40:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20190905114030.GL2349@hirez.programming.kicks-ass.net>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <87imq72dpc.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imq72dpc.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:18:55PM +0100, Patrick Bellasi wrote:

> Right, we have this dualism to deal with and current mainline behaviour
> is somehow in the middle.
> 
> BTW, the FB requirement is the same we have in Android.
> We want some CFS tasks to have very small latency and a low chance
> to be preempted by the wake-up of less-important "background" tasks.
> 
> I'm not totally against the usage of a signed range, but I'm thinking
> that since we are introducing a new (non POSIX) concept we can get the
> chance to make it more human friendly.

I'm arguing that signed _is_ more human friendly ;-)

> Give the two extremes above, would not be much simpler and intuitive to
> have 0 implementing the FB/Android (no latency) case and 1024 the
> (max latency) Oracle case?

See, I find the signed thing more natural, negative is a bias away from
latency sensitive, positive is a bias towards latency sensitive.

Also; 0 is a good default value ;-)

> Moreover, we will never match completely the nice semantic, give that
> a 1 nice unit has a proper math meaning, isn't something like 10% CPU
> usage change for each step?

Only because we were nice when implementing it. Posix leaves it
unspecified and we could change it at any time. The only real semantics
is a relative 'weight' (opengroup uses the term 'favourable').

> Could changing the name to "latency-tolerance" break the tie by marking
> its difference wrt prior/nice levels? AFAIR, that was also the original
> proposal [1] by PaulT during the OSPM discussion.

latency torrerance could still be a signed entity, positive would
signify we're more tolerant of latency (ie. less sensitive) while
negative would be less tolerant (ie. more sensitive).

> For latency-nice instead we will likely base our biasing strategies on
> some predefined (maybe system-wide configurable) const thresholds.

I'm not quite sure; yes, for some of these things, like the idle search
on wakeup, certainly. But say for wakeup-preemption, we could definitely
make it a task relative attribute.
