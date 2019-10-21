Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75209CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C98A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571672836;
	bh=yWTVOHOUEozzL0/pvoAXqbBAibq+XkVJT53b4tBpbY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Emmy035RaWpqpDXNXXqTjX0gjEV+Jjt/mkFZTRwRlX/qIGZgMQmH1Fd1dlJqLpXDt
	 NkbyuLkvYrnNV7J1BslmHEE5CxNBx3y74dYhcAUsi70ZvA1RPazihJYn1tfdSSl135
	 NMsWhNTQYgK4uUPzdgSZL+tlDf15NQuROlOTWRjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfJUPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:47:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbfJUPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B848EAE79;
        Mon, 21 Oct 2019 15:47:12 +0000 (UTC)
Date:   Mon, 21 Oct 2019 17:47:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc.c: Don't set pages PageReserved()
 when offlining
Message-ID: <20191021154712.GW9379@dhcp22.suse.cz>
References: <20191021141927.10252-1-david@redhat.com>
 <20191021141927.10252-2-david@redhat.com>
 <20191021144345.GT9379@dhcp22.suse.cz>
 <b6a392c9-1cb8-321e-b7ba-d483d928a3cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a392c9-1cb8-321e-b7ba-d483d928a3cc@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 17:39:36, David Hildenbrand wrote:
> On 21.10.19 16:43, Michal Hocko wrote:
[...]
> > We still set PageReserved before onlining pages and that one should be
> > good to go as well (memmap_init_zone).
> > Thanks!
> 
> memmap_init_zone() is called when onlining memory. There, set all pages to
> reserved right now (on context == MEMMAP_HOTPLUG). We clear PG_reserved when
> onlining a page to the buddy (e.g., generic_online_page). If we would online
> a memory block with holes, we would want to keep all such pages
> (!pfn_valid()) set to reserved. Also, there might be other side effects.

Isn't it sufficient to have those pages in a poisoned state? They are
not onlined so their state is basically undefined anyway. I do not see
how PageReserved makes this any better.

Also is the hole inside a hotplugable memory something we really have to
care about. Has anybody actually seen a platform to require that?
-- 
Michal Hocko
SUSE Labs
