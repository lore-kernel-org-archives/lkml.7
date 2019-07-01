Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ADFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0917A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561967779;
	bh=B4TUnaGWg8VUcduUA3qEJifzurj0GdDrPtgXHngOP9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=De4QbgqGJf3yTPuYzuQfwwmXJ/iPzJo/WexRUzShDIeGXz0uICm3qQvSR2GACyDZo
	 2BVyJWMSj6I4uG5IrwvhHcV2WpmYgQVbLZkTEbzBblhNmh/RizBKDAYvg+A3AMkaje
	 oDVgHkjVi0wgzFEqoReIzVaSd1iVx5SMv4LKpnXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfGAH4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:56:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfGAH4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:56:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AD85AEBD;
        Mon,  1 Jul 2019 07:56:15 +0000 (UTC)
Date:   Mon, 1 Jul 2019 09:56:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 05/11] drivers/base/memory: Pass a block_id to
 init_memory_block()
Message-ID: <20190701075615.GE6376@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-6-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-05-19 13:11:46, David Hildenbrand wrote:
> We'll rework hotplug_memory_register() shortly, so it no longer consumes
> pass a section.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/base/memory.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f180427e48f4..f914fa6fe350 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -651,21 +651,18 @@ int register_memory(struct memory_block *memory)
>  	return ret;
>  }
>  
> -static int init_memory_block(struct memory_block **memory,
> -			     struct mem_section *section, unsigned long state)
> +static int init_memory_block(struct memory_block **memory, int block_id,
> +			     unsigned long state)
>  {
>  	struct memory_block *mem;
>  	unsigned long start_pfn;
> -	int scn_nr;
>  	int ret = 0;
>  
>  	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>  	if (!mem)
>  		return -ENOMEM;
>  
> -	scn_nr = __section_nr(section);
> -	mem->start_section_nr =
> -			base_memory_block_id(scn_nr) * sections_per_block;
> +	mem->start_section_nr = block_id * sections_per_block;
>  	mem->end_section_nr = mem->start_section_nr + sections_per_block - 1;
>  	mem->state = state;
>  	start_pfn = section_nr_to_pfn(mem->start_section_nr);
> @@ -694,7 +691,8 @@ static int add_memory_block(int base_section_nr)
>  
>  	if (section_count == 0)
>  		return 0;
> -	ret = init_memory_block(&mem, __nr_to_section(section_nr), MEM_ONLINE);
> +	ret = init_memory_block(&mem, base_memory_block_id(base_section_nr),
> +				MEM_ONLINE);
>  	if (ret)
>  		return ret;
>  	mem->section_count = section_count;
> @@ -707,6 +705,7 @@ static int add_memory_block(int base_section_nr)
>   */
>  int hotplug_memory_register(int nid, struct mem_section *section)
>  {
> +	int block_id = base_memory_block_id(__section_nr(section));
>  	int ret = 0;
>  	struct memory_block *mem;
>  
> @@ -717,7 +716,7 @@ int hotplug_memory_register(int nid, struct mem_section *section)
>  		mem->section_count++;
>  		put_device(&mem->dev);
>  	} else {
> -		ret = init_memory_block(&mem, section, MEM_OFFLINE);
> +		ret = init_memory_block(&mem, block_id, MEM_OFFLINE);
>  		if (ret)
>  			goto out;
>  		mem->section_count++;
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
