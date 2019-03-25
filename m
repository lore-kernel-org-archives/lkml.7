Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819EC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfCYNMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:12:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:59834 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCYNMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:12:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 06:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="129981054"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2019 06:12:38 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8PP2-0005vP-9E; Mon, 25 Mar 2019 15:12:36 +0200
Date:   Mon, 25 Mar 2019 15:12:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190325131236.GW9224@smile.fi.intel.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.


This seems to miss Randy's (IIRC) comment about too many const specifiers.

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  include/asm-generic/bitops/find.h | 14 ++++++
>  include/linux/bitops.h            |  5 ++
>  lib/find_bit.c                    | 81 +++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+)
> 
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 8a1ee10014de..9a76adff59c6 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -80,4 +80,18 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
>  
>  #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
>  
> +unsigned long bitmap_get_value8(const unsigned long *const bitmap,
> +				const unsigned int size,
> +				const unsigned int start);
> +
> +void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
> +		       const unsigned long value, const unsigned int start);
> +
> +unsigned int find_next_clump8(unsigned long *const clump,
> +			      const unsigned long *const addr,
> +			      unsigned int offset, const unsigned int size);
> +
> +#define find_first_clump8(clump, bits, size) \
> +	find_next_clump8((clump), (bits), 0, (size))
> +
>  #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 602af23b98c7..f19a7bc8f559 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
>  	     (bit) < (size);					\
>  	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
>  
> +#define for_each_set_clump8(start, clump, bits, size) \
> +	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> +	     (start) < (size); \
> +	     (start) = find_next_clump8(&(clump), (bits), (start) + 8, (size)))
> +
>  static inline int get_bitmask_order(unsigned int count)
>  {
>  	int order;
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index ee3df93ba69a..1b6f8a6f1957 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -218,3 +218,84 @@ EXPORT_SYMBOL(find_next_bit_le);
>  #endif
>  
>  #endif /* __BIG_ENDIAN */
> +
> +/**
> + * bitmap_get_value8 - get an 8-bit value within a memory region
> + * @bitmap: address to the bitmap memory region
> + * @size: bitmap size in number of bits
> + * @start: bit offset of the 8-bit value
> + *
> + * Returns the 8-bit value located at the @start bit offset within the @bitmap
> + * memory region.
> + */
> +unsigned long bitmap_get_value8(const unsigned long *const bitmap,
> +				const unsigned int size,
> +				const unsigned int start)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned int offset = start % BITS_PER_LONG;
> +	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
> +				       BITS_PER_LONG - offset : 8;
> +	const unsigned long low = bitmap[index] >> offset;
> +	const unsigned long high = (low_width < 8 && start + 8 <= size) ?
> +				   bitmap[index + 1] << low_width : 0;
> +
> +	return (low | high) & 0xFF;
> +}
> +EXPORT_SYMBOL(bitmap_get_value8);
> +
> +/**
> + * bitmap_set_value8 - set an 8-bit value within a memory region
> + * @bitmap: address to the bitmap memory region
> + * @size: bitmap size in number of bits
> + * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> + * @start: bit offset of the 8-bit value
> + */
> +void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
> +		       const unsigned long value, const unsigned int start)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned int offset = start % BITS_PER_LONG;
> +	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
> +				       BITS_PER_LONG - offset : 8;
> +	const unsigned long low_mask = GENMASK(low_width - 1, 0) << offset;
> +	const unsigned int high_width = 8 - low_width;
> +	const unsigned long high_mask = GENMASK(high_width - 1, 0);
> +
> +	/* set lower portion */
> +	bitmap[index] &= ~low_mask;
> +	bitmap[index] |= value << offset;
> +
> +	/* set higher portion if space available in bitmap */
> +	if (high_width && start + 8 <= size) {
> +		bitmap[index + 1] &= ~high_mask;
> +		bitmap[index + 1] |= value >> low_width;
> +	}
> +}
> +EXPORT_SYMBOL(bitmap_set_value8);
> +
> +/**
> + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> + * @clump: location to store copy of found clump
> + * @addr: address to base the search on
> + * @offset: bit offset at which to start searching
> + * @size: bitmap size in number of bits
> + *
> + * Returns the bit offset for the next set clump; the found clump value is
> + * copied to the location pointed by @clump. If no bits are set, returns @size.
> + */
> +unsigned int find_next_clump8(unsigned long *const clump,
> +			      const unsigned long *const addr,
> +			      unsigned int offset, const unsigned int size)
> +{
> +	for (; offset < size; offset += 8) {
> +		*clump = bitmap_get_value8(addr, size, offset);
> +		if (!*clump)
> +			continue;
> +
> +		return offset;
> +	}
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(find_next_clump8);
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko


