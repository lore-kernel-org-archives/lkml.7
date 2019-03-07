Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C19C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03CD20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCGOMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:12:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:63025 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfCGOMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:12:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 06:12:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="139956148"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2019 06:12:33 -0800
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h1tlA-0001vb-GY; Thu, 07 Mar 2019 16:12:32 +0200
Date:   Thu, 7 Mar 2019 16:12:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@rasmusvillemoes.dk
Cc:     Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v1] lib/test_printf: Switch to bitmap_zalloc()
Message-ID: <20190307141232.GG9224@smile.fi.intel.com>
References: <20190304100009.65147-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304100009.65147-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Petr

On Mon, Mar 04, 2019 at 12:00:09PM +0200, Andy Shevchenko wrote:
> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_printf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 659b6cc0d483..e8206d8d2d08 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -481,14 +481,14 @@ static void __init
>  large_bitmap(void)
>  {
>  	const int nbits = 1 << 16;
> -	unsigned long *bits = kcalloc(BITS_TO_LONGS(nbits), sizeof(long), GFP_KERNEL);
> +	unsigned long *bits = bitmap_zalloc(nbits, GFP_KERNEL);
>  	if (!bits)
>  		return;
>  
>  	bitmap_set(bits, 1, 20);
>  	bitmap_set(bits, 60000, 15);
>  	test("1-20,60000-60014", "%*pbl", nbits, bits);
> -	kfree(bits);
> +	bitmap_free(bits);
>  }
>  
>  static void __init
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


