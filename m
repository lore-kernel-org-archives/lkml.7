Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90FCC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2F220693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbfGRJh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:37:29 -0400
Received: from foss.arm.com ([217.140.110.172]:56242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbfGRJh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:37:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F417328;
        Thu, 18 Jul 2019 02:37:27 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B903D3F71A;
        Thu, 18 Jul 2019 02:37:27 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 72C736827B1; Thu, 18 Jul 2019 10:37:26 +0100 (BST)
Date:   Thu, 18 Jul 2019 10:37:26 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [EXT] Re: [PATCH] drm/arm/mali-dp: Add display QoS interface
 configuration
Message-ID: <20190718093726.GA5942@e110455-lin.cambridge.arm.com>
References: <20190717092353.43386-1-wen.he_1@nxp.com>
 <20190717112201.GA17638@e110455-lin.cambridge.arm.com>
 <DB7PR04MB51952D8288917D8C2ECFDBEAE2C80@DB7PR04MB5195.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB51952D8288917D8C2ECFDBEAE2C80@DB7PR04MB5195.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 03:29:48AM +0000, Wen He wrote:
> 
> 
> > -----Original Message-----
> > From: Liviu Dudau <liviu.dudau@arm.com>
> > Sent: 2019年7月17日 19:22
> > To: Wen He <wen.he_1@nxp.com>
> > Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org;
> > brian.starkey@arm.com; airlied@linux.ie; daniel@ffwll.ch; Leo Li
> > <leoyang.li@nxp.com>
> > Subject: [EXT] Re: [PATCH] drm/arm/mali-dp: Add display QoS interface
> > configuration
> > 
> > 
> > Hi Wen,
> > 
> 
> Hi Liviu,

Hi Wen,

> 
> > On Wed, Jul 17, 2019 at 05:23:53PM +0800, Wen He wrote:
> > > Configure the display Quality of service (QoS) levels to high priority
> > > if the level is defined as high as in DTS. The ARQOS for DP500 is
> > > driven from the "RQOS" register, needed to program the RQOS register
> > > value < 7 for the 4k resolution flicker to disappear on the LS1028A platform.
> > 
> > Thanks for taking time to come up with a more generic patch for your issue!
> > 
> 
> Thanks for the review and comments,
> 
> > I have a question: what happens if you program the
> > MALIDP500_RQOS_QUALITY register to 0xd000d000 for all pixelclocks?
> > 
> 
> We can't do that, because:
> 1. The flicker issue only reproduced in 4k@60.

Can you clarify? Does this mean that with the RQOS setting of 0xd000d000 you
don't see flicker at lower resolutions, or that you haven't tested at other
resolution than 4k@60?

> 2. This configuration will be reduced DDR benchmark performance data, because the
> LCDC and DDR are both to connect CCI-400. we have to make sure that DDR performance
> at first when work together with other resolutions.

Hmm, I'm not sure I'm sharing the same view of the problem. You are writing
into DP500's QoS registers, which don't control how CCI-400 or DDR are going to
behave. Now I agree that a more aggressive QoS from DP500 is going to lead to
more contention to the DDR, but maybe you can look into CCI-400's QoS settings
and tweak the bandwidth allocation there as well.

> 
> > Also, some suggestions further down:
> > 
> > >
> > > Signed-off-by: Wen He <wen.he_1@nxp.com>
> > > ---
> > > change in v2:
> > >         - add new implementation for 4k flicker issue on the LS1028A
> > >
> > >  drivers/gpu/drm/arm/malidp_drv.c  |  5 +++++
> > >  drivers/gpu/drm/arm/malidp_hw.c   | 13 +++++++++++++
> > >  drivers/gpu/drm/arm/malidp_hw.h   |  3 +++
> > >  drivers/gpu/drm/arm/malidp_regs.h | 12 ++++++++++++
> > >  4 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/arm/malidp_drv.c
> > > b/drivers/gpu/drm/arm/malidp_drv.c
> > > index f25ec4382277..d2b2cf52ac87 100644
> > > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > > @@ -818,6 +818,11 @@ static int malidp_bind(struct device *dev)
> > >
> > >       malidp->core_id = version;
> > >
> > > +     hwdev->arqos_high_level = false;
> > 
> > This is not needed.
> > 
> > > +
> > > +     hwdev->arqos_high_level = of_property_read_bool(dev->of_node,
> > > +                                     "arm,malidp-arqos-high-level");
> > 
> > I think it would be better to have this property as a u32 value, rather than a
> > boolean, and put the value that we want to program MALIDP_RQOS_QUALITY
> > with in there.
> 
> I really thought that, but I've tested DDR performance for 4k resolution with
> different RQOS setting, the best test performance data is when set the RQOS
> register value's 0xd000d000. So the value is fixed, I think the Boolean type is
> better used here, that's why I did it.

Yes, it is fixed for your platform, but not fixed for other ODMs that might
decide to use the LS1028A chip to create a board. They might use different
DDRs, or their PCB traces might have different lengths. I think it is still
valuable to put the 0xd000d000 value into the device tree and read it from
there. For LS1028A NXP boards it will do then the right thing.

> 
> > 
> > Also, you need to add the documentation for this optional property in
> > Documentation/devicetree/bindings/display/arm,malidp.txt.
> 
> Understand, I will generate another patch to add this change for the DT bindings.
> 
> > 
> 
> > > +
> > >       /* set the number of lines used for output of RGB data */
> > >       ret = of_property_read_u8_array(dev->of_node,
> > >                                       "arm,malidp-output-port-lines",
> > > diff --git a/drivers/gpu/drm/arm/malidp_hw.c
> > > b/drivers/gpu/drm/arm/malidp_hw.c index 50af399d7f6f..eaa1658cd86b
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
> > > +      *  Program the RQoS register to increasing QoS levels for
> > > +      *  the 4k resolution flicker to disappear on the LS1028A.
> > 
> > Looks like two sentences got smashed into one, the result is a bit hard to read.
> > 
> 
> Ha, maybe should be described like this:
> "Program the RQoS register to avoid 4k resolution flicker on the LS1028A."

Yes, that is much easier to understand.

Thank you,
Liviu


> 
> Best Regards,
> Wen
> 
> > Best regards,
> > Liviu
> > 
> > > +      */
> > > +     if (hwdev->arqos_high_level) {
> > > +             val = RED_ARQOS_VALUE | GREEN_ARQOS_VALUE;
> > > +
> > > +             if (mode->pixelclock == 594000000)
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
> > > b/drivers/gpu/drm/arm/malidp_hw.h index 968a65eed371..b8baba60508a
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
> > > +     bool arqos_high_level;
> > >  };
> > >
> > >  static inline u32 malidp_hw_read(struct malidp_hw_device *hwdev, u32
> > > reg) diff --git a/drivers/gpu/drm/arm/malidp_regs.h
> > > b/drivers/gpu/drm/arm/malidp_regs.h
> > > index 993031542fa1..08842142b3b2 100644
> > > --- a/drivers/gpu/drm/arm/malidp_regs.h
> > > +++ b/drivers/gpu/drm/arm/malidp_regs.h
> > > @@ -210,6 +210,18 @@
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
> > > +#define RED_ARQOS_VALUE                 (0xd << 12)
> > > +#define GREEN_ARQOS_VALUE               (0xd << 28)
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
