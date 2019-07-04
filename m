Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345AFC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 04:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D7E21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 04:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562214065;
	bh=mJqkzmc6c8N2fzdxWYE8k4OlBYCRBlYdCVqBqionRnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=17DGoDitS8xImHXG9wjU1kfEiAtJKlL9wTFYzl3FyGdE5dFkKZM9zuZklklHzTufT
	 FNQ782c/VscKBpMnGfic9WMqomkuS/faGZ1M4+GL1/bswrRtxZZQ9/yKA6nz8q6aWy
	 JW4CJS/0w3fWOqPdG1lcvMHxAQv095Vc32KMPusM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfGDEU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 00:20:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45112 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfGDEU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 00:20:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so6695100qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 21:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VjvgxdNhPmADUJRmfeTfTeGfFIsk8W3vAlS9rGS+5AM=;
        b=BnWc5xtMEJsnDCepWNyb5rcilvYtilHQ0QXIGZK9YkG/Pg9Y8eseLWULMKFz3VXCP9
         cVlZqVBI5XO4GtgimaItxTYUR1dOoJCb8cQuG6KUoF1Su6+F5eKeq0lN1eMslGMK9xPY
         3MqPpJrCdwR9MmUG6UsFlHWS75zrbatjkKoOgfQUtOv4P6JIn+6h451LqtFDEmd56nqY
         lBlciWn0EV/aSSQAikypVJs4i+sl4yWWz7xW3G27KSqVODQrLZ56nrKwGtEYYf+xuVWs
         Q1XS5SYKybuYBkJcagE53Z3YLVRNujRpsQTvPqK1fGFLYXMZsbECiciahprDxlA2bIe3
         cknA==
X-Gm-Message-State: APjAAAWFADFK0R324Dt0h9B4YITLcLIGb+OjEsrRT+eWvEh4bmWdU4SC
        bzLf9+np4RdKJ8pL50xDAHs=
X-Google-Smtp-Source: APXvYqzMRVfvHpkLgMAQyujeyq9jczN9KYoJEegLcswXWtcHBnEzNE2ycM0Njt2NLU3cr/g3HsJOfA==
X-Received: by 2002:aed:3ed5:: with SMTP id o21mr33852578qtf.369.1562214057070;
        Wed, 03 Jul 2019 21:20:57 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::d156])
        by smtp.gmail.com with ESMTPSA id i1sm1911451qtb.7.2019.07.03.21.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 21:20:55 -0700 (PDT)
Date:   Thu, 4 Jul 2019 00:20:53 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] percpu: Make pcpu_setup_first_chunk() void function
Message-ID: <20190704042053.GA29349@dennisz-mbp.dhcp.thefacebook.com>
References: <20190703082552.69951-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703082552.69951-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 04:25:52PM +0800, Kefeng Wang wrote:
> pcpu_setup_first_chunk() will panic or BUG_ON if the are some
> error and doesn't return any error, hence it can be defined to
> return void.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/ia64/mm/contig.c    |  5 +----
>  arch/ia64/mm/discontig.c |  5 +----
>  include/linux/percpu.h   |  2 +-
>  mm/percpu.c              | 17 ++++++-----------
>  4 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
> index d29fb6b9fa33..db09a693f094 100644
> --- a/arch/ia64/mm/contig.c
> +++ b/arch/ia64/mm/contig.c
> @@ -134,10 +134,7 @@ setup_per_cpu_areas(void)
>  	ai->atom_size		= page_size;
>  	ai->alloc_size		= percpu_page_size;
>  
> -	rc = pcpu_setup_first_chunk(ai, __per_cpu_start + __per_cpu_offset[0]);
> -	if (rc)
> -		panic("failed to setup percpu area (err=%d)", rc);
> -
> +	pcpu_setup_first_chunk(ai, __per_cpu_start + __per_cpu_offset[0]);
>  	pcpu_free_alloc_info(ai);
>  }
>  #else
> diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> index 05490dd073e6..004dee231874 100644
> --- a/arch/ia64/mm/discontig.c
> +++ b/arch/ia64/mm/discontig.c
> @@ -245,10 +245,7 @@ void __init setup_per_cpu_areas(void)
>  		gi->cpu_map		= &cpu_map[unit];
>  	}
>  
> -	rc = pcpu_setup_first_chunk(ai, base);
> -	if (rc)
> -		panic("failed to setup percpu area (err=%d)", rc);
> -
> +	pcpu_setup_first_chunk(ai, base);
>  	pcpu_free_alloc_info(ai);
>  }
>  #endif
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 9909dc0e273a..5e76af742c80 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -105,7 +105,7 @@ extern struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
>  							     int nr_units);
>  extern void __init pcpu_free_alloc_info(struct pcpu_alloc_info *ai);
>  
> -extern int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> +extern void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  					 void *base_addr);
>  
>  #ifdef config_need_per_cpu_embed_first_chunk
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 9821241fdede..ad32c3d11ca7 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2267,12 +2267,9 @@ static void pcpu_dump_alloc_info(const char *lvl,
>   * share the same vm, but use offset regions in the area allocation map.
>   * the chunk serving the dynamic region is circulated in the chunk slots
>   * and available for dynamic allocation like any other chunk.
> - *
> - * returns:
> - * 0 on success, -errno on failure.
>   */
> -int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> -				  void *base_addr)
> +void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> +				   void *base_addr)
>  {
>  	size_t size_sum = ai->static_size + ai->reserved_size + ai->dyn_size;
>  	size_t static_size, dyn_size;
> @@ -2457,7 +2454,6 @@ int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  
>  	/* we're done */
>  	pcpu_base_addr = base_addr;
> -	return 0;
>  }
>  
>  #ifdef config_smp
> @@ -2710,7 +2706,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
>  	struct pcpu_alloc_info *ai;
>  	size_t size_sum, areas_size;
>  	unsigned long max_distance;
> -	int group, i, highest_group, rc;
> +	int group, i, highest_group, rc = 0;
>  
>  	ai = pcpu_build_alloc_info(reserved_size, dyn_size, atom_size,
>  				   cpu_distance_fn);
> @@ -2795,7 +2791,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
>  		pfn_down(size_sum), ai->static_size, ai->reserved_size,
>  		ai->dyn_size, ai->unit_size);
>  
> -	rc = pcpu_setup_first_chunk(ai, base);
> +	pcpu_setup_first_chunk(ai, base);
>  	goto out_free;
>  
>  out_free_areas:
> @@ -2920,7 +2916,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
>  		unit_pages, psize_str, ai->static_size,
>  		ai->reserved_size, ai->dyn_size);
>  
> -	rc = pcpu_setup_first_chunk(ai, vm.addr);
> +	pcpu_setup_first_chunk(ai, vm.addr);
>  	goto out_free_ar;
>  
>  enomem:
> @@ -3014,8 +3010,7 @@ void __init setup_per_cpu_areas(void)
>  	ai->groups[0].nr_units = 1;
>  	ai->groups[0].cpu_map[0] = 0;
>  
> -	if (pcpu_setup_first_chunk(ai, fc) < 0)
> -		panic("failed to initialize percpu areas.");
> +	pcpu_setup_first_chunk(ai, fc);
>  	pcpu_free_alloc_info(ai);
>  }
>  
> -- 
> 2.20.1
> 

Hi Kefeng,

This makes sense to me. I've applied this to for-5.4.

Thanks,
Dennis
