Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE0C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70E2206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HQ7rJIh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfG2O2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:28:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46958 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfG2O2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cgd07V1X1aWq4Nq8OV+7HBCsrLjmlGfJU51VxLF3KME=; b=HQ7rJIh3bHrwXb5N+hm1m1ta2
        3xN8kgOWRqh7smEYAmFrsJkadsRGpGLLsb9/LHLQ7ywUfoljVN6vzmX+Bzw/03Co2DXcMu0BJRZyE
        qox34odUC6mRHsYT2mmBBcIq58sAF1mXYmXtJm6jQ5YwJ96Fqx8c3dLNZR3ODeLP5LnWEYNF0xod5
        eMq1JAQ/NAdU6bQ20v8FDHnuKmDlCGL1lXRg2R4BEu9qLOWxqHU7b/51x4ducyTPTFmu+731k6hXA
        KwDWNZRXZr96XzMPdBleNmGzRwcOAlMP6kGNFFVV+gpKnCWbcVoyyamjgy+CHXCAQbcBJ8izHsMPN
        R71FeIoDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6d3-0002u2-Ca; Mon, 29 Jul 2019 14:27:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2974320AFFEAD; Mon, 29 Jul 2019 16:27:56 +0200 (CEST)
Date:   Mon, 29 Jul 2019 16:27:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190729142756.GF31425@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729085235.GT31381@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:52:35AM +0200, Peter Zijlstra wrote:
> On Sat, Jul 27, 2019 at 01:10:47PM -0400, Waiman Long wrote:
> > It was found that a dying mm_struct where the owning task has exited
> > can stay on as active_mm of kernel threads as long as no other user
> > tasks run on those CPUs that use it as active_mm. This prolongs the
> > life time of dying mm holding up memory and other resources like swap
> > space that cannot be freed.
> 
> Sure, but this has been so 'forever', why is it a problem now?
> 
> > Fix that by forcing the kernel threads to use init_mm as the active_mm
> > if the previous active_mm is dying.
> > 
> > The determination of a dying mm is based on the absence of an owning
> > task. The selection of the owning task only happens with the CONFIG_MEMCG
> > option. Without that, there is no simple way to determine the life span
> > of a given mm. So it falls back to the old behavior.
> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  include/linux/mm_types.h | 15 +++++++++++++++
> >  kernel/sched/core.c      | 13 +++++++++++--
> >  mm/init-mm.c             |  4 ++++
> >  3 files changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 3a37a89eb7a7..32712e78763c 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -623,6 +623,21 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
> >  	return atomic_read(&mm->tlb_flush_pending) > 1;
> >  }
> >  
> > +#ifdef CONFIG_MEMCG
> > +/*
> > + * A mm is considered dying if there is no owning task.
> > + */
> > +static inline bool mm_dying(struct mm_struct *mm)
> > +{
> > +	return !mm->owner;
> > +}
> > +#else
> > +static inline bool mm_dying(struct mm_struct *mm)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  struct vm_fault;
> 
> Yuck. So people without memcg will still suffer the terrible 'whatever
> it is this patch fixes'.

Also; why then not key off that owner tracking to free the resources
(and leave the struct mm around) and avoid touching this scheduling
hot-path ?
