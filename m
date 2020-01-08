Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B19C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A06720720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgAHQn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:43:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:31611 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgAHQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:43:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="271873912"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jan 2020 08:43:54 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipER0-0005VF-1r; Wed, 08 Jan 2020 18:43:54 +0200
Date:   Wed, 8 Jan 2020 18:43:54 +0200
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
Subject: Re: [PATCH v2 15/36] platform/x86: intel_mid_powerbtn: Convert to
 use new SCU IPC API
Message-ID: <20200108164354.GF32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-16-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-16-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:40PM +0300, Mika Westerberg wrote:
> This converts the power button driver to use the new SCU IPC API where
> the SCU IPC instance is passed to the functions.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_mid_powerbtn.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_mid_powerbtn.c b/drivers/platform/x86/intel_mid_powerbtn.c
> index 6f436836fe50..1fdcdef1d89f 100644
> --- a/drivers/platform/x86/intel_mid_powerbtn.c
> +++ b/drivers/platform/x86/intel_mid_powerbtn.c
> @@ -46,6 +46,7 @@ struct mid_pb_ddata {
>  	unsigned short mirqlvl1_addr;
>  	unsigned short pbstat_addr;
>  	u8 pbstat_mask;
> +	struct intel_scu_ipc_dev *scu;
>  	int (*setup)(struct mid_pb_ddata *ddata);
>  };
>  
> @@ -55,7 +56,8 @@ static int mid_pbstat(struct mid_pb_ddata *ddata, int *value)
>  	int ret;
>  	u8 pbstat;
>  
> -	ret = intel_scu_ipc_ioread8(ddata->pbstat_addr, &pbstat);
> +	ret = intel_scu_ipc_dev_ioread8(ddata->scu, ddata->pbstat_addr,
> +					&pbstat);
>  	if (ret)
>  		return ret;
>  
> @@ -67,14 +69,15 @@ static int mid_pbstat(struct mid_pb_ddata *ddata, int *value)
>  
>  static int mid_irq_ack(struct mid_pb_ddata *ddata)
>  {
> -	return intel_scu_ipc_update_register(ddata->mirqlvl1_addr, 0, MSIC_PWRBTNM);
> +	return intel_scu_ipc_dev_update(ddata->scu, ddata->mirqlvl1_addr, 0,
> +					MSIC_PWRBTNM);
>  }
>  
>  static int mrfld_setup(struct mid_pb_ddata *ddata)
>  {
>  	/* Unmask the PBIRQ and MPBIRQ on Tangier */
> -	intel_scu_ipc_update_register(BCOVE_PBIRQ, 0, MSIC_PWRBTNM);
> -	intel_scu_ipc_update_register(BCOVE_PBIRQMASK, 0, MSIC_PWRBTNM);
> +	intel_scu_ipc_dev_update(ddata->scu, BCOVE_PBIRQ, 0, MSIC_PWRBTNM);
> +	intel_scu_ipc_dev_update(ddata->scu, BCOVE_PBIRQMASK, 0, MSIC_PWRBTNM);
>  
>  	return 0;
>  }
> @@ -161,6 +164,10 @@ static int mid_pb_probe(struct platform_device *pdev)
>  			return error;
>  	}
>  
> +	ddata->scu = devm_intel_scu_ipc_dev_get(&pdev->dev);
> +	if (!ddata->scu)
> +		return -EPROBE_DEFER;
> +
>  	error = devm_request_threaded_irq(&pdev->dev, irq, NULL, mid_pb_isr,
>  					  IRQF_ONESHOT, DRIVER_NAME, ddata);
>  	if (error) {
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


