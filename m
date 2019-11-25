Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDA2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3170A20835
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=familie-tometzki.de header.i=@familie-tometzki.de header.b="SmKp7ahW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfKYRkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:40:37 -0500
Received: from mail-qk1-f230.google.com ([209.85.222.230]:36545 "EHLO
        mail-qk1-f230.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYRkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:40:36 -0500
Received: by mail-qk1-f230.google.com with SMTP id d13so13534010qko.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+huwJCFXXOEMTc07Kcaz/2nVWKpv10+dNgjYcwOYVxg=;
        b=SmKp7ahWJXnjNJG2md/iJJ0FMJoFExTujhG38AIwSLtzxmfgQ4jF9PHfa32ql/CZPV
         4Ar5Mlj+e1/OX17UzQceqQFYgbyEyVS/eR44NKa5YkQUZ5FbMFoPpshZFJ1PsvV6fLwb
         hM82XE6+gvJmgv5EutE8uSuW1sp/jdQkRtGWWRU8ATLTayl7+fzQ+cz7V62lQh038/EV
         9r5P2WHGpHhM+no8nJcth/WoOeDEZ4iji+2/ZiqB7mJOLqFtE6olFPBVBGEvLKUL/6hd
         mvKriEqkwUhYmXRlYb/BxzlLOcMjQ5AL9rb7j7vET1hyt7DEiYjmE891rPSmvT4CRybc
         7gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+huwJCFXXOEMTc07Kcaz/2nVWKpv10+dNgjYcwOYVxg=;
        b=O+oOc4+u2JluOUijDtLhrJFp1idiMBKwLbU3omHaRm83fUto9XbyusT9nAwOhwbW3j
         jQSsQzCk+kNI99JaJXpbmxPNHUACnL4s4MX546J64WWEOWCzWp4JTNk8mshv/4OD1idx
         tq7XuN/EIiK2R3lGiOQiG6VGA+nwc0hV87TNnyN8bb+SFXOjQh+rMgc13rJ+C5VASep4
         seVoxld2as71Ab5DwOgcS+VDzl4BtaLSub5ijc3s8xVWb/OoBSi00qimO4F1rW8YfePs
         ue3lwrxe7Ri1p7bL29tHNMyCgTjt14xpxIYzMXCRFcsnUlosIzeFc4Z+xjCJdGda5A/L
         FBEw==
X-Gm-Message-State: APjAAAWFgtwdqfo5NnpMvHnPa6qqr8ToceOK6CIdr+3PGeOFDQpYkz6c
        UKCeEAi5FD1wDk2WwrgcD7vz0Bt86Skp+EfTc3hOlJ3Fz/Zs+A==
X-Google-Smtp-Source: APXvYqyug6y3iBLlHZKNmE08YXCDHxV2pZWQgGUccS4PANp0NI7422vEJm9i15MpiFGaP62GSvAFCNf5VRv4
X-Received: by 2002:a05:620a:78d:: with SMTP id 13mr27647992qka.311.1574703635558;
        Mon, 25 Nov 2019 09:40:35 -0800 (PST)
Received: from freebsd.familie-tometzki.de (freebsd.familie-tometzki.de. [18.210.29.142])
        by smtp-relay.gmail.com with ESMTPS id f23sm1129510qkg.9.2019.11.25.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 09:40:35 -0800 (PST)
X-Relaying-Domain: familie-tometzki.de
Received: from freebsd.familie-tometzki.de (freebsd.familie-tometzki.de [10.0.1.7])
        by freebsd.familie-tometzki.de (Postfix) with ESMTP id 8339427515;
        Mon, 25 Nov 2019 18:40:34 +0100 (CET)
Date:   Mon, 25 Nov 2019 18:40:34 +0100
From:   Damian Tometzki <dti+kernel@familie-tometzki.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] mm/memory_hotplug: Don't allow to online/offline
 memory blocks with holes
Message-ID: <20191125174034.GA41469@freebsd.familie-tometzki.de>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20191119115237.6662-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119115237.6662-1-david@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19. Nov 12:52, David Hildenbrand wrote:
> Our onlining/offlining code is unnecessarily complicated. Only memory
> blocks added during boot can have holes (a range that is not
> IORESOURCE_SYSTEM_RAM). Hotplugged memory never has holes (e.g., see
> add_memory_resource()). All memory blocks that belong to boot memory are
> already online.
> 
> Note that boot memory can have holes and the memmap of the holes is marked
> PG_reserved. However, also memory allocated early during boot is
> PG_reserved - basically every page of boot memory that is not given to the
> buddy is PG_reserved.
> 
> Therefore, when we stop allowing to offline memory blocks with holes, we
> implicitly no longer have to deal with onlining memory blocks with holes.
> E.g., online_pages() will do a
> walk_system_ram_range(..., online_pages_range), whereby
> online_pages_range() will effectively only free the memory holes not
> falling into a hole to the buddy. The other pages (holes) are kept
> PG_reserved (via move_pfn_range_to_zone()->memmap_init_zone()).
> 
> This allows to simplify the code. For example, we no longer have to
> worry about marking pages that fall into memory holes PG_reserved when
> onlining memory. We can stop setting pages PG_reserved completely in
> memmap_init_zone().
> 
> Offlining memory blocks added during boot is usually not guaranteed to work
> either way (unmovable data might have easily ended up on that memory during
> boot). So stopping to do that should not really hurt. Also, people are not
> even aware of a setup where onlining/offlining of memory blocks with
> holes used to work reliably (see [1] and [2] especially regarding the
> hotplug path) - I doubt it worked reliably.
> 
> For the use case of offlining memory to unplug DIMMs, we should see no
> change. (holes on DIMMs would be weird).
> 
> Please note that hardware errors (PG_hwpoison) are not memory holes and
> are not affected by this change when offlining.
> 
> [1] https://lkml.org/lkml/2019/10/22/135
> [2] https://lkml.org/lkml/2019/8/14/1365
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> This patch was part of:
> 	[PATCH v1 00/10] mm: Don't mark hotplugged pages PG_reserved
> 	(including ZONE_DEVICE)
> 	-> https://www.spinics.net/lists/linux-driver-devel/msg130042.html
> 
> However, before we can perform the PG_reserved changes, we have to fix
> pfn_to_online_page() in special scenarios first (bootmem and devmem falling
> into a single section). Dan is working on that.
> 
> I propose to give this patch a churn in -next so we can identify if this
> change would break any existing setup. I will then follow up with cleanups
> and the PG_reserved changes later.
> 
> ---
>  mm/memory_hotplug.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 46b2e056a43f..fc617ad6f035 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1455,10 +1455,19 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
>  		node_clear_state(node, N_MEMORY);
>  }
>  
> +static int count_system_ram_pages_cb(unsigned long start_pfn,
> +				     unsigned long nr_pages, void *data)
> +{
> +	unsigned long *nr_system_ram_pages = data;
> +
> +	*nr_system_ram_pages += nr_pages;
> +	return 0;
> +}
> +
Hello David,

what is the meaning of the function ? The return is every time 0. 

I dont understand it ?

Best regards
Damian

>  static int __ref __offline_pages(unsigned long start_pfn,
>  		  unsigned long end_pfn)
>  {
> -	unsigned long pfn, nr_pages;
> +	unsigned long pfn, nr_pages = 0;
>  	unsigned long offlined_pages = 0;
>  	int ret, node, nr_isolate_pageblock;
>  	unsigned long flags;
> @@ -1469,6 +1478,22 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  
>  	mem_hotplug_begin();
>  
> +	/*
> +	 * Don't allow to offline memory blocks that contain holes.
> +	 * Consequently, memory blocks with holes can never get onlined
> +	 * via the hotplug path - online_pages() - as hotplugged memory has
> +	 * no holes. This way, we e.g., don't have to worry about marking
> +	 * memory holes PG_reserved, don't need pfn_valid() checks, and can
> +	 * avoid using walk_system_ram_range() later.
> +	 */
> +	walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
> +			      count_system_ram_pages_cb);
> +	if (nr_pages != end_pfn - start_pfn) {
> +		ret = -EINVAL;
> +		reason = "memory holes";
> +		goto failed_removal;
> +	}
> +
>  	/* This makes hotplug much easier...and readable.
>  	   we assume this for now. .*/
>  	if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start,
> @@ -1480,7 +1505,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  
>  	zone = page_zone(pfn_to_page(valid_start));
>  	node = zone_to_nid(zone);
> -	nr_pages = end_pfn - start_pfn;
>  
>  	/* set above range as isolated */
>  	ret = start_isolate_page_range(start_pfn, end_pfn,
> -- 
> 2.21.0
> 
> 
