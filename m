Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0B620882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfDBMUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:20:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:64005 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfDBMUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:20:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 05:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,300,1549958400"; 
   d="scan'208";a="332997269"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2019 05:20:02 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBIOX-0008Cs-10; Tue, 02 Apr 2019 15:20:01 +0300
Date:   Tue, 2 Apr 2019 15:20:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190402122001.GM9224@smile.fi.intel.com>
References: <20190318095316.69278-1-andriy.shevchenko@linux.intel.com>
 <20190402051211.GR4187@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402051211.GR4187@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:12:11AM +0100, Lee Jones wrote:
> On Mon, 18 Mar 2019, Andy Shevchenko wrote:
> 
> > Add an mfd driver for Intel Merrifield Basin Cove PMIC.
> 
> Nit: s/mfd/MFD/

Noted. And changed for v2.

> > +static const struct mfd_cell bcove_dev[] = {
> > +	{
> > +		.name = "mrfld_bcove_pwrbtn",
> > +		.num_resources = 1,
> > +		.resources = &irq_level2_resources[0],
> > +	}, {
> > +		.name = "mrfld_bcove_tmu",
> > +		.num_resources = 1,
> > +		.resources = &irq_level2_resources[1],
> > +	}, {
> > +		.name = "mrfld_bcove_thermal",
> > +		.num_resources = 1,
> > +		.resources = &irq_level2_resources[2],
> > +	}, {
> > +		.name = "mrfld_bcove_bcu",
> > +		.num_resources = 1,
> > +		.resources = &irq_level2_resources[3],
> > +	}, {
> > +		.name = "mrfld_bcove_adc",
> > +		.num_resources = 1,
> > +		.resources = &irq_level2_resources[4],
> > +	}, {
> > +		.name = "mrfld_bcove_charger",
> > +		.num_resources = 1,
> > +		.resources = &irq_level2_resources[5],
> > +	}, {
> > +		.name = "mrfld_bcove_extcon",
> > +		.num_resources = 1,
> > +		.resources = &irq_level2_resources[5],
> > +	}, {
> > +		.name = "mrfld_bcove_gpio",
> > +		.num_resources = 1,
> > +		.resources = &irq_level2_resources[6],
> > +	},
> > +	{	.name = "mrfld_bcove_region", },
> > +};

> > +static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
> 
> Prefixing these with regmap is pretty confusing, since this it not
> part of the Regmap API.  Better to provide them with local names
> instead.
> 
>   bcove_ipc_byte_reg_read()

Good point. And changed for v2.

> > +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> > +		ret = platform_get_irq(pdev, i);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		irq_level2_resources[i].start = ret;
> > +		irq_level2_resources[i].end = ret;
> > +	}
> 
> Although succinct, dragging values from one platform device into
> another doesn't sound that neat.

So, how to split resources given in one _physical_ multi-functional device to
several of them?  Isn't it what MFD framework for?

Any other approach here? I'm all ears!

> Also, since the ordering of the
> devices is critical in this implementation, it also comes across as
> fragile.

How fragile? In ACPI we don't have IRQ labeling scheme. Index is used for that.

> Any reason why ACPI can't register all of the child devices, or for
> the child devices to obtain their IRQ directly from the tables?

And how are we supposed to enumerated them taking into consideration single
ACPI ID given?

-- 
With Best Regards,
Andy Shevchenko


