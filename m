Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABC5C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24592089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405276AbfFKKPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:15:47 -0400
Received: from foss.arm.com ([217.140.110.172]:57630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404521AbfFKKPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:15:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6714B337;
        Tue, 11 Jun 2019 03:15:46 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8DCD3F557;
        Tue, 11 Jun 2019 03:17:27 -0700 (PDT)
Subject: Re: [PATCH 02/17] mm: stub out all of swapops.h for !CONFIG_MMU
To:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190610221621.10938-1-hch@lst.de>
 <20190610221621.10938-3-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <516c8def-22db-027c-873d-a943454e33af@arm.com>
Date:   Tue, 11 Jun 2019 11:15:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610221621.10938-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 11:16 PM, Christoph Hellwig wrote:
> The whole header file deals with swap entries and PTEs, none of which
> can exist for nommu builds.

Although I agree with the patch, I'm wondering how you get into it?

Cheers
Vladimir

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/swapops.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 4d961668e5fc..b02922556846 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -6,6 +6,8 @@
>  #include <linux/bug.h>
>  #include <linux/mm_types.h>
>  
> +#ifdef CONFIG_MMU
> +
>  /*
>   * swapcache pages are stored in the swapper_space radix tree.  We want to
>   * get good packing density in that tree, so the index should be dense in
> @@ -50,13 +52,11 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
>  	return entry.val & SWP_OFFSET_MASK;
>  }
>  
> -#ifdef CONFIG_MMU
>  /* check whether a pte points to a swap entry */
>  static inline int is_swap_pte(pte_t pte)
>  {
>  	return !pte_none(pte) && !pte_present(pte);
>  }
> -#endif
>  
>  /*
>   * Convert the arch-dependent pte representation of a swp_entry_t into an
> @@ -375,4 +375,5 @@ static inline int non_swap_entry(swp_entry_t entry)
>  }
>  #endif
>  
> +#endif /* CONFIG_MMU */
>  #endif /* _LINUX_SWAPOPS_H */
> 

