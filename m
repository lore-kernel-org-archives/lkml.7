Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4064C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01E82054F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfIIKGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:06:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:38333 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbfIIKGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:06:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 03:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="208918441"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2019 03:06:10 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i7GYi-0006Q9-Nv; Mon, 09 Sep 2019 13:06:08 +0300
Date:   Mon, 9 Sep 2019 13:06:08 +0300
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
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 5/7] lib: rework bitmap_parse()
Message-ID: <20190909100608.GR2680@smile.fi.intel.com>
References: <20190909033021.11600-1-yury.norov@gmail.com>
 <20190909033021.11600-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909033021.11600-6-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 08:30:19PM -0700, Yury Norov wrote:
> bitmap_parse() is ineffective and full of opaque variables and opencoded
> parts. It leads to hard understanding and usage of it. This rework
> includes:
>  - remove bitmap_shift_left() call from the cycle. Now it makes the
>    complexity of the algorithm as O(nbits^2). In the suggested approach
>    the input string is parsed in reverse direction, so no shifts needed;
>  - relax requirement on a single comma and no white spaces between chunks.
>    It is considered useful in scripting, and it aligns with
>    bitmap_parselist();
>  - split bitmap_parse() to small readable helpers;
>  - make an explicit calculation of the end of input line at the
>    beginning, so users of the bitmap_parse() won't bother doing this.

> +static const char *bitmap_get_x32_reverse(const char *start,
> +					const char *end, u32 *num)
> +{
> +	u32 ret = 0;
> +	int c, i;
> +

> +	if (!isxdigit(*end))
> +		return ERR_PTR(-EINVAL);

This seems redundant...

> +
> +	for (i = 0; i < 32; i += 4) {

> +		c = hex_to_bin(*end--);
> +		if (c < 0)
> +			return ERR_PTR(-EINVAL);

...because this will do the same check.

Am I right?

> +
> +		ret |= c << i;
> +
> +		if (start > end || __end_of_region(*end))
> +			goto out;
> +	}
> +

> +	if (isxdigit(*end))
> +		return ERR_PTR(-EOVERFLOW);

hex_to_bin() doesn't rely on ctype array, won't drain caches.
I guess it's not a fast path, so, either will work.

> +out:
> +	*num = ret;
> +	return end;
> +}

-- 
With Best Regards,
Andy Shevchenko


