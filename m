Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8A6C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCD92070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfG2Iep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:34:45 -0400
Received: from outbound-smtp28.blacknight.com ([81.17.249.11]:56516 "EHLO
        outbound-smtp28.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbfG2Iep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:34:45 -0400
Received: from mail.blacknight.com (unknown [81.17.255.152])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id 5CF23D01D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:34:42 +0100 (IST)
Received: (qmail 30865 invoked from network); 29 Jul 2019 08:34:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.7])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Jul 2019 08:34:42 -0000
Date:   Mon, 29 Jul 2019 09:34:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        vbabka@suse.cz, Qian Cai <cai@lca.pw>, aryabinin@virtuozzo.com,
        osalvador@suse.de, rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] make "order" unsigned int
Message-ID: <20190729083440.GE2739@techsingularity.net>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
 <20190726072637.GC2739@techsingularity.net>
 <CAD7_sbHwjN3RY+ofgWvhQFJdxhCC4=gsMs194=wOH3tKV-qSUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAD7_sbHwjN3RY+ofgWvhQFJdxhCC4=gsMs194=wOH3tKV-qSUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 12:44:36AM +0800, Pengfei Li wrote:
> On Fri, Jul 26, 2019 at 3:26 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> 
> Thank you for your comments.
> 
> > On Fri, Jul 26, 2019 at 02:42:43AM +0800, Pengfei Li wrote:
> > > Objective
> > > ----
> > > The motivation for this series of patches is use unsigned int for
> > > "order" in compaction.c, just like in other memory subsystems.
> > >
> >
> > Why? The series is relatively subtle in parts, particularly patch 5.
> 
> Before I sent this series of patches, I took a close look at the
> git log for compact.c.
> 
> Here is a short history, trouble you to look patiently.
> 
> 1) At first, "order" is _unsigned int_
> 
> The commit 56de7263fcf3 ("mm: compaction: direct compact when a
> high-order allocation fails") introduced the "order" in
> compact_control and its type is unsigned int.
> 
> Besides, you specify that order == -1 is the flag that triggers
> compaction via proc.
> 

Yes, specifying that compaction in that context is for the entire zone
without any specific allocation context or request.

> 2) Next, because order equals -1 is special, it causes an error.
> 
> The commit 7be62de99adc ("vmscan: kswapd carefully call compaction")
> determines if "order" is less than 0.
> 
> This condition is always true because the type of "order" is
> _unsigned int_.
> 
> -               compact_zone(zone, &cc);
> +               if (cc->order < 0 || !compaction_deferred(zone))
> 
> 3) Finally, in order to fix the above error, the type of the order
> is modified to _int_
> 
> It is done by commit: aad6ec3777bf ("mm: compaction: make
> compact_control order signed").
> 
> The reason I mention this is because I want to express that the
> type of "order" is originally _unsigned int_. And "order" is
> modified to _int_ because of the special value of -1.
> 

And in itself, why does that matter?

> If the special value of "order" is not a negative number (for
> example, -1), but a number greater than MAX_ORDER - 1 (for example,
> MAX_ORDER), then the "order" may still be _unsigned int_ now.
> 

Sure, but then you have to check that every check on order understands
the new special value.

> > There have been places where by it was important for order to be able to
> > go negative due to loop exit conditions.
> 
> I think that even if "cc->order" is _unsigned int_, it can be done
> with a local temporary variable easily.
> 
> Like this,
> 
> function(...)
> {
>     for(int tmp_order = cc->order; tmp_order >= 0; tmp_order--) {
>         ...
>     }
> }
> 

Yes, it can be expressed as unsigned but in itself why does that justify
the review of a large series? There is limited to no performance gain
and functionally it's equivalent.

> > If there was a gain from this
> > or it was a cleanup in the context of another major body of work, I
> > could understand the justification but that does not appear to be the
> > case here.
> >
> 
> My final conclusion:
> 
> Why "order" is _int_ instead of unsigned int?
>   => Because order == -1 is used as the flag.
>     => So what about making "order" greater than MAX_ORDER - 1?
>       => The "order" can be _unsigned int_ just like in most places.
> 
> (Can we only pick -1 as this special value?)
> 

No, but the existing code did make that choice and has been debugged
with that decision.

> This series of patches makes sense because,
> 
> 1) It guarantees that "order" remains the same type.
> 

And the advantage is?

> No one likes to see this
> 
> __alloc_pages_slowpath(unsigned int order, ...)
>  => should_compact_retry(int order, ...)            /* The type changed */
>   => compaction_zonelist_suitable(int order, ...)
>    => __compaction_suitable(int order, ...)
>     => zone_watermark_ok(unsigned int order, ...)   /* The type
> changed again! */
> 
> 2) It eliminates the evil "order == -1".
> 
> If "order" is specified as any positive number greater than
> MAX_ORDER - 1 in commit 56de7263fcf3, perhaps no int order will
> appear in compact.c until now.
> 

So, while it is possible, the point still holds. There is marginal to no
performance advantage (some CPUs perform fractionally better when an
index variable is unsigned rather than signed but it's difficult to
measure even when you're looking for it). It'll take time to review and
then debug the entire series. If this was in the context of a larger
functional enablement or performance optimisation then it would be
worthwhile but as it is, it looks more like churn for the sake of it.

-- 
Mel Gorman
SUSE Labs
