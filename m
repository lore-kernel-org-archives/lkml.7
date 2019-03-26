Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F772075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfCZKKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:10:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:12092 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:10:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 03:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="155871028"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2019 03:09:57 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8j1o-00018Y-1k; Tue, 26 Mar 2019 12:09:56 +0200
Date:   Tue, 26 Mar 2019 12:09:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] bitmap_parselist: don't calculate length of the
 input string
Message-ID: <20190326100956.GS9224@smile.fi.intel.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
 <20190325210748.6571-2-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325210748.6571-2-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:07:43AM +0300, Yury Norov wrote:
> bitmap_parselist() calculates length of the input string before passing
> it to the __bitmap_parselist(). But the end-of-line condition is checked
> for every character in __bitmap_parselist() anyway. So doing it in wrapper
> is a simple waste of time.

This is not best change, I think. See my further comments.

> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  lib/bitmap.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 98872e9025da..ad1fb7e6ad0e 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -614,10 +614,7 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
>  
>  int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
>  {
> -	char *nl  = strchrnul(bp, '\n');
> -	int len = nl - bp;
> -
> -	return __bitmap_parselist(bp, len, 0, maskp, nmaskbits);
> +	return __bitmap_parselist(bp, UINT_MAX, 0, maskp, nmaskbits);
>  }
>  EXPORT_SYMBOL(bitmap_parselist);
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


