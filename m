Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2BA20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfCZKMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:12:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:4030 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZKMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:12:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 03:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="137344286"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2019 03:12:44 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8j4U-0001AK-Vi; Tue, 26 Mar 2019 12:12:42 +0200
Date:   Tue, 26 Mar 2019 12:12:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] lib/test_bitmap: add tests for bitmap_parselist_user
Message-ID: <20190326101242.GU9224@smile.fi.intel.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
 <20190325210748.6571-7-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325210748.6571-7-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:07:48AM +0300, Yury Norov wrote:
> Propagate existing bitmap_parselist() tests to bitmap_parselist_user().

Increasing test coverage is a good point,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for all test related patches

> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  lib/test_bitmap.c | 46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 709424a788ee..d4ecac0da160 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -11,6 +11,7 @@
>  #include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/uaccess.h>
>  
>  static unsigned total_tests __initdata;
>  static unsigned failed_tests __initdata;
> @@ -278,39 +279,63 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
>  	{-EINVAL, "0-\n", NULL, 8, 0},
>  };
>  
> -static void __init test_bitmap_parselist(void)
> +static void __init __test_bitmap_parselist(int is_user)
>  {
>  	int i;
>  	int err;
>  	ktime_t time;
>  	DECLARE_BITMAP(bmap, 2048);
> +	char *mode = is_user ? "_user"  : "";
>  
>  	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
>  #define ptest parselist_tests[i]
>  
> -		time = ktime_get();
> -		err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
> -		time = ktime_get() - time;
> +		if (is_user) {
> +			mm_segment_t orig_fs = get_fs();
> +			size_t len = strlen(ptest.in);
> +
> +			set_fs(KERNEL_DS);
> +			time = ktime_get();
> +			err = bitmap_parselist_user(ptest.in, len,
> +						    bmap, ptest.nbits);
> +			time = ktime_get() - time;
> +			set_fs(orig_fs);
> +		} else {
> +			time = ktime_get();
> +			err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
> +			time = ktime_get() - time;
> +		}
>  
>  		if (err != ptest.errno) {
> -			pr_err("test %d: input is %s, errno is %d, expected %d\n",
> -					i, ptest.in, err, ptest.errno);
> +			pr_err("parselist%s: %d: input is %s, errno is %d, expected %d\n",
> +					mode, i, ptest.in, err, ptest.errno);
>  			continue;
>  		}
>  
>  		if (!err && ptest.expected
>  			 && !__bitmap_equal(bmap, ptest.expected, ptest.nbits)) {
> -			pr_err("test %d: input is %s, result is 0x%lx, expected 0x%lx\n",
> -					i, ptest.in, bmap[0], *ptest.expected);
> +			pr_err("parselist%s: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
> +					mode, i, ptest.in, bmap[0],
> +					*ptest.expected);
>  			continue;
>  		}
>  
>  		if (ptest.flags & PARSE_TIME)
> -			pr_err("test %d: input is '%s' OK, Time: %llu\n",
> -					i, ptest.in, time);
> +			pr_err("parselist%s: %d: input is '%s' OK, Time: %llu\n",
> +					mode, i, ptest.in, time);
>  	}
>  }
>  
> +static void __init test_bitmap_parselist(void)
> +{
> +	__test_bitmap_parselist(0);
> +}
> +
> +static void __init test_bitmap_parselist_user(void)
> +{
> +	__test_bitmap_parselist(1);
> +}
> +
>  #define EXP_BYTES	(sizeof(exp) * 8)
>  
>  static void __init test_bitmap_arr32(void)
> @@ -383,6 +408,7 @@ static int __init test_bitmap_init(void)
>  	test_copy();
>  	test_bitmap_arr32();
>  	test_bitmap_parselist();
> +	test_bitmap_parselist_user();
>  	test_mem_optimisations();
>  
>  	if (failed_tests == 0)
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


