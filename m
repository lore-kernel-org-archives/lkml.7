Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBCC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E60A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XK994wVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfLQNqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:46:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38508 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfLQNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:46:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so3234801wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kZuWd/3jkSU468vrZtKybTAjJX1Jep24XVi1Wi4q33k=;
        b=XK994wVVrkzFy0kYAn6YNVPCGij+VqhuMZC2yPF2zmpoSL1t182ncy8nuiNo5zng4Z
         WPFfdmKerYYyv2faiAywqYmjUlJWN8c8sDMRIiX2QhGVIqH9X2zcK+ROViyaRiDUZfjN
         MS46kihklyILLInJAkBt/mjzCwvf4dpgp0yac7AA3B1aclCBtqlsVz1qRWbAJUzDd6Wp
         walFi+txkCkoY1p6ZAmsmDSUtNZN4W9uvEoo1yOW0pXVuhMT3ppXifn3dvN1DFIBG6hT
         /2vATZu+R8Iuq8zTRgwX1otltmSndbWvbKrOSQtab37hC5Xokm6YJYdFkuILS1JKU5S4
         RQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kZuWd/3jkSU468vrZtKybTAjJX1Jep24XVi1Wi4q33k=;
        b=UOhYWiygcHdS7GgBEG8IcwDa4Yn/6D8/64BJVioptkQO6Pu9H6PWJdALKeRXjSLSBj
         25wIgGssSM1wRclLxPqMVSwfidky8OWJwo1PIKKT7sDcs/kd39fScWeicoqqm2DsHfm6
         XT8zfMPjqOkthg0Acvg4S0J2mKDFjb9j9f98pOnqAWxVdPRKn9Qwob82VZqrnnJxn2E+
         SLcYK5bWH3fxqpH82KN2XBCMNRYNSdh/aDMjxlOvSG8UQ2YiZ8Rl3lcoHib7MLZ25qU/
         bQfOWYcivYmhS4ofibGkkMLaQ9l92bf5EWyp9iKW0EwNqa1PNObcVXGX/EWMLFagVNxi
         Wy4w==
X-Gm-Message-State: APjAAAWhr+JMKM1D/TbO9R0dgCdCD6SAWnoSky3O7i5W8Lrqfk/h/8Lp
        leuggw5oz26P5tZ/e/NaIBs/eA==
X-Google-Smtp-Source: APXvYqyNCklkEVENRexg11/lVsAZF67JMyMSJB9/s1vxBi0hQ6lOnAJ1HSWjhfQSwKh/52Z4A1/krA==
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr5986321wma.79.1576590377924;
        Tue, 17 Dec 2019 05:46:17 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id r15sm2967823wmh.21.2019.12.17.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:46:17 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:46:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, lars@metafoo.de, pascal.huerst@gmail.com
Subject: Re: [PATCH 06/10] mfd: Add core driver for AD242x A2B transceivers
Message-ID: <20191217134617.GK18955@dell>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-8-daniel@zonque.org>
 <20191217133952.GJ18955@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217133952.GJ18955@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019, Lee Jones wrote:

> On Mon, 09 Dec 2019, Daniel Mack wrote:
> 
> > The core driver for these devices is split into several parts.
> > 
> > The master node driver is an I2C client. It is responsible for
> > bringing up the bus topology and discovering the slave nodes.
> > This process requries some knowlegde of the slave node configuration
> > to program the bus timings correctly, so the master drivers walks
> > the tree of nodes in the devicetree. The slave driver handles platform
> > devices that are instantiated by the master node driver after
> > discovery has finished.
> > 
> > Master nodes expose two addresses on the I2C bus, one (referred to as
> > 'BASE' in the datasheet) for accessing registers on the transceiver
> > node itself, and one (referred to as 'BUS') for accessing remote
> > registers, either on the remote transceiver itself, or on I2C hardware
> > connected to that remote transceiver, which then acts as a remote I2C
> > bus master.
> > 
> > In order to allow MFD sub-devices to be registered as children of
> > either the master or any slave node, the details on how to access the
> > registers are hidden behind a regmap config. A pointer to the regmap
> > is then exposed in the struct shared with the sub-devices.
> > 
> > The ad242x-bus driver is a simple proxy that occupies the BUS I2C
> > address and which is referred to through a devicetree handle by the
> > master driver.
> > 
> > For the discovery process, the driver has to wait for an interrupt
> > to occur. In case no interrupt is configured in DT, the driver falls
> > back to interrupt polling. After the discovery phase is completed,
> > interrupts are only needed for error handling and GPIO handling,
> > both of which is not currenty implemented.
> > 
> > Code common to both the master and the slave driver lives in
> > 'ad242x-node.c'.
> > 
> > Signed-off-by: Daniel Mack <daniel@zonque.org>
> > 
> > mfd
> 
> ?
> 
> > ---
> >  drivers/mfd/Kconfig         |  11 +
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/ad242x-bus.c    |  42 +++
> >  drivers/mfd/ad242x-master.c | 611 ++++++++++++++++++++++++++++++++++++
> >  drivers/mfd/ad242x-node.c   | 262 ++++++++++++++++
> >  drivers/mfd/ad242x-slave.c  | 234 ++++++++++++++
> >  include/linux/mfd/ad242x.h  | 400 +++++++++++++++++++++++
> 
> This device, or at least the way it's been coded is batty!
> 
> It's going to need a lot of massaging before being accepted.

One thing I should mention upfront; there is too much code "doing
things" in here for it to be an MFD.  MFDs don't care about; syncs,
slots, TDM, inverting lines, upstreams, downstreams, etc etc etc.
Anything remotely technical or functional, the code that "does things"
should be moved out to the relevant areas.  In the case of this
device, that's looking like one of the Audio related subsystems.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
