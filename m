Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDC1C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0405522DD3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjXCf0+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbfIEKq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:46:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIEKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gnHLwW18GHsqNY1glFxvL0YT/FOtfFV2qvtzl/muhyA=; b=kjXCf0+cZaU+Uq4bITC4armFQ
        MW7ezSuVSJtE2ZoY7h58hQqHDrjLDLjuKfTk7DyOdKxRCUNPAXr0kE29b0n1cD3XU+2x6RdNnw/Xz
        kZHQKf+mqmtlxM0Z0r7fDc3hTdEQ9kKnhphBO96TfYHgBYE8152nHFtF7PZ2pxyvsHxzn0FSUfx7Z
        kxVXBKgZLlPpJuX3s/zdg7TfEWEmujqd2WM6oZaxSHO7uBmJwddV/siCASyURpVqOYoHcbe4B8dHw
        gBCQ3ytjTSqx5VhyzCvBx3HV4C41STeowQf85ATCcX/O5GanboG5w04KHaGUPrxQzOliuy4coy9+w
        tbWu+tDaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5pHO-0002CN-Uk; Thu, 05 Sep 2019 10:46:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6113530604E;
        Thu,  5 Sep 2019 12:45:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FBD229BB14BE; Thu,  5 Sep 2019 12:46:16 +0200 (CEST)
Date:   Thu, 5 Sep 2019 12:46:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20190905104616.GD2332@hirez.programming.kicks-ass.net>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r24v2i14.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:45:27AM +0100, Patrick Bellasi wrote:

> > From just reading the above, I would expect it to have the range
> > [-20,19] just like normal nice. Apparently this is not so.
> 
> Regarding the range for the latency-nice values, I guess we have two
> options:
> 
>   - [-20..19], which makes it similar to priorities
>   downside: we quite likely end up with a kernel space representation
>   which does not match the user-space one, e.g. look at
>   task_struct::prio.
> 
>   - [0..1024], which makes it more similar to a "percentage"
> 
> Being latency-nice a new concept, we are not constrained by POSIX and
> IMHO the [0..1024] scale is a better fit.
> 
> That will translate into:
> 
>   latency-nice=0 : default (current mainline) behaviour, all "biasing"
>   policies are disabled and we wakeup up as fast as possible
> 
>   latency-nice=1024 : maximum niceness, where for example we can imaging
>   to turn switch a CFS task to be SCHED_IDLE?

There's a few things wrong there; I really feel that if we call it nice,
it should be like nice. Otherwise we should call it latency-bias and not
have the association with nice to confuse people.

Secondly; the default should be in the middle of the range. Naturally
this would be a signed range like nice [-(x+1),x] for some x. but if you
want [0,1024], then the default really should be 512, but personally I
like 0 better as a default, in which case we need negative numbers.

This is important because we want to be able to bias towards less
importance to (tail) latency as well as more importantance to (tail)
latency.

Specifically, Oracle wants to sacrifice (some) latency for throughput.
Facebook OTOH seems to want to sacrifice (some) throughput for latency.
