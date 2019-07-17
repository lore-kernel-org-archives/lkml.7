Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F6C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E9121841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfGQIIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:08:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:52136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfGQIIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:08:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B73E1AE37;
        Wed, 17 Jul 2019 08:08:05 +0000 (UTC)
Date:   Wed, 17 Jul 2019 10:08:03 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
Message-ID: <20190717080755.GA22661@linux>
References: <20190715081549.32577-1-osalvador@suse.de>
 <20190715081549.32577-3-osalvador@suse.de>
 <87tvbne0rd.fsf@linux.ibm.com>
 <1563225851.3143.24.camel@suse.de>
 <CAPcyv4gp18-CRADqrqAbR0SnjKBoPaTyL_oaEyyNPJOeLybayg@mail.gmail.com>
 <20190717073853.GA22253@linux>
 <da07d964-fcfa-1406-bc12-faebbe38696e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da07d964-fcfa-1406-bc12-faebbe38696e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:01:01AM +0200, David Hildenbrand wrote:
> I'd also like to note that we should strive for making all zone-related
> changes when offlining in the future, not when removing memory. So
> ideally, any core changes we perform from now, should make that step
> (IOW implementing that) easier, not harder. Of course, BUGs have to be
> fixed.
> 
> The rough idea would be to also mark ZONE_DEVICE sections as ONLINE (or
> rather rename it to "ACTIVE" to generalize).
> 
> For each section we would then have
> 
> - pfn_valid(): We have a valid "struct page" / memmap
> - pfn_present(): We have actually added that memory via an oficial
>   interface to mm (e.g., arch_add_memory() )
> - pfn_online() / (or pfn_active()): Memory is active (online in "buddy"-
>   speak, or memory that was moved to the ZONE_DEVICE zone)
> 
> When resizing the zones (e.g., when offlining memory), we would then
> search for pfn_online(), not pfn_present().
> 
> In addition to move_pfn_range_to_zone(), we would have
> remove_pfn_range_from_zone(), called during offline_pages() / by
> devmem/hmm/pmem code before removing.
> 
> (I started to look into this, but I don't have any patches yet)

Yes, it seems like a good approach, and something that makes sense
to pursue.
FWIF, I sent a patchset [1] for that a long time ago, but I could not
follow-up due to time constraints.

[1] https://patchwork.kernel.org/cover/10700783/


-- 
Oscar Salvador
SUSE L3
