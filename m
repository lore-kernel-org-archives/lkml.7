Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC8020989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEHIrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:47:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:58102 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEHIrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:47:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 01:47:10 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2019 01:47:04 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hOIEA-0006VF-P7; Wed, 08 May 2019 11:47:02 +0300
Date:   Wed, 8 May 2019 11:47:02 +0300
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
Subject: Re: [PATCH 1/7] lib/string: add strnchrnul()
Message-ID: <20190508084702.GZ9224@smile.fi.intel.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
 <20190501010636.30595-2-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501010636.30595-2-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:06:30PM -0700, Yury Norov wrote:
> New function works like strchrnul() with a length limited strings.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4deb11f7976b..ae934d6c50bf 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -62,6 +62,7 @@ extern char * strchr(const char *,int);
>  #ifndef __HAVE_ARCH_STRCHRNUL
>  extern char * strchrnul(const char *,int);
>  #endif
> +extern char * strnchrnul(const char *, size_t, int);
>  #ifndef __HAVE_ARCH_STRNCHR
>  extern char * strnchr(const char *, size_t, int);
>  #endif
> diff --git a/lib/string.c b/lib/string.c
> index 6016eb3ac73d..eee521ad1f40 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -429,6 +429,23 @@ char *strchrnul(const char *s, int c)
>  EXPORT_SYMBOL(strchrnul);
>  #endif
>  
> +/**
> + * strnchrnul - Find and return a character in a length limited string,
> + * or end of string
> + * @s: The string to be searched
> + * @count: The number of characters to be searched
> + * @c: The character to search for
> + *
> + * Returns pointer to the first occurrence of 'c' in s. If c is not found,
> + * then return a pointer to the last character of the string.
> + */
> +char *strnchrnul(const char *s, size_t count, int c)
> +{
> +	while (count-- && *s && *s != (char)c)
> +		s++;
> +	return (char *)s;
> +}
> +
>  #ifndef __HAVE_ARCH_STRRCHR
>  /**
>   * strrchr - Find the last occurrence of a character in a string
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


