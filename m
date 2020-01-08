Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C402C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3854120692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgAHQiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:38:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:21187 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgAHQiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:38:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:38:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="303602294"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 08:37:56 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipELE-0005Qd-BW; Wed, 08 Jan 2020 18:37:56 +0200
Date:   Wed, 8 Jan 2020 18:37:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/36] platform/x86: intel_mid_powerbtn: Take a copy
 of ddata
Message-ID: <20200108163756.GU32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-2-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:26PM +0300, Mika Westerberg wrote:
> The driver gets driver_data from memory that is marked as const (which
> is probably put to read-only memory) and it then modifies it. This
> likely causes some sort of fault to happen.
> 
> Fix this by taking a copy of the structure.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: c94a8ff14de3 ("platform/x86: intel_mid_powerbtn: make mid_pb_ddata const")
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_mid_powerbtn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_mid_powerbtn.c b/drivers/platform/x86/intel_mid_powerbtn.c
> index 292bace83f1e..6f436836fe50 100644
> --- a/drivers/platform/x86/intel_mid_powerbtn.c
> +++ b/drivers/platform/x86/intel_mid_powerbtn.c
> @@ -146,9 +146,10 @@ static int mid_pb_probe(struct platform_device *pdev)
>  
>  	input_set_capability(input, EV_KEY, KEY_POWER);
>  
> -	ddata = (struct mid_pb_ddata *)id->driver_data;
> +	ddata = devm_kmemdup(&pdev->dev, (void *)id->driver_data,
> +			     sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
> -		return -ENODATA;
> +		return -ENOMEM;
>  
>  	ddata->dev = &pdev->dev;
>  	ddata->irq = irq;
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


