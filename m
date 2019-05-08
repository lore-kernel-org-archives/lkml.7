Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BB2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E945121530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfEHIsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:48:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:12429 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEHIsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:48:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 01:48:40 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2019 01:48:33 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hOIFb-0006Wj-QA; Wed, 08 May 2019 11:48:31 +0300
Date:   Wed, 8 May 2019 11:48:31 +0300
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
Subject: Re: [PATCH 7/7] cpumask: don't calculate length of the input string
Message-ID: <20190508084831.GE9224@smile.fi.intel.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
 <20190501010636.30595-8-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501010636.30595-8-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:06:36PM -0700, Yury Norov wrote:
> New design of inner bitmap_parse() allows to avoid
> calculating the size of a null-terminated string.
> 

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  include/linux/cpumask.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 21755471b1c3..d55d015edc58 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -633,9 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
>   */
>  static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
>  {
> -	unsigned int len = strchrnul(buf, '\n') - buf;
> -
> -	return bitmap_parse(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
> +	return bitmap_parse(buf, UINT_MAX, cpumask_bits(dstp), nr_cpumask_bits);
>  }
>  
>  /**
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


