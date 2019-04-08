Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD4020883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDHMnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:43:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:54700 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfDHMnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:43:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 05:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="140989814"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2019 05:43:49 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDTcq-0007je-7w; Mon, 08 Apr 2019 15:43:48 +0300
Date:   Mon, 8 Apr 2019 15:43:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Binbin Wu <binbin.wu@intel.com>
Cc:     mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] pinctrl: pinctrl-intel: move gpio suspend/resume to
 noirq phase
Message-ID: <20190408124348.GQ9224@smile.fi.intel.com>
References: <1554720566-29103-1-git-send-email-binbin.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554720566-29103-1-git-send-email-binbin.wu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 06:49:26PM +0800, Binbin Wu wrote:
> In current driver, SET_LATE_SYSTEM_SLEEP_PM_OPS is used to install the
> callbacks for suspend/resume.
> GPIO pin may be used as the interrupt pin by some device. However, using
> SET_LATE_SYSTEM_SLEEP_PM_OPS() to install the callbacks, the resume
> callback is called after resume_device_irqs(). Unintended interrupts may
> arrive due to resuming device irqs first, but the GPIO controller is not
> properly restored.
> 
> Normally, for a SMP system, there are multiple cores, so even when there are
> unintended interrupts, BSP gets the chance to init the gpio chip soon.

gpio -> GPIO.
(If Mika is okay with patch content, I may fix this when applying)

> But when there is only 1 core is active (other cores are offlined or
> single core) during resume, it is more easily to observe the unintended
> interrupts.
> 
> This patch renames the suspend/resume function by adding suffix "_noirq",
> and installs the callbacks using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS().
> 
> Signed-off-by: Binbin Wu <binbin.wu@intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c |  8 ++++----
>  drivers/pinctrl/intel/pinctrl-intel.h | 11 ++++++-----
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index 3b18181..70638b7 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -1466,7 +1466,7 @@ static bool intel_pinctrl_should_save(struct intel_pinctrl *pctrl, unsigned int
>  	return false;
>  }
>  
> -int intel_pinctrl_suspend(struct device *dev)
> +int intel_pinctrl_suspend_noirq(struct device *dev)
>  {
>  	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
>  	struct intel_community_context *communities;
> @@ -1505,7 +1505,7 @@ int intel_pinctrl_suspend(struct device *dev)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(intel_pinctrl_suspend);
> +EXPORT_SYMBOL_GPL(intel_pinctrl_suspend_noirq);
>  
>  static void intel_gpio_irq_init(struct intel_pinctrl *pctrl)
>  {
> @@ -1527,7 +1527,7 @@ static void intel_gpio_irq_init(struct intel_pinctrl *pctrl)
>  	}
>  }
>  
> -int intel_pinctrl_resume(struct device *dev)
> +int intel_pinctrl_resume_noirq(struct device *dev)
>  {
>  	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
>  	const struct intel_community_context *communities;
> @@ -1589,7 +1589,7 @@ int intel_pinctrl_resume(struct device *dev)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(intel_pinctrl_resume);
> +EXPORT_SYMBOL_GPL(intel_pinctrl_resume_noirq);
>  #endif
>  
>  MODULE_AUTHOR("Mathias Nyman <mathias.nyman@linux.intel.com>");
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
> index b8a07d37..a8e958f 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.h
> +++ b/drivers/pinctrl/intel/pinctrl-intel.h
> @@ -177,13 +177,14 @@ int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
>  int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
>  
>  #ifdef CONFIG_PM_SLEEP
> -int intel_pinctrl_suspend(struct device *dev);
> -int intel_pinctrl_resume(struct device *dev);
> +int intel_pinctrl_suspend_noirq(struct device *dev);
> +int intel_pinctrl_resume_noirq(struct device *dev);
>  #endif
>  
> -#define INTEL_PINCTRL_PM_OPS(_name)						  \
> -const struct dev_pm_ops _name = {						  \
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend, intel_pinctrl_resume) \
> +#define INTEL_PINCTRL_PM_OPS(_name)					\
> +const struct dev_pm_ops _name = {					\
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq,	\
> +				      intel_pinctrl_resume_noirq)	\
>  }
>  
>  #endif /* PINCTRL_INTEL_H */
> -- 
> 2.7.4
> 

-- 
With Best Regards,
Andy Shevchenko


