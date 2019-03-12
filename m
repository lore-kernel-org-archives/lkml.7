Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA4C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677222147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCLPhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:37:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:42554 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfCLPhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:37:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 08:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="306561943"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2019 08:37:03 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h3jSg-0008OA-Ju; Tue, 12 Mar 2019 17:37:02 +0200
Date:   Tue, 12 Mar 2019 17:37:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: baytrail: Fix potential NULL pointer dereference
Message-ID: <20190312153702.GH9224@smile.fi.intel.com>
References: <20190312150552.1429-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312150552.1429-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:05:52AM -0500, Aditya Pakki wrote:
> saved-context in byt_gpio_probe is allocated via devm_kcalloc and is
> used without checking for NULL in later functions. This patch avoids
> such a scenario.
> 

Thanks.
I take it to our branch after merge window will be finished.

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/pinctrl/intel/pinctrl-baytrail.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
> index 241384ead4ed..18d9ad504194 100644
> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
> @@ -1710,6 +1710,8 @@ static int byt_gpio_probe(struct byt_gpio *vg)
>  #ifdef CONFIG_PM_SLEEP
>  	vg->saved_context = devm_kcalloc(&vg->pdev->dev, gc->ngpio,
>  				       sizeof(*vg->saved_context), GFP_KERNEL);
> +	if (!vg->saved_context)
> +		return -ENOMEM;
>  #endif
>  	ret = devm_gpiochip_add_data(&vg->pdev->dev, gc, vg);
>  	if (ret) {
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


