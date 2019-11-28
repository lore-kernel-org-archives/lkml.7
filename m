Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFB4C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1374B21781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574941826;
	bh=qTT6E8YRt/oOh19g7ey+f1QBN1z4cn0BJAB9BtcsmcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oeYcLCUs3v6NAppGCgCZqHvNBR1TWXMQNSIJs5JCiwIk29U/3V1BCJRrisKHbarvb
	 pMAeq4MhUA/hBEJfgteiawBVZAGzyA7C/OSx+v4NiHZ5GH7sv+3ZPlpm21rEsZTRd1
	 gcdbqyuG3eA1i43EMYN+/f7UIl2FSzwuarrlufS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfK1LuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:50:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40480 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1LuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:50:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so6124318wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 03:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmLcKOmIA16FX9tnY2ZPEvFzU6RreEjPc+Jrr3fPjfA=;
        b=f+MocNaY2dSAAJ8/O0GBsipgBQKP9tud2kI9fmrkFWR4WhW2qfHq7g6ewrfsrSzjWf
         q5aAk1yNDX4SJIzN2kVbThw3uS13eFRHV961d44DKPUrSOo471sIL7d4MafYn7G7tiUg
         6yu887vHWEY3u2lC8TA2DK6GN4i5T8ujekJ4uKnzg+bn2/kWyyWqk00tcGOYuSmvUoO7
         oEti7RP1Svq1A2Pii2OkGPt07DCi6QFqC59CD74VorgFnunACiQx6wSBqXW/LN2NH+XC
         yH+rGyOySQ5cCC7oazsuj32iDBLS/Q0BAJ4Z3M5h03JjBgS2aac+H1ZOHIBmK6QaCn2f
         G1Yw==
X-Gm-Message-State: APjAAAX5kIT2D8fxtcAa7biPnIdxsI2+fxeRORQdPhsv22boyNkNvcNi
        QJq+K+r8274IbIur7nSxmbk=
X-Google-Smtp-Source: APXvYqyCMXoGweWrexaZkJ2yraofBHm/5mseUsg+BHIXD88+l/tNxzb/A16mBGOA769kWy4GSet5yQ==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr48142135wrx.113.1574941822320;
        Thu, 28 Nov 2019 03:50:22 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f67sm10453953wme.16.2019.11.28.03.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 03:50:21 -0800 (PST)
Date:   Thu, 28 Nov 2019 12:50:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/base/node.c: get rid of get_nid_for_pfn()
Message-ID: <20191128115021.GJ26807@dhcp22.suse.cz>
References: <20191128102051.GI26807@dhcp22.suse.cz>
 <5E2F5866-0605-4DD2-9AEA-4B1C44E57D9F@redhat.com>
 <c8d2225f-9a90-65fa-5553-f4af8ca39b44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d2225f-9a90-65fa-5553-f4af8ca39b44@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-11-19 12:23:08, David Hildenbrand wrote:
[...]
> >From fc13fd540a1702592e389e821f6266098e41e2bd Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 27 Nov 2019 16:18:42 +0100
> Subject: [PATCH] drivers/base/node.c: optimize get_nid_for_pfn()
> 
> Since commit d84f2f5a7552 ("drivers/base/node.c: simplify
> unregister_memory_block_under_nodes()") we only have a single user of
> get_nid_for_pfn(). The remaining user calls this function when booting -
> where all added memory is online.
> 
> Make it clearer that this function should only be used during boot (
> e.g., calling it on offline memory would be bad) by renaming the
> function to something meaningful, optimize out the ifdef and the additional
> system_state check, and add a comment why CONFIG_DEFERRED_STRUCT_PAGE_INIT
> handling is in place at all.
> 
> Also, optimize the call site. There is no need to check against
> page_nid < 0 - it will never match the nid (nid >= 0).
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yes this looks much better! I am not sure this will pass all weird
config combinations because IS_ENABLED will not hide early_pfn_to_nid
from the early compiler stages so it might complain. But if this passes
0day compile scrutiny then this is much much better. If not then we just
have to use ifdef which is a minor thing.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  drivers/base/node.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 98a31bafc8a2..d525e30581de 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -744,14 +744,16 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> -static int __ref get_nid_for_pfn(unsigned long pfn)
> +static int __ref boot_pfn_to_nid(unsigned long pfn)
>  {
>  	if (!pfn_valid_within(pfn))
>  		return -1;
> -#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> -	if (system_state < SYSTEM_RUNNING)
> +	/*
> +	 * With deferred struct page initialization, the memmap will contain
> +	 * garbage - we have to rely on the early nid.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
>  		return early_pfn_to_nid(pfn);
> -#endif
>  	return pfn_to_nid(pfn);
>  }
>  
> @@ -766,8 +768,6 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  	unsigned long pfn;
>  
>  	for (pfn = start_pfn; pfn <= end_pfn; pfn++) {
> -		int page_nid;
> -
>  		/*
>  		 * memory block could have several absent sections from start.
>  		 * skip pfn range from absent section
> @@ -783,13 +783,9 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  		 * case, during hotplug we know that all pages in the memory
>  		 * block belong to the same node.
>  		 */
> -		if (system_state == SYSTEM_BOOTING) {
> -			page_nid = get_nid_for_pfn(pfn);
> -			if (page_nid < 0)
> -				continue;
> -			if (page_nid != nid)
> -				continue;
> -		}
> +		if (system_state == SYSTEM_BOOTING &&
> +		    boot_pfn_to_nid(pfn) != nid)
> +			continue;
>  
>  		/*
>  		 * If this memory block spans multiple nodes, we only indicate
> -- 
> 2.21.0
> 
> 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb

-- 
Michal Hocko
SUSE Labs
