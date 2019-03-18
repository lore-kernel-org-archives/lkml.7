Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B817C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7586420811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfCRMq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:46:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:58428 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfCRMq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:46:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 05:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="283638091"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2019 05:46:54 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h5rfJ-0001xi-JY; Mon, 18 Mar 2019 14:46:53 +0200
Date:   Mon, 18 Mar 2019 14:46:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/2] extcon: mrfld: Introduce extcon driver for Basin
 Cove PMIC
Message-ID: <20190318124653.GS9224@smile.fi.intel.com>
References: <20190318095225.69200-1-andriy.shevchenko@linux.intel.com>
 <20190318095225.69200-2-andriy.shevchenko@linux.intel.com>
 <CGME20190318101117epcas2p246ba2571549569d1ce18b829d6579bd3@epcas2p2.samsung.com>
 <20190318101109.GP9224@smile.fi.intel.com>
 <3af26666-8913-c8bb-d2fb-64bd9ea0ec69@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af26666-8913-c8bb-d2fb-64bd9ea0ec69@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 07:38:26PM +0900, Chanwoo Choi wrote:

> Thanks for comment. I add my comments
> and then you have to rebase it on latest v5.0-rc1
> because the merge conflict happen on v5.0-rc1.

Thanks for review, see my answers below.
Non-answered items will be fixed accordingly.

> >> +config EXTCON_INTEL_MRFLD
> > 
> >> +	tristate "Intel MErrifield Basin Cove PMIC extcon driver"
> > 
> > ME -> Me (will be fixed)
> > 
> >> +	depends on INTEL_SOC_PMIC_MRFLD
> 
> This driver uses the regmap interface. So, you better to add
> following dependency?

> - select REGMAP_I2C or REGMAP_SPI

None of them fits this or MFD driver. See below.

> But, if 'INTEL_SOC_PMIC_MRFLE' selects already REGMAP_*
> configuration. It is not necessary.

https://lore.kernel.org/lkml/20190318095316.69278-1-andriy.shevchenko@linux.intel.com/

It selects REGMAP_IRQ which selects necessary bits from regmap API.

> >> +	help
> >> +	  Say Y here to enable extcon support for charger detection / control
> >> +	  on the Intel Merrifiel Basin Cove PMIC.
> 
> What is correct word?
> - Merrifield? is used on above
> - Merrifiel?

Merrifield is a correct one. Thanks for spotting this.

> >> +static int mrfld_extcon_set(struct mrfld_extcon_data *data, unsigned int reg,
> >> +			    unsigned int mask)
> >> +{
> >> +	return regmap_update_bits(data->regmap, reg, mask, 0xff);
> >> +}
> 
> mrfld_extcon_clear() and mrfld_extcon_set() are just wrapper function
> for regmap interface. I think that you better to define
> the meaningful defintion for '0x00' and '0xff' as following:
> 
> (just example, you may make the more correct name)
> #define INTEL_MRFLD_RESET	0x00
> #define INTEL_MRFLD_SET		0xff

It makes a little sense here, the idea is to reduce parameters.

I could ideally write
(..., mask, ~mask) for clear
and
(..., mask, mask) for set

> And then you better to use the 'regmap_update_bits()' function
> directly instead of mrfld_extcon_clear/set'.

It will bring duplication of long definitions and reduce readability of the
code.

> >> +	/*
> >> +	 * It seems SCU firmware clears the content of BCOVE_CHGRIRQ1
> >> +	 * and makes it useless for OS. Instead we compare a previously
> >> +	 * stored status to the current one, provided by BCOVE_SCHGRIRQ1.
> >> +	 */
> >> +	ret = regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (!(status ^ data->status))
> >> +		return -ENODATA;
> >> +
> >> +	if ((status ^ data->status) & BCOVE_CHGRIRQ_USBIDDET)
> >> +		ret = mrfld_extcon_role_detect(data);
> This line gets the return value from mrfld_extcon_role_detect(data)
> without any error handling and then the below line just saves 'status'
> to 'data->status' regardless of 'ret' value.
> 
> I think that you have to handle the error case of
> 'ret = mrfld_extcon_role_detect(data)'.

I'm not sure of the consequences of such change.
I will give it some tests, and then will proceed accordingly.

> >> +		.name	= KBUILD_MODNAME,
> 
> Where is the definition of KBUILD_MODNAME? Are you missing?

In the Makefile.
Nothing is missed here.

But I could put its content explicitly here.

-- 
With Best Regards,
Andy Shevchenko


