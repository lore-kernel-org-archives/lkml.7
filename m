Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6408F2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554280681;
	bh=ic91AT5UehXIM0D+1UWc5MP52UlnhBHsRf5I7s8tQwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xPOcH0K4wOGr0VEqrJziyZ157xUaIclfAPv9QG0CW9kFdIB7bhh91/DyoJT+yYzZj
	 T13Las1swEYcGy0fuEwnpub9eE79gp9eyawLS63cmG5+g8mvTwmzShVQKecnFYqbbh
	 d98fptrV6PTHENQeUYtncn8WvHsWKIovIrfE3ZoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfDCIiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:38:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:47998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfDCIiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:38:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD974AD07;
        Wed,  3 Apr 2019 08:37:58 +0000 (UTC)
Date:   Wed, 3 Apr 2019 10:37:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190403083757.GC15605@dhcp22.suse.cz>
References: <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
 <20190402124845.GD28293@dhcp22.suse.cz>
 <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
 <20190403081232.GB15605@dhcp22.suse.cz>
 <d55aa259-56c0-9601-ffce-997ea1fb3ac5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d55aa259-56c0-9601-ffce-997ea1fb3ac5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-04-19 10:17:26, David Hildenbrand wrote:
> On 03.04.19 10:12, Michal Hocko wrote:
> > On Wed 03-04-19 10:01:16, Oscar Salvador wrote:
> >> On Tue, Apr 02, 2019 at 02:48:45PM +0200, Michal Hocko wrote:
> >>> So what is going to happen when you hotadd two memblocks. The first one
> >>> holds memmaps and then you want to hotremove (not just offline) it?
> >>
> >> If you hot-add two memblocks, this means that either:
> >>
> >> a) you hot-add a 256MB-memory-device (128MB per memblock)
> >> b) you hot-add two 128MB-memory-device
> >>
> >> Either way, hot-removing only works for memory-device as a whole, so
> >> there is no problem.
> >>
> >> Vmemmaps are created per hot-added operations, this means that
> >> vmemmaps will be created for the hot-added range.
> >> And since hot-add/hot-remove operations works with the same granularity,
> >> there is no problem.
> > 
> > What does prevent calling somebody arch_add_memory for a range spanning
> > multiple memblocks from a driver directly. In other words aren't you
> 
> To drivers, we only expose add_memory() and friends. And I think this is
> a good idea.
> 
> > making  assumptions about a future usage based on the qemu usecase?
> > 
> 
> As I noted, we only have an issue if add add_memory() and
> remove_memory() is called with different granularity. I gave two
> examples where this might not be the case, but we will have to look int
> the details.

It seems natural that the DIMM will be hot remove all at once because
you cannot hot remove a half of the DIMM, right? But I can envision that
people might want to hotremove a faulty part of a really large DIMM
because they would like to save some resources.

With different users asking for the hotplug functionality, I do not
think we want to make such a strong assumption as hotremove will have
the same granularity as hotadd.


That being said it should be the caller of the hotplug code to tell
the vmemmap allocation strategy. For starter, I would only pack vmemmaps
for "regular" kernel zone memory. Movable zones should be more careful.
We can always re-evaluate later when there is a strong demand for huge
pages on movable zones but this is not the case now because those pages
are not really movable in practice.
-- 
Michal Hocko
SUSE Labs
