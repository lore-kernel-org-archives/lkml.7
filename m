Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D8CC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21186214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565820662;
	bh=2YQMr9WmohFL+xkk50uFprdKReR2E7JTnbbbO1059oA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fbO8FtRKyguzYQ94SwVe1kl3Htvx5bFCPbZFM/PC1bK4bvNiezVKzVitXE12zRDeM
	 cu0I4fyKWXdQlFctTE9SO6LJM93KaR2f0TVu9XK6Q86AhqCTZs6gc8cOfZhS163xBt
	 Mx1atEozvlRtiBR+9G/N+qRRXjcB7mTp4yPp/m1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfHNWLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfHNWLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:11:00 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BF32064A;
        Wed, 14 Aug 2019 22:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565820660;
        bh=2YQMr9WmohFL+xkk50uFprdKReR2E7JTnbbbO1059oA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nni+87chGmQaQDK8GYduslnDr78IJ75iX/jjJzdja8FuHyonKkGVJ9TJbqa+1r2+g
         Bj5z2EZ9x7Tu4dLBvT9FHLLid9v0DUT5RTzPuYXwyKdKNIbsFi6X0YF5iUvKb5JNAj
         EqADKsB5cz+e0n1z7exbiuiRittpuRoGaNTXA404=
Date:   Wed, 14 Aug 2019 15:10:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arun KS <arunks@codeaurora.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/5] mm/memory_hotplug: Make sure the pfn is aligned
 to the order when onlining
Message-Id: <20190814151059.54618c4f86b7e0c613ab7413@linux-foundation.org>
In-Reply-To: <784cba14-e0ad-cfea-8ffc-bfbf855ceb10@redhat.com>
References: <20190814154109.3448-1-david@redhat.com>
        <20190814154109.3448-5-david@redhat.com>
        <20190814135608.a449ca5a75cd700e077a8d23@linux-foundation.org>
        <784cba14-e0ad-cfea-8ffc-bfbf855ceb10@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 23:47:24 +0200 David Hildenbrand <david@redhat.com> wrote:

> >> --- a/mm/memory_hotplug.c
> >> +++ b/mm/memory_hotplug.c
> >> @@ -646,6 +646,9 @@ static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> >>  	 */
> >>  	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
> >>  		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
> >> +		/* __free_pages_core() wants pfns to be aligned to the order */
> >> +		if (unlikely(!IS_ALIGNED(pfn, 1ul << order)))
> >> +			order = 0;
> >>  		(*online_page_callback)(pfn_to_page(pfn), order);
> >>  	}
> > 
> > We aren't sure if this occurs, but if it does, we silently handle it.
> > 
> > It seems a reasonable defensive thing to do, but should we add a
> > WARN_ON_ONCE() so that we get to find out about it?  If we get such a
> > report then we can remove the WARN_ON_ONCE() and add an illuminating
> > comment.
> > 
> > 
> 
> Makes sense, do you want to add the WARN_ON_ONCE() or shall I resend?

--- a/mm/memory_hotplug.c~mm-memory_hotplug-make-sure-the-pfn-is-aligned-to-the-order-when-onlining-fix
+++ a/mm/memory_hotplug.c
@@ -647,7 +647,7 @@ static int online_pages_range(unsigned l
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
 		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
 		/* __free_pages_core() wants pfns to be aligned to the order */
-		if (unlikely(!IS_ALIGNED(pfn, 1ul << order)))
+		if (WARN_ON_ONCE(!IS_ALIGNED(pfn, 1ul << order)))
 			order = 0;
 		(*online_page_callback)(pfn_to_page(pfn), order);
 	}
_

