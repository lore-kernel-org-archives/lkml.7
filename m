Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFFDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B378221774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574936129;
	bh=anyANB+XsEnzltCK4bU8PTOq1HDad/i3YWqgxvLKIAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i+o4acq7eJDhdQUADRzWYFL4OiqCBA/usKlzsyCowwSdLZ2bgQ/uJZGPaBLUtF0qO
	 FYyXLBW+SUB76HxZQ33FykjdAMpza/tI2OSinHKoVSsPXcz5Fi+k/9jmNQKGIj7C9p
	 I9wzzSHsgWHOcAr2Yj/3C9PtXWns8TU12PseMVqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfK1KP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:15:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46965 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfK1KP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:15:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so26924331wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RaQdlszzuDgWhjMpY6dg4NeccHOPLScQ3D/dY4b09no=;
        b=Zl66hErt6OkvlBi+6ZJj8UAx3aZ+bHRWAITlMWy5X1+YGeNmZQWT1Cy2sH8INXGesD
         sUwuCwC61yJpbxGryqNwK/YWuxZTzA6zwaWuXd4Yy6IETcD1SorkAYLj/XUEGTBkMyl7
         JSUCjhBuxZKRPelhXWEdiG2TkhoHXH2FFo3PEKgpOz3bk4y/DtqO0RFgttIKUlJEp6Aj
         isz/jTWKCk0yxDXb/z+zoA2K3o6Ax7zZLsAf4I4iVuMQUWr68ksCiSiND3fYtD56f1Wv
         ZcATffqBwGzT/67FXRz62ApbipP7vyLzlDUcJ5ymrLo2M0bDFDf6x1JOdh3Y3Cg/IZRO
         toWw==
X-Gm-Message-State: APjAAAVnegZPQk+VqgeDm6lJID1C8dE5eJGtvQf/6e6N/g3KtHct2Umw
        0aNLZvIimhf1zucVxtVJUHk=
X-Google-Smtp-Source: APXvYqzeCdu3eiR5KbUmuc1zn2SskYx5c5XzkCZjP4ANNnQe6stdWCmblsielqxF13tyiVHnmUASaw==
X-Received: by 2002:adf:ec4b:: with SMTP id w11mr46427121wrn.243.1574936126102;
        Thu, 28 Nov 2019 02:15:26 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a24sm7669435wmb.29.2019.11.28.02.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 02:15:25 -0800 (PST)
Date:   Thu, 28 Nov 2019 11:15:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in
 find_(smallest|biggest)_section_pfn
Message-ID: <20191128101524.GH26807@dhcp22.suse.cz>
References: <20191127174158.28226-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127174158.28226-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-11-19 18:41:58, David Hildenbrand wrote:
> Now that we always check against a zone, we can stop checking against
> the nid, it is implicitly covered by the zone.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

OK, this makes some sense to me. The node really is superfluous and it
doesn't add any clarity. Quite contrary it just brings question why do
we check it as well. If there ever is a need to check for the node then
we have it available in struct zone and that would be much more robust
approach because an accidental mismatch between parameters is ruled out.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 46b2e056a43f..602f753c662c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -344,17 +344,14 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  }
>  
>  /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
> -static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
> -				     unsigned long start_pfn,
> -				     unsigned long end_pfn)
> +static unsigned long find_smallest_section_pfn(struct zone *zone,
> +					       unsigned long start_pfn,
> +					       unsigned long end_pfn)
>  {
>  	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUBSECTION) {
>  		if (unlikely(!pfn_to_online_page(start_pfn)))
>  			continue;
>  
> -		if (unlikely(pfn_to_nid(start_pfn) != nid))
> -			continue;
> -
>  		if (zone != page_zone(pfn_to_page(start_pfn)))
>  			continue;
>  
> @@ -365,9 +362,9 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
>  }
>  
>  /* find the biggest valid pfn in the range [start_pfn, end_pfn). */
> -static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
> -				    unsigned long start_pfn,
> -				    unsigned long end_pfn)
> +static unsigned long find_biggest_section_pfn(struct zone *zone,
> +					      unsigned long start_pfn,
> +					      unsigned long end_pfn)
>  {
>  	unsigned long pfn;
>  
> @@ -377,9 +374,6 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>  		if (unlikely(!pfn_to_online_page(pfn)))
>  			continue;
>  
> -		if (unlikely(pfn_to_nid(pfn) != nid))
> -			continue;
> -
>  		if (zone != page_zone(pfn_to_page(pfn)))
>  			continue;
>  
> @@ -393,7 +387,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  			     unsigned long end_pfn)
>  {
>  	unsigned long pfn;
> -	int nid = zone_to_nid(zone);
>  
>  	zone_span_writelock(zone);
>  	if (zone->zone_start_pfn == start_pfn) {
> @@ -403,7 +396,7 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  		 * In this case, we find second smallest valid mem_section
>  		 * for shrinking zone.
>  		 */
> -		pfn = find_smallest_section_pfn(nid, zone, end_pfn,
> +		pfn = find_smallest_section_pfn(zone, end_pfn,
>  						zone_end_pfn(zone));
>  		if (pfn) {
>  			zone->spanned_pages = zone_end_pfn(zone) - pfn;
> @@ -419,7 +412,7 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  		 * In this case, we find second biggest valid mem_section for
>  		 * shrinking zone.
>  		 */
> -		pfn = find_biggest_section_pfn(nid, zone, zone->zone_start_pfn,
> +		pfn = find_biggest_section_pfn(zone, zone->zone_start_pfn,
>  					       start_pfn);
>  		if (pfn)
>  			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
