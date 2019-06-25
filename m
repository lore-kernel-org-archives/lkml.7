Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A62C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A61213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfFYN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:28:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:65246 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfFYN2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:28:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 06:28:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="155509935"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2019 06:28:13 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hflUa-0002rB-Do; Tue, 25 Jun 2019 16:28:12 +0300
Date:   Tue, 25 Jun 2019 16:28:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, akpm@linux-foundation.org,
        ndesaulniers@google.com
Subject: Re: [PATCH][V4] lib: fix __sysfs_match_string() helper when n != -1
Message-ID: <20190625132812.GB9224@smile.fi.intel.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
 <20190625130104.29904-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625130104.29904-1-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 04:01:04PM +0300, Alexandru Ardelean wrote:
> The documentation the `__sysfs_match_string()` helper mentions that `n`
> (the size of the given array) should be:
>  * @n: number of strings in the array or -1 for NULL terminated arrays
> 
> The behavior of the function is different, in the sense that it exits on
> the first NULL element in the array.
> 
> This patch changes the behavior, to exit the loop when a NULL element is
> found, and the size of the array is provided as -1.
> 
> All current users of __sysfs_match_string() & sysfs_match_string() provide
> contiguous arrays of strings, so this behavior change doesn't influence
> anything (at this point in time).
> 
> This behavior change allows for an array of strings to have NULL elements
> within the array, which will be ignored. This is particularly useful when
> creating mapping of strings and integers (as bitfields or other HW
> description).

Since it does nothing for current users and comes without an example,
it's hard to justify the need.

The code itself looks good to me.

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v3 -> v4:
> * split this patch away from series; there are some unsolved discussions
>   that will probably need resolving per sub-system
> 
>  lib/string.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index 3ab861c1a857..5bea3f98478a 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -674,8 +674,11 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *str)
>  
>  	for (index = 0; index < n; index++) {
>  		item = array[index];
> -		if (!item)
> +		if (!item) {
> +			if (n != (size_t)-1)
> +				continue;
>  			break;
> +		}
>  		if (sysfs_streq(item, str))
>  			return index;
>  	}
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


