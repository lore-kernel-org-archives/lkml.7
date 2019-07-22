Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E85C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4480921E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfGVJco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:32:44 -0400
Received: from foss.arm.com ([217.140.110.172]:34202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfGVJcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:32:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C6128;
        Mon, 22 Jul 2019 02:32:42 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 674373F694;
        Mon, 22 Jul 2019 02:32:42 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 1CB4468258A; Mon, 22 Jul 2019 10:32:41 +0100 (BST)
Date:   Mon, 22 Jul 2019 10:32:41 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [EXT] Re: [v2 1/3] drm/arm/mali-dp: Add display QoS interface
 configuration for Mali DP500
Message-ID: <20190722093241.GC15612@e110455-lin.cambridge.arm.com>
References: <20190719095445.11575-1-wen.he_1@nxp.com>
 <20190719114624.GB16673@e110455-lin.cambridge.arm.com>
 <DB7PR04MB5195BD852798B113D4CB8BA4E2C40@DB7PR04MB5195.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB5195BD852798B113D4CB8BA4E2C40@DB7PR04MB5195.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 02:12:08AM +0000, Wen He wrote:
> 
> 
> > -----Original Message-----
> > From: Liviu Dudau <liviu.dudau@arm.com>
> > Sent: 2019年7月19日 19:46
> > To: Wen He <wen.he_1@nxp.com>
> > Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org;
> > brian.starkey@arm.com; airlied@linux.ie; daniel@ffwll.ch; Leo Li
> > <leoyang.li@nxp.com>
> > Subject: [EXT] Re: [v2 1/3] drm/arm/mali-dp: Add display QoS interface
> > configuration for Mali DP500
> > 
> > Caution: EXT Email
> > 
> > On Fri, Jul 19, 2019 at 05:54:45PM +0800, Wen He wrote:
> > > Configure the display Quality of service (QoS) levels priority if the
> > > optional property node "arm,malidp-aqros-value" is defined in DTS file.
> > >
> > > QoS signaling using AQROS and AWQOS AXI interface signals, the AQROS
> > > is driven from the "RQOS" register, so needed to program the RQOS
> > > register to avoid the 4k resolution flicker issue on the LS1028A platform.
> > >
> > > Signed-off-by: Wen He <wen.he_1@nxp.com>
> > > ---
> > > change in v2:
> > >         - modify some content based on feedback from maintainers
> > >
> > >  drivers/gpu/drm/arm/malidp_drv.c  |  6 ++++++
> > >  drivers/gpu/drm/arm/malidp_hw.c   | 13 +++++++++++++
> > >  drivers/gpu/drm/arm/malidp_hw.h   |  3 +++
> > >  drivers/gpu/drm/arm/malidp_regs.h | 10 ++++++++++
> > >  4 files changed, 32 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/arm/malidp_drv.c
> > > b/drivers/gpu/drm/arm/malidp_drv.c
> > > index f25ec4382277..61c49a0668a7 100644
> > > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > > @@ -818,6 +818,12 @@ static int malidp_bind(struct device *dev)
> > >
> > >       malidp->core_id = version;
> > >
> > > +     ret = of_property_read_u32(dev->of_node,
> > > +                                     "arm,malidp-arqos-value",
> > > +                                     &hwdev->arqos_value);
> > > +     if (ret)
> > > +             hwdev->arqos_value = 0x0;
> > 
> > Is zero the default value that you want? I thought it was 0x00010001.
> 
> Actually, the register default value always is 0x00010001(can be found in RM document).

Exactly, but with your code you are overwriting it to 0 if the DT doesn't have
the arm,malidp-arqos-value property.

> 
> > 
> > > +
> > >       /* set the number of lines used for output of RGB data */
> > >       ret = of_property_read_u8_array(dev->of_node,
> > >                                       "arm,malidp-output-port-lines",
> > > diff --git a/drivers/gpu/drm/arm/malidp_hw.c
> > > b/drivers/gpu/drm/arm/malidp_hw.c index 50af399d7f6f..323683b1e9f7
> > > 100644
> > > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > > @@ -374,6 +374,19 @@ static void malidp500_modeset(struct
> > malidp_hw_device *hwdev, struct videomode *
> > >               malidp_hw_setbits(hwdev, MALIDP_DISP_FUNC_ILACED,
> > MALIDP_DE_DISPLAY_FUNC);
> > >       else
> > >               malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED,
> > > MALIDP_DE_DISPLAY_FUNC);
> > > +
> > > +     /*
> > > +      * Program the RQoS register to avoid 4k resolution flicker
> > > +      * on the LS1028A.
> > > +      */
> > > +     if (hwdev->arqos_value) {
> > > +             val = hwdev->arqos_value;
> > > +
> > > +             if (mode->pixelclock == 594000000)
> > 
> > If I remember correctly, you declare the pixelclocks in the device tree, so I
> > wonder if this is needed here. We should just set what value was in the DT
> > regardless of the pixelclock, and then you manipulate the DT to choose one of
> > your fixed resolutions and also set the QoS value.
> 
> Yes, you remember correctly, but
> 1. declare the pixelclocks in the device tree.
> About this, I was hoping to discuss it with you. I want to implement another patch
> that just declare 27MHz reference clock in the device tree and add a fake clock subsystem
> to enable/display prepare to set PLL. I am thinking what to do next.
> As I remember, I sent out a patch that "Disable checking for required pixel clock",
> I think should be cancel it.
> 
> 2. declare the fixed resolutions list in DTS.
> Yes, Although I put four resolutions for supported list in DTS file, but this just a
> workaround that If not enable EDID OR EDID is not available. Once EDID is enabled,
> these resolutions list declare will be remove in DTS. so we can't use it as a condition
> to set the QoS value. 

3. Actually enable the clock provider. I've had a look at the public
documentation and it looks like the the pixelclock is provided by an IDT VersaClock 5
generator, for which there is a kernel driver. I've started playing with it but got 
pulled back by other more immediate tasks.

Anyway, what I was trying to hint was that putting in the code the exact pixelclock
value might not be the best thing. In my view, pixelclock reflects the need for
a certain bandwidth, with is usually a product of output (number of pixels) and
refresh frequency. I'm guessing going above 4k@60 will also trigger the
flicker, but with your patch we will not react correctly.

Best regards,
Liviu


> 
> Best Regards,
> Wen
> 
> > 
> > Best regards,
> > Liviu
> > 
> > > +                     malidp_hw_setbits(hwdev, val,
> > MALIDP500_RQOS_QUALITY);
> > > +             else
> > > +                     malidp_hw_clearbits(hwdev, val,
> > MALIDP500_RQOS_QUALITY);
> > > +     }
> > >  }
> > >
> > >  int malidp_format_get_bpp(u32 fmt)
> > > diff --git a/drivers/gpu/drm/arm/malidp_hw.h
> > > b/drivers/gpu/drm/arm/malidp_hw.h index 968a65eed371..e4c36bc90bda
> > > 100644
> > > --- a/drivers/gpu/drm/arm/malidp_hw.h
> > > +++ b/drivers/gpu/drm/arm/malidp_hw.h
> > > @@ -251,6 +251,9 @@ struct malidp_hw_device {
> > >
> > >       /* size of memory used for rotating layers, up to two banks available
> > */
> > >       u32 rotation_memory[2];
> > > +
> > > +     /* priority level of RQOS register used for driven the ARQOS signal */
> > > +     u32 arqos_value;
> > >  };
> > >
> > >  static inline u32 malidp_hw_read(struct malidp_hw_device *hwdev, u32
> > > reg) diff --git a/drivers/gpu/drm/arm/malidp_regs.h
> > > b/drivers/gpu/drm/arm/malidp_regs.h
> > > index 993031542fa1..514c50dcb74d 100644
> > > --- a/drivers/gpu/drm/arm/malidp_regs.h
> > > +++ b/drivers/gpu/drm/arm/malidp_regs.h
> > > @@ -210,6 +210,16 @@
> > >  #define MALIDP500_CONFIG_VALID               0x00f00
> > >  #define MALIDP500_CONFIG_ID          0x00fd4
> > >
> > > +/*
> > > + * The quality of service (QoS) register on the DP500. RQOS register
> > > +values
> > > + * are driven by the ARQOS signal, using AXI transacations, dependent
> > > +on the
> > > + * FIFO input level.
> > > + * The RQOS register can also set QoS levels for:
> > > + *    - RED_ARQOS   @ A 4-bit signal value for close to underflow
> > conditions
> > > + *    - GREEN_ARQOS @ A 4-bit signal value for normal conditions
> > > + */
> > > +#define MALIDP500_RQOS_QUALITY          0x00500
> > > +
> > >  /* register offsets and bits specific to DP550/DP650 */
> > >  #define MALIDP550_ADDR_SPACE_SIZE    0x10000
> > >  #define MALIDP550_DE_CONTROL         0x00010
> > > --
> > > 2.17.1
> > >
> > 
> > --
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ¯\_(ツ)_/¯

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
