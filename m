Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11582C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D768020989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEHIra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:47:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:40401 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEHIra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:47:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 01:47:29 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 08 May 2019 01:47:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hOIEU-0006Vb-F2; Wed, 08 May 2019 11:47:22 +0300
Date:   Wed, 8 May 2019 11:47:22 +0300
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
Subject: Re: [PATCH 3/7] lib: add test for bitmap_parse()
Message-ID: <20190508084722.GB9224@smile.fi.intel.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
 <20190501010636.30595-4-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501010636.30595-4-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:06:32PM -0700, Yury Norov wrote:
> The test is derived from bitmap_parselist()
> NO_LEN is reserved for use in following patches.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  lib/test_bitmap.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index d3a501f2a81a..731e107d811a 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -205,7 +205,8 @@ static void __init test_copy(void)
>  	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
>  }
>  
> -#define PARSE_TIME 0x1
> +#define PARSE_TIME	0x1
> +#define NO_LEN		0x2
>  
>  struct test_bitmap_parselist{
>  	const int errno;
> @@ -328,6 +329,85 @@ static void __init __test_bitmap_parselist(int is_user)
>  	}
>  }
>  
> +static const unsigned long parse_test[] __initconst = {
> +	BITMAP_FROM_U64(0),
> +	BITMAP_FROM_U64(1),
> +	BITMAP_FROM_U64(0xdeadbeef),
> +	BITMAP_FROM_U64(0x100000000ULL),
> +};
> +
> +static const unsigned long parse_test2[] __initconst = {
> +	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xdeadbeef),
> +	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xbaadf00ddeadbeef),
> +	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0x0badf00ddeadbeef),
> +};
> +
> +static const struct test_bitmap_parselist parse_tests[] __initconst = {
> +	{0, "0",			&parse_test[0 * step], 32, 0},
> +	{0, "1",			&parse_test[1 * step], 32, 0},
> +	{0, "deadbeef",			&parse_test[2 * step], 32, 0},
> +	{0, "1,0",			&parse_test[3 * step], 33, 0},
> +
> +	{0, "deadbeef,1,0",		&parse_test2[0 * 2 * step], 96, 0},
> +	{0, "baadf00d,deadbeef,1,0",	&parse_test2[1 * 2 * step], 128, 0},
> +	{0, "badf00d,deadbeef,1,0",	&parse_test2[2 * 2 * step], 124, 0},
> +
> +	{-EINVAL,    "goodfood,deadbeef,1,0",	NULL, 128, 0},
> +	{-EOVERFLOW, "3,0",			NULL, 33, 0},
> +	{-EOVERFLOW, "123badf00d,deadbeef,1,0",	NULL, 128, 0},
> +	{-EOVERFLOW, "badf00d,deadbeef,1,0",	NULL, 90, 0},
> +	{-EOVERFLOW, "fbadf00d,deadbeef,1,0",	NULL, 95, 0},
> +	{-EOVERFLOW, "badf00d,deadbeef,1,0",	NULL, 100, 0},
> +};
> +
> +static void __init __test_bitmap_parse(int is_user)
> +{
> +	int i;
> +	int err;
> +	ktime_t time;
> +	DECLARE_BITMAP(bmap, 2048);
> +	char *mode = is_user ? "_user"  : "";
> +
> +	for (i = 0; i < ARRAY_SIZE(parse_tests); i++) {
> +		struct test_bitmap_parselist test = parse_tests[i];
> +
> +		if (is_user) {
> +			size_t len = strlen(test.in);
> +			mm_segment_t orig_fs = get_fs();
> +
> +			set_fs(KERNEL_DS);
> +			time = ktime_get();
> +			err = bitmap_parse_user(test.in, len, bmap, test.nbits);
> +			time = ktime_get() - time;
> +			set_fs(orig_fs);
> +		} else {
> +			size_t len = test.flags & NO_LEN ?
> +				UINT_MAX : strlen(test.in);
> +			time = ktime_get();
> +			err = bitmap_parse(test.in, len, bmap, test.nbits);
> +			time = ktime_get() - time;
> +		}
> +
> +		if (err != test.errno) {
> +			pr_err("parse%s: %d: input is %s, errno is %d, expected %d\n",
> +					mode, i, test.in, err, test.errno);
> +			continue;
> +		}
> +
> +		if (!err && test.expected
> +			 && !__bitmap_equal(bmap, test.expected, test.nbits)) {
> +			pr_err("parse%s: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
> +					mode, i, test.in, bmap[0],
> +					*test.expected);
> +			continue;
> +		}
> +
> +		if (test.flags & PARSE_TIME)
> +			pr_err("parse%s: %d: input is '%s' OK, Time: %llu\n",
> +					mode, i, test.in, time);
> +	}
> +}
> +
>  static void __init test_bitmap_parselist(void)
>  {
>  	__test_bitmap_parselist(0);
> @@ -338,6 +418,16 @@ static void __init test_bitmap_parselist_user(void)
>  	__test_bitmap_parselist(1);
>  }
>  
> +static void __init test_bitmap_parse(void)
> +{
> +	__test_bitmap_parse(0);
> +}
> +
> +static void __init test_bitmap_parse_user(void)
> +{
> +	__test_bitmap_parse(1);
> +}
> +
>  #define EXP_BYTES	(sizeof(exp) * 8)
>  
>  static void __init test_bitmap_arr32(void)
> @@ -409,6 +499,8 @@ static void __init selftest(void)
>  	test_fill_set();
>  	test_copy();
>  	test_bitmap_arr32();
> +	test_bitmap_parse();
> +	test_bitmap_parse_user();
>  	test_bitmap_parselist();
>  	test_bitmap_parselist_user();
>  	test_mem_optimisations();
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


