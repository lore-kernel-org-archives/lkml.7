Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC013C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C553A21744
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfEHIrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:47:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:43550 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEHIrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:47:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 01:47:39 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2019 01:47:34 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hOIEe-0006Vm-SS; Wed, 08 May 2019 11:47:32 +0300
Date:   Wed, 8 May 2019 11:47:32 +0300
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
Subject: Re: [PATCH 4/7] lib: make bitmap_parse_user a wrapper on bitmap_parse
Message-ID: <20190508084732.GC9224@smile.fi.intel.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
 <20190501010636.30595-5-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501010636.30595-5-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:06:33PM -0700, Yury Norov wrote:
> Currently we parse user data byte after byte which leads to
> overcomplicating of parsing algorithm. There are no performance
> critical users of bitmap_parse_user(), and so we can duplicate
> user data to kernel buffer and simply call bitmap_parselist().
> This rework lets us unify and simplify bitmap_parse() and
> bitmap_parse_user(), which is done in the following patch.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  lib/bitmap.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index f235434df87b..300732031fad 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -434,22 +434,22 @@ EXPORT_SYMBOL(__bitmap_parse);
>   *    then it must be terminated with a \0.
>   * @maskp: pointer to bitmap array that will contain result.
>   * @nmaskbits: size of bitmap, in bits.
> - *
> - * Wrapper for __bitmap_parse(), providing it with user buffer.
> - *
> - * We cannot have this as an inline function in bitmap.h because it needs
> - * linux/uaccess.h to get the access_ok() declaration and this causes
> - * cyclic dependencies.
>   */
>  int bitmap_parse_user(const char __user *ubuf,
>  			unsigned int ulen, unsigned long *maskp,
>  			int nmaskbits)
>  {
> -	if (!access_ok(ubuf, ulen))
> -		return -EFAULT;
> -	return __bitmap_parse((const char __force *)ubuf,
> -				ulen, 1, maskp, nmaskbits);
> +	char *buf;
> +	int ret;
>  
> +	buf = memdup_user_nul(ubuf, ulen);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	ret = bitmap_parse(buf, ulen, maskp, nmaskbits);
> +
> +	kfree(buf);
> +	return ret;
>  }
>  EXPORT_SYMBOL(bitmap_parse_user);
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


