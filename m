Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4EEC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790CA216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfGVNhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:37:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:11372 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfGVNhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:37:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 06:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; 
   d="scan'208";a="180401015"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2019 06:37:27 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpYVI-0004UC-Qf; Mon, 22 Jul 2019 16:37:24 +0300
Date:   Mon, 22 Jul 2019 16:37:24 +0300
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
        linux-kernel@vger.kernel.org, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 5/7] lib: rework bitmap_parse()
Message-ID: <20190722133724.GV9224@smile.fi.intel.com>
References: <20190721212753.3287-1-yury.norov@gmail.com>
 <20190721212753.3287-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721212753.3287-6-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 02:27:51PM -0700, Yury Norov wrote:
> From Yury Norov <ynorov@marvell.com>
> 
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

> Signed-off-by: Yury Norov <ynorov@marvell.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

I'm not sure this is good to have two SoB tags for one person.

> +	if (hex_to_bin(*end) < 0)

Isn't it simple isxdigit() check?

> +		return ERR_PTR(-EINVAL);
> +

> +	for (i = 0; i < 32; i += 4) {
> +		c = hex_to_bin(*end--);
> +		if (c < 0)
> +			return ERR_PTR(-EINVAL);
> +
> +		ret |= c << i;

Dunno if it's for this series, but perhaps we would like to have something like

	/* Convert hex representation of u32 value to binary format */
	static inline int hex2bin32(const char *buf, u32 *result)
	{
		u8 value[4];
		int ret;

		ret = hex2bin(value, buf, sizeof(u32));
		if (ret)
			return ret;

		*result = get_unaligned((u32 *)value);
		// I guess it's aligned and thus can be done with:
		//   *result = be32_to_cpup((__force __be32 *)value);
		// just don't like enforcing bitwise types
		return 0;
	}

// also can be your variant with for-loop.

At least here for now and then can be moved to the kernel.h / hexdump.c.

> +
> +		if (start > end || __end_of_region(*end))
> +			goto out;
> +	}
> +

> +	if (hex_to_bin(*end) >= 0)

Isn't it simple isxdigit() check?

> +		return ERR_PTR(-EOVERFLOW);

-- 
With Best Regards,
Andy Shevchenko


