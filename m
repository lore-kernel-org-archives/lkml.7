Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F8C21741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UelHzHqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfDDJDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33702 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbfDDJDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so923055pgh.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FHPP9nWlqDOPlcosk5yuZBJwdP9D5eNil7nDje7cllA=;
        b=UelHzHqF+DfaJL4sJJlgzhaLNOQqOhoDgir1ySbgsv/4bzRD9VR/AwhYtJKlXdg6Ff
         DynDvj2NoScSlWYPZ+DUAte+WtCXUQkgTcBgZDeKQElWaLLBWsCAkoFALVrLKHW3ea+q
         UGgzY5B9WG0qgQa4sAmAjnJYvUD805RfyvS8DjVlC6+rBzjjwX2CLW0uX9PPUemoXPwV
         NuFx5aD5vLnzkByUsJ/ohiytvj7LqjYR8rg0yVbGJ2mgyBtsSFEdN5vQWI7CCJdeO6CX
         baVbEfrYe6r1CfAtvWVGRgeS2k9bCFdMJ+HeVzcrQPW/OgFmXow1zuv5TjBFVbkhbnyX
         qMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FHPP9nWlqDOPlcosk5yuZBJwdP9D5eNil7nDje7cllA=;
        b=ZTZFpSqXsDwhEAQJEV1DBwzzL+b3bRdjQfnximX0fvRnQSbmnEQJimPq9AP3NZHk3O
         0v+IVGli5Umvv3RjCWVBJUGRcsRc9SgcWhNOGnklP37Q5PimtAUOyPicj4pySqSY9ypx
         RPQRKR1kQbzXkxLwkvA/tq4lbbOtpElTYpx6lcoIjZFZQu8ya+Zg0g1Ptl3Pcg8jVD2x
         YGSgsEyLY65P5ctKlJVybwuybBT8dsNmEo9hqzgHgqVJwZACis6rcZMnE5Mj4E53QI9x
         SKPQDKddRJlp0umfK/kyMfhdi3U8ajj35lnpjjL2S65J20g1HrOvTubwbytHHisIUrKA
         JUmA==
X-Gm-Message-State: APjAAAUcEyXxxhhyHxDbR8qrE9vEPA6qaWP5hN+hb/j7mHqKAbaTgwm+
        ySk6nXrX+lPZDwaQ/CCnI6tuWZHJMdpNog==
X-Google-Smtp-Source: APXvYqwDQsCCjb/36g8/DkzRLfsT5EViXvmzHhTMGoeEgw6JZgn6UfdtQXwkiZcjo7Na4QI+G5dkAA==
X-Received: by 2002:a62:6e05:: with SMTP id j5mr4493623pfc.5.1554368599979;
        Thu, 04 Apr 2019 02:03:19 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id f63sm18405632pfc.180.2019.04.04.02.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:03:18 -0700 (PDT)
Date:   Thu, 4 Apr 2019 10:03:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190404090314.GT6830@dell>
References: <20190318095316.69278-1-andriy.shevchenko@linux.intel.com>
 <20190402051211.GR4187@dell>
 <20190402122001.GM9224@smile.fi.intel.com>
 <20190404070004.GE6830@dell>
 <20190404070357.GF6830@dell>
 <20190404082138.GF9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404082138.GF9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019, Andy Shevchenko wrote:

> On Thu, Apr 04, 2019 at 08:03:57AM +0100, Lee Jones wrote:
> > On Thu, 04 Apr 2019, Lee Jones wrote:
> > > On Tue, 02 Apr 2019, Andy Shevchenko wrote:
> > > > On Tue, Apr 02, 2019 at 06:12:11AM +0100, Lee Jones wrote:
> > > > > On Mon, 18 Mar 2019, Andy Shevchenko wrote:
> 
> > > > > > +static const struct mfd_cell bcove_dev[] = {
> > > > > > +	{
> > > > > > +		.name = "mrfld_bcove_pwrbtn",
> > > > > > +		.num_resources = 1,
> > > > > > +		.resources = &irq_level2_resources[0],
> > > > > > +	}, {
> > > > > > +		.name = "mrfld_bcove_tmu",
> > > > > > +		.num_resources = 1,
> > > > > > +		.resources = &irq_level2_resources[1],
> > > > > > +	}, {
> > > > > > +		.name = "mrfld_bcove_thermal",
> > > > > > +		.num_resources = 1,
> > > > > > +		.resources = &irq_level2_resources[2],
> > > > > > +	}, {
> > > > > > +		.name = "mrfld_bcove_bcu",
> > > > > > +		.num_resources = 1,
> > > > > > +		.resources = &irq_level2_resources[3],
> > > > > > +	}, {
> > > > > > +		.name = "mrfld_bcove_adc",
> > > > > > +		.num_resources = 1,
> > > > > > +		.resources = &irq_level2_resources[4],
> > > > > > +	}, {
> > > > > > +		.name = "mrfld_bcove_charger",
> > > > > > +		.num_resources = 1,
> > > > > > +		.resources = &irq_level2_resources[5],
> > > > > > +	}, {
> > > > > > +		.name = "mrfld_bcove_extcon",
> > > > > > +		.num_resources = 1,
> > > > > > +		.resources = &irq_level2_resources[5],
> > > > > > +	}, {
> > > > > > +		.name = "mrfld_bcove_gpio",
> > > > > > +		.num_resources = 1,
> > > > > > +		.resources = &irq_level2_resources[6],
> > > > > > +	},
> > > > > > +	{	.name = "mrfld_bcove_region", },
> > > > > > +};
> 
> > > > > > +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> > > > > > +		ret = platform_get_irq(pdev, i);
> > > > > > +		if (ret < 0)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		irq_level2_resources[i].start = ret;
> > > > > > +		irq_level2_resources[i].end = ret;
> > > > > > +	}
> > > > > 
> > > > > Although succinct, dragging values from one platform device into
> > > > > another doesn't sound that neat.
> > > > 
> > > > So, how to split resources given in one _physical_ multi-functional device to
> > > > several of them?  Isn't it what MFD framework for?
> > > > 
> > > > Any other approach here? I'm all ears!
> > > 
> > > From the child:
> > > 
> > >   platform_get_irq(dev->parent, CLIENT_ID);
> 
> So, instead of keeping a fragile approach in one driver, we will spread this
> to all of them.

No, the fragileness goes away with implicit definitions of IDs.

> > If you set the .id of the cell properly you could do:
> > 
> >   platform_get_irq(dev->parent, dev->id);
> 
> This will bring a confuse, ID is used to form an instance name, for now
> we don't have several instances of any of the devices from PMIC.

That is true.  It is probably an abuse of the API. :)

I'm just floating ideas.

> On top of above, some of the resources (one already, others might be a case in
> the future) is split between two drivers, which would bring even more confusion
> to the entire picture.

I don't see any indication in the code that 2 platform devices can't
share the same .id value.  But again, this is probably academic since
abusing the API should probably be avoided in general.

> > > > > Also, since the ordering of the
> > > > > devices is critical in this implementation, it also comes across as
> > > > > fragile.
> > > > 
> > > > How fragile? In ACPI we don't have IRQ labeling scheme. Index is used for that.
> > > > 
> > > > > Any reason why ACPI can't register all of the child devices, or for
> > > > > the child devices to obtain their IRQ directly from the tables?
> > > > 
> > > > And how are we supposed to enumerated them taking into consideration single
> > > > ACPI ID given?
> > > 
> > > This question was a little whimsical, since I have no idea how the
> > > ACPI tables you're working with are laid out.
> 
> There is one device node with several IRQ and other resources.
> In pseudo code:
> 
> 	device node {
> 		device ID,
> 		IRQ 0,
> 		IRQ 1,
> 		...
> 		MMIO 0,
> 		...
> 	}

Sure.  Thanks for the explanation.

Very well.  I guess it's not too bad as it is.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
