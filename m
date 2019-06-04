Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD65BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B4A20859
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pnah5gSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFDRTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:19:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41312 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFDRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gWGjWzmCxsyuXIXCpCZydRWI4/aqXORiJ7KdqIf6h8A=; b=pnah5gSItygt61ykCf1GYTq/j
        uUzMYF9hlIKA/l8FEHyURRElzRnkJ3zAL8SYH+lB2itn68gHmROydqhB3TsGGgNmXEPiCM3FRdZnK
        Mo1CYz+qCywwBDt24sgh7vU9aTS1N1dUGOAWxUY52r7iRl+hthks2u3ExihCj3H+2JzCgY6vqEwi5
        5jLS6HaSLouyyumMm8KqkeDgkMDf0gWWebCelraH/QANcLXMTq+1A4fXAfk52wSZHcgNJshvqccCb
        HuYI8iiOsa/8HPh6pfjJo+pAmOjDksq46njBnXFh23fqWsySS66krfqiPRK9/MuBh/vJeMMcnrg4T
        Ln7EAfnjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYD5B-0007jT-Mr; Tue, 04 Jun 2019 17:18:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A82B2008D9D7; Tue,  4 Jun 2019 19:18:44 +0200 (CEST)
Date:   Tue, 4 Jun 2019 19:18:44 +0200
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
Subject: Re: [PATCH v8 17/19] locking/rwsem: Merge owner into count on x86-64
Message-ID: <20190604171844.GF3419@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-18-longman@redhat.com>
 <20190604094537.GK3402@hirez.programming.kicks-ass.net>
 <d03f319a-790c-3084-2908-76f44d3f41f5@redhat.com>
 <20190604170218.GE3419@hirez.programming.kicks-ass.net>
 <28a6c7b5-c40e-1c89-03e2-688c1135f3b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a6c7b5-c40e-1c89-03e2-688c1135f3b5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:06:11PM -0400, Waiman Long wrote:
> On 6/4/19 1:02 PM, Peter Zijlstra wrote:
> > On Tue, Jun 04, 2019 at 11:47:21AM -0400, Waiman Long wrote:
> >> On 6/4/19 5:45 AM, Peter Zijlstra wrote:
> >>> On Mon, May 20, 2019 at 04:59:16PM -0400, Waiman Long wrote:
> >>>> With separate count and owner, there are timing windows where the two
> >>>> values are inconsistent. That can cause problem when trying to figure
> >>>> out the exact state of the rwsem. For instance, a RT task will stop
> >>>> optimistic spinning if the lock is acquired by a writer but the owner
> >>>> field isn't set yet. That can be solved by combining the count and
> >>>> owner together in a single atomic value.
> >>> I just realized we can use cmpxchg_double() here (where available of
> >>> course).
> >> Does the 2 doubles need to be 128-bit aligned to use cmpxchg_double()? I
> >> don't think we can guarantee that unless we explicitly set this alignment.
> > It does :/ and yes, we'd need to play games with __align(2*sizeof(long))
> > and such.
> 
> So do you want this as an option now as it will be x86 specific? Or we
> can do that as a follow-up if we want to.

x86, s390 and arm64 have cmpxchg_double().

I was going to have a look (but like I wrote, I'm pretty useless today
so i didn't actually get anywhere) at the exact race that's a problem
here and see if there's not another solution too.

