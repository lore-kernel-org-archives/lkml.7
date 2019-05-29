Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C55CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222E6208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="McFL6gJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE2KKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:10:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfE2KKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=95Oxk8yU+7lW8gyKo1/2OpFJ/n7OwlhaWfOSt2Jh2II=; b=McFL6gJP1i+wIeMgFZ59Fim5k
        IDvtMHIF5SfmGl1JMacxqRL2kGI/ky/ZVTBcnnEy/CQNZ2hAAONCEnX+fkx1ekitpHqEgNtef2Ly1
        lUZgOdcJDtSaXcsG08P+kX5ymVDaVbuppat2lI9cTXVOUTE7Lh2BShA4KePoXw/lZUsMUeicU2s4R
        0K7F0KAFRaGx60tJBrZwgVJ79szyvqAIz+0b1ytxjE9HIRBsjI1YU2NpwknMtpMjld/WuLEK4i1BY
        xD0HoaZ5pHWInHch+tAZQRI9AW7CFXKgR+XGI1DmHu2qqYWJmctPFFMqfNSyVzdzSzIZYwtOA37ur
        l0Rxt/jAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVvXf-0008LP-VT; Wed, 29 May 2019 10:10:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78560201A7E40; Wed, 29 May 2019 12:10:42 +0200 (CEST)
Date:   Wed, 29 May 2019 12:10:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529101042.GN2623@hirez.programming.kicks-ass.net>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529091733.GA4485@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:17:33AM +0100, Will Deacon wrote:
> On Tue, May 28, 2019 at 07:32:28PM +0200, Peter Zijlstra wrote:

> > 'funny' thing that, perf_sample_regs_user() seems to assume that
> > anything with current->mm is in fact a user task, and that assumption is
> > just plain wrong, consider use_mm().
> 
> Right, I suppose that was attempting to handle interrupt skid from the PMU
> overflow?

Nah, just a broken test to determine if there is userspace at all. It is
mostly right, just not completely :-)

> > So I'm thinking the right thing to do here is something like the below;
> > umh should get PF_KTHREAD cleared when it passes exec(). And this should
> > also fix the power splat I'm thinking.
> > 
> > ---
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index abbd4b3b96c2..9929404b6eb9 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5923,7 +5923,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
> >  	if (user_mode(regs)) {
> >  		regs_user->abi = perf_reg_abi(current);
> >  		regs_user->regs = regs;
> > -	} else if (current->mm) {
> > +	} else if (!(current->flags & PF_KTHREAD) && current->mm) {
> >  		perf_get_regs_user(regs_user, regs, regs_user_copy);
> 
> Makes sense, but under which circumstances would we have a NULL mm here?

Dunno; I'm paranoid, and also:

  mm/memcontrol.c:        if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
  mm/vmacache.c:  return current->mm == mm && !(current->flags & PF_KTHREAD);

