Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A04C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FD62077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfDPNSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:18:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:40565 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfDPNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:18:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 06:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="162369180"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2019 06:18:09 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hGNyS-0003PI-1R; Tue, 16 Apr 2019 16:18:08 +0300
Date:   Tue, 16 Apr 2019 16:18:08 +0300
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
Subject: Re: [PATCH 2/5] lib: rework bitmap_parselist
Message-ID: <20190416131808.GF9224@smile.fi.intel.com>
References: <20190416063801.20134-1-ynorov@marvell.com>
 <20190416063801.20134-3-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416063801.20134-3-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:37:58PM -0700, Yury Norov wrote:
> From: Yury Norov <ynorov@marvell.com>
> 
> Remove __bitmap_parselist helper and split the function to logical
> parts.
> 

One comment below.

Overall looks good to me, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  lib/bitmap.c | 255 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 142 insertions(+), 113 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index c63ddd06a5da..f235434df87b 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -20,6 +20,8 @@
>  
>  #include <asm/page.h>
>  
> +#include "kstrtox.h"
> +
>  /**
>   * DOC: bitmap introduction
>   *
> @@ -477,12 +479,128 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>  }
>  EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>  
> +/*
> + * Region 9-38:4/10 describes the following bitmap structure:
> + * 0	   9  12    18			38
> + * .........****......****......****......
> + *	    ^  ^     ^			 ^
> + *      start  off   group_len	       end
> + */
> +struct region {
> +	unsigned int start;
> +	unsigned int off;
> +	unsigned int group_len;
> +	unsigned int end;
> +};
> +
> +static int bitmap_set_region(const struct region *r,
> +				unsigned long *bitmap, int nbits)
> +{
> +	unsigned int start;
> +
> +	if (r->end >= nbits)
> +		return -ERANGE;
> +
> +	for (start = r->start; start <= r->end; start += r->group_len)
> +		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
> +
> +	return 0;
> +}
> +
> +static int bitmap_check_region(const struct region *r)
> +{
> +	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const char *bitmap_getnum(const char *str, unsigned int *num)
> +{
> +	unsigned long long n;
> +	unsigned int len;
> +

> +	len = _parse_integer(str, 10, &n);

I think we are good here, since it's only for use inside lib itself.

> +	if (!len)
> +		return ERR_PTR(-EINVAL);

> +	if (len & KSTRTOX_OVERFLOW || n != (unsigned int)n)

Second part is simple to compare to UINT_MAX: "n > UINT_MAX", or
"upper_32_bits(n)" would work as well.

Among all I would rather go to comparison with limits, i.e. UINT_MAX.

> +		return ERR_PTR(-EOVERFLOW);
> +
> +	*num = n;
> +	return str + len;
> +}
> +
> +static inline bool end_of_str(char c)
> +{
> +	return c == '\0' || c == '\n';
> +}
> +
> +static inline bool __end_of_region(char c)
> +{
> +	return isspace(c) || c == ',';
> +}
> +
> +static inline bool end_of_region(char c)
> +{
> +	return __end_of_region(c) || end_of_str(c);
> +}
> +
> +/*
> + * The format allows commas and whitespases at the beginning
> + * of the region.
> + */
> +static const char *bitmap_find_region(const char *str)
> +{
> +	while (__end_of_region(*str))
> +		str++;
> +
> +	return end_of_str(*str) ? NULL : str;
> +}
> +
> +static const char *bitmap_parse_region(const char *str, struct region *r)
> +{
> +	str = bitmap_getnum(str, &r->start);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	if (end_of_region(*str))
> +		goto no_end;
> +
> +	if (*str != '-')
> +		return ERR_PTR(-EINVAL);
> +
> +	str = bitmap_getnum(str + 1, &r->end);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	if (end_of_region(*str))
> +		goto no_pattern;
> +
> +	if (*str != ':')
> +		return ERR_PTR(-EINVAL);
> +
> +	str = bitmap_getnum(str + 1, &r->off);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	if (*str != '/')
> +		return ERR_PTR(-EINVAL);
> +
> +	return bitmap_getnum(str + 1, &r->group_len);
> +
> +no_end:
> +	r->end = r->start;
> +no_pattern:
> +	r->off = r->end + 1;
> +	r->group_len = r->end + 1;
> +
> +	return end_of_str(*str) ? NULL : str;
> +}
> +
>  /**
> - * __bitmap_parselist - convert list format ASCII string to bitmap
> - * @buf: read nul-terminated user string from this buffer
> - * @buflen: buffer size in bytes.  If string is smaller than this
> - *    then it must be terminated with a \0.
> - * @is_user: location of buffer, 0 indicates kernel space
> + * bitmap_parselist - convert list format ASCII string to bitmap
> + * @buf: read user string from this buffer; must be terminated
> + *    with a \0 or \n.
>   * @maskp: write resulting mask here
>   * @nmaskbits: number of bits in mask to be written
>   *
> @@ -498,127 +616,38 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>   *
>   * Returns: 0 on success, -errno on invalid input strings. Error values:
>   *
> - *   - ``-EINVAL``: second number in range smaller than first
> + *   - ``-EINVAL``: wrong region format
>   *   - ``-EINVAL``: invalid character in string
>   *   - ``-ERANGE``: bit number specified too large for mask
> + *   - ``-EOVERFLOW``: integer overflow in the input parameters
>   */
> -static int __bitmap_parselist(const char *buf, unsigned int buflen,
> -		int is_user, unsigned long *maskp,
> -		int nmaskbits)
> +int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>  {
> -	unsigned int a, b, old_a, old_b;
> -	unsigned int group_size, used_size, off;
> -	int c, old_c, totaldigits, ndigits;
> -	const char __user __force *ubuf = (const char __user __force *)buf;
> -	int at_start, in_range, in_partial_range;
> +	struct region r;
> +	long ret;
>  
> -	totaldigits = c = 0;
> -	old_a = old_b = 0;
> -	group_size = used_size = 0;
>  	bitmap_zero(maskp, nmaskbits);
> -	do {
> -		at_start = 1;
> -		in_range = 0;
> -		in_partial_range = 0;
> -		a = b = 0;
> -		ndigits = totaldigits;
> -
> -		/* Get the next cpu# or a range of cpu#'s */
> -		while (buflen) {
> -			old_c = c;
> -			if (is_user) {
> -				if (__get_user(c, ubuf++))
> -					return -EFAULT;
> -			} else
> -				c = *buf++;
> -			buflen--;
> -			if (isspace(c))
> -				continue;
>  
> -			/* A '\0' or a ',' signal the end of a cpu# or range */
> -			if (c == '\0' || c == ',')
> -				break;
> -			/*
> -			* whitespaces between digits are not allowed,
> -			* but it's ok if whitespaces are on head or tail.
> -			* when old_c is whilespace,
> -			* if totaldigits == ndigits, whitespace is on head.
> -			* if whitespace is on tail, it should not run here.
> -			* as c was ',' or '\0',
> -			* the last code line has broken the current loop.
> -			*/
> -			if ((totaldigits != ndigits) && isspace(old_c))
> -				return -EINVAL;
> -
> -			if (c == '/') {
> -				used_size = a;
> -				at_start = 1;
> -				in_range = 0;
> -				a = b = 0;
> -				continue;
> -			}
> +	while (buf) {
> +		buf = bitmap_find_region(buf);
> +		if (buf == NULL)
> +			return 0;
>  
> -			if (c == ':') {
> -				old_a = a;
> -				old_b = b;
> -				at_start = 1;
> -				in_range = 0;
> -				in_partial_range = 1;
> -				a = b = 0;
> -				continue;
> -			}
> +		buf = bitmap_parse_region(buf, &r);
> +		if (IS_ERR(buf))
> +			return PTR_ERR(buf);
>  
> -			if (c == '-') {
> -				if (at_start || in_range)
> -					return -EINVAL;
> -				b = 0;
> -				in_range = 1;
> -				at_start = 1;
> -				continue;
> -			}
> +		ret = bitmap_check_region(&r);
> +		if (ret)
> +			return ret;
>  
> -			if (!isdigit(c))
> -				return -EINVAL;
> +		ret = bitmap_set_region(&r, maskp, nmaskbits);
> +		if (ret)
> +			return ret;
> +	}
>  
> -			b = b * 10 + (c - '0');
> -			if (!in_range)
> -				a = b;
> -			at_start = 0;
> -			totaldigits++;
> -		}
> -		if (ndigits == totaldigits)
> -			continue;
> -		if (in_partial_range) {
> -			group_size = a;
> -			a = old_a;
> -			b = old_b;
> -			old_a = old_b = 0;
> -		} else {
> -			used_size = group_size = b - a + 1;
> -		}
> -		/* if no digit is after '-', it's wrong*/
> -		if (at_start && in_range)
> -			return -EINVAL;
> -		if (!(a <= b) || group_size == 0 || !(used_size <= group_size))
> -			return -EINVAL;
> -		if (b >= nmaskbits)
> -			return -ERANGE;
> -		while (a <= b) {
> -			off = min(b - a + 1, used_size);
> -			bitmap_set(maskp, a, off);
> -			a += group_size;
> -		}
> -	} while (buflen && c == ',');
>  	return 0;
>  }
> -
> -int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
> -{
> -	char *nl  = strchrnul(bp, '\n');
> -	int len = nl - bp;
> -
> -	return __bitmap_parselist(bp, len, 0, maskp, nmaskbits);
> -}
>  EXPORT_SYMBOL(bitmap_parselist);
>  
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


