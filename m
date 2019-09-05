Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF170C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC3120882
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfIEBq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:46:27 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:44377 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfIEBq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:46:27 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 5 Sep 2019 10:46:24 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: sangwoo2.park@lge.com
Received: from unknown (HELO LGEARND18B2) (10.168.178.132)
        by 156.147.1.121 with ESMTP; 5 Sep 2019 10:46:24 +0900
X-Original-SENDERIP: 10.168.178.132
X-Original-MAILFROM: sangwoo2.park@lge.com
Date:   Thu, 5 Sep 2019 10:46:24 +0900
From:   Park Sangwoo <sangwoo2.park@lge.com>
To:     mhocko@kernel.org
Cc:     hannes@cmpxchg.org, arunks@codeaurora.org, guro@fb.com,
        richard.weiyang@gmail.com, glider@google.com, jannh@google.com,
        dan.j.williams@intel.com, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com, rppt@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, janne.huttunen@nokia.com,
        pasha.tatashin@soleen.com, vbabka@suse.cz, osalvador@suse.de,
        mgorman@techsingularity.net, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Add nr_free_highatomimic to fix incorrect watermatk
 routine
Message-ID: <20190905014624.GA25551@LGEARND18B2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed 04-09-19 15:54:57, Park Sangwoo wrote:
> > On Tue 03-09-19 18:59:59, Park Sangwoo wrote:
> > > On Mon 02-09-19 13:34:54, Sangwoo� wrote:
> > >>> On Fri 30-08-19 18:25:53, Sangwoo wrote:
> > >>>> The highatomic migrate block can be increased to 1% of Total memory.
> > >>>> And, this is for only highorder ( > 0 order). So, this block size is
> > >>>> excepted during check watermark if allocation type isn't alloc_harder.
> > >>>>
> > >>>> It has problem. The usage of highatomic is already calculated at
> > >>> NR_FREE_PAGES.
> > >>>>> So, if we except total block size of highatomic, it's twice minus size of
> > >>> allocated
> > >>>>> highatomic.
> > >>>>> It's cause allocation fail although free pages enough.
> > >>>>>
> > >>>>> We checked this by random test on my target(8GB RAM).
> > >>>>>
> > >>>>>  Binder:6218_2: page allocation failure: order:0, mode:0x14200ca
> > >>> (GFP_HIGHUSER_MOVABLE), nodemask=(null)
> > >>>>>  Binder:6218_2 cpuset=background mems_allowed=0
> > >>>>
> > >>>> How come this order-0 sleepable allocation fails? The upstream kernel
> > >>>> doesn't fail those allocations unless the process context is killed by
> > >>>> the oom killer.
> > >>> 
> > > >>> Most calltacks are zsmalloc, as shown below.
> > > >>
> > > >> What makes those allocations special so that they fail unlike any other
> > > >> normal order-0 requests? Also do you see the same problem with the
> > > >> current upstream kernel? Is it possible this is an Android specific
> > > >> issue?
> > > >
> > > > There is the other case of fail order-0 fail.
> > > > ----
> > > > hvdcp_opti: page allocation failure: order:0, mode:0x1004000(GFP_NOWAIT|__GFP_COMP), nodemask=(null)
> > > 
> > > This is an atomic allocation and failing that one is not a problem
> > > usually. High atomic reservations might prevent GFP_NOWAIT allocation
> > > from suceeding but I do not see that as a problem. This is the primary
> > > purpose of the reservation. 
> > 
> > Thanks, your answer helped me. However, my suggestion is not to modify the use and management of the high atomic region,
> > but to calculate the exact free size of the highatomic so that fail does not occur for previously shared cases.
> > 
> > In __zone_water_mark_ok(...) func, if it is not atomic allocation, high atomic size is excluded.
> > 
> > bool __zone_watermark_ok(struct zone *z,
> > ...
> > {
> >     ...
> >     if (likely(!alloc_harder)) {
> >         free_pages -= z->nr_reserved_highatomic;
> >     ...
> > }
> > 
> > However, free_page excludes the size already allocated by hiahtomic.
> > If highatomic block is small(Under 4GB RAM), it could be no problem.
> > But, the larger the memory size, the greater the chance of problems.
> > (Becasue highatomic size can be increased up to 1% of memory)
> 
> I still do not understand. NR_FREE_PAGES should include the amount of
> hhighatomic reserves, right. So reducing the free_pages for normal
> allocations just makes sense. Or what do I miss?

You are right. But z->nr_reserved_highatomic value is total size of
highatomic migrate type per zone.

nr_reserved_highatomic = (# of allocated of highatomic) + (# of free list of highatomic).

And (# of allocated of hiagatomic) is already excluded at NR_FREE_PAGES.
So, if reducing nr_reserved_highatomic at NR_FREE_PAGES,
the (# of allocated of highatomic) is double reduced.

So I proposal that only (# of free list of highatomic) is reduced at NR_FREE_PAGE.

    if (likely(!alloc_harder)) {
-       free_pages -= z->nr_reserved_highatomic;
+       free_pages -= zone_page_state(z, NR_FREE_HIGHATOMIC_PAGES);
    } else {

> 
> I am sorry but I find your reasoning really hard to follow.

