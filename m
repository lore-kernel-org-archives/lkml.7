Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F5AC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B80B222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570310560;
	bh=b2ojuscvA5vHZZCIRcmyr63IQh+4Z67dn4JCAN9oUvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=a9FNay3aKjLIa+kk/1doh47DaI0Zj7Dcj4ORSaiOiT3dOHeiY7i1cgHNVICdTqOOI
	 faTcg1urprP63ql0EJ3E6ygFfYF3UuR3654lpSNobQdkX1OAIlELOkdNccXPMj440f
	 AJqma31CcdSSyrv6hKoBqyIC5SuGk4IeqR2UkSMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfJEVWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 17:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJEVWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 17:22:36 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E39222C5;
        Sat,  5 Oct 2019 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570310553;
        bh=b2ojuscvA5vHZZCIRcmyr63IQh+4Z67dn4JCAN9oUvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vomw4Odzzw6K7rO6NN4INokEnUY6gIv4thk7COYozO8+LUEx2QuMV+Pq8PZVl+7oa
         Nx5x+M1wSdYtnKovrxGVdUAzPbhBR+C04UtI6ublLEyzQxdZKdUWvDyYP07mNo5cbN
         LpFB/bMGN6ywLBW0Gt6P5gpkqiWgnYJpxSvNwIgo=
Date:   Sat, 5 Oct 2019 14:22:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
Message-Id: <20191005142232.e08976cf8905824fad0533ff@linux-foundation.org>
In-Reply-To: <20191004144150.GO9578@dhcp22.suse.cz>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
        <20191004105824.GD9578@dhcp22.suse.cz>
        <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
        <1570193776.5576.270.camel@lca.pw>
        <20191004130713.GK9578@dhcp22.suse.cz>
        <1570195839.5576.273.camel@lca.pw>
        <20191004133814.GM9578@dhcp22.suse.cz>
        <1570197360.5576.275.camel@lca.pw>
        <20191004144150.GO9578@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019 16:41:50 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > > This is just insane. The hotplug code is in no way special wrt printk.
> > > It is never called from the printk code AFAIK and thus there is no real
> > > reason why this particular code should be any special. Not to mention
> > > it calls printk indirectly from a code that is shared with other code
> > > paths.
> > 
> > Basically, printk() while holding the zone_lock will be problematic as console
> > is doing the opposite as it always needs to allocate some memory. Then, it will
> > always find some way to form this chain,
> > 
> > console_lock -> * -> zone_lock.
> 
> So this is not as much a hotplug specific problem but zone->lock ->
> printk -> alloc chain that is a problem, right? Who is doing an
> allocation from this atomic context? I do not see any atomic allocation
> in kernel/printk/printk.c.

Apparently some console drivers can do memory allocation on the printk()
path.

This behavior is daft, IMO.  Have we identified which ones and looked
into fixing them?

