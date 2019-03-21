Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DFDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8CC218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfCUP4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:56:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:46957 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfCUP4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:56:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 08:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="124672687"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 21 Mar 2019 08:56:02 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h702z-00062I-Ie; Thu, 21 Mar 2019 17:56:01 +0200
Date:   Thu, 21 Mar 2019 17:56:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel_soc_pmic_bxtwc: Add device for the I2C master
Message-ID: <20190321155601.GP9224@smile.fi.intel.com>
References: <20190321144122.88484-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321144122.88484-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:41:22PM +0300, Heikki Krogerus wrote:
> Intel WhiskeyCove PMIC has also I2C master interface that is
> designed to be used for controlling a discrete battery
> charger IC.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index 03fe33882441..52885e2c0d85 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -84,6 +84,7 @@ enum bxtwc_irqs_adc {
>  
>  enum bxtwc_irqs_chgr {
>  	BXTWC_USBC_IRQ = 0,
> +	BXTWC_I2C_IRQ,
>  	BXTWC_CHGR0_IRQ,
>  	BXTWC_CHGR1_IRQ,
>  };
> @@ -121,7 +122,8 @@ static const struct regmap_irq bxtwc_regmap_irqs_adc[] = {
>  
>  static const struct regmap_irq bxtwc_regmap_irqs_chgr[] = {
>  	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 0, 0x20),
> -	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, 0x1f),
> +	REGMAP_IRQ_REG(BXTWC_I2C_IRQ, 0, 0x0f),
> +	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, 0x10),
>  	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 1, 0x1f),
>  };
>  
> @@ -208,6 +210,10 @@ static struct resource usbc_resources[] = {
>  	DEFINE_RES_IRQ(BXTWC_USBC_IRQ),
>  };
>  
> +static struct resource i2c_resources[] = {
> +	DEFINE_RES_IRQ(BXTWC_I2C_IRQ),
> +};
> +
>  static struct resource charger_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(BXTWC_CHGR0_IRQ, "CHARGER"),
>  	DEFINE_RES_IRQ_NAMED(BXTWC_CHGR1_IRQ, "CHARGER1"),
> @@ -241,6 +247,11 @@ static struct mfd_cell bxt_wc_dev[] = {
>  		.num_resources = ARRAY_SIZE(usbc_resources),
>  		.resources = usbc_resources,
>  	},
> +	{
> +		.name = "bxt_wcove_i2c",
> +		.num_resources = ARRAY_SIZE(i2c_resources),
> +		.resources = i2c_resources,
> +	},
>  	{
>  		.name = "bxt_wcove_ext_charger",
>  		.num_resources = ARRAY_SIZE(charger_resources),
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


