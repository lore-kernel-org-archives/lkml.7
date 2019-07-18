Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34687C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052B12173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfGRF6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:58:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGRF6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:58:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72475308FBAC;
        Thu, 18 Jul 2019 05:58:31 +0000 (UTC)
Received: from redhat.com (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id C085E5D9D6;
        Thu, 18 Jul 2019 05:58:17 +0000 (UTC)
Date:   Thu, 18 Jul 2019 01:58:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: use of shrinker in virtio balloon free page hinting
Message-ID: <20190718015319-mutt-send-email-mst@kernel.org>
References: <20190717071332-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73E16D4B2@shsmsx102.ccr.corp.intel.com>
 <20190718000434-mutt-send-email-mst@kernel.org>
 <5D300A32.4090300@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D300A32.4090300@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 18 Jul 2019 05:58:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 01:57:06PM +0800, Wei Wang wrote:
> On 07/18/2019 12:13 PM, Michael S. Tsirkin wrote:
> > 
> > It makes sense for pages in the balloon (requested by hypervisor).
> > However free page hinting can freeze up lots of memory for its own
> > internal reasons. It does not make sense to ask hypervisor
> > to set flags in order to fix internal guest issues.
> 
> Sounds reasonable to me. Probably we could move the flag check to
> shrinker_count and shrinker_scan as a reclaiming condition for
> ballooning pages only?

I think so, yes. I also wonder whether we should stop reporting
at that point - otherwise we'll just allocate the freed pages again.

> 
> > 
> > Right. But that does not include the pages in the hint vq,
> > which could be a significant amount of memory.
> 
> I think it includes, as vb->num_free_page_blocks records the total number
> of free page blocks that balloon has taken from mm.

Oh - you are right. Thanks!

> For shrink_free_pages, it calls return_free_pages_to_mm, which pops pages
> from vb->free_page_list (this is the list where pages get enlisted after
> they
> are put to the hint vq, see get_free_page_and_send).
> 
> 
> > 
> > 
> > > > - if free pages are being reported, pages freed
> > > >    by shrinker will just get re-allocated again
> > > fill_balloon will re-try the allocation after sleeping 200ms once allocation fails.
> > Even if ballon was never inflated, if shrinker frees some memory while
> > we are hinting, hint vq will keep going and allocate it back without
> > sleeping.
> 
> Still see get_free_page_and_send. -EINTR is returned when page allocation
> fails,
> and reporting ends then.

what if it does not fail?


> 
> Shrinker is called on system memory pressure. On memory pressure
> get_free_page_and_send will fail memory allocation, so it stops allocating
> more.

Memory pressure could be triggered by an unrelated allocation
e.g. from another driver.

> 
> 
> Best,
> Wei
