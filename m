Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE2CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247E920578
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfJ3NjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:39:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfJ3NjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:39:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F56CB584;
        Wed, 30 Oct 2019 13:38:57 +0000 (UTC)
Date:   Wed, 30 Oct 2019 14:38:54 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        pasha.tatashin@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191030133850.GA16826@linux>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030131122.8256-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:11:22PM +0100, Vincent Whitchurch wrote:
> sparsemem without VMEMMAP has two allocation paths to allocate the
> memory needed for its memmap (done in sparse_mem_map_populate()).
> 
> In one allocation path (sparse_buffer_alloc() succeeds), the memory is
> not zeroed (since it was previously allocated with
> memblock_alloc_try_nid_raw()).
> 
> In the other allocation path (sparse_buffer_alloc() fails and
> sparse_mem_map_populate() falls back to memblock_alloc_try_nid()), the
> memory is zeroed.
> 
> AFAICS this difference does not appear to be on purpose.  If the code is
> supposed to work with non-initialized memory (__init_single_page() takes
> care of zeroing the struct pages which are actually used), we should
> consistently not zero the memory, to avoid masking bugs.
> 
> (I noticed this because on my ARM64 platform, with 1 GiB of memory the
>  first [and only] section is allocated from the zeroing path while with
>  2 GiB of memory the first 1 GiB section is allocated from the
>  non-zeroing path.)
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Good catch

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6891c1992b1..01e467adc219 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -458,7 +458,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
>  	if (map)
>  		return map;
>  
> -	map = memblock_alloc_try_nid(size,
> +	map = memblock_alloc_try_nid_raw(size,
>  					  PAGE_SIZE, addr,
>  					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>  	if (!map)
> -- 
> 2.20.0
> 

-- 
Oscar Salvador
SUSE L3
