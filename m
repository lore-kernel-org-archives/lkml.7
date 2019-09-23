Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7426720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569235948;
	bh=hVEcUP2XdTHKFAH20FkL7pAEYoxfyGGlbMFrOmKJoMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ck3iAhRhe6AX63mBxcxlLbGhdY4PmCp5D6GjyhMkKkGR4KxagGPDYjgYKqMsRNOOw
	 PCSsx0p+Ba7e/kvHuXvLwbCfDpAcM+ilNWM/t5FaVFUXu3nj68MMdRIBWYbFlRgJfI
	 iZHEgAB3nDP1ii5CYEA1iyEusQ+CDjKXUSASZzko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfIWKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:47574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728458AbfIWKw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D52AAEE1;
        Mon, 23 Sep 2019 10:52:25 +0000 (UTC)
Date:   Mon, 23 Sep 2019 12:52:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
Message-ID: <20190923105224.GH6016@dhcp22.suse.cz>
References: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-09-19 11:17:37, Anshuman Khandual wrote:
> In add_memory_resource() the memory range to be hot added first gets into
> the memblock via memblock_add() before arch_add_memory() is called on it.
> Reverse sequence should be followed during memory hot removal which already
> is being followed in add_memory_resource() error path. This now ensures
> required re-order between memblock_[free|remove]() and arch_remove_memory()
> during memory hot-remove.

This changelog is not really easy to follow. First of all please make
sure to explain whether there is any actual problem to solve or this is
an aesthetic matter. Please think of people reading this changelog in
few years and scratching their heads what you were thinking back then...

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Original patch https://lkml.org/lkml/2019/9/3/327
> 
> Memory hot remove now works on arm64 without this because a recent commit
> 60bb462fc7ad ("drivers/base/node.c: simplify unregister_memory_block_under_nodes()").
> 
> David mentioned that re-ordering should still make sense for consistency
> purpose (removing stuff in the reverse order they were added). This patch
> is now detached from arm64 hot-remove series.
> 
> https://lkml.org/lkml/2019/9/3/326
> 
>  mm/memory_hotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c73f09913165..355c466e0621 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1770,13 +1770,13 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
> -	memblock_free(start, size);
> -	memblock_remove(start, size);
>  
>  	/* remove memory block devices before removing memory */
>  	remove_memory_block_devices(start, size);
>  
>  	arch_remove_memory(nid, start, size, NULL);
> +	memblock_free(start, size);
> +	memblock_remove(start, size);
>  	__release_memory_resource(start, size);
>  
>  	try_offline_node(nid);
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
