Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B59FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CA12077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoOm9beX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfJFT6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:58:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37429 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJFT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:58:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so10707259qkd.4;
        Sun, 06 Oct 2019 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=APg736jg0ah1Nn8uMNYIJkW2DcUQUmQs6qDMcBNTRSY=;
        b=FoOm9beXdYeuD1c+g8rePWP5H+HcWgPE076sSAqfiTel4Q0Td54IlBGRZMjKxlUk8L
         HVRy25IZMnNbc8SWFbKQpgGlvGFGDOWhUN+AgLYL92MXWhih+qj8A2fL3VALNocwTpqP
         FQgKEQ9d+gNs/CWsBfMg2M9N1HgEO7l4VgKTRdNRP7srbptNIvK1yLiq9PQFzN97hwJD
         PQqjTJBI9iBcbCgHfkAQivSS8ZhZGWhp7euCX2oVGNcFVVabiEBZ2YQtPZM3E2PwhQNC
         l3CHuJVy6xsLzc6ZK3Xl6/ZmPZbZyzn+7BrsOpcQQthNYmztIX5TH3rU39i5J11LksM6
         OUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=APg736jg0ah1Nn8uMNYIJkW2DcUQUmQs6qDMcBNTRSY=;
        b=okdBIucCcJq8hEe6ADkQZXBX7p9Hbd4wqwP/nRduW+4154hfX7FgJ3gkIPx8mvBucG
         r4qSmZoZZU0GSnVJjA5ilX+y2blXzoGwOUBIwKggqaR7ai6xRthftHBQ7sptT18E42/X
         yfRvXMu05SL/seokK7tj3CtnK1SrEyJfBvMDYmGbbsgTJgzaD46kUvXcNMIC70F2E5XQ
         yMgiw1ZOBbOU7CM6VKm2x4F4FV3Gkf5bwlzM5MGfGhcAMUyaq44mVueAfpBZedIRQ1Bf
         sizIG5McrrZmKITwCSQk93VNNJxvjcUZg59KiIQhnjzYa46ug1siVjVQ/pYzMEzP0uvL
         RmoA==
X-Gm-Message-State: APjAAAVghAbrvb05qX6Drw5ulLRK+L6PBSU626fKxvw3yYuBUSJNeLSb
        Cl69gd/U219CzK23oG3TJ0U=
X-Google-Smtp-Source: APXvYqwd63qnLz5/ty0+jRrhUrnVAvecut6TehXBQWTOiWh9hSCC+3s41ChbAphbo9+h6ZSP8hjXUA==
X-Received: by 2002:a37:4e84:: with SMTP id c126mr19418006qkb.334.1570391921654;
        Sun, 06 Oct 2019 12:58:41 -0700 (PDT)
Received: from freebsd.route53-aws-cloud.de (ec2-3-95-91-234.compute-1.amazonaws.com. [3.95.91.234])
        by smtp.gmail.com with ESMTPSA id k2sm6645230qti.24.2019.10.06.12.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 12:58:41 -0700 (PDT)
Date:   Sun, 6 Oct 2019 21:58:39 +0200
From:   Damian Tometzki <damian.tometzki@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v6 01/10] mm/memunmap: Don't access uninitialized memmap
 in memunmap_pages()
Message-ID: <20191006195838.GA27160@freebsd.route53-aws-cloud.de>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006085646.5768-2-david@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

patch 05/10 is missing in the patch series. 


On Sun, 06. Oct 10:56, David Hildenbrand wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> 
> With an altmap, the memmap falling into the reserved altmap space are
> not initialized and, therefore, contain a garbage NID and a garbage
> zone. Make sure to read the NID/zone from a memmap that was initialzed.
> 
> This fixes a kernel crash that is observed when destroying a namespace:
> 
> [   81.356173] kernel BUG at include/linux/mm.h:1107!
> cpu 0x1: Vector: 700 (Program Check) at [c000000274087890]
>     pc: c0000000004b9728: memunmap_pages+0x238/0x340
>     lr: c0000000004b9724: memunmap_pages+0x234/0x340
> ...
>     pid   = 3669, comm = ndctl
> kernel BUG at include/linux/mm.h:1107!
> [c000000274087ba0] c0000000009e3500 devm_action_release+0x30/0x50
> [c000000274087bc0] c0000000009e4758 release_nodes+0x268/0x2d0
> [c000000274087c30] c0000000009dd144 device_release_driver_internal+0x174/0x240
> [c000000274087c70] c0000000009d9dfc unbind_store+0x13c/0x190
> [c000000274087cb0] c0000000009d8a24 drv_attr_store+0x44/0x60
> [c000000274087cd0] c0000000005a7470 sysfs_kf_write+0x70/0xa0
> [c000000274087d10] c0000000005a5cac kernfs_fop_write+0x1ac/0x290
> [c000000274087d60] c0000000004be45c __vfs_write+0x3c/0x70
> [c000000274087d80] c0000000004c26e4 vfs_write+0xe4/0x200
> [c000000274087dd0] c0000000004c2a6c ksys_write+0x7c/0x140
> [c000000274087e20] c00000000000bbd0 system_call+0x5c/0x68
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> [ minimze code changes, rephrase description ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memremap.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 557e53c6fb46..8c2fb44c3b4d 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -123,6 +123,7 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
>  void memunmap_pages(struct dev_pagemap *pgmap)
>  {
>  	struct resource *res = &pgmap->res;
> +	struct page *first_page;
>  	unsigned long pfn;
>  	int nid;
>  
> @@ -131,14 +132,16 @@ void memunmap_pages(struct dev_pagemap *pgmap)
>  		put_page(pfn_to_page(pfn));
>  	dev_pagemap_cleanup(pgmap);
>  
> +	/* make sure to access a memmap that was actually initialized */
> +	first_page = pfn_to_page(pfn_first(pgmap));
> +
>  	/* pages are dead and unused, undo the arch mapping */
> -	nid = page_to_nid(pfn_to_page(PHYS_PFN(res->start)));
> +	nid = page_to_nid(first_page);

Why we need 'nid = page_to_nid(first_page)' we didnt use it anymore in this function ?

>  
>  	mem_hotplug_begin();
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> -		pfn = PHYS_PFN(res->start);
> -		__remove_pages(page_zone(pfn_to_page(pfn)), pfn,
> -				 PHYS_PFN(resource_size(res)), NULL);
> +		__remove_pages(page_zone(first_page), PHYS_PFN(res->start),
> +			       PHYS_PFN(resource_size(res)), NULL);
>  	} else {
>  		arch_remove_memory(nid, res->start, resource_size(res),
>  				pgmap_altmap(pgmap));
> -- 
> 2.21.0
>
Best regards
Damian
 
