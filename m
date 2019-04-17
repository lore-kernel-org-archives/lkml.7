Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6234C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3CA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h3XSVs9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfDQJAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:00:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=enmcABnWUvYHanVHYgM0g9upvgwSCPXe+33Tj2Aa/Yo=; b=h3XSVs9FnpOR4S+6uPZAvYfxx
        Py3OmokhCTX90+0pebHtH5rN/Q/UP8stsAGlfkpPY1am83lriO8tGbox9w40CGQCDvwcQHQ+r9EHb
        HtmAmE9NeJoOqC3HXcW0O3vfIkQZVXGDQ3nhqIFIavkgTBVSgFWGKE0/cPVEXsZtm1MFEs5UEcp94
        SEgSlbFz9JJUPH975KzvN64bXfhrv325zdKTlVI/e+ua6fhvfHlwwGAWNRU0zuVHFc6rfmIypiruw
        9C25Qs0UEYrhC0YI18PsvhP8/9h3VBEprC22gCjbFhyVitHnvPam4g65QOS9HELIPbgi0K4JhYipr
        VGfK9rQXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGgQJ-0002cX-QJ; Wed, 17 Apr 2019 09:00:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BFCC29B52941; Wed, 17 Apr 2019 11:00:06 +0200 (CEST)
Date:   Wed, 17 Apr 2019 11:00:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 08/16] locking/rwsem: Make rwsem_spin_on_owner()
 return owner state
Message-ID: <20190417090006.GC4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-9-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-9-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:51PM -0400, Waiman Long wrote:
> This patch modifies rwsem_spin_on_owner() to return four possible
> values to better reflect the state of lock holder which enables us to
> make a better decision of what to do next.
> 
> In the special case that there is no active lock and the handoff bit
> is set, optimistic spinning has to be stopped.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem.c | 45 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index aaab546a890d..2d6850c3e77b 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -156,6 +156,11 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
>  	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
>  }
>  
> +static inline bool is_rwsem_owner_reader(struct task_struct *owner)
> +{
> +	return (unsigned long)owner & RWSEM_READER_OWNED;
> +}

Move this and the surrounding helpers into the RWSEM_SPIN_ON_OWNER
block, it is only used there and that way all the code is together.
