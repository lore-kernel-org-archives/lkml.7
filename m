Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DAEC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4E820700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554288370;
	bh=LYcMB2ThWS8TiTb2sdQZtFtuxTkNgYOkY5ZRF0bVuu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ve/8C7Fl/TJx9GUVDMMxKPd5psMDviC36g2eDo0a0mM9ooGQUFVz4Hk6bURRwgMJz
	 Q2zWZj7Mmlos3DvaCefwVOds2zwasYROA8WLWTdTwzSj2Mhv4jCI5omhNCquRUAUdM
	 Wj+uCn/huDwCJL/zKmkZk9AEBwBobKZv87SEcCAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDCKqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:46:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:49372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfDCKqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:46:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6B22AF4C;
        Wed,  3 Apr 2019 10:46:03 +0000 (UTC)
Date:   Wed, 3 Apr 2019 12:46:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190403104602.GJ15605@dhcp22.suse.cz>
References: <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
 <20190402124845.GD28293@dhcp22.suse.cz>
 <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
 <20190403081232.GB15605@dhcp22.suse.cz>
 <d55aa259-56c0-9601-ffce-997ea1fb3ac5@redhat.com>
 <20190403083757.GC15605@dhcp22.suse.cz>
 <20190403094054.jdr7lxm45htgcsk7@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403094054.jdr7lxm45htgcsk7@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-04-19 11:40:54, Oscar Salvador wrote:
> On Wed, Apr 03, 2019 at 10:37:57AM +0200, Michal Hocko wrote:
> > That being said it should be the caller of the hotplug code to tell
> > the vmemmap allocation strategy. For starter, I would only pack vmemmaps
> > for "regular" kernel zone memory. Movable zones should be more careful.
> > We can always re-evaluate later when there is a strong demand for huge
> > pages on movable zones but this is not the case now because those pages
> > are not really movable in practice.
> 
> I agree that makes sense to let the caller specify if it wants to allocate
> vmemmaps per memblock or per memory-range, so we are more flexible when it
> comes to granularity in hot-add/hot-remove operations.

And just to be more specific. The api shouldn't really care about this
implementation detail. So ideally the caller of add_pages just picks up
the proper allocator and the rest is completely transparent.

> But the thing is that the zones are picked at onling stage, while
> vmemmaps are created at hot-add stage, so I am not sure we can define
> the strategy depending on the zone.

THis is a good point. We do have means to tell a default zone for the
regular memory hotplug so this can be reused based on the pfn range
(default_zone_for_pfn).
-- 
Michal Hocko
SUSE Labs
