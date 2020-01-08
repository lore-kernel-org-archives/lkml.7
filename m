Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2766DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE3720692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgAHRi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:38:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:49806 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbgAHRi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:38:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="223602809"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2020 09:38:22 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipFHi-000660-WC; Wed, 08 Jan 2020 19:38:23 +0200
Date:   Wed, 8 Jan 2020 19:38:22 +0200
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
Subject: Re: [PATCH v2 16/36] watchdog: intel-mid_wdt: Convert to use new SCU
 IPC API
Message-ID: <20200108173822.GC32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-17-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-17-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:41PM +0300, Mika Westerberg wrote:
> This converts the Intel MID watchdog driver over the new SCU IPC API
> where the SCU IPC instance is passed to the functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/watchdog/intel-mid_wdt.c | 53 ++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index 470213abfd3d..1ae03b64ef8b 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -33,14 +33,24 @@ enum {
>  	SCU_WATCHDOG_KEEPALIVE,
>  };
>  
> -static inline int wdt_command(int sub, u32 *in, int inlen)
> +struct mid_wdt {
> +	struct watchdog_device wd;
> +	struct device *dev;
> +	struct intel_scu_ipc_dev *scu;
> +};
> +
> +static inline int
> +wdt_command(struct mid_wdt *mid, int sub, const void *in, size_t inlen, size_t size)
>  {
> -	return intel_scu_ipc_command(IPC_WATCHDOG, sub, in, inlen, NULL, 0);
> +	struct intel_scu_ipc_dev *scu = mid->scu;
> +
> +	return intel_scu_ipc_dev_command_with_size(scu, IPC_WATCHDOG, sub, in,
> +						   inlen, size, NULL, 0);
>  }
>  
>  static int wdt_start(struct watchdog_device *wd)
>  {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>  	int ret, in_size;
>  	int timeout = wd->timeout;
>  	struct ipc_wd_start {
> @@ -49,38 +59,41 @@ static int wdt_start(struct watchdog_device *wd)
>  	} ipc_wd_start = { timeout - MID_WDT_PRETIMEOUT, timeout };
>  
>  	/*
> -	 * SCU expects the input size for watchdog IPC to
> -	 * be based on 4 bytes
> +	 * SCU expects the input size for watchdog IPC to be 2 which is the
> +	 * size of the structure in dwords. SCU IPC normally takes bytes
> +	 * but this is a special case where we specify size to be different
> +	 * than inlen.
>  	 */
>  	in_size = DIV_ROUND_UP(sizeof(ipc_wd_start), 4);
>  
> -	ret = wdt_command(SCU_WATCHDOG_START, (u32 *)&ipc_wd_start, in_size);
> +	ret = wdt_command(mid, SCU_WATCHDOG_START, &ipc_wd_start,
> +			  sizeof(ipc_wd_start), in_size);
>  	if (ret)
> -		dev_crit(dev, "error starting watchdog: %d\n", ret);
> +		dev_crit(mid->dev, "error starting watchdog: %d\n", ret);
>  
>  	return ret;
>  }
>  
>  static int wdt_ping(struct watchdog_device *wd)
>  {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>  	int ret;
>  
> -	ret = wdt_command(SCU_WATCHDOG_KEEPALIVE, NULL, 0);
> +	ret = wdt_command(mid, SCU_WATCHDOG_KEEPALIVE, NULL, 0, 0);
>  	if (ret)
> -		dev_crit(dev, "Error executing keepalive: %d\n", ret);
> +		dev_crit(mid->dev, "Error executing keepalive: %d\n", ret);
>  
>  	return ret;
>  }
>  
>  static int wdt_stop(struct watchdog_device *wd)
>  {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>  	int ret;
>  
> -	ret = wdt_command(SCU_WATCHDOG_STOP, NULL, 0);
> +	ret = wdt_command(mid, SCU_WATCHDOG_STOP, NULL, 0, 0);
>  	if (ret)
> -		dev_crit(dev, "Error stopping watchdog: %d\n", ret);
> +		dev_crit(mid->dev, "Error stopping watchdog: %d\n", ret);
>  
>  	return ret;
>  }
> @@ -110,6 +123,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct watchdog_device *wdt_dev;
>  	struct intel_mid_wdt_pdata *pdata = dev->platform_data;
> +	struct mid_wdt *mid;
>  	int ret;
>  
>  	if (!pdata) {
> @@ -123,10 +137,13 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	wdt_dev = devm_kzalloc(dev, sizeof(*wdt_dev), GFP_KERNEL);
> -	if (!wdt_dev)
> +	mid = devm_kzalloc(dev, sizeof(*mid), GFP_KERNEL);
> +	if (!mid)
>  		return -ENOMEM;
>  
> +	mid->dev = dev;
> +	wdt_dev = &mid->wd;
> +
>  	wdt_dev->info = &mid_wdt_info;
>  	wdt_dev->ops = &mid_wdt_ops;
>  	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
> @@ -135,7 +152,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  	wdt_dev->parent = dev;
>  
>  	watchdog_set_nowayout(wdt_dev, WATCHDOG_NOWAYOUT);
> -	watchdog_set_drvdata(wdt_dev, dev);
> +	watchdog_set_drvdata(wdt_dev, mid);
>  
>  	ret = devm_request_irq(dev, pdata->irq, mid_wdt_irq,
>  			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
> @@ -145,6 +162,10 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	mid->scu = devm_intel_scu_ipc_dev_get(dev);
> +	if (!mid->scu)
> +		return -EPROBE_DEFER;
> +
>  	/*
>  	 * The firmware followed by U-Boot leaves the watchdog running
>  	 * with the default threshold which may vary. When we get here
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


