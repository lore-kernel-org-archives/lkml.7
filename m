Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A547C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1B320720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgAHRc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:32:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:8572 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbgAHRc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:32:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:32:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="271885676"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jan 2020 09:32:46 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipFCI-00062Z-J2; Wed, 08 Jan 2020 19:32:46 +0200
Date:   Wed, 8 Jan 2020 19:32:46 +0200
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
Subject: Re: [PATCH v2 27/36] mfd: intel_soc_pmic_bxtwc: Convert to use new
 SCU IPC API
Message-ID: <20200108173246.GY32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-28-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-28-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:52PM +0300, Mika Westerberg wrote:
> Convert the Intel Broxton Whiskey Cover PMIC driver to use the new SCU
> IPC API. This allows us to get rid of the PMC IPC implementation which
> is now covered in SCU IPC driver.
> 
> Also move PMIC specific IPC message constants to the PMIC driver from
> the intel_pmc_ipc.h header.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h |  3 ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c   | 22 +++++++++++++++-------
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
> index e6da1ce26256..b438a488f613 100644
> --- a/arch/x86/include/asm/intel_pmc_ipc.h
> +++ b/arch/x86/include/asm/intel_pmc_ipc.h
> @@ -3,9 +3,6 @@
>  #define  _ASM_X86_INTEL_PMC_IPC_H_
>  
>  /* Commands */
> -#define PMC_IPC_PMIC_ACCESS		0xFF
> -#define		PMC_IPC_PMIC_ACCESS_READ	0x0
> -#define		PMC_IPC_PMIC_ACCESS_WRITE	0x1
>  #define PMC_IPC_USB_PWR_CTRL		0xF0
>  #define PMC_IPC_PMIC_BLACKLIST_SEL	0xEF
>  #define PMC_IPC_PHY_CONFIG		0xEE
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index 739cfb5b69fe..60aba2a1561c 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -15,7 +15,7 @@
>  #include <linux/mfd/intel_soc_pmic_bxtwc.h>
>  #include <linux/module.h>
>  
> -#include <asm/intel_pmc_ipc.h>
> +#include <asm/intel_scu_ipc.h>
>  
>  /* PMIC device registers */
>  #define REG_ADDR_MASK		0xFF00
> @@ -58,6 +58,10 @@
>  /* Whiskey Cove PMIC share same ACPI ID between different platforms */
>  #define BROXTON_PMIC_WC_HRV	4
>  
> +#define PMC_PMIC_ACCESS		0xFF
> +#define PMC_PMIC_READ		0x0
> +#define PMC_PMIC_WRITE		0x1
> +
>  enum bxtwc_irqs {
>  	BXTWC_PWRBTN_LVL1_IRQ = 0,
>  	BXTWC_TMU_LVL1_IRQ,
> @@ -288,9 +292,9 @@ static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
>  
>  	ipc_in[0] = reg;
>  	ipc_in[1] = i2c_addr;
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
> -			PMC_IPC_PMIC_ACCESS_READ,
> -			ipc_in, sizeof(ipc_in), (u32 *)ipc_out, 1);
> +	ret = intel_scu_ipc_dev_command(pmic->scu, PMC_PMIC_ACCESS,
> +					PMC_PMIC_READ, ipc_in, sizeof(ipc_in),
> +					ipc_out, sizeof(ipc_out));
>  	if (ret) {
>  		dev_err(pmic->dev, "Failed to read from PMIC\n");
>  		return ret;
> @@ -321,9 +325,9 @@ static int regmap_ipc_byte_reg_write(void *context, unsigned int reg,
>  	ipc_in[0] = reg;
>  	ipc_in[1] = i2c_addr;
>  	ipc_in[2] = val;
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
> -			PMC_IPC_PMIC_ACCESS_WRITE,
> -			ipc_in, sizeof(ipc_in), NULL, 0);
> +	ret = intel_scu_ipc_dev_command(pmic->scu, PMC_PMIC_ACCESS,
> +					PMC_PMIC_WRITE, ipc_in, sizeof(ipc_in),
> +					NULL, 0);
>  	if (ret) {
>  		dev_err(pmic->dev, "Failed to write to PMIC\n");
>  		return ret;
> @@ -457,6 +461,10 @@ static int bxtwc_probe(struct platform_device *pdev)
>  	dev_set_drvdata(&pdev->dev, pmic);
>  	pmic->dev = &pdev->dev;
>  
> +	pmic->scu = devm_intel_scu_ipc_dev_get(&pdev->dev);
> +	if (!pmic->scu)
> +		return -EPROBE_DEFER;
> +
>  	pmic->regmap = devm_regmap_init(&pdev->dev, NULL, pmic,
>  					&bxtwc_regmap_config);
>  	if (IS_ERR(pmic->regmap)) {
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


