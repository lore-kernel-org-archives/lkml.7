Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD344C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A789A218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553162600;
	bh=SEMZUVcX7pLFfkgD2J31gTYN7FPuMe2NRmoDrlaQqW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xak7MH1tLHO09W+OytMnfWKPOk+DOY+qg1v1ZRRYVdlzfqlJkLLqI8v2AAaTTYnnJ
	 hqTMSADhXur/wZs0gj+oXcf46mu8E2aiWiSzXFQ5RWGzxxsRMk7qk/3g9ld6Hi3DJI
	 4WC22NHjLaquF6icUF3inOeJ+WI6KT5Hd3M9M+4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfCUKDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:03:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:54304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728214AbfCUKDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:03:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB793B049;
        Thu, 21 Mar 2019 10:03:17 +0000 (UTC)
Date:   Thu, 21 Mar 2019 11:03:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.kravetz@oracle.com,
        zi.yan@cs.rutgers.edu, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/isolation: Remove redundant pfn_valid_within() in
 __first_valid_page()
Message-ID: <20190321100316.GN8696@dhcp22.suse.cz>
References: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
 <20190321094237.onu3kar2ez7xv5wj@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321094237.onu3kar2ez7xv5wj@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-03-19 10:42:40, Oscar Salvador wrote:
> On Thu, Mar 21, 2019 at 09:43:15AM +0530, Anshuman Khandual wrote:
> > pfn_valid_within() calls pfn_valid() when CONFIG_HOLES_IN_ZONE making it
> > redundant for both definitions (w/wo CONFIG_MEMORY_HOTPLUG) of the helper
> > pfn_to_online_page() which either calls pfn_valid() or pfn_valid_within().
> > pfn_valid_within() being 1 when !CONFIG_HOLES_IN_ZONE is irrelevant either
> > way. This does not change functionality.
> > 
> > Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> About the "Fixes:" tag issue, I agree with Michal that the code is not
> really broken, but perhaps "suboptimal" depending on how much can affect
> performance on those systems where pfn_valid_within() is more complicated than
> simple returning true.
> 
> I see that on arm64, that calls memblock_is_map_memory()->memblock_search(),
> to trigger a search for the region containing the address, so I guess it
> is an expensive operation.
> 
> Depending on how much time we can shave, it might be worth to have the tag
> Fixes, but the removal of the code is fine anyway, so:

Yeah, seeing a noticesable slowdown (actual numbers) would warrant a
backport to 5.0.

-- 
Michal Hocko
SUSE Labs
