Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98514C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647C92084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfDBI2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:28:17 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:51091 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfDBI2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:28:16 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 6D7C047BE; Tue,  2 Apr 2019 10:28:15 +0200 (CEST)
Date:   Tue, 2 Apr 2019 10:28:15 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401115306.GF28293@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 01:53:06PM +0200, Michal Hocko wrote:
> On Mon 01-04-19 09:59:36, Oscar Salvador wrote:
> > On Fri, Mar 29, 2019 at 02:42:43PM +0100, Michal Hocko wrote:
> > > Having a larger contiguous area is definitely nice to have but you also
> > > have to consider the other side of the thing. If we have a movable
> > > memblock with unmovable memory then we are breaking the movable
> > > property. So there should be some flexibility for caller to tell whether
> > > to allocate on per device or per memblock. Or we need something to move
> > > memmaps during the hotremove.
> > 
> > By movable memblock you mean a memblock whose pages can be migrated over when
> > this memblock is offlined, right?
> 
> I am mostly thinking about movable_node kernel parameter which makes
> newly hotpluged memory go into ZONE_MOVABLE and people do use that to
> make sure such a memory can be later hotremoved.

Uhm, I might be missing your point, but hot-added memory that makes use of
vmemmap pages can be hot-removed as any other memory.

Vmemmap pages do not account as unmovable memory, they just stick around
until all sections they referred to have been removed, and then, we proceed
with removing them.
So, to put it in another way: vmemmap pages are left in the system until the
whole memory device (DIMM, virt mem-device or whatever) is completely
hot-removed.

-- 
Oscar Salvador
SUSE L3
