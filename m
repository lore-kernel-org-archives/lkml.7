Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A6C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23392081C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BXpRmV+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEAXZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 19:25:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44596 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfEAXZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 19:25:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id s10so456698qtc.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AH9bebtrf3dfxBIvf5hyUAJKcC8A07SNFaz6GXtYOok=;
        b=BXpRmV+6OvhC688uYI7duSFxoIJaSy5qGca6z3Jg/huzWFwaDds/rsuOmCgs+X/2D6
         nBypKSCBxfF4R11Now1TSKhdmOMcrt3KkOdbhBH0StpDAk0pUqh67sdtSS9SmVYGhDUk
         /99rNYVp/l9SQQD1woxx4wplZpwQh7L398wBwiSgokkpiSyf3soHy/rfnupj45f8qETL
         3Zbbo4Qv4rbnpxEJ3d7hMOa96+c1exFDA5YIp3AA2vuT6pZa8bi7DOkFM2mh3N66ok6F
         IOCT3T8WXbGp8+s6DBvFxEJp6jdS5SHiiuzhxHnHHGQ0ViVh7R+puVcqX8lGPsNsV6j6
         gf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AH9bebtrf3dfxBIvf5hyUAJKcC8A07SNFaz6GXtYOok=;
        b=raUU5tQ8p5k16TDzmUUSOHhrKWuFoE49/34qkcGB1waIt3YzBgox9MrX5ND6kbFDOT
         RkumGBft+ekvstzs7F2AxxRaynckY0aM3YS1QlxTTSwflP9mE/gtfEqnpfa2USrusvVD
         V48h51aRmFDHHBPjSiASkavHzRzroBdazlIVafOMmN7Ooa7QqXTg8TLKitfUBDFVNCbc
         9VptpXVtgSDL9+yXD1N/a2avWHuYFn7Bs5Fn+iwNiPH4bLf72vGE5rvwfGLSI7ZgKRCL
         1865Ri3KiPzzI18N4XK+OMYmekNHdLw+LZw63Q1yNOeqeWfq9Rh7oHAW7tPzoXA4yhOQ
         k0gw==
X-Gm-Message-State: APjAAAUcR20xMuV6OPVZm0S4/Eczv6I5txx2IbO0UFDGR5uceoWRXKY4
        M1o2hVzQSzUnzB7lvFY++cF3RQ==
X-Google-Smtp-Source: APXvYqz0BDqKG+Q2jzUmKI5xzLPAvNPYQjFLDLv988MLkpQr6Ryuk0h2Lnb2Pj89t7Bct/URoLhIMw==
X-Received: by 2002:ac8:27aa:: with SMTP id w39mr658332qtw.227.1556753119438;
        Wed, 01 May 2019 16:25:19 -0700 (PDT)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id 62sm13373216qtf.89.2019.05.01.16.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 16:25:18 -0700 (PDT)
Date:   Wed, 1 May 2019 23:25:17 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        david@redhat.com
Subject: Re: [PATCH v6 01/12] mm/sparsemem: Introduce struct mem_section_usage
Message-ID: <20190501232517.crbmgcuk7u4gvujr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-17 11:39:00, Dan Williams wrote:
> Towards enabling memory hotplug to track partial population of a
> section, introduce 'struct mem_section_usage'.
> 
> A pointer to a 'struct mem_section_usage' instance replaces the existing
> pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> house a new 'map_active' bitmap.  The new bitmap enables the memory
> hot{plug,remove} implementation to act on incremental sub-divisions of a
> section.
> 
> The primary motivation for this functionality is to support platforms
> that mix "System RAM" and "Persistent Memory" within a single section,
> or multiple PMEM ranges with different mapping lifetimes within a single
> section. The section restriction for hotplug has caused an ongoing saga
> of hacks and bugs for devm_memremap_pages() users.
> 
> Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> from a section, and updates to usemap allocation path, there are no
> expected behavior changes.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h |   23 ++++++++++++--
>  mm/memory_hotplug.c    |   18 ++++++-----
>  mm/page_alloc.c        |    2 +
>  mm/sparse.c            |   81 ++++++++++++++++++++++++------------------------
>  4 files changed, 71 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 70394cabaf4e..f0bbd85dc19a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1160,6 +1160,19 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
>  #define SECTION_ALIGN_UP(pfn)	(((pfn) + PAGES_PER_SECTION - 1) & PAGE_SECTION_MASK)
>  #define SECTION_ALIGN_DOWN(pfn)	((pfn) & PAGE_SECTION_MASK)
>  
> +#define SECTION_ACTIVE_SIZE ((1UL << SECTION_SIZE_BITS) / BITS_PER_LONG)
> +#define SECTION_ACTIVE_MASK (~(SECTION_ACTIVE_SIZE - 1))
> +
> +struct mem_section_usage {
> +	/*
> +	 * SECTION_ACTIVE_SIZE portions of the section that are populated in
> +	 * the memmap
> +	 */
> +	unsigned long map_active;

I think this should be proportional to section_size / subsection_size.
For example, on intel section size = 128M, and subsection is 2M, so
64bits work nicely. But, on arm64 section size if 1G, so subsection is
16M.

On the other hand 16M is already much better than what we have: with 1G
section size and 2M pmem alignment we guaranteed to loose 1022M. And
with 16M subsection it is only 14M.
