Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D8D2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfDDPkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:40:10 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:36978 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfDDPkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:40:10 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 3CFB14824; Thu,  4 Apr 2019 17:40:09 +0200 (CEST)
Date:   Thu, 4 Apr 2019 17:40:09 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm, memory_hotplug: cleanup memory offline path
Message-ID: <20190404154006.ywtpwb3c3frkajzk@d104.suse.de>
References: <20190404125916.10215-1-osalvador@suse.de>
 <20190404125916.10215-2-osalvador@suse.de>
 <f2360f11-4360-b678-f095-c4ebbf7cd0ec@redhat.com>
 <20190404132506.kaqzop4qs6m56plu@d104.suse.de>
 <7874ef85-adc7-95a8-87f4-1f15eb21c677@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7874ef85-adc7-95a8-87f4-1f15eb21c677@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 04:47:43PM +0200, David Hildenbrand wrote:
> On 04.04.19 15:25, Oscar Salvador wrote:
> > On Thu, Apr 04, 2019 at 03:18:00PM +0200, David Hildenbrand wrote:
> >>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >>> index f206b8b66af1..d8a3e9554aec 100644
> >>> --- a/mm/memory_hotplug.c
> >>> +++ b/mm/memory_hotplug.c
> >>> @@ -1451,15 +1451,11 @@ static int
> >>>  offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
> >>>  			void *data)
> >>>  {
> >>> -	__offline_isolated_pages(start, start + nr_pages);
> >>> -	return 0;
> >>> -}
> >>> +	unsigned long offlined_pages;
> >>>  
> >>> -static void
> >>> -offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
> >>> -{
> >>> -	walk_system_ram_range(start_pfn, end_pfn - start_pfn, NULL,
> >>> -				offline_isolated_pages_cb);
> >>> +	offlined_pages = __offline_isolated_pages(start, start + nr_pages);
> >>> +	*(unsigned long *)data += offlined_pages;
> >>
> >> unsigned long *offlined_pages = data;
> >>
> >> *offlined_pages += __offline_isolated_pages(start, start + nr_pages);
> > 
> > Yeah, more readable.
> > 
> >> Only nits
> > 
> > About the identation, I double checked the code and it looks fine to me.
> > In [1] looks fine too, might be your mail client?
> > 
> > [1] https://patchwork.kernel.org/patch/10885571/
> 
> Double checked, alignment on the parameter on the new line is very weird.

Uhm, are not you confused because we removed the "while (off...)", and
"ret =" gets idented right below "/*check again*".

Try to apply the patch and check whether you still see the issue.
I just checked out the branch and it looks fine to me.

> And both lines cross 80 lines per line ... nit :)

Yeah, 81 characters, but I decided to go with that rather than start doing
tricky things to accomplish 80 characters.
Maybe Andrew agrees, or he might slap me.

-- 
Oscar Salvador
SUSE L3
