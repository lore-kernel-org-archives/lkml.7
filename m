Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2382C00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24AE218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578214771;
	bh=CT4m01CpbW961uA/BU7pCA9q3wG8bPnj9nD2I6vLHfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iEy4mV69ihmzTralRVEHu7K1Z2qcTEjckQodaf0KQoUMN0q3wEg/5Uojxktgsgu86
	 sfGk/Pn5jtjCr814L4Y2lYxWDBbRRiAkEuAjGci6gjbZt45bseBVIoc5llpNb0f/YP
	 f2xg8iEC7FwNICJxC8SUJkamoK63uONLg74Qipmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgAEI7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 03:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEI7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 03:59:30 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDC3120866;
        Sun,  5 Jan 2020 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578214769;
        bh=CT4m01CpbW961uA/BU7pCA9q3wG8bPnj9nD2I6vLHfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XX3bwu1Lw7diO7JTeZYjwMe9ckJIosm9Gh6zZFXXwF/3Rc5CZpia2aKwEArwoXPTE
         WqvFxpk1yuMmTtLxPOOLiTaQkpDQHSsXEgTr+eFiQ5eJakrL7b5s7Z/rIRKIB2K3GT
         k42uSjXYWL91thxgfFTP0X70bF0phS7agNEbCZtQ=
Date:   Sun, 5 Jan 2020 10:59:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/memblock: Define memblock_physmem()
Message-ID: <20200105085921.GB7261@rapoport-lnx>
References: <1578040866-3844-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578040866-3844-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Fri, Jan 03, 2020 at 02:11:06PM +0530, Anshuman Khandual wrote:
> On s390 platform memblock.physmem array is being built by directly calling
> into memblock_add_range() which is a low level function not intended to be
> used outside of memblock. Hence lets conditionally add helper functions for
> physmem array when HAVE_MEMBLOCK_PHYS_MAP is enabled. Also use MAX_NUMNODES
> instead of 0 as node ID similar to memblock_add() and memblock_reserve().
> While here replace some function name strings with (%s __func__) in various
> memblock_dbg() call sites.
 
I'd prefer to have memblock_dbg() updates as a separate patch.

> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Collin Walling <walling@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Only build tested for s390, will appreciate if some one can give it a try
> on a real system.
> 
>  arch/s390/kernel/setup.c | 14 ++++----------
>  include/linux/memblock.h |  3 +++
>  mm/memblock.c            | 20 ++++++++++++++++----
>  3 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 9cbf490fd162..79a7b1872e5a 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -761,14 +761,6 @@ static void __init free_mem_detect_info(void)
>  		memblock_free(start, size);
>  }
>  
> -static void __init memblock_physmem_add(phys_addr_t start, phys_addr_t size)
> -{
> -	memblock_dbg("memblock_physmem_add: [%#016llx-%#016llx]\n",
> -		     start, start + size - 1);
> -	memblock_add_range(&memblock.memory, start, size, 0, 0);
> -	memblock_add_range(&memblock.physmem, start, size, 0, 0);
> -}
> -
>  static const char * __init get_mem_info_source(void)
>  {
>  	switch (mem_detect.info_source) {
> @@ -793,8 +785,10 @@ static void __init memblock_add_mem_detect_info(void)
>  		     get_mem_info_source(), mem_detect.info_source);
>  	/* keep memblock lists close to the kernel */
>  	memblock_set_bottom_up(true);
> -	for_each_mem_detect_block(i, &start, &end)
> -		memblock_physmem_add(start, end - start);
> +	for_each_mem_detect_block(i, &start, &end) {
> +		memblock_add(start, end - start);
> +		memblock_physmem(start, end - start);

Maybe memblock_physmem_add()?

And, since memblock_add_range() will actually become private, cab you
please make it static?

> +	}
>  	memblock_set_bottom_up(false);
>  	memblock_dump_all();
>  }
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 1510b12de031..d17e7b841cb6 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -115,6 +115,9 @@ int memblock_add(phys_addr_t base, phys_addr_t size);
>  int memblock_remove(phys_addr_t base, phys_addr_t size);
>  int memblock_free(phys_addr_t base, phys_addr_t size);
>  int memblock_reserve(phys_addr_t base, phys_addr_t size);
> +#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> +int memblock_physmem(phys_addr_t base, phys_addr_t size);
> +#endif
>  void memblock_trim_memory(phys_addr_t align);
>  bool memblock_overlaps_region(struct memblock_type *type,
>  			      phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3e20c6ba2101..f6d17a1f30e3 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -694,7 +694,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
>  {
>  	phys_addr_t end = base + size - 1;
>  
> -	memblock_dbg("memblock_add: [%pa-%pa] %pS\n",
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
>  	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
> @@ -795,7 +795,7 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
>  {
>  	phys_addr_t end = base + size - 1;
>  
> -	memblock_dbg("memblock_remove: [%pa-%pa] %pS\n",
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
>  	return memblock_remove_range(&memblock.memory, base, size);
> @@ -813,7 +813,7 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
>  {
>  	phys_addr_t end = base + size - 1;
>  
> -	memblock_dbg("   memblock_free: [%pa-%pa] %pS\n",
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
>  	kmemleak_free_part_phys(base, size);
> @@ -824,12 +824,24 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
>  {
>  	phys_addr_t end = base + size - 1;
>  
> -	memblock_dbg("memblock_reserve: [%pa-%pa] %pS\n",
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
>  	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
>  }
>  
> +#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> +int __init_memblock memblock_physmem(phys_addr_t base, phys_addr_t size)
> +{
> +	phys_addr_t end = base + size - 1;
> +
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> +		     &base, &end, (void *)_RET_IP_);
> +
> +	return memblock_add_range(&memblock.physmem, base, size, MAX_NUMNODES, 0);
> +}
> +#endif
> +
>  /**
>   * memblock_setclr_flag - set or clear flag for a memory region
>   * @base: base address of the region
> -- 
> 2.20.1
> 
> 

-- 
Sincerely yours,
Mike.
