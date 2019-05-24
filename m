Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E471C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B3D206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404069AbfEXNvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:51:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:30283 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403878AbfEXNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:51:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 06:51:47 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2019 06:51:45 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hUAbp-0003c0-C1; Fri, 24 May 2019 16:51:45 +0300
Date:   Fri, 24 May 2019 16:51:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/9] genirq/timings: Fix next event index function
Message-ID: <20190524135145.GW9224@smile.fi.intel.com>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
 <20190524111615.4891-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524111615.4891-2-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:16:07PM +0200, Daniel Lezcano wrote:
> The current code was luckily working with most of the interval samples
> testing but actually it fails to correctly detect pattern repeatition
> breaking at the end of the buffer.
> 
> Narrowing down the bug has been a real pain because of the pointers,
> so the routine is rewrite by using indexes instead.

Minor spelling issues below.

> +	/*
> +	 * Move the beginnning pointer to the end minus the max period

Typo: beginning.

> +	 * x 3. We are at the point we can begin searching the pattern

"x 3." would be read better on the previous line.

> +	 */
> +	buffer = &buffer[len - (period_max * 3)];

> +	/*
> +	 * Adjust the length to the maximum allowed period x 3
> +	 */

One line?

> +	len = period_max * 3;

> -	for (i = period_max; i >= PREDICTION_PERIOD_MIN ; i--) {
> +	for (period = period_max; period >= PREDICTION_PERIOD_MIN ; period--) {

At the same time you may drop extra white space.

>  	}

-- 
With Best Regards,
Andy Shevchenko


