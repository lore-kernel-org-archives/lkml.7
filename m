Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED41C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16970214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554373879;
	bh=dK/tKrSFp26Eepbzlg1bjC3x/6iKoLhgPxKZDpO+E0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tpvgiwg5P+sGzdF3I0cYIfhe8yRLVWZ5NCLR3HwPI3m32N6AZUeOiss1szRP+R42+
	 0nQVKlemVoomtyY3ZPlGDSWKhBM8kzlVp481Ij89ixzdLJF/jjFuQYl8CpOqXOC95n
	 WFsJOKEH3rfzsM8tD0Qgu0SdON0SmPf+hxAdVWNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfDDKbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:31:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:37476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbfDDKbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:31:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C3D4AF00;
        Thu,  4 Apr 2019 10:31:16 +0000 (UTC)
Date:   Thu, 4 Apr 2019 12:31:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-ID: <20190404103115.GF12864@dhcp22.suse.cz>
References: <20190328134320.13232-1-osalvador@suse.de>
 <20190328134320.13232-3-osalvador@suse.de>
 <20190403084603.GE15605@dhcp22.suse.cz>
 <20190404100403.6lci2e55egrjfwig@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404100403.6lci2e55egrjfwig@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-04-19 12:04:05, Oscar Salvador wrote:
> On Wed, Apr 03, 2019 at 10:46:03AM +0200, Michal Hocko wrote:
> > On Thu 28-03-19 14:43:18, Oscar Salvador wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > arch_add_memory, __add_pages take a want_memblock which controls whether
> > > the newly added memory should get the sysfs memblock user API (e.g.
> > > ZONE_DEVICE users do not want/need this interface). Some callers even
> > > want to control where do we allocate the memmap from by configuring
> > > altmap.
> > > 
> > > Add a more generic hotplug context for arch_add_memory and __add_pages.
> > > struct mhp_restrictions contains flags which contains additional
> > > features to be enabled by the memory hotplug (MHP_MEMBLOCK_API
> > > currently) and altmap for alternative memmap allocator.
> > > 
> > > Please note that the complete altmap propagation down to vmemmap code
> > > is still not done in this patch. It will be done in the follow up to
> > > reduce the churn here.
> > > 
> > > This patch shouldn't introduce any functional change.
> > 
> > Is there an agreement on the interface here? Or do we want to hide almap
> > behind some more general looking interface? If the former is true, can
> > we merge it as it touches a code that might cause merge conflicts later on
> > as multiple people are working on this area.
> 
> Uhm, I think that the interface is fine for now.
> I thought about providing some callbacks to build the altmap layout, but I
> realized that it was overcomplicated and I would rather start easy.
> Maybe the naming could be changed to what David suggested, something like
> "mhp_options", which actually looks more generic and allows us to stuff more
> things into it should the need arise in the future.
> But that is something that can come afterwards I guess.
> 
> But merging this now is not a bad idea taking into account that some people
> is working on the same area and merge conflicts arise easily.
> Otherwise re-working it every version is going to be a pita.

I do not get wee bit about naming TBH. Do as you like. But please repost
just these two patches and we can discuss the rest of this feature in a
separate discussion.

Thanks!
-- 
Michal Hocko
SUSE Labs
