Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FEEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2282053B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574936457;
	bh=J1+iNaRSXKUt7bMtf7Wi4WCO+LwToo+LiJe8WeiPmPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jbK5ycNnVJTLugaXEI9nTyDyVNosl2BQWG4zsvYXy5R/WRBQoN9D9H6hCVHZaZ1ui
	 7uEfdmhn4fJnV5KiVwaGrzQp3hI9p78j/GFdltmEI4GP2zFim7ydhfZaIsgaHes7ej
	 vYWjEmN4XfgoPjjiJuKhOQpuJVzbIvVnMeBfC+gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfK1KU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:20:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34230 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfK1KU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:20:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so30359639wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=caWmBHqOFCXoHvzB9Rg0Yov3N8s7t2SawQxPVgzqSw4=;
        b=dCYQR2n44rq+7GWeL5Lgy7OmheUIf5XwE1+PFdVyCrsbnfPhLTrVBfN4pdpzsw8O/S
         yv7sgl8CBCwiRYjZV8XJbik2idGU7y9fraEfU3U/9YS4rCp5WcBWieHRu0yK+sy64VUy
         tjVH1fTv8H8DqVauPID3lOHN+AF0mrCypt1Zm9hGXr9ViFAEU0mDI7DiWNrhUkzwud0z
         m/WhbFHURFWiXmwiXLYk8V8JQc8a4FK9JEWcgRxYWNyJlQ3VXfkQriIAPl76ru+d+hHD
         OijLzNnGig5I5gNY+zSBdKiDbhQgQm8QyJqW19l9qgm+VIoEJCF0IfOKgzSBLnLcu+lE
         /xSw==
X-Gm-Message-State: APjAAAXeCFlkkR4xkyEudm2LR46R2iS6iQS2YN9u+VU7o/5cxJywdro7
        cPw9LDSHYKQjEHVYS7ypR1w=
X-Google-Smtp-Source: APXvYqwGRZRnVs75F0orSXv2n5n1SyiQDtgNO1It2H0+sjNBdyZzegh5FzGkWXuN2ViBfGB8/E225g==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr29500317wru.154.1574936452924;
        Thu, 28 Nov 2019 02:20:52 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z6sm9672837wrw.36.2019.11.28.02.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 02:20:52 -0800 (PST)
Date:   Thu, 28 Nov 2019 11:20:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/base/node.c: get rid of get_nid_for_pfn()
Message-ID: <20191128102051.GI26807@dhcp22.suse.cz>
References: <20191127174126.28064-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127174126.28064-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-11-19 18:41:26, David Hildenbrand wrote:
> Since commit d84f2f5a7552 ("drivers/base/node.c: simplify
> unregister_memory_block_under_nodes()") we only have a single user of
> get_nid_for_pfn(). Let's just inline that code and get rid of
> get_nid_for_pfn().
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I am not really sure this is an improvement. The code is ugly as hell
and open coding it just makes register_mem_sect_under_node harder to
read.

If anything get_nid_for_pfn deserves a comment why
CONFIG_DEFERRED_STRUCT_PAGE_INIT calls for special case as
early_pfn_to_nid is not bound to that config (it is defined when
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID || CONFIG_HAVE_MEMBLOCK_NODE_MAP

> ---
>  drivers/base/node.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 98a31bafc8a2..735073fd2926 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -744,17 +744,6 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> -static int __ref get_nid_for_pfn(unsigned long pfn)
> -{
> -	if (!pfn_valid_within(pfn))
> -		return -1;
> -#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> -	if (system_state < SYSTEM_RUNNING)
> -		return early_pfn_to_nid(pfn);
> -#endif
> -	return pfn_to_nid(pfn);
> -}
> -
>  /* register memory section under specified node if it spans that node */
>  static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  					 void *arg)
> @@ -766,8 +755,6 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  	unsigned long pfn;
>  
>  	for (pfn = start_pfn; pfn <= end_pfn; pfn++) {
> -		int page_nid;
> -
>  		/*
>  		 * memory block could have several absent sections from start.
>  		 * skip pfn range from absent section
> @@ -784,11 +771,15 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  		 * block belong to the same node.
>  		 */
>  		if (system_state == SYSTEM_BOOTING) {
> -			page_nid = get_nid_for_pfn(pfn);
> -			if (page_nid < 0)
> +			if (!pfn_valid_within(pfn))
>  				continue;
> -			if (page_nid != nid)
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +			if (early_pfn_to_nid(pfn) != nid)
>  				continue;
> +#else
> +			if (pfn_to_nid(pfn) != nid)
> +				continue;
> +#endif
>  		}
>  
>  		/*
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
