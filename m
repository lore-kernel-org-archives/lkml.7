Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC67C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1893C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOz7SWGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfHMLv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 07:51:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46293 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfHMLv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:51:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so13937150pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zQLcyMh/ISEYCNtjhilvOef27B+ErPxPF2alHh2I/rc=;
        b=yOz7SWGI5f2DNgNH+EDVpBNZsvS2JWwojelO+H3twD4309I0JzuqE9agVRxnlQ8aSz
         lqymVTEIYXM28K8H/SJ6Lx1gp2cvzcHi9GARmU59TWWmeUzkeMfRg0rZ4jzR8E5Pi31u
         TnQ7bN+rkEd4W/ulDNtN7Uu4CQqkbXO/ROkzmYkY4XAtX1Xq+nLwdF8cpa8htS09pTY+
         LRbE3p7fSlADM8+7Tdpy5pE1GpSp+U/u9PF1fxYOJprhpRF43X/6RRz4wkMAcSZWXv8M
         m3UMA7psFdisL+/dzly3IvowyM+WY2Hh5KQmjVy4mdRrVXv+NbRyV9xpQBw9LS2mNTld
         j3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zQLcyMh/ISEYCNtjhilvOef27B+ErPxPF2alHh2I/rc=;
        b=B5iICnjTEg/gejd0bKEqMrKi65YiX3oYMG3is6G4wqywFHFBZiQ1zljWkIa97/JW1C
         +PwHGfc0nl0tTlcxv7vuawWrRtkH1i9kM0jhzy8fWP1CyM1kA+EGizir0XWXKoEFtN6r
         fLviO1yBCdx+fxa6bi6AvrmSU5WaAPCsY8uB/WAf+m7ryDmk2gNcpf6ns1ZjXjW3GycW
         UDWB18vfY8cvInNRIu11pLSNkD57s8iQPkkMZ8NNpOj8x8gH/BKkwhN2C1inwk4AcCTr
         KzlKMIN5ViOrZ87NKFhHvF01BQbYCvzMBFieHBMR+ule5CGe9X7+v5hJFI35C7HyO8+1
         p1vQ==
X-Gm-Message-State: APjAAAWNn2rPFJvBp6ZdR+LQALo+ctfChRz9GYWUWSk5ie6s+N3YDq/2
        HtzklWFhYQzn4tFyUicgMKIxPCAvLg==
X-Google-Smtp-Source: APXvYqxc/t6kiEwTrKBx62vfKP5EcaMkAfRfkcv1bxg95HmegdS7ap89d9SxVaFk0eASmLiYCIqh1g==
X-Received: by 2002:a63:2807:: with SMTP id o7mr34711857pgo.131.1565697116787;
        Tue, 13 Aug 2019 04:51:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:649c:6ce0:9d44:669c:5d6c:bc5f])
        by smtp.gmail.com with ESMTPSA id u18sm5071090pfl.29.2019.08.13.04.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 04:51:56 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:21:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        c.barrett@framos.com, linux-kernel@vger.kernel.org,
        a.brela@framos.com, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: media: i2c: Add IMX290 CMOS sensor
 binding
Message-ID: <20190813115147.GB28877@Mani-XPS-13-9360>
References: <20190806130938.19916-1-manivannan.sadhasivam@linaro.org>
 <20190806130938.19916-2-manivannan.sadhasivam@linaro.org>
 <20190813113846.GG13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813113846.GG13294@shell.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

On Tue, Aug 13, 2019 at 12:38:46PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Aug 06, 2019 at 06:39:36PM +0530, Manivannan Sadhasivam wrote:
> > +Required Properties:
> > +- compatible: Should be "sony,imx290"
> > +- reg: I2C bus address of the device
> > +- clocks: Reference to the xclk clock.
> > +- clock-names: Should be "xclk".
> > +- clock-frequency: Frequency of the xclk clock.
> 
> Driver code:
> 
> +       ret = of_property_read_u32(dev->of_node, "clock-frequency", &xclk_freq);+       if (ret) {
> +               dev_err(dev, "Could not get xclk frequency\n");
> +               return ret;
> +       }
> +
> +       /* external clock must be 37.125 MHz */
> +       if (xclk_freq != 37125000) {
> +               dev_err(dev, "External clock frequency %u is not supported\n",
> +                       xclk_freq);
> +               return -EINVAL;
> +       }
> 
> So, only 37125000 is supported - is that not worth mentioning in this
> description?  Is this a hard requirement of the sensor?  If so, why
> does it need to be mentioned in the DT binding?
> 

Actually, sensor supports only 2 clock frequencies: 37.125 MHz and 74.25 MHz.
And the driver currently supports only 37.125, because that's what I can test
with my setup.

So how about below:

clock-frequency: Frequency of the xclk clock in Hz. It should be one of the
		 following:
		 - 37125000
		 - 74250000

Thanks,
Mani

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
