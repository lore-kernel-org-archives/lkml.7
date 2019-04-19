Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6090BC282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2330C2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="naKeu+d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDSXJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:09:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2625 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDSXJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:09:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cba55290000>; Fri, 19 Apr 2019 16:09:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Apr 2019 16:09:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Apr 2019 16:09:51 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Apr
 2019 23:09:51 +0000
Subject: Re: [PATCH v6 04/12] mm/hotplug: Prepare shrink_{zone, pgdat}_span
 for sub-section removal
To:     Dan Williams <dan.j.williams@intel.com>,
        <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>, <linux-mm@kvack.org>,
        <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <001f15a6-26bb-cbab-587f-d897b2dc9094@nvidia.com>
Date:   Fri, 19 Apr 2019 16:09:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555715370; bh=LsXD0klpMTgpZM/8Qdv7cRMawphkfxNMAjiWA9I1AKk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=naKeu+d4gLKnO5C+DmaZOCySBAoJ8cnyIa7Zr53HUzI9uYduIhZ1k2Arw1neNJcdn
         aR+9Tv/IC6YDMK/wVL9YN1vtgnb0vP9YXGs5ivCcr/3cbfnKeMHGteKPNTpi58wYbB
         ipGbxXkNE7Gt0GK5OYE40P0YsZMCe2FrS7HQZB79Dj3cyL1cU/PA2Z1sJQFa3dX4wE
         bd2gwNrqZveXL7PvMzhmlhH1VhC/W/NTxXIbhBgI+iQ9pGqcELanGfC31bknXs/rGX
         wBxEJxxe4sKIxV9tYKJQqCceUIq9hxLGhbm4+NYeiVn7J8LWXu6zC/iPCTWpPy7Ndp
         V67k15WSlznHg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed this by inspection.
I can't say I'm very familiar with the code.

On 4/17/19 11:39 AM, Dan Williams wrote:
> Sub-section hotplug support reduces the unit of operation of hotplug
> from section-sized-units (PAGES_PER_SECTION) to sub-section-sized units
> (PAGES_PER_SUBSECTION). Teach shrink_{zone,pgdat}_span() to consider
> PAGES_PER_SUBSECTION boundaries as the points where pfn_valid(), not
> valid_section(), can toggle.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   include/linux/mmzone.h |    2 ++
>   mm/memory_hotplug.c    |   16 ++++++++--------
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index cffde898e345..b13f0cddf75e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1164,6 +1164,8 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
>   
>   #define SECTION_ACTIVE_SIZE ((1UL << SECTION_SIZE_BITS) / BITS_PER_LONG)
>   #define SECTION_ACTIVE_MASK (~(SECTION_ACTIVE_SIZE - 1))
> +#define PAGES_PER_SUB_SECTION (SECTION_ACTIVE_SIZE / PAGE_SIZE)
> +#define PAGE_SUB_SECTION_MASK (~(PAGES_PER_SUB_SECTION-1))
>   
>   struct mem_section_usage {
>   	/*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8b7415736d21..d5874f9d4043 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -327,10 +327,10 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
>   {
>   	struct mem_section *ms;
>   
> -	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SECTION) {
> +	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUB_SECTION) {
>   		ms = __pfn_to_section(start_pfn);
>   
> -		if (unlikely(!valid_section(ms)))
> +		if (unlikely(!pfn_valid(start_pfn)))
>   			continue;

Note that "struct mem_section *ms;" is now set but not used.
You can remove the definition and initialization of "ms".

>   		if (unlikely(pfn_to_nid(start_pfn) != nid))
> @@ -355,10 +355,10 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>   
>   	/* pfn is the end pfn of a memory section. */
>   	pfn = end_pfn - 1;
> -	for (; pfn >= start_pfn; pfn -= PAGES_PER_SECTION) {
> +	for (; pfn >= start_pfn; pfn -= PAGES_PER_SUB_SECTION) {
>   		ms = __pfn_to_section(pfn);
>   
> -		if (unlikely(!valid_section(ms)))
> +		if (unlikely(!pfn_valid(pfn)))
>   			continue;

Ditto about "ms".

>   		if (unlikely(pfn_to_nid(pfn) != nid))
> @@ -417,10 +417,10 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>   	 * it check the zone has only hole or not.
>   	 */
>   	pfn = zone_start_pfn;
> -	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SECTION) {
> +	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUB_SECTION) {
>   		ms = __pfn_to_section(pfn);
>   
> -		if (unlikely(!valid_section(ms)))
> +		if (unlikely(!pfn_valid(pfn)))
>   			continue;

Ditto about "ms".

>   		if (page_zone(pfn_to_page(pfn)) != zone)
> @@ -485,10 +485,10 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
>   	 * has only hole or not.
>   	 */
>   	pfn = pgdat_start_pfn;
> -	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SECTION) {
> +	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SUB_SECTION) {
>   		ms = __pfn_to_section(pfn);
>   
> -		if (unlikely(!valid_section(ms)))
> +		if (unlikely(!pfn_valid(pfn)))
>   			continue;

Ditto about "ms".

>   		if (pfn_to_nid(pfn) != nid)
> 
