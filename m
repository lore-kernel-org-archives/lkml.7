Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BBF20675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfDPNIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:08:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:24799 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfDPNIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:08:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 06:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="131841488"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 16 Apr 2019 06:08:39 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hGNpG-0003KP-5R; Tue, 16 Apr 2019 16:08:38 +0300
Date:   Tue, 16 Apr 2019 16:08:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] lib: make bitmap_parselist_user() a wrapper on
 bitmap_parselist()
Message-ID: <20190416130838.GE9224@smile.fi.intel.com>
References: <20190416063801.20134-1-ynorov@marvell.com>
 <20190416063801.20134-2-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416063801.20134-2-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:37:57PM -0700, Yury Norov wrote:
> From: Yury Norov <ynorov@marvell.com>
> 
> Currently we parse user data byte after byte which leads to
> overcomplification of parsing algorithm. The only user of
> bitmap_parselist_user() is not performance-critical, and so we
> can duplicate user data to kernel buffer and simply call
> bitmap_parselist(). This rework lets us unify and simplify
> bitmap_parselist() and bitmap_parselist_user(), which is done
> in the following patch.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  lib/bitmap.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 3f3b8051f342..c63ddd06a5da 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -632,19 +632,22 @@ EXPORT_SYMBOL(bitmap_parselist);
>   * @nmaskbits: size of bitmap, in bits.
>   *
>   * Wrapper for bitmap_parselist(), providing it with user buffer.
> - *
> - * We cannot have this as an inline function in bitmap.h because it needs
> - * linux/uaccess.h to get the access_ok() declaration and this causes
> - * cyclic dependencies.
>   */
>  int bitmap_parselist_user(const char __user *ubuf,
>  			unsigned int ulen, unsigned long *maskp,
>  			int nmaskbits)
>  {
> -	if (!access_ok(ubuf, ulen))
> -		return -EFAULT;
> -	return __bitmap_parselist((const char __force *)ubuf,
> -					ulen, 1, maskp, nmaskbits);
> +	char *buf;
> +	int ret;
> +
> +	buf = memdup_user_nul(ubuf, ulen);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	ret = bitmap_parselist(buf, maskp, nmaskbits);
> +
> +	kfree(buf);
> +	return ret;
>  }
>  EXPORT_SYMBOL(bitmap_parselist_user);
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


