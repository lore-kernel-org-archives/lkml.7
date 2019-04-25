Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A4C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28793217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHiJ6Rim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfDYH2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:28:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34188 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:28:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so10695060pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qhmohsoX6NmnLjphnMLD1/HU82A9nQ69kZEBNxqNlrw=;
        b=wHiJ6RimfgYWut8XMPTGpOaW8er6PEkCWb80FQ0gMQKSLz/G8r1BGzguEKOWYtlA7Y
         vqB4/rAPTlWxYDG4taMQlLaXS5EIgTwF8MkXbVnCXHAVcLAAvstO1tIUTq6wNCCLG0aH
         O/r3XDseZmNypHqU3s1iJZiXMRYqT2jCjSSMIucSvyy9+d7Ku+z/VOSXui/oaJ5sVgEm
         aq9aYa4tJPqj1uWpL8ong2HEX+rGMC51eDCl0FrDsdfhyJgqLVvkFvCos5JUFmS4sNNQ
         w6oUKyCSEk2zyUxfoAWUTtokOX2ilsGbrEvlITTiaZs/kLtl5C9fSHkSJa9AUvbgnzVC
         XjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qhmohsoX6NmnLjphnMLD1/HU82A9nQ69kZEBNxqNlrw=;
        b=WWBSBsS6w+8VUO0e5X6n7wXkb+dv9XMXZBOhmEKwAGE/SWKhWC9CSUmsxgPKW937zQ
         SLMVYcSMKwDVkBQ5oVVIziKMg0JEAdCQ7FE6nGQh+XqoM7BQiFe1Ts9kiRfPAaEIfr5Y
         rN/WvTrCPbuROnV6osCPSTzNhGn9f/rpxxmnwoian3m7psCVanyBzE9vYkG4hAOZifcL
         U8suZ13ZjkPChMsChtGce1Po98gqHQdg7QNZD4TmxB6wQCUdzxdpyx5zgmxLRI2jSAkb
         mu6JHx8ntPCWFm4KeAjtaXtj4D0MtBzkvDQsNbkzNsf5byHLx/5dlh0VIXLc1mPxCRz3
         lNGA==
X-Gm-Message-State: APjAAAV+Semvezf/vCOgjqefeEWby1IqL5IN214A4RFfMvgCuduJ2ugx
        aBFMTGlThEH2pnYjAKOqToiFV46jIg==
X-Google-Smtp-Source: APXvYqwXtj1FCdVYyLAiEBY7Mn7+TTQbwy/zj+sbLH85VH6PvdFDozlAVcSQ43y8S1lFOPMILIB96g==
X-Received: by 2002:a62:e10e:: with SMTP id q14mr96112pfh.161.1556177313733;
        Thu, 25 Apr 2019 00:28:33 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:81e:2691:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id h15sm19701093pfr.146.2019.04.25.00.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 00:28:32 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:58:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 4/5] pinctrl: Add pinctrl support for BM1880 SoC
Message-ID: <20190425072825.GA31116@Mani-XPS-13-9360>
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
 <20190424120224.22660-5-manivannan.sadhasivam@linaro.org>
 <CACRpkdZJweCPs096r6LJJTUSmPYViPDV_rBJ8NWbHzx96xEfsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZJweCPs096r6LJJTUSmPYViPDV_rBJ8NWbHzx96xEfsw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Apr 25, 2019 at 09:09:28AM +0200, Linus Walleij wrote:
> On Wed, Apr 24, 2019 at 2:03 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
> > Add pinctrl support for Bitmain BM1880 SoC. The driver only handles
> > pinmuxing as the SoC is not capable of handling pinconf.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Patch applied, because there is no reason to hold back this clean
> and important infrastructure for the platform. Minor nits can be
> considered for follow-up patches.
> 

Thanks a lot! I will follow up with the cleanup patches.

> > +config PINCTRL_BM1880
> > +       bool "Bitmain BM1880 Pinctrl driver"
> > +       depends on ARCH_BITMAIN
> 
> Could we do:
> 
> depends on ARCH_BITMAIN || COMPILE_TEST
> 
> to get some compiler coverage?
> 

Sure, will do.

> > +       select PINMUX
> > +       help
> > +         Pinctrl driver for Bitmain BM1880 SoC.
> 
> I think the platform always want this driver enabled, so I would either
> select it from arch/arm/mach-foo/Kconfig or add a row like this:
> 
> default ARCH_BITMAIN
> 
> Either defaulting it to 'y'.
> 

Makes sense! Will add ARCH_BITMAIN default to this Kconfig.

> > +       F_nand, F_spi, F_emmc, F_sdio, F_eth0, F_pwm0, F_pwm1, F_pwm2,
> > +       F_pwm3, F_pwm4, F_pwm5, F_pwm6, F_pwm7, F_pwm8, F_pwm9, F_pwm10,
> > +       F_pwm11, F_pwm12, F_pwm13, F_pwm14, F_pwm15, F_pwm16, F_pwm17,
> > +       F_pwm18, F_pwm19, F_pwm20, F_pwm21, F_pwm22, F_pwm23, F_pwm24,
> > +       F_pwm25, F_pwm26, F_pwm27, F_pwm28, F_pwm29, F_pwm30, F_pwm31,
> > +       F_pwm32, F_pwm33, F_pwm34, F_pwm35, F_pwm36, F_pwm37, F_i2c0, F_i2c1,
> 
> 
> Wow 38 individual PWMs. This platform must really have good use for PWM.
> I wonder why they hardcoded so many of them into the hardware...
> 

I don't know the reasoning behind it. This SoC is targeted at AI/ML
usecase, and there are 4 PWM modules in it. Maybe they tried to integrate
motor control usecase with these PWM modules? There is also a RISC-V core
in this SoC, which can perform some real time offloading.

> > +static int __init bm1880_pinctrl_init(void)
> > +{
> > +       return platform_driver_register(&bm1880_pinctrl_driver);
> > +}
> > +arch_initcall(bm1880_pinctrl_init);
> 
> driver_initcall() also known as module_builtin_driver() doesn't work?
> 

It will work, but I want this driver to be probed very soon.

> Do you plan to add GPIO (and interrupts) and pin config to this driver as well?
> 

GPIO support is handled by Designware IP. I have already added DTS
support for it. And you acked those 2 patches ;-)

For pinconfig, sadly there is nothing I can see in the vendor kernel so
assumed that the SoC doesn't support it (yes it is wierd). I will ask
Bitmain folks to be sure.

Thanks,
Mani

> Yours,
> Linus Walleij
