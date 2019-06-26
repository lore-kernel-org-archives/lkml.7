Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73328C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483DC20659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfFZJ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:26:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:60498 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZJ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:26:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 02:26:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="164291206"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2019 02:26:02 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hg4Bl-0005Og-Ul; Wed, 26 Jun 2019 12:26:01 +0300
Date:   Wed, 26 Jun 2019 12:26:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190626092601.GH9224@smile.fi.intel.com>
References: <20190612101945.55065-1-andriy.shevchenko@linux.intel.com>
 <20190624161348.GB21119@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624161348.GB21119@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:13:48PM +0100, Lee Jones wrote:
> On Wed, 12 Jun 2019, Andy Shevchenko wrote:
> 
> > Add an MFD driver for Intel Merrifield Basin Cove PMIC.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > - updated copyright year to be 2019
> > - rebased on top of latest vanilla rc
> > 
> >  drivers/mfd/Kconfig                      |  11 ++
> >  drivers/mfd/Makefile                     |   1 +
> >  drivers/mfd/intel_soc_pmic_mrfld.c       | 157 +++++++++++++++++++++++
> >  include/linux/mfd/intel_soc_pmic_mrfld.h |  81 ++++++++++++
> >  4 files changed, 250 insertions(+)
> >  create mode 100644 drivers/mfd/intel_soc_pmic_mrfld.c
> >  create mode 100644 include/linux/mfd/intel_soc_pmic_mrfld.h
> 
> [...]
> 
> > +static int bcove_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct intel_soc_pmic *pmic;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> > +	if (!pmic)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, pmic);
> > +	pmic->dev = &pdev->dev;
> > +
> > +	pmic->regmap = devm_regmap_init(dev, NULL, pmic, &bcove_regmap_config);
> > +	if (IS_ERR(pmic->regmap))
> > +		return PTR_ERR(pmic->regmap);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> > +		ret = platform_get_irq(pdev, i);
> 
> If you already know the order, define the children's device IDs in the
> parent's shared header ('intel_soc_pmic_mrfld.h'?) and retreive them
> like:
> 
>   platform_get_irq(pdev->parent, <SUITABLE_DEFINED_ID>);
> 
> Then you can skip all of this platform device -> platform device hoop
> jumping.

The idea of MFD is to get children to be parent agnostic
(at least to some extent). What you are proposing here
seems like disadvantage from MFD philosophy. No?


-- 
With Best Regards,
Andy Shevchenko


