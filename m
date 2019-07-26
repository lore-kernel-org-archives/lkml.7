Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24732C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FDB22CBF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfGZQs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:48:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:8827 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfGZQs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:48:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 09:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322083350"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 09:48:25 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hr3OJ-000539-MC; Fri, 26 Jul 2019 19:48:23 +0300
Date:   Fri, 26 Jul 2019 19:48:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        Coly Li <colyli@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] md: Convert to use int_pow()
Message-ID: <20190726164823.GB9224@smile.fi.intel.com>
References: <20190723204155.71531-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723204155.71531-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:41:55PM +0300, Andy Shevchenko wrote:
> Instead of linear approach to calculate power of 10, use generic int_pow()
> which does it better.

I took into Cc drivers/dm guys as they might have known something about md raid
state of affairs. Sorry if I mistakenly added somebody.

Who is doing this?
Should it be orphaned?

(I got a bounce from Shaohua address)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/md/md.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 24638ccedce4..3f1252440ad0 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3664,11 +3664,7 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
>  		return -EINVAL;
>  	if (decimals < 0)
>  		decimals = 0;
> -	while (decimals < scale) {
> -		result *= 10;
> -		decimals ++;
> -	}
> -	*res = result;
> +	*res = result * int_pow(10, scale - decimals);
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


