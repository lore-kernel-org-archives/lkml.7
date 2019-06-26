Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA6BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E3C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561530273;
	bh=fRBJvTZcKtFeRMn+qbJ8uLU1XusvmsSzwy8Nz6fD0Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qwvsFuyGr5sUhdl5j72eYopQ8OED6N0J2uJeCFXC27fr5apRC9oQzSRB6eqCR5Zi2
	 yoshonrXR4VKiaQaWvEB8hH1wUF50V2EkxD17vwJPnn636p7z4mMrlc3KXTfH0/8cA
	 PXR9chkCjSK7nH61NhvKjHPLiswthgLdf2dpEaFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfFZGYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:24:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZGYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:24:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 011A7AD47;
        Wed, 26 Jun 2019 06:24:31 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:24:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm: Don't manually decrement num_poisoned_pages
Message-ID: <20190626062428.GH17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-4-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626061124.16013-4-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-06-19 16:11:23, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Use the function written to do it instead.

I am not sure a single line helper is a great win but this makes the
code consistent at least.

> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/sparse.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 1ec32aef5590..d9b3625bfdf0 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -11,6 +11,8 @@
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>  
>  #include "internal.h"
>  #include <asm/dma.h>
> @@ -772,7 +774,7 @@ static void clear_hwpoisoned_pages(struct page *memmap,
>  
>  	for (i = start; i < start + count; i++) {
>  		if (PageHWPoison(&memmap[i])) {
> -			atomic_long_sub(1, &num_poisoned_pages);
> +			num_poisoned_pages_dec();
>  			ClearPageHWPoison(&memmap[i]);
>  		}
>  	}
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
