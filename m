Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7516EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448EA2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDCJk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:40:56 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:44919 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfDCJkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:40:55 -0400
Received: by suse.de (Postfix, from userid 1000)
        id A2A2647F0; Wed,  3 Apr 2019 11:40:54 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:40:54 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190403094054.jdr7lxm45htgcsk7@d104.suse.de>
References: <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
 <20190402124845.GD28293@dhcp22.suse.cz>
 <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
 <20190403081232.GB15605@dhcp22.suse.cz>
 <d55aa259-56c0-9601-ffce-997ea1fb3ac5@redhat.com>
 <20190403083757.GC15605@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403083757.GC15605@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:37:57AM +0200, Michal Hocko wrote:
> That being said it should be the caller of the hotplug code to tell
> the vmemmap allocation strategy. For starter, I would only pack vmemmaps
> for "regular" kernel zone memory. Movable zones should be more careful.
> We can always re-evaluate later when there is a strong demand for huge
> pages on movable zones but this is not the case now because those pages
> are not really movable in practice.

I agree that makes sense to let the caller specify if it wants to allocate
vmemmaps per memblock or per memory-range, so we are more flexible when it
comes to granularity in hot-add/hot-remove operations.

But the thing is that the zones are picked at onling stage, while
vmemmaps are created at hot-add stage, so I am not sure we can define
the strategy depending on the zone.

-- 
Oscar Salvador
SUSE L3
