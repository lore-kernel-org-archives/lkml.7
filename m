Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E16AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764D120989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfEHIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:48:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:2152 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEHIsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:48:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 01:48:07 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2019 01:48:01 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hOIF5-0006WK-U2; Wed, 08 May 2019 11:47:59 +0300
Date:   Wed, 8 May 2019 11:47:59 +0300
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
Subject: Re: [PATCH 6/7] lib: new testcases for bitmap_parse{_user}
Message-ID: <20190508084759.GD9224@smile.fi.intel.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
 <20190501010636.30595-7-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501010636.30595-7-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:06:35PM -0700, Yury Norov wrote:
> New version of bitmap_parse() is unified with bitmap_parse_list(),
> and therefore:
>  - weakens rules on whitespaces and commas between hex chunks;
>  - in addition to \0 allows using \n as the line ending symbol;
>  - allows passing UINT_MAX or any other big number as the length
>    of input string instead of actual string length.
> 
> The patch covers the cases.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  lib/test_bitmap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 731e107d811a..9e6b87895108 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -343,14 +343,22 @@ static const unsigned long parse_test2[] __initconst = {
>  };
>  
>  static const struct test_bitmap_parselist parse_tests[] __initconst = {
> +	{0, "",				&parse_test[0 * step], 32, 0},
> +	{0, " ",			&parse_test[0 * step], 32, 0},
>  	{0, "0",			&parse_test[0 * step], 32, 0},
> +	{0, "0\n",			&parse_test[0 * step], 32, 0},
>  	{0, "1",			&parse_test[1 * step], 32, 0},
>  	{0, "deadbeef",			&parse_test[2 * step], 32, 0},
>  	{0, "1,0",			&parse_test[3 * step], 33, 0},
> +	{0, "deadbeef,\n,0,1",		&parse_test[2 * step], 96, 0},
>  
>  	{0, "deadbeef,1,0",		&parse_test2[0 * 2 * step], 96, 0},
>  	{0, "baadf00d,deadbeef,1,0",	&parse_test2[1 * 2 * step], 128, 0},
>  	{0, "badf00d,deadbeef,1,0",	&parse_test2[2 * 2 * step], 124, 0},
> +	{0, "badf00d,deadbeef,1,0",	&parse_test2[2 * 2 * step], 124, NO_LEN},
> +	{0, "  badf00d,deadbeef,1,0  ",	&parse_test2[2 * 2 * step], 124, 0},
> +	{0, " , badf00d,deadbeef,1,0 , ",	&parse_test2[2 * 2 * step], 124, 0},
> +	{0, " , badf00d, ,, ,,deadbeef,1,0 , ",	&parse_test2[2 * 2 * step], 124, 0},
>  
>  	{-EINVAL,    "goodfood,deadbeef,1,0",	NULL, 128, 0},
>  	{-EOVERFLOW, "3,0",			NULL, 33, 0},
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


