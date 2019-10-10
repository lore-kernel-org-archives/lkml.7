Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A649C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637BC218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570693118;
	bh=Hz0SnG5dekAmO6sUVEGc10gMyzyuXZqIkeBbKDC/oEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IdEnNhkDVkoOVdq+murqqMI1fE0a+4YNYsMW/8E1n1Aqded6GueZBBGU507G3SC4Y
	 6E6DMWwc6DiFmOQh3sH/XedSyqb1diqXTl5Q8ie2ggETdhYyFJDXA44oGlqt21+bsG
	 db3eEg0dglKJOkGb2QmKiSYFT3ZQMdAhSGbSUD3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfJJHid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:48930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733082AbfJJHf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:35:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60907B02E;
        Thu, 10 Oct 2019 07:35:27 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:35:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Message-ID: <20191010073526.GC18412@dhcp22.suse.cz>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
 <20191009144323.GH6681@dhcp22.suse.cz>
 <5a626821-77e9-e26b-c2ee-219670283bf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a626821-77e9-e26b-c2ee-219670283bf0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-10-19 09:27:32, David Hildenbrand wrote:
> On 09.10.19 16:43, Michal Hocko wrote:
> > On Wed 09-10-19 16:24:35, David Hildenbrand wrote:
> >> We should check for pfn_to_online_page() to not access uninitialized
> >> memmaps. Reshuffle the code so we don't have to duplicate the error
> >> message.
> >>
> >> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/memory-failure.c | 14 ++++++++------
> >>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 7ef849da8278..e866e6e5660b 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
> >>  	if (!sysctl_memory_failure_recovery)
> >>  		panic("Memory failure on page %lx", pfn);
> >>  
> >> -	if (!pfn_valid(pfn)) {
> >> +	p = pfn_to_online_page(pfn);
> >> +	if (!p) {
> >> +		if (pfn_valid(pfn)) {
> >> +			pgmap = get_dev_pagemap(pfn, NULL);
> >> +			if (pgmap)
> >> +				return memory_failure_dev_pagemap(pfn, flags,
> >> +								  pgmap);
> >> +		}
> >>  		pr_err("Memory failure: %#lx: memory outside kernel control\n",
> >>  			pfn);
> >>  		return -ENXIO;
> > 
> > Don't we need that earlier at hwpoison_inject level?
> > 
> 
> Theoretically yes, this is another instance. But pfn_to_online_page(pfn)
> alone would not be sufficient as discussed. We would, again, have to
> special-case ZONE_DEVICE via things like get_dev_pagemap() ...
> 
> But mm/hwpoison-inject.c:hwpoison_inject() is a pure debug feature either way:
> 
> 	/*
> 	 * Note that the below poison/unpoison interfaces do not involve
> 	 * hardware status change, hence do not require hardware support.
> 	 * They are mainly for testing hwpoison in software level.
> 	 */
> 
> So it's not that bad compared to memory_failure() called from real HW or
> drivers/base/memory.c:soft_offline_page_store()/hard_offline_page_store()

Yes, this is just a toy. And yes we need to handle zone device pages
here because a) people likely want to test MCE behavior even on these
pages and b) HW can really trigger MCEs there as well. I was just
pointing that the patch is likely incomplete.

-- 
Michal Hocko
SUSE Labs
