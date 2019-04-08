Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A170C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D755214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDHJzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:55:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:32477 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfDHJzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:55:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 02:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="314030678"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2019 02:55:42 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDR08-0006X1-MO; Mon, 08 Apr 2019 12:55:40 +0300
Date:   Mon, 8 Apr 2019 12:55:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>, Yury Norov <ynorov@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] lib: rework bitmap_parselist
Message-ID: <20190408095540.GG9224@smile.fi.intel.com>
References: <20190405173211.11373-1-ynorov@marvell.com>
 <20190405173211.11373-3-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405173211.11373-3-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 08:32:08PM +0300, Yury Norov wrote:
> Remove __bitmap_parselist helper and split the function to logical
> parts.

> +static const char *bitmap_getnum(const char *str, unsigned int *num)
> +{
> +	unsigned int n = 0, _num = 0;
> +
> +	if (!isdigit(*str))
> +		return ERR_PTR(-EINVAL);
> +
> +	for (; isdigit(*str); str++) {
> +		_num = _num * 10 + (*str - '0');
> +		if (_num < n)
> +			return ERR_PTR(-EOVERFLOW);
> +
> +		n = _num;
> +	}
> +
> +	*num = _num;
> +
> +	return str;
> +}

This looks like (semi) open coded simple_strtoull()

unsigned long long _num;
char *endp;

_num = simple_strtoull(str, &endp, 10);
if (endp == str)
	return ERR_PTR(-EINVAL);
if (_num > UINT_MAX || (endp - str) > 10)
	return ERR_PTR(-EOVERFLOW);
*num = _num;
return endp;

> +static inline bool end_of_str(char c)
> +{
> +	return c == '\0' || c == '\n';
> +}

This reminds me a check at the end of _kstrtoull(). Can we use same approach in
both cases?

-- 
With Best Regards,
Andy Shevchenko


