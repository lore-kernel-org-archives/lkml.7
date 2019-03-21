Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93128C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5877C21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdXcIt5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfCULRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:17:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35762 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCULRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:17:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so2275177wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gp2ng7nSfy8Z8xcq8dhu92gjbqiFq92z2oJYWrHy4JA=;
        b=bdXcIt5KAgB/pp+JSnJaXbIChW4eUZ6zvCtrvXXmrMezOWpqtrVz3ac/zgNvB88mQN
         HMyKL6W0EvdE29OfWY5mrX2lJbXnZh1sq/fHQ6FfMcb5AWTCv3RkTgGXI9UNFOmTSOBW
         sKSYsCXdXDKqudRrqS+UjCw6xHMYdRy/X8NmBHwUap/5sLvo/16fIqlma2cqVlZJIY38
         IzAtEAu/fi+JIs12qCb+lzbFImXxowpd1PcFPxAq5fAPmOELfUwJFcVu6g7s0uzXZ9oy
         Hy3oE/SEtoRo/Zm3GHpZuhZz3QiAitZfZA38bRyIhkcX2PyC9V1fihPmcc9Pv0OWv+C2
         y5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gp2ng7nSfy8Z8xcq8dhu92gjbqiFq92z2oJYWrHy4JA=;
        b=VVsyUDDwq6wj3zR7KpvoubXaSKJnqO7QNAuN4/4x8moFRB8tkXgOLebkazYQvmT8Ja
         26gmrFWfl+naVFZFusmsAP9qksQGmzRFC4coBhSpBAATuN8NtJ5S+nLvyQ++ewG4G9W9
         JmzYGvnUYrB7NOVyp/2tBkSIXYt/TyqbDceE6bTM86o5EfwJAFoP6lbuVcCMIvk5e2uJ
         hBxnfpeWj5xLEz1VT6Jiz7pyelxzlyULI+zu7ImImUto9tWZ9A5WhjJBHSodXIZXLpbh
         FHGG/Ii5iyF2Yh1Iy6ULbHhiQieh1MXaY8BIN2s61Coca/NuU6SeHek6ARPaPfr7UlWS
         tI0g==
X-Gm-Message-State: APjAAAXGb2SpvQoXcWoYWj9boScGWQEorrJIBDTVqlNq9sOCauL38rzU
        m7CLHFCZEAmrCubk4OfgH5W62g==
X-Google-Smtp-Source: APXvYqy0sva5OnWB6n3gDLDZLeAM/7yurwdx+5yY2du4VuiJUS/Y+YcR1jRTfCyYZ7uO9HZW/bhm8A==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr2189613wmo.52.1553167038910;
        Thu, 21 Mar 2019 04:17:18 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d1sm3508071wrs.13.2019.03.21.04.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 04:17:17 -0700 (PDT)
Date:   Thu, 21 Mar 2019 11:17:16 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        xuwei5@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        peter.griffin@linaro.org, guodong.xu@linaro.org,
        haojian.zhuang@linaro.org
Subject: Re: [PATCH 1/2] amba: Take device out of reset before reading pid
 and cid values
Message-ID: <20190321111716.weqoderiyuicbktc@holly.lan>
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
 <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
 <20190312122711.b2ibipico2dgavl7@holly.lan>
 <20190320065658.GA22381@Mani-XPS-13-9360>
 <20190320172956.lt4eq3vusq4traea@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320172956.lt4eq3vusq4traea@shell.armlinux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 05:29:56PM +0000, Russell King - ARM Linux admin wrote:
> On Wed, Mar 20, 2019 at 12:26:58PM +0530, Manivannan Sadhasivam wrote:
> > Hi Daniel,
> > 
> > On Tue, Mar 12, 2019 at 12:27:11PM +0000, Daniel Thompson wrote:
> > > On Sat, Mar 09, 2019 at 07:26:34AM +0530, Manivannan Sadhasivam wrote:
> > > > For the AMBA Primecell devices having the reset lines wired, it is
> > > > necessary to take them out of reset before reading the pid and cid values.
> > > > Earlier we were dependent on the bootloader to do this but a more cleaner
> > > > approach would be to do it in the kernel itself. Hence, this commit
> > > > deasserts the reset line just before reading the pid and cid values.
> > > > 
> > > > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/amba/bus.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > > > index 41b706403ef7..da8f1aac5315 100644
> > > > --- a/drivers/amba/bus.c
> > > > +++ b/drivers/amba/bus.c
> > > > @@ -21,6 +21,7 @@
> > > >  #include <linux/limits.h>
> > > >  #include <linux/clk/clk-conf.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/reset.h>
> > > >  
> > > >  #include <asm/irq.h>
> > > >  
> > > > @@ -352,6 +353,7 @@ static void amba_device_release(struct device *dev)
> > > >  
> > > >  static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> > > >  {
> > > > +	struct reset_control *rst;
> > > >  	u32 size;
> > > >  	void __iomem *tmp;
> > > >  	int i, ret;
> > > > @@ -388,6 +390,13 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> > > >  	if (ret == 0) {
> > > >  		u32 pid, cid;
> > > >  
> > > > +		/* De-assert the reset line to take the device out of reset */
> > > > +		rst = reset_control_get_optional_exclusive(&dev->dev, NULL);
> > > > +		if (IS_ERR(rst))
> > > > +			return PTR_ERR(rst);
> > > 
> > > It is really correct to propagate an error if we cannot get exclusive
> > > ownership of the reset line.
> > > 
> > > With drivers for vendor specific cells it is ok to "just know" that the
> > > reset line is never shared but we cannot know this for generic cells and
> > > we certainly can't know this for the bus.
> > > 
> > > I think it *might* be OK to propagate an error if you used
> > > reset_control_get_optional_shared() instead because if that reports an
> > > error than arguably we have either a mistake in the DT or a bug in the
> > > driver we are sharing a reset with.
> > > 
> > 
> > Hmm. I'm not sure whether we can assume shared reset lines here or not! Maybe
> > Russell can share his opinion here.
> 
> I've no reference to base an opinion on as I have no hardware that
> would use this facility.
> 
> However, it seems obvious to me that if a reset line is shared between
> several devices, and when the reset line is asserted, it blocks reading
> the ID, then we do need a way for the AMBA primecell code to be able
> to lift the reset to read the device ID, and we need to do it in a way
> that is capable of being done even when another device/driver has
> already bound and taken control of the reset line.
> 
> That said, if a reset line is shared between multiple devices, and a
> driver wants to assert the reset line, it would disrupt the operation
> of all those devices, so there would need to be some kind of
> synchronisation between the drivers.

That is what shared ownership of the reset line provides. When a line is
shared a single driver does not have the authority to unilaterally
assert reset because deasserts and asserts are counted and the line only
goes high again when they balance.


> A different way to look at it though is that such a reset line is not
> a property of the individual devices, but of the bus - in which case
> it should be specified at bus level and controlled at bus level, not
> at individual device level.
> 
> What is appropriate is entirely dependent on the hardware setup, and
> as I said above, with no view of the hardware I am unable to give a
> meaningful opinion.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
