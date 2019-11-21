Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB982C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FFE20715
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUBHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:07:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:61555 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfKUBHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:07:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 17:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="209930142"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 20 Nov 2019 17:07:48 -0800
Date:   Thu, 21 Nov 2019 09:07:39 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/2] mm/memory-failure.c: PageHuge is handled at the
 beginning of memory_failure
Message-ID: <20191121010739.GB12975@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
 <1e61c115-5787-9ef4-a449-2e490c53fca7@redhat.com>
 <20191120004620.GB11061@richard>
 <a85053b7-9298-9dd3-3826-e63cf8c7bd81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85053b7-9298-9dd3-3826-e63cf8c7bd81@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 04:04:44PM +0100, David Hildenbrand wrote:
>On 20.11.19 01:46, Wei Yang wrote:
>> On Tue, Nov 19, 2019 at 01:23:54PM +0100, David Hildenbrand wrote:
>> > On 18.11.19 09:20, Wei Yang wrote:
>> > > PageHuge is handled by memory_failure_hugetlb(), so this case could be
>> > > removed.
>> > > 
>> > > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> > > ---
>> > >    mm/memory-failure.c | 5 +----
>> > >    1 file changed, 1 insertion(+), 4 deletions(-)
>> > > 
>> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> > > index 3151c87dff73..392ac277b17d 100644
>> > > --- a/mm/memory-failure.c
>> > > +++ b/mm/memory-failure.c
>> > > @@ -1359,10 +1359,7 @@ int memory_failure(unsigned long pfn, int flags)
>> > >    	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
>> > >    	 * correctly, we save a copy of the page flags at this time.
>> > >    	 */
>> > > -	if (PageHuge(p))
>> > > -		page_flags = hpage->flags;
>> > > -	else
>> > > -		page_flags = p->flags;
>> > > +	page_flags = p->flags;
>> > >    	/*
>> > >    	 * unpoison always clear PG_hwpoison inside page lock
>> > > 
>> > 
>> > I somewhat miss a proper explanation why this is safe to do. We access page
>> > flags here, so why is it safe to refer to the ones of the sub-page?
>> > 
>> 
>> Hi, David
>> 
>> I think your comment is on this line:
>> 
>> 	page_flags = p->flags;
>> 
>> Maybe we need to use this:
>> 
>> 	page_flags = hpage->flags;
>> 
>> And use hpage in the following or even the whole function?
>> 
>> While one thing interesting is not all "compound page" is PageCompound. For
>> some sub-page, we can't get the correct head. This means we may just check on
>> the sub-page.
>
>Oh wait, I think I missed the check right at the beginning of this function,
>sorry :/
>
>Sooo, memory_failure_hugetlb() was introduced by
>
>commit 761ad8d7c7b5485bb66fd5bccb58a891fe784544
>Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>Date:   Mon Jul 10 15:47:47 2017 -0700
>
>    mm: hwpoison: introduce memory_failure_hugetlb()
>
>and essentially ripped out all PageHuge() checks *except* this check. This
>check was introduced in
>
>commit 7258ae5c5a2ce2f5969e8b18b881be40ab55433d
>Author: James Morse <james.morse@arm.com>
>Date:   Fri Jun 16 14:02:29 2017 -0700
>
>    mm/memory-failure.c: use compound_head() flags for huge pages
>
>
>Maybe that was just a merge oddity as both commits are only ~1month apart.
>IOW, I think Naoya's patch forgot to rip it out.
>
>
>Can we make this clear in the patch description like "This is dead code that
>cannot be reached after commit 761ad8d7c7b5 ("mm: hwpoison: introduce
>memory_failure_hugetlb()")"
>
>I assume Andrew can fix up when applying
>

That's very helpful. Thanks for your time sincerely.

>Reviewed-by: David Hildenbrand <david@redhat.com>
>
>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
