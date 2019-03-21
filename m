Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDC0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B615218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553157404;
	bh=9T332Y0mZkwTkCFRz76z5V1n2jZJvJkza9vnqt7zONo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g85ykr/moGPu0UTso2wgbZrxx+H4w/yaOYD+cUoGYeuYSreU4t7bQS6mPnzcK0N5r
	 mPZq9tI3M/o4PWjujETj1STTTRpdnbOAIYluMtUOvqrS92+a54R/jg23183ZGs5cyJ
	 IsTfDAmkOWSSP9UhWZrSv/FJjnWNE76pHO6D8YqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfCUIgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:36:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:35926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfCUIgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:36:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 460A5AC8A;
        Thu, 21 Mar 2019 08:36:41 +0000 (UTC)
Date:   Thu, 21 Mar 2019 09:36:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, osalvador@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        rientjes@google.com, zi.yan@cs.rutgers.edu
Subject: Re: [RFC] mm/hotplug: Make get_nid_for_pfn() work with
 HAVE_ARCH_PFN_VALID
Message-ID: <20190321083639.GJ8696@dhcp22.suse.cz>
References: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-03-19 13:38:20, Anshuman Khandual wrote:
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

Could you be more specific on what is the actual problem please? It
would be also helpful to mention when is the memblock[remove|free]
called actually.

> During runtime memory hot remove get_nid_for_pfn() needs to validate that
> given pfn has a struct page mapping so that it can fetch required nid. This
> can be achieved just by looking into it's section mapping information. This
> adds a new helper pfn_section_valid() for this purpose. Its same as generic
> pfn_valid().

I have to say I do not like this. Having pfn_section_valid != pfn_valid_within
is just confusing as hell. pfn_valid_within should return true whenever
a struct page exists and it is sensible (same like pfn_valid). So it
seems that this is something to be solved on that arch specific side of
pfn_valid.
-- 
Michal Hocko
SUSE Labs
