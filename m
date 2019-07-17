Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B1920818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGQHjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:39:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfGQHjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:39:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D197EADBF;
        Wed, 17 Jul 2019 07:39:00 +0000 (UTC)
Date:   Wed, 17 Jul 2019 09:38:58 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
Message-ID: <20190717073853.GA22253@linux>
References: <20190715081549.32577-1-osalvador@suse.de>
 <20190715081549.32577-3-osalvador@suse.de>
 <87tvbne0rd.fsf@linux.ibm.com>
 <1563225851.3143.24.camel@suse.de>
 <CAPcyv4gp18-CRADqrqAbR0SnjKBoPaTyL_oaEyyNPJOeLybayg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gp18-CRADqrqAbR0SnjKBoPaTyL_oaEyyNPJOeLybayg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 07:28:54PM -0700, Dan Williams wrote:
> This makes it more clear that the problem is with the "start_pfn ==
> pfn" check relative to subsections, but it does not clarify why it
> needs to clear pfn_valid() before calling shrink_zone_span().
> Sections were not invalidated prior to shrink_zone_span() in the
> pre-subsection implementation and it seems all we need is to keep the
> same semantic. I.e. skip the range that is currently being removed:

Yes, as I said in my reply to Aneesh, that is the other way I thought
when fixing it.
The reason I went this way is because it seemed more reasonable and
natural to me that pfn_valid() would just return the next active
sub-section.

I just though that we could leverage the fact that we can deactivate
a sub-section before scanning for the next one.

On a second thought, the changes do not outweight the case, being the first
fix enough and less intrusive, so I will send a v2 with that instead.


-- 
Oscar Salvador
SUSE L3
