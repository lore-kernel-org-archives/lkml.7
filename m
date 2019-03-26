Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C994C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E372075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfCZKKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:10:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:20984 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZKKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:10:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 03:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="130239543"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2019 03:10:46 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8j2b-00018w-6r; Tue, 26 Mar 2019 12:10:45 +0200
Date:   Tue, 26 Mar 2019 12:10:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] bitmap_parselist: rework input string parser
Message-ID: <20190326101045.GT9224@smile.fi.intel.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
 <20190325210748.6571-4-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325210748.6571-4-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:07:45AM +0300, Yury Norov wrote:
> The requirement for this rework is to keep the __bitmap_parselist()
> copy-less and single-pass but make it more readable and maintainable by
> splitting into logical parts and removing explicit nested cycles and
> opaque local variables.
> 
> __bitmap_parselist() can parse userspace inputs and therefore we cannot
> use simple_strtoul() to parse numbers.

> +static long get_char(char *c, const char *str, int is_user)
> +{
> +	if (unlikely(is_user))

Can is_user be boolean?

Can we name it from_user or is_from_user?

> +		return __get_user(*c, (const char __force __user *)str);
> +
> +	*c = *str;
> +	return 0;
> +}
> +
> +static const char *bitmap_getnum(unsigned int *num, const char *str,
> +			    const char *const end, int is_user)
> +{
> +	unsigned int n = 0;
> +	const char *_str;
> +	long ret;
> +	char c;
> +

> +	for (_str = str, *num = 0; _str <= end; _str++) {
> +		ret = get_char(&c, _str, is_user);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		if (!isdigit(c)) {
> +			if (_str == str)
> +				return ERR_PTR(-EINVAL);
> +
> +			return _str;
> +		}
> +
> +		*num = *num * 10 + (c - '0');
> +		if (*num < n)
> +			return ERR_PTR(-EOVERFLOW);
> +
> +		n = *num;
> +	}

Can't we do other way around, i.e. move the loop body to a helper and do
	something like this:

if (is_from_user) {
	for (...) {
		__get_user(...);
		helper1();
		helper2();
	}
} else {
	for (...) {
		*c = *str;
		helper1();
		helper2()
	}
}

Each branch can be optimized more I think.

> +
> +	return _str;
> +}
> +
> +static const char *bitmap_find_region(const char *str,
> +			const char *const end, int is_user)
> +{
> +	long ret;
> +	char c;
> +
> +	for (; str <= end; str++) {
> +		ret = get_char(&c, str, is_user);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		/* Unexpected end of line. */
> +		if (c == 0 || c == '\n')
> +			return NULL;
> +
> +		/*
> +		 * The format allows commas and whitespases
> +		 * at the beginning of the region, so skip it.
> +		 */
> +		if (!isspace(c) && c != ',')
> +			break;
> +	}
> +
> +	return str <= end ? str : NULL;
> +}
> +
> +static const char *bitmap_parse_region(struct region *r, const char *str,
> +				 const char *const end, int is_user)
> +{
> +	long ret;
> +	char c;
> +
> +	str = bitmap_getnum(&r->start, str, end, is_user);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	ret = get_char(&c, str, is_user);
> +	if (ret)
> +		return (char *)ret;
> +
> +	if (c == 0 || c == '\n') {
> +		str = end + 1;
> +		goto no_end;
> +	}
> +
> +	if (isspace(c) || c == ',')
> +		goto no_end;
> +
> +	if (c != '-')
> +		return ERR_PTR(-EINVAL);
> +
> +	str = bitmap_getnum(&r->end, str + 1, end, is_user);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	ret = get_char(&c, str, is_user);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (c == 0 || c == '\n') {
> +		str = end + 1;
> +		goto no_pattern;
> +	}
> +
> +	if (isspace(c) || c == ',')
> +		goto no_pattern;
> +
> +	if (c != ':')
> +		return ERR_PTR(-EINVAL);
> +
> +	str = bitmap_getnum(&r->off, str + 1, end, is_user);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	ret = get_char(&c, str, is_user);
> +	if (ret)
> +		return (char *)ret;
> +
> +	if (c != '/')
> +		return ERR_PTR(-EINVAL);
> +

> +	str = bitmap_getnum(&r->grlen, str + 1, end, is_user);
> +
> +	return str;

return bitmap_getnum(...);

> +
> +no_end:
> +	r->end = r->start;
> +no_pattern:
> +	r->off = r->end + 1;
> +	r->grlen = r->end + 1;
> +
> +	return str;
> +}
> +

So, all above depends to what memory we access kernel / user space.
Perhaps we can get copy of memory of a given size and then parse it in kernel space always?

-- 
With Best Regards,
Andy Shevchenko


