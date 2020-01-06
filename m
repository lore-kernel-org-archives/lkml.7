Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B469CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9128E2071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgAFLuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:50:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41577 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFLuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:50:54 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ioQuK-0006CS-IE; Mon, 06 Jan 2020 12:50:52 +0100
Message-ID: <a4b9f091b846ef0a445408debef57a55feb1e647.camel@pengutronix.de>
Subject: Re: [PATCH 2/6] drm/etnaviv: determine product, customer and eco id
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Date:   Mon, 06 Jan 2020 12:50:52 +0100
In-Reply-To: <CAH9NwWc-M2TvPGnDY5d_aWxrtrb+SZZOObd9KSAAzN+K7WMpOg@mail.gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
         <20200102100230.420009-3-christian.gmeiner@gmail.com>
         <5cd1dc11df43d86d9db0dc2520de9b2e839ea7cc.camel@pengutronix.de>
         <CAH9NwWddNNc+2rRsntm+_eYF0S9uwC0kTszpPysbzmkc4dNuNA@mail.gmail.com>
         <191213c32908a217cf78590464c9b9519865f3e0.camel@pengutronix.de>
         <CAH9NwWc-M2TvPGnDY5d_aWxrtrb+SZZOObd9KSAAzN+K7WMpOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2020-01-06 at 12:40 +0100, Christian Gmeiner wrote:
> Hi Lucas
> 
> Am Mo., 6. Jan. 2020 um 12:22 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
> > On Mo, 2020-01-06 at 11:57 +0100, Christian Gmeiner wrote:
> > > Hi Lucas
> > > 
> > > Am Mo., 6. Jan. 2020 um 11:03 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
> > > > On Do, 2020-01-02 at 11:02 +0100, Christian Gmeiner wrote:
> > > > > They will be used for extended HWDB support. The eco id logic was taken
> > > > > from galcore kernel driver sources.
> > > > > 
> > > > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 17 +++++++++++++++++
> > > > >  drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  6 +++---
> > > > >  2 files changed, 20 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > > index d47d1a8e0219..253301be9e95 100644
> > > > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > > @@ -321,6 +321,18 @@ static void etnaviv_hw_specs(struct etnaviv_gpu *gpu)
> > > > >               gpu->identity.varyings_count -= 1;
> > > > >  }
> > > > > 
> > > > > +static void etnaviv_hw_eco_id(struct etnaviv_gpu *gpu)
> > > > > +{
> > > > > +     const u32 chipDate = gpu_read(gpu, VIVS_HI_CHIP_DATE);
> > > > > +     gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
> > > > > +
> > > > > +     if (etnaviv_is_model_rev(gpu, GC1000, 0x5037) && (chipDate == 0x20120617))
> > > > > +             gpu->identity.eco_id = 1;
> > > > > +
> > > > > +     if (etnaviv_is_model_rev(gpu, GC320, 0x5303) && (chipDate == 0x20140511))
> > > > > +             gpu->identity.eco_id = 1;
> > > > 
> > > > I'm not sure if those two checks warrant a separate function. Maybe
> > > > just place them besides the other ID fixups?
> > > > 
> > > 
> > > This is almost a 1:1 copy of _GetEcoID(..) but will try to move the fixups.
> > > 
> > > 
> > > > > +}
> > > > > +
> > > > >  static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> > > > >  {
> > > > >       u32 chipIdentity;
> > > > > @@ -362,6 +374,8 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> > > > >                       }
> > > > >               }
> > > > > 
> > > > > +             gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
> > > > > +
> > > > >               /*
> > > > >                * NXP likes to call the GPU on the i.MX6QP GC2000+, but in
> > > > >                * reality it's just a re-branded GC3000. We can identify this
> > > > > @@ -375,6 +389,9 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> > > > >               }
> > > > >       }
> > > > > 
> > > > > +     etnaviv_hw_eco_id(gpu);
> > > > > +     gpu->identity.customer_id = gpu_read(gpu, VIVS_HI_CHIP_CUSTOMER_ID);
> > > > 
> > > > I don't like this scattering of identity register reads. Please move
> > > > all of those reads to the else clause where we currently read
> > > > model/rev. I doubt that the customer ID register is available on the
> > > > really early cores, that only have the VIVS_HI_CHIP_IDENTITY register.
> > > > 
> > > 
> > > There is feature bit for it: chipMinorFeatures5_HAS_PRODUCTID
> > > Will change the code to make use of it. Shall I still put it in the
> > > else clause then?
> > 
> > If there's a feature bit we need to move the read toward the end of the
> > function, as we currently read the features as the last step in the
> > hw_identify.
> > 
> > But then I'm not sure if the HAS_PRODUCTID feature bit is correct. At
> > least wumpus' gpus_comparison says that none of the known <= GC3000
> > cores has it set, which seems... suspicious.
> > 
> 
> Hmm... what if I just mimic what is done here?
> https://github.com/etnaviv/vivante_kernel_drivers/blob/master/imx8_v6.2.3.129602/hal/kernel/arch/gc_hal_kernel_hardware.c#L220
> 
> Unconditionally read the product id at the end of the else clause. The
> same is done in the stm32 galcore kernel driver.

If we read it unconditionally, just move it to the start of the else
clause, next to the model/rev reads and be done with it.

Regards,
Lucas

