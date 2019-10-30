Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AD8CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7F22087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572442203;
	bh=aFG6BGDDmjJyMn3ku+VuQqMfCYFPXnrqn881bsl/MYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qHYhbK/zZ5eoPg5r8IGH1Xi/P1h8kz5hpdZzzTyucIWGUFfZb/9QD7I7SLJNnMuix
	 7zXlgExE1vff+YaYhiW8o/M7ZcIm+MXWziImWlNn6NRipRu752jnbAAXjvny0xU8Fx
	 rcpcLFNaQx8S6AjpJ+9AEAbUB+kd1c7ITs52vViE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfJ3NaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:30:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbfJ3NaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:30:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E72FB351;
        Wed, 30 Oct 2019 13:29:59 +0000 (UTC)
Date:   Wed, 30 Oct 2019 14:29:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        pasha.tatashin@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191030132958.GD31513@dhcp22.suse.cz>
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

On Wed 30-10-19 14:11:22, Vincent Whitchurch wrote:
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

You are right that this is not intentional.

> (I noticed this because on my ARM64 platform, with 1 GiB of memory the
>  first [and only] section is allocated from the zeroing path while with
>  2 GiB of memory the first 1 GiB section is allocated from the
>  non-zeroing path.)

Do I get it right that sparse_buffer_init couldn't allocate memmap for
the full node for some reason and so sparse_init_nid would have to
allocate one for each memory section?

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Anyway the patch is OK. Even though this is not a bug strictly speaking
it is certainly a suboptimal behavior because zeroying takes time so
I would flag this for a stable tree 4.19+. There is no clear Fixes tag
to apply (35fd1eb1e8212 would get closest I guess).

Acked-by: Michal Hocko <mhocko@suse.com>

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

-- 
Michal Hocko
SUSE Labs
