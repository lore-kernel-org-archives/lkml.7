Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46302082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfDDME6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:04:58 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:23548 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfDDME6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:04:58 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 1676C4817; Thu,  4 Apr 2019 14:04:56 +0200 (CEST)
Date:   Thu, 4 Apr 2019 14:04:56 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-ID: <20190404120456.htogl7lck6v4rj37@d104.suse.de>
References: <20190328134320.13232-1-osalvador@suse.de>
 <20190328134320.13232-3-osalvador@suse.de>
 <20190403084603.GE15605@dhcp22.suse.cz>
 <20190404100403.6lci2e55egrjfwig@d104.suse.de>
 <20190404103115.GF12864@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404103115.GF12864@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:31:15PM +0200, Michal Hocko wrote:
> On Thu 04-04-19 12:04:05, Oscar Salvador wrote:
> > On Wed, Apr 03, 2019 at 10:46:03AM +0200, Michal Hocko wrote:
> > > On Thu 28-03-19 14:43:18, Oscar Salvador wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > arch_add_memory, __add_pages take a want_memblock which controls whether
> > > > the newly added memory should get the sysfs memblock user API (e.g.
> > > > ZONE_DEVICE users do not want/need this interface). Some callers even
> > > > want to control where do we allocate the memmap from by configuring
> > > > altmap.
> > > > 
> > > > Add a more generic hotplug context for arch_add_memory and __add_pages.
> > > > struct mhp_restrictions contains flags which contains additional
> > > > features to be enabled by the memory hotplug (MHP_MEMBLOCK_API
> > > > currently) and altmap for alternative memmap allocator.
> > > > 
> > > > Please note that the complete altmap propagation down to vmemmap code
> > > > is still not done in this patch. It will be done in the follow up to
> > > > reduce the churn here.
> > > > 
> > > > This patch shouldn't introduce any functional change.
> > > 
> > > Is there an agreement on the interface here? Or do we want to hide almap
> > > behind some more general looking interface? If the former is true, can
> > > we merge it as it touches a code that might cause merge conflicts later on
> > > as multiple people are working on this area.
> > 
> > Uhm, I think that the interface is fine for now.
> > I thought about providing some callbacks to build the altmap layout, but I
> > realized that it was overcomplicated and I would rather start easy.
> > Maybe the naming could be changed to what David suggested, something like
> > "mhp_options", which actually looks more generic and allows us to stuff more
> > things into it should the need arise in the future.
> > But that is something that can come afterwards I guess.
> > 
> > But merging this now is not a bad idea taking into account that some people
> > is working on the same area and merge conflicts arise easily.
> > Otherwise re-working it every version is going to be a pita.
> 
> I do not get wee bit about naming TBH. Do as you like. But please repost
> just these two patches and we can discuss the rest of this feature in a
> separate discussion.

Sure, I will repost them in the next hour (just want to check that everything
is alright).

-- 
Oscar Salvador
SUSE L3
