Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7551FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4455C21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258646;
	bh=8kUI5uTiuueVp3cVVoGS+3+sacqpOELCdMke7xRFe80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dt3+8MT5Pr/Q3r9H4XqtObRqXSdrmgzcqMVli90h8fc93BouxJF1HAvSZiLiQz3O5
	 btOlSSgKpJu9gmmH1ii7CXn9rQrHiI84waR1TwCRNp1wbI2UwAd/yr/VrWA8oT7fxY
	 hpbWTPWvSsa14LBKo4/hFNQABMB6RQHVoB4QDPCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbfCVMoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:44:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:34726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388354AbfCVMCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37D71AF49;
        Fri, 22 Mar 2019 12:02:21 +0000 (UTC)
Date:   Fri, 22 Mar 2019 13:02:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, osalvador@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        rientjes@google.com, zi.yan@cs.rutgers.edu
Subject: Re: [RFC] mm/hotplug: Make get_nid_for_pfn() work with
 HAVE_ARCH_PFN_VALID
Message-ID: <20190322120219.GI32418@dhcp22.suse.cz>
References: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
 <20190321083639.GJ8696@dhcp22.suse.cz>
 <621cc94c-210d-6fd4-a2e1-b7cfce733cf3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <621cc94c-210d-6fd4-a2e1-b7cfce733cf3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-03-19 11:49:30, Anshuman Khandual wrote:
> 
> 
> On 03/21/2019 02:06 PM, Michal Hocko wrote:
> > On Thu 21-03-19 13:38:20, Anshuman Khandual wrote:
> >> Memory hot remove uses get_nid_for_pfn() while tearing down linked sysfs
> >> entries between memory block and node. It first checks pfn validity with
> >> pfn_valid_within() before fetching nid. With CONFIG_HOLES_IN_ZONE config
> >> (arm64 has this enabled) pfn_valid_within() calls pfn_valid().
> >>
> >> pfn_valid() is an arch implementation on arm64 (CONFIG_HAVE_ARCH_PFN_VALID)
> >> which scans all mapped memblock regions with memblock_is_map_memory(). This
> >> creates a problem in memory hot remove path which has already removed given
> >> memory range from memory block with memblock_[remove|free] before arriving
> >> at unregister_mem_sect_under_nodes().
> > 
> > Could you be more specific on what is the actual problem please? It
> > would be also helpful to mention when is the memblock[remove|free]
> > called actually.
> 
> The problem is in unregister_mem_sect_under_nodes() as it skips calling into both
> instances of sysfs_remove_link() which removes node-memory block sysfs symlinks.
> The node enumeration of the memory block still remains in sysfs even if the memory
> block itself has been removed.
> 
> This happens because get_nid_for_pfn() returns -1 for a given pfn even if it has
> a valid associated struct page to fetch the node ID from.
> 
> On arm64 (with CONFIG_HOLES_IN_ZONE)
> 
> get_nid_for_pfn() -> pfn_valid_within() -> pfn_valid -> memblock_is_map_memory()
> 
> At this point memblock for the range has been removed.
> 
> __remove_memory()
> 	memblock_free()
> 	memblock_remove()	--------> memblock has already been removed
> 	arch_remove_memory()
> 		__remove_pages()
> 			__remove_section()
> 				unregister_memory_section()
>  					remove_memory_section()
> 						unregister_mem_sect_under_nodes()
> 
> There is a dependency on memblock (after it has been removed) through pfn_valid().

Can we reorganize or rework the code that the memblock is removed later?
I guess this is what Oscar was suggesting.

Or ...

> >> During runtime memory hot remove get_nid_for_pfn() needs to validate that
> >> given pfn has a struct page mapping so that it can fetch required nid. This
> >> can be achieved just by looking into it's section mapping information. This
> >> adds a new helper pfn_section_valid() for this purpose. Its same as generic
> >> pfn_valid().
> > 
> > I have to say I do not like this. Having pfn_section_valid != pfn_valid_within
> > is just confusing as hell. pfn_valid_within should return true whenever
> > a struct page exists and it is sensible (same like pfn_valid). So it
> > seems that this is something to be solved on that arch specific side of
> > pfn_valid.
> 
> At present arm64's pfn_valid() implementation validates the pfn inside sparse
> memory section mapping as well memblock. The memblock search excludes memory
> with MEMBLOCK_NOMAP attribute. But in this particular instance during hotplug
> only section mapping validation for the pfn is good enough.
> 
> IIUC the current arm64 pfn_valid() already extends the definition beyond the
> availability of a valid struct page to operate on.

is there any way to record that nomap information into the section
instead. It looks rather weird that this information is spread into two
data structures and it makes pfn_valid more expensive at the same time.
-- 
Michal Hocko
SUSE Labs
