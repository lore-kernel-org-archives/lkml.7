Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8F8C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2674322ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfGZKLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:11:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfGZKLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:11:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79544B634;
        Fri, 26 Jul 2019 10:11:43 +0000 (UTC)
Date:   Fri, 26 Jul 2019 12:11:40 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        anshuman.khandual@arm.com, Jonathan.Cameron@huawei.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mm: Introduce a new Vmemmap page-type
Message-ID: <20190726101136.GA26721@linux>
References: <20190725160207.19579-1-osalvador@suse.de>
 <20190725160207.19579-3-osalvador@suse.de>
 <7e8746ac-6a66-d73c-9f2a-4fc53c7e4c04@redhat.com>
 <20190726092548.GA26268@linux>
 <dbd19aea-fe18-ec42-7932-f03109cb399e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd19aea-fe18-ec42-7932-f03109cb399e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 11:41:46AM +0200, David Hildenbrand wrote:
> > static void __meminit __init_single_page(struct page *page, unsigned long pfn,
> >                                 unsigned long zone, int nid)
> > {
> >         if (PageVmemmap(page))
> >                 /*
> >                  * Vmemmap pages need to preserve their state.
> >                  */
> >                 goto preserve_state;
> 
> Can you be sure there are no false positives? (if I remember correctly,
> this memory might be completely uninitialized - I might be wrong)

Normal pages reaching this point will be uninitialized or 
poisoned-initialized.

Vmemmap pages are initialized to 0 in mhp_mark_vmemmap_pages,
before reaching here.

For the false positive to be effective, page should be reserved, and 
page->type would have to have a specific value.
If we feel unsure about this, I could add a new kind of check for only
this situation, where we initialize another field of struct page
to another specific/magic value, so we will have three checks only at
this stage.

> 
> > 
> >         mm_zero_struct_page(page);
> >         page_mapcount_reset(page);
> >         INIT_LIST_HEAD(&page->lru);
> > preserve_state:
> >         init_page_count(page);
> >         set_page_links(page, zone, nid, pfn);
> >         page_cpupid_reset_last(page);
> >         page_kasan_tag_reset(page);
> > 
> > So, vmemmap pages will fall within the same zone as the range we are adding,
> > that does not change.
> 
> I wonder if that is the right thing to do, hmmmm, because they are
> effectively not part of that zone (not online)
> 
> Will have a look at the details :)

I might be wrong here, but last time I checked, pages that are used for memmaps
at boot time (not hotplugged), are still linked to some zone.

Will have to double check though.

If that is not case, it would be easier, but I am afraid it is.


-- 
Oscar Salvador
SUSE L3
