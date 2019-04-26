Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB5DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB112077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfDZN7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:59:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfDZN7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:59:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9654AEC2;
        Fri, 26 Apr 2019 13:59:15 +0000 (UTC)
Date:   Fri, 26 Apr 2019 15:59:12 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        david@redhat.com
Subject: Re: [PATCH v6 04/12] mm/hotplug: Prepare shrink_{zone, pgdat}_span
 for sub-section removal
Message-ID: <20190426135907.GA30513@linux>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:39:16AM -0700, Dan Williams wrote:
> @@ -417,10 +417,10 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  	 * it check the zone has only hole or not.
>  	 */
>  	pfn = zone_start_pfn;
> -	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SECTION) {
> +	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUB_SECTION) {
>  		ms = __pfn_to_section(pfn);
>  
> -		if (unlikely(!valid_section(ms)))
> +		if (unlikely(!pfn_valid(pfn)))
>  			continue;
>  
>  		if (page_zone(pfn_to_page(pfn)) != zone)
> @@ -485,10 +485,10 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
>  	 * has only hole or not.
>  	 */
>  	pfn = pgdat_start_pfn;
> -	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SECTION) {
> +	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SUB_SECTION) {
>  		ms = __pfn_to_section(pfn);
>  
> -		if (unlikely(!valid_section(ms)))
> +		if (unlikely(!pfn_valid(pfn)))
>  			continue;
>  
>  		if (pfn_to_nid(pfn) != nid)

The last loop from shrink_{pgdat,zone}_span can be reworked to unify both
in one function, and both functions can be factored out a bit.
Actually, I do have a patch that does that, I might dig it up.

The rest looks good:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> 

-- 
Oscar Salvador
SUSE L3
