Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EAFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E39D20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfEHIql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:46:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:36811 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEHIql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:46:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 01:46:41 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2019 01:46:34 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hOIDg-0006Uw-NY; Wed, 08 May 2019 11:46:32 +0300
Date:   Wed, 8 May 2019 11:46:32 +0300
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
Message-ID: <20190508084632.GY9224@smile.fi.intel.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
 <20190501010636.30595-6-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501010636.30595-6-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:06:34PM -0700, Yury Norov wrote:
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

> +static inline bool in_str(const char *start, const char *ptr)
> +{
> +	return start <= ptr;
> +}
> +

The explicit use of the conditional is better.

-- 
With Best Regards,
Andy Shevchenko


