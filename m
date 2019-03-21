Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA7921915
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfCUKhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:37:02 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:26235 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727859AbfCUKhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:37:01 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 9825D464D; Thu, 21 Mar 2019 11:37:00 +0100 (CET)
Date:   Thu, 21 Mar 2019 11:37:00 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        rientjes@google.com, zi.yan@cs.rutgers.edu
Subject: Re: [RFC] mm/hotplug: Make get_nid_for_pfn() work with
 HAVE_ARCH_PFN_VALID
Message-ID: <20190321103657.22ivyuyq3k7zhy5n@d104.suse.de>
References: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:38:20PM +0530, Anshuman Khandual wrote:
> Memory hot remove uses get_nid_for_pfn() while tearing down linked sysfs
> entries between memory block and node. It first checks pfn validity with
> pfn_valid_within() before fetching nid. With CONFIG_HOLES_IN_ZONE config
> (arm64 has this enabled) pfn_valid_within() calls pfn_valid().
> 
> pfn_valid() is an arch implementation on arm64 (CONFIG_HAVE_ARCH_PFN_VALID)
> which scans all mapped memblock regions with memblock_is_map_memory(). This
> creates a problem in memory hot remove path which has already removed given
> memory range from memory block with memblock_[remove|free] before arriving
> at unregister_mem_sect_under_nodes().
> 
> During runtime memory hot remove get_nid_for_pfn() needs to validate that
> given pfn has a struct page mapping so that it can fetch required nid. This
> can be achieved just by looking into it's section mapping information. This
> adds a new helper pfn_section_valid() for this purpose. Its same as generic
> pfn_valid().
> 
> This maintains existing behaviour for deferred struct page init case.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

I did not look really close to the patch, but I was dealing with
unregister_mem_sect_under_nodes() some time ago [1].

The thing is, I think we can just make it less complex.
Jonathan tried it out that patch on arm64 back then, and it worked correctly
for him, and it did for me too on x86_64.

I am not sure if I overlooked a corner case during the creation of the patch,
that could lead to problems.
But if not, we can get away with that, and we would not need to worry
about get_nid_for_pfn on hot-remove path.

I plan to revisit the patch in some days, but first I wanted to sort out
the vmemmap stuff, which I am preparing a new version of it.

[1] https://patchwork.kernel.org/patch/10700795/

-- 
Oscar Salvador
SUSE L3
