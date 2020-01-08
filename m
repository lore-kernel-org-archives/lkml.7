Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D1C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF775206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgAHR2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:28:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:26056 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbgAHR2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:28:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="225940503"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jan 2020 09:28:25 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipF85-0005yq-Cs; Wed, 08 Jan 2020 19:28:25 +0200
Date:   Wed, 8 Jan 2020 19:28:25 +0200
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
Subject: Re: [PATCH v2 24/36] platform/x86: intel_scu_ipc: Add function to
 remove SCU IPC
Message-ID: <20200108172825.GV32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-25-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-25-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:49PM +0300, Mika Westerberg wrote:
> Drivers such as intel_pmc_ipc.c can be unloaded as well so in order to
> support those in this driver add a new function that can be called to
> remove the SCU IPC if the driver is unloaded.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_scu_ipc.h |  1 +
>  drivers/platform/x86/intel_scu_ipc.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
> index 9895b60386c5..250127eb1e38 100644
> --- a/arch/x86/include/asm/intel_scu_ipc.h
> +++ b/arch/x86/include/asm/intel_scu_ipc.h
> @@ -32,6 +32,7 @@ struct intel_scu_ipc_pdata {
>  
>  struct intel_scu_ipc_dev *
>  intel_scu_ipc_probe(struct device *dev, const struct intel_scu_ipc_pdata *pdata);
> +void intel_scu_ipc_remove(struct intel_scu_ipc_dev *scu);
>  
>  struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void);
>  void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu);
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index cc29f504adcf..9fa0ea95198b 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -566,3 +566,21 @@ intel_scu_ipc_probe(struct device *dev, const struct intel_scu_ipc_pdata *pdata)
>  	return scu;
>  }
>  EXPORT_SYMBOL_GPL(intel_scu_ipc_probe);
> +
> +/**
> + * intel_scu_ipc_remove() - Remove SCU IPC
> + * @scu: SCU IPC handle
> + *
> + * This unregisters the SCU IPC device and releases the interrupt.
> + */
> +void intel_scu_ipc_remove(struct intel_scu_ipc_dev *scu)
> +{
> +	mutex_lock(&ipclock);
> +	if (!WARN_ON(!scu->dev)) {
> +		if (scu->irq > 0)
> +			devm_free_irq(scu->dev, scu->irq, scu);
> +		scu->dev = NULL;
> +	}
> +	mutex_unlock(&ipclock);
> +}
> +EXPORT_SYMBOL_GPL(intel_scu_ipc_remove);
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


