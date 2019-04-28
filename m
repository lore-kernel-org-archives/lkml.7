Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC5FC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633B820693
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfD1Q5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 12:57:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:30306 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfD1Q5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 12:57:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 09:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,406,1549958400"; 
   d="scan'208";a="319749754"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2019 09:57:48 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hKn7Z-0006IZ-N6; Sun, 28 Apr 2019 19:57:45 +0300
Date:   Sun, 28 Apr 2019 19:57:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 4/6] lib: rework bitmap_parse()
Message-ID: <20190428165745.GX9224@smile.fi.intel.com>
References: <20190428032936.1317-1-ynorov@marvell.com>
 <20190428032936.1317-5-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428032936.1317-5-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 08:29:34PM -0700, Yury Norov wrote:
> bitmap_parse() is ineffective and full of opaque variables and opencoded
> parts. It leads to hard understanding of it. This rework includes:
>  - remove bitmap_shift_left() call from the cycle. Now it makes the
>    complexity of the algorithm as O(nbits^2). In the suggested approach
>    the input string is parsed in reverse direction, so no shifts needed;
>  - relax requirement on a single comma and no white spaces between chunks.
>    It is considered useful in scripting, and it aligns with
>    bitmap_parselist();
>  - split bitmap_parse() to small readable helpers;
>  - make an explicit calculation of the end of input line at the
>    beginning, so users of the bitmap_parse() won't bother doing this.

> +static inline bool in_str(const char *start, const char *ptr)
> +{
> +	return start <= ptr;
> +}
> +

I don't see how it's better than explicit use. Moreover, explicit use shows the
exact condition in-line. Even by used characters it's longer.

> +static const char *bitmap_get_hex32_rev(const char *start,
> +					const char *end, u32 *num)

In kernel few functions to work with hex u32 named foo_x32(). I would rather
use that. Besides, we spell "reverse" in full.

> +{
> +	u32 ret = 0;
> +	int c, i;
> +
> +	if (hex_to_bin(*end) < 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	for (i = 0; i < 32; i += 4) {
> +		c = hex_to_bin(*end--);
> +		if (c < 0)

Perhaps we may need similar patch for hex_to_bin() as in the commit
9888a588ea96 ("lib/hexdump.c: return -EINVAL in case of error in hex2bin()")

> +			return ERR_PTR(-EINVAL);

> +
> +		ret |= c << i;
> +
> +		if (!in_str(start, end) || __end_of_region(*end))
> +			goto out;
> +	}
> +
> +	if (hex_to_bin(*end) >= 0)
> +		return ERR_PTR(-EOVERFLOW);
> +out:
> +	*num = ret;
> +	return end;
> +}

-- 
With Best Regards,
Andy Shevchenko


