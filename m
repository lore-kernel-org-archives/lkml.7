Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09809C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4AE21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfCVSWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:22:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:1681 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfCVSWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:22:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 11:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="331109085"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2019 11:22:45 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h7OoW-0005Wr-F7; Fri, 22 Mar 2019 20:22:44 +0200
Date:   Fri, 22 Mar 2019 20:22:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 01/10] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190322182244.GZ9224@smile.fi.intel.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <0e4d352418252d480dfc7d529604819f8ff88d9c.1552566113.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e4d352418252d480dfc7d529604819f8ff88d9c.1552566113.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 09:30:02PM +0900, William Breathitt Gray wrote:
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.

> +void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
> +		       const unsigned long value, const unsigned int start)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned int offset = start % BITS_PER_LONG;
> +	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
> +				       BITS_PER_LONG - offset : 8;

> +	const unsigned long low_mask = GENMASK(offset + low_width - 1, offset);

I think

	unsigned long low_mask = GENMASK(low_width - 1, 0) << offset;

will generate better code.

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

-- 
With Best Regards,
Andy Shevchenko


