Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A340A20449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuA7itUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDDHED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:04:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36712 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDHEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:04:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck15so693434plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BkD4wCUM/M4wEOwKV9+kUowLc443t/sZzP07s4Zp0tE=;
        b=iuA7itURIH0+AmRaZx7z/Dx2/CsYzRrj806z6UOKcpx/njFFRLQZXt8Y2eYhIPSA3W
         brI/ne47IOXC1NN5XYZKRNEKHUMEDD/2MOl3b80ic4avtBWYJOWsagiT52YzJUavqoLY
         Jmde/nc9/wGxJPg/tg1WOZsypNdefyxdvklcKlVw1WzHuYLBIqPQtr985I6QZ9NrvEML
         nBTg12x2dCUkTc8ni5RpDkkAVhPCvARHobwa52hqf/WE7HxNkk5trYFMuzKuVOyOxVJC
         3kGJW2Zh9sLBmb5UcktF0CXgY3uinzxGefw+23AxU3Lv4NgfmwPpgh2uGeufFcMWVL/z
         xxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BkD4wCUM/M4wEOwKV9+kUowLc443t/sZzP07s4Zp0tE=;
        b=S6w62EIPAR+m13+bx44l+wRRq4ZEZsYOZF5ef02V9I1AxhgxsY4klbn9fIgHmB8JVp
         otq986LwUJ4sScWOFEUmA38Cic9zztpFDQG4xHc5VtzbQ3BYmPazUIRQLPSDtX7HMje2
         +neo+onHWZKF5SemAaf+BhoQv78cl3P110+am+2CqIFzdAtdC8Z7AWMx7Rg3Hk7LMzbm
         kiUiMW7VH5warpg+IiaGerbbeDF4RMpo2T37NoRqR1gsMspwDR4LJ6+CRpQSYgXdZ/6f
         /6C2EgdmGyEZXVWAp/yjn3dmKcUXS14AR28u6odohQax/9cE6aokcC99/YoTQ/s9V+bp
         u+GQ==
X-Gm-Message-State: APjAAAVp/SO7dvRCLi1MFXYRXPv9EU19wJ6Nl8fGNr1jcRYedQgmQTF7
        9/S1wE84S+y7iteTFUTOryQi9w==
X-Google-Smtp-Source: APXvYqzGPk0mYCT8LvCrMfSdtcPptAqQGQL7XOA36nzFhj+rXO6EM8UfheGV+bTXzjFTG/G8RWl7mw==
X-Received: by 2002:a17:902:1002:: with SMTP id b2mr4756438pla.248.1554361441767;
        Thu, 04 Apr 2019 00:04:01 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id z129sm40277922pfz.103.2019.04.04.00.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:04:00 -0700 (PDT)
Date:   Thu, 4 Apr 2019 08:03:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190404070357.GF6830@dell>
References: <20190318095316.69278-1-andriy.shevchenko@linux.intel.com>
 <20190402051211.GR4187@dell>
 <20190402122001.GM9224@smile.fi.intel.com>
 <20190404070004.GE6830@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404070004.GE6830@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019, Lee Jones wrote:

> On Tue, 02 Apr 2019, Andy Shevchenko wrote:
> 
> > On Tue, Apr 02, 2019 at 06:12:11AM +0100, Lee Jones wrote:
> > > On Mon, 18 Mar 2019, Andy Shevchenko wrote:
> > > 
> > > > Add an mfd driver for Intel Merrifield Basin Cove PMIC.
> > > 
> > > Nit: s/mfd/MFD/
> > 
> > Noted. And changed for v2.
> > 
> > > > +static const struct mfd_cell bcove_dev[] = {
> > > > +	{
> > > > +		.name = "mrfld_bcove_pwrbtn",
> > > > +		.num_resources = 1,
> > > > +		.resources = &irq_level2_resources[0],
> > > > +	}, {
> > > > +		.name = "mrfld_bcove_tmu",
> > > > +		.num_resources = 1,
> > > > +		.resources = &irq_level2_resources[1],
> > > > +	}, {
> > > > +		.name = "mrfld_bcove_thermal",
> > > > +		.num_resources = 1,
> > > > +		.resources = &irq_level2_resources[2],
> > > > +	}, {
> > > > +		.name = "mrfld_bcove_bcu",
> > > > +		.num_resources = 1,
> > > > +		.resources = &irq_level2_resources[3],
> > > > +	}, {
> > > > +		.name = "mrfld_bcove_adc",
> > > > +		.num_resources = 1,
> > > > +		.resources = &irq_level2_resources[4],
> > > > +	}, {
> > > > +		.name = "mrfld_bcove_charger",
> > > > +		.num_resources = 1,
> > > > +		.resources = &irq_level2_resources[5],
> > > > +	}, {
> > > > +		.name = "mrfld_bcove_extcon",
> > > > +		.num_resources = 1,
> > > > +		.resources = &irq_level2_resources[5],
> > > > +	}, {
> > > > +		.name = "mrfld_bcove_gpio",
> > > > +		.num_resources = 1,
> > > > +		.resources = &irq_level2_resources[6],
> > > > +	},
> > > > +	{	.name = "mrfld_bcove_region", },
> > > > +};
> > 
> > > > +static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
> > > 
> > > Prefixing these with regmap is pretty confusing, since this it not
> > > part of the Regmap API.  Better to provide them with local names
> > > instead.
> > > 
> > >   bcove_ipc_byte_reg_read()
> > 
> > Good point. And changed for v2.
> > 
> > > > +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> > > > +		ret = platform_get_irq(pdev, i);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +
> > > > +		irq_level2_resources[i].start = ret;
> > > > +		irq_level2_resources[i].end = ret;
> > > > +	}
> > > 
> > > Although succinct, dragging values from one platform device into
> > > another doesn't sound that neat.
> > 
> > So, how to split resources given in one _physical_ multi-functional device to
> > several of them?  Isn't it what MFD framework for?
> > 
> > Any other approach here? I'm all ears!
> 
> From the child:
> 
>   platform_get_irq(dev->parent, CLIENT_ID);

If you set the .id of the cell properly you could do:

  platform_get_irq(dev->parent, dev->id);

> > > Also, since the ordering of the
> > > devices is critical in this implementation, it also comes across as
> > > fragile.
> > 
> > How fragile? In ACPI we don't have IRQ labeling scheme. Index is used for that.
> > 
> > > Any reason why ACPI can't register all of the child devices, or for
> > > the child devices to obtain their IRQ directly from the tables?
> > 
> > And how are we supposed to enumerated them taking into consideration single
> > ACPI ID given?
> 
> This question was a little whimsical, since I have no idea how the
> ACPI tables you're working with are laid out.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
