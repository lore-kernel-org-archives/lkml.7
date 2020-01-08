Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880BBC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B264206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgAHRft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:35:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:49567 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgAHRfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:35:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="395811677"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2020 09:35:42 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipFF6-00064R-VV; Wed, 08 Jan 2020 19:35:40 +0200
Date:   Wed, 8 Jan 2020 19:35:40 +0200
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
Subject: Re: [PATCH v2 28/36] mfd: intel_soc_pmic_mrfld: Convert to use new
 SCU IPC API
Message-ID: <20200108173540.GA32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-29-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-29-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:53PM +0300, Mika Westerberg wrote:
> This converts the Intel Merrifield PMIC driver over the new SCU IPC API
> where the SCU IPC instance is passed to the functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_mrfld.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_mrfld.c b/drivers/mfd/intel_soc_pmic_mrfld.c
> index 26a1551c5faf..bd94c989d232 100644
> --- a/drivers/mfd/intel_soc_pmic_mrfld.c
> +++ b/drivers/mfd/intel_soc_pmic_mrfld.c
> @@ -74,10 +74,11 @@ static const struct mfd_cell bcove_dev[] = {
>  static int bcove_ipc_byte_reg_read(void *context, unsigned int reg,
>  				    unsigned int *val)
>  {
> +	struct intel_soc_pmic *pmic = context;
>  	u8 ipc_out;
>  	int ret;
>  
> -	ret = intel_scu_ipc_ioread8(reg, &ipc_out);
> +	ret = intel_scu_ipc_dev_ioread8(pmic->scu, reg, &ipc_out);
>  	if (ret)
>  		return ret;
>  
> @@ -88,10 +89,11 @@ static int bcove_ipc_byte_reg_read(void *context, unsigned int reg,
>  static int bcove_ipc_byte_reg_write(void *context, unsigned int reg,
>  				     unsigned int val)
>  {
> +	struct intel_soc_pmic *pmic = context;
>  	u8 ipc_in = val;
>  	int ret;
>  
> -	ret = intel_scu_ipc_iowrite8(reg, ipc_in);
> +	ret = intel_scu_ipc_dev_iowrite8(pmic->scu, reg, ipc_in);
>  	if (ret)
>  		return ret;
>  
> @@ -117,6 +119,10 @@ static int bcove_probe(struct platform_device *pdev)
>  	if (!pmic)
>  		return -ENOMEM;
>  
> +	pmic->scu = devm_intel_scu_ipc_dev_get(dev);
> +	if (!pmic->scu)
> +		return -ENOMEM;
> +
>  	platform_set_drvdata(pdev, pmic);
>  	pmic->dev = &pdev->dev;
>  
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


