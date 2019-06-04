Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61F5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAF820883
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iPXATZBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfFDRCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:02:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40946 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfFDRCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cOmAcXP3xslB9SN+5584hLRHldJIouXYPbVgjk2nYSM=; b=iPXATZBtcyo8M05+4EfxuLU+b
        mk10UIWmgoSKPjpOIFJx92Ro5KTGoGDRD2cHYYIXwj5ONEuphhuEINydK47JTVs8Wzw71hfn19MC7
        JGHMuVBbd6AmmoHBxq5ZB6ZNL6fuZkwyHburri88Vbs8wJrfL5CuNwDBUfXT8tWUq7BkFHRSLeGNv
        IE+1IWJwOOAqwPMdGfWwcFpeCIOECFGQqgbsAC6kRoiebf9aOMkKwd9EOniVOijd14p1BOlE/xftP
        RzsPBhT15AButzFfThpFJFD3MQLX4DT8bVxDcnvInzRlPx1qdlJoOCF23F3vX7mLE3OriUii9bcaR
        7yVJlD5cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYCpJ-0007Zn-5N; Tue, 04 Jun 2019 17:02:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2C0220114D92; Tue,  4 Jun 2019 19:02:18 +0200 (CEST)
Date:   Tue, 4 Jun 2019 19:02:18 +0200
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
Message-ID: <20190604170218.GE3419@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-18-longman@redhat.com>
 <20190604094537.GK3402@hirez.programming.kicks-ass.net>
 <d03f319a-790c-3084-2908-76f44d3f41f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03f319a-790c-3084-2908-76f44d3f41f5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:47:21AM -0400, Waiman Long wrote:
> On 6/4/19 5:45 AM, Peter Zijlstra wrote:
> > On Mon, May 20, 2019 at 04:59:16PM -0400, Waiman Long wrote:
> >> With separate count and owner, there are timing windows where the two
> >> values are inconsistent. That can cause problem when trying to figure
> >> out the exact state of the rwsem. For instance, a RT task will stop
> >> optimistic spinning if the lock is acquired by a writer but the owner
> >> field isn't set yet. That can be solved by combining the count and
> >> owner together in a single atomic value.
> > I just realized we can use cmpxchg_double() here (where available of
> > course).
> 
> Does the 2 doubles need to be 128-bit aligned to use cmpxchg_double()? I
> don't think we can guarantee that unless we explicitly set this alignment.

It does :/ and yes, we'd need to play games with __align(2*sizeof(long))
and such.
