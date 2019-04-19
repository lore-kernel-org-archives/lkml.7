Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2329921479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tkSMhpou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfDSTa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:30:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfDSTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HeRWp3SbhYmoU91Lf8c1z2p2ddTb4bDbJKsU2tWCahE=; b=tkSMhpoum3YIfOBi7tKJVq9Yx
        UMuKJJUDWogZqua/oD58ODAPZIns9EArjYEoll3EBvu3a4aONaOnIdLDsIhfNRcrHCoC7BIokfxFY
        ZkoSgDs5IJS6Bk0yZUK2qTP4FIo9RYWAXiq/CLhT1RnQnweIdPjbcswLvoBcrsupCpga2XNUXQQey
        VpGBgUnXIB9eQA+XQ9wjGzRsSVLb1uByAfkR4TJqVCH1nd9b12r5Te6e0mdk7LxxgRGel2f52Netj
        gI4Q9j3VO7udHGgAkDDAES8q3p5XRjxm1QhnXTCPIcwKCkO89RDPP5jA4bKEYm0X6cBcLye24hSr4
        l+ik22GoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHONZ-0004Rd-GR; Fri, 19 Apr 2019 07:56:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A61329B52926; Fri, 19 Apr 2019 09:56:10 +0200 (CEST)
Date:   Fri, 19 Apr 2019 09:56:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 12/16] locking/rwsem: Enable time-based spinning on
 reader-owned rwsem
Message-ID: <20190419075610.GN4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-13-longman@redhat.com>
 <20190418130611.GK4038@hirez.programming.kicks-ass.net>
 <52aee7c3-b8aa-a617-c1f2-34bc99c72474@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52aee7c3-b8aa-a617-c1f2-34bc99c72474@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:15:33AM -0400, Waiman Long wrote:
> On 04/18/2019 09:06 AM, Peter Zijlstra wrote:

> >> +			/*
> >> +			 * Check time threshold every 16 iterations to
> >> +			 * avoid calling sched_clock() too frequently.
> >> +			 * This will make the actual spinning time a
> >> +			 * bit more than that specified in the threshold.
> >> +			 */
> >> +			else if (!(++loop & 0xf) &&
> >> +				 (sched_clock() > rspin_threshold)) {
> > Why is calling sched_clock() lots a problem?
> 
> Actually I am more concern about the latency introduced by the
> sched_clock() call. BTW, I haven't done any measurement myself. Do you
> know how much cost the sched_clock() call is?
> 
> If the cost is relatively high, the average latency period after the
> lock is free and the spinner is ready to do a trylock will increase.

Totally depends on the arch or course :/ For 'sane' x86 it is: RDTSC,
MUL; SHRD; SHR; ADD, which is plenty fast.

I know we have poll loops with sched_clock/local_clock in them, I just
can't seem to find any atm.
