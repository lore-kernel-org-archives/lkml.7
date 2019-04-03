Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4601FC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B212147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDCIuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:50:44 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:21968 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfDCIuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:50:44 -0400
Received: by suse.de (Postfix, from userid 1000)
        id EE81C47ED; Wed,  3 Apr 2019 10:50:42 +0200 (CEST)
Date:   Wed, 3 Apr 2019 10:50:42 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190403085042.t5wcyvaolxiw65rr@d104.suse.de>
References: <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
 <20190402124845.GD28293@dhcp22.suse.cz>
 <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
 <20190403081232.GB15605@dhcp22.suse.cz>
 <d55aa259-56c0-9601-ffce-997ea1fb3ac5@redhat.com>
 <20190403083757.GC15605@dhcp22.suse.cz>
 <04a5b856-c8e0-937b-72bb-b9d17a12ccc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a5b856-c8e0-937b-72bb-b9d17a12ccc7@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:41:35AM +0200, David Hildenbrand wrote:
> > That being said it should be the caller of the hotplug code to tell
> > the vmemmap allocation strategy. For starter, I would only pack vmemmaps
> > for "regular" kernel zone memory. Movable zones should be more careful.
> > We can always re-evaluate later when there is a strong demand for huge
> > pages on movable zones but this is not the case now because those pages
> > are not really movable in practice.
> 
> Remains the issue with potential different user trying to remove memory
> it didn't add in some other granularity. We then really have to identify
> and isolate that case.

If we let the caller specify whether it wants vmemmaps per memblock or range,
I would trust that caller to do the correct thing and specify one thing or
another depending on what it wants to do in the future.

So, say a driver adds 512MB memory and it specifies that it wants vmemmaps per
memblock because later on it will like to hot-remove in chunks of 128MB.

-- 
Oscar Salvador
SUSE L3
