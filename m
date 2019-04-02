Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDF2C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9402177E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554209329;
	bh=ljeQLHHp48tWEDAdvc7koZ6K5g5TymMiH6vpMzMFty4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zEQbug7HLmGQk33bMQpB4eeEC2wkQM/kiAUSeeinQBnEsZ6xic/pMAadORvc50H0p
	 pqyYcHj5twUEBiLxREg2SSKxy8TZ9qlTGXwNqt00WTGhihYJsUr9/QshmF+sdmzhYB
	 Upgf+2lytUN7ik/6EykGSx+/K5NvfnlfwCd2+E20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfDBMss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:48:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfDBMsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:48:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62AC5ACAD;
        Tue,  2 Apr 2019 12:48:46 +0000 (UTC)
Date:   Tue, 2 Apr 2019 14:48:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190402124845.GD28293@dhcp22.suse.cz>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-04-19 10:28:15, Oscar Salvador wrote:
> On Mon, Apr 01, 2019 at 01:53:06PM +0200, Michal Hocko wrote:
> > On Mon 01-04-19 09:59:36, Oscar Salvador wrote:
> > > On Fri, Mar 29, 2019 at 02:42:43PM +0100, Michal Hocko wrote:
> > > > Having a larger contiguous area is definitely nice to have but you also
> > > > have to consider the other side of the thing. If we have a movable
> > > > memblock with unmovable memory then we are breaking the movable
> > > > property. So there should be some flexibility for caller to tell whether
> > > > to allocate on per device or per memblock. Or we need something to move
> > > > memmaps during the hotremove.
> > > 
> > > By movable memblock you mean a memblock whose pages can be migrated over when
> > > this memblock is offlined, right?
> > 
> > I am mostly thinking about movable_node kernel parameter which makes
> > newly hotpluged memory go into ZONE_MOVABLE and people do use that to
> > make sure such a memory can be later hotremoved.
> 
> Uhm, I might be missing your point, but hot-added memory that makes use of
> vmemmap pages can be hot-removed as any other memory.
> 
> Vmemmap pages do not account as unmovable memory, they just stick around
> until all sections they referred to have been removed, and then, we proceed
> with removing them.
> So, to put it in another way: vmemmap pages are left in the system until the
> whole memory device (DIMM, virt mem-device or whatever) is completely
> hot-removed.

So what is going to happen when you hotadd two memblocks. The first one
holds memmaps and then you want to hotremove (not just offline) it?
-- 
Michal Hocko
SUSE Labs
