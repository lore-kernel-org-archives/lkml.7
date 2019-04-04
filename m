Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4084CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9FD2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfDDNZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:25:12 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:59910 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfDDNZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:25:11 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 16B4D481A; Thu,  4 Apr 2019 15:25:09 +0200 (CEST)
Date:   Thu, 4 Apr 2019 15:25:09 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm, memory_hotplug: cleanup memory offline path
Message-ID: <20190404132506.kaqzop4qs6m56plu@d104.suse.de>
References: <20190404125916.10215-1-osalvador@suse.de>
 <20190404125916.10215-2-osalvador@suse.de>
 <f2360f11-4360-b678-f095-c4ebbf7cd0ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2360f11-4360-b678-f095-c4ebbf7cd0ec@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 03:18:00PM +0200, David Hildenbrand wrote:
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index f206b8b66af1..d8a3e9554aec 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1451,15 +1451,11 @@ static int
> >  offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
> >  			void *data)
> >  {
> > -	__offline_isolated_pages(start, start + nr_pages);
> > -	return 0;
> > -}
> > +	unsigned long offlined_pages;
> >  
> > -static void
> > -offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
> > -{
> > -	walk_system_ram_range(start_pfn, end_pfn - start_pfn, NULL,
> > -				offline_isolated_pages_cb);
> > +	offlined_pages = __offline_isolated_pages(start, start + nr_pages);
> > +	*(unsigned long *)data += offlined_pages;
> 
> unsigned long *offlined_pages = data;
> 
> *offlined_pages += __offline_isolated_pages(start, start + nr_pages);

Yeah, more readable.

> Only nits

About the identation, I double checked the code and it looks fine to me.
In [1] looks fine too, might be your mail client?

[1] https://patchwork.kernel.org/patch/10885571/

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks ;-)

-- 
Oscar Salvador
SUSE L3
