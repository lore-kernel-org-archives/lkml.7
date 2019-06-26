Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F77C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DB920644
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9cRQL0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfFZKRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:17:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40264 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZKRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:17:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so1479653wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wxuF6BcCB22Tp1U7dRAu1vlyc3DAJ417R0nKRnfw/cY=;
        b=h9cRQL0mgTQ+HmDI3xoTiV68KxdTc2pKkVZqHauc5drERA39lQlBXypAvYQMscvDmh
         zaUJyvos2Slsvj1onvXDYELmpQhVXUuYTAZhq8H/xLk80kEH/Q3wlMfRFgUxAcIvIgrZ
         k8McKnXJsIT8FkiKb+/e3fCF4eb0aIc3aUOy7pT3wVFgbeEf9qIOQ248mCbr6u3GwLk/
         rtTCxf8ecl3/Ycg0/Xl7G5P3FJndSTpnr6+ZOGahPuGqhavjAwotaOzJ+RAdAx3OHaQv
         UHU9KFBvUl9E0hGlJCKXx/FdJ9FMhXNzji4kqxhtRQDRcEir1RUhDLjIy1nfo+nUxTBH
         q0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wxuF6BcCB22Tp1U7dRAu1vlyc3DAJ417R0nKRnfw/cY=;
        b=LaDw+Q6zEAzDTFqY1IdTMeP2lkK3j54xwZRsVV5jR5jbRLzZujk6HLi78Qm1qb9aFV
         lGCTqX16FAzU+deO50/a0/I3CndQsNIrloIgRaUuIAih9YkusQ422zjjSEp/2A0MHRRG
         PoMo6MHRdz5jc5sH4Tup00rlyoZhaKsNCh/dTyv95C4blLI39Qk1YJu2X9Qk98h8m5ED
         BbSSD/NtR4XXmCmX0T/lHnU6P7CTjoQqycSFn/QWPPyzJHkCeHUkdN35L0JQS79Kr0Ea
         6vzEZNKPEUT5gM7yGBCYhZsX7w5YvL8Fe42C3GOvweVIyOTWV5leNFd4DVc/IdbAWhuS
         CJWw==
X-Gm-Message-State: APjAAAVqbpcvL1ydKey1ZeWpW2W0FEaFYSXnxtnxeZqzypgRH+XzS0ds
        bCPLn6tg37Tw7zEeWK/dQYL4GQh+fes=
X-Google-Smtp-Source: APXvYqxI8g1jjBOHPRr2TiPZ2Kcfhp2+PgnuIpz3o/dV48CisJuLONoOkqe5ymg1aDjuXnfHlOFbUw==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr2133217wmj.71.1561544249173;
        Wed, 26 Jun 2019 03:17:29 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id l12sm34629342wrb.81.2019.06.26.03.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 03:17:28 -0700 (PDT)
Date:   Wed, 26 Jun 2019 11:17:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190626101727.GN21119@dell>
References: <20190612101945.55065-1-andriy.shevchenko@linux.intel.com>
 <20190624161348.GB21119@dell>
 <20190626092601.GH9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626092601.GH9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Andy Shevchenko wrote:

> On Mon, Jun 24, 2019 at 05:13:48PM +0100, Lee Jones wrote:
> > On Wed, 12 Jun 2019, Andy Shevchenko wrote:
> > 
> > > Add an MFD driver for Intel Merrifield Basin Cove PMIC.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > - updated copyright year to be 2019
> > > - rebased on top of latest vanilla rc
> > > 
> > >  drivers/mfd/Kconfig                      |  11 ++
> > >  drivers/mfd/Makefile                     |   1 +
> > >  drivers/mfd/intel_soc_pmic_mrfld.c       | 157 +++++++++++++++++++++++
> > >  include/linux/mfd/intel_soc_pmic_mrfld.h |  81 ++++++++++++
> > >  4 files changed, 250 insertions(+)
> > >  create mode 100644 drivers/mfd/intel_soc_pmic_mrfld.c
> > >  create mode 100644 include/linux/mfd/intel_soc_pmic_mrfld.h
> > 
> > [...]
> > 
> > > +static int bcove_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct intel_soc_pmic *pmic;
> > > +	unsigned int i;
> > > +	int ret;
> > > +
> > > +	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> > > +	if (!pmic)
> > > +		return -ENOMEM;
> > > +
> > > +	platform_set_drvdata(pdev, pmic);
> > > +	pmic->dev = &pdev->dev;
> > > +
> > > +	pmic->regmap = devm_regmap_init(dev, NULL, pmic, &bcove_regmap_config);
> > > +	if (IS_ERR(pmic->regmap))
> > > +		return PTR_ERR(pmic->regmap);
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> > > +		ret = platform_get_irq(pdev, i);
> > 
> > If you already know the order, define the children's device IDs in the
> > parent's shared header ('intel_soc_pmic_mrfld.h'?) and retreive them
> > like:
> > 
> >   platform_get_irq(pdev->parent, <SUITABLE_DEFINED_ID>);
> > 
> > Then you can skip all of this platform device -> platform device hoop
> > jumping.
> 
> The idea of MFD is to get children to be parent agnostic
> (at least to some extent). What you are proposing here
> seems like disadvantage from MFD philosophy. No?

Not at all.  The idea of MFD is to split up support for monolithic h/w
such that they can be handled properly by their appropriate
subsystems, and by extension, maintained by the associated subject
matter experts.

Children are often aware of their parents (some siblings are even
aware of each other!), and many expect and depend on the data-sets
provided by their parents.

For instance (this example may come to bite me in the behind, but),
taken from this very patch, where is this consumed?

 platform_set_drvdata(pdev, pmic);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
