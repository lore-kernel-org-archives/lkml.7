Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA511C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393A2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCBTIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:08:25 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:47388 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 14:08:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 0043D9E74B3;
        Sat,  2 Mar 2019 19:08:19 +0000 (GMT)
Date:   Sat, 2 Mar 2019 19:08:17 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/9] staging: iio: ad7780: set pattern values and
 masks directly
Message-ID: <20190302190817.61dc4e72@archlinux>
In-Reply-To: <20190302190716.26838b52@archlinux>
References: <cover.1551358569.git.renatogeh@gmail.com>
        <9c8331166124ec2bd52794a9c9f844bfb70d1cd9.1551358569.git.renatogeh@gmail.com>
        <efc42dc6be92871f03e5f8dc3d5aa9ebad5bedb8.camel@analog.com>
        <20190302190716.26838b52@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2019 19:07:16 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 1 Mar 2019 07:17:04 +0000
> "Ardelean, Alexandru" <Alex.Ardelean@analog.com> wrote:
> 
> > On Thu, 2019-02-28 at 11:24 -0300, Renato Lui Geh wrote:  
> > > 
> > > 
> > > The AD7780 driver contains status pattern bits designed for checking
> > > whether serial transfers have been correctly performed. Pattern macros
> > > were previously generated through bit fields. This patch sets good
> > > pattern values directly and masks through GENMASK.
> > > 
> > > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > > ---
> > >  drivers/staging/iio/adc/ad7780.c | 20 +++++++++-----------
> > >  1 file changed, 9 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7780.c
> > > b/drivers/staging/iio/adc/ad7780.c
> > > index 7a68e90ddf14..56c49e28f432 100644
> > > --- a/drivers/staging/iio/adc/ad7780.c
> > > +++ b/drivers/staging/iio/adc/ad7780.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/sched.h>
> > >  #include <linux/gpio/consumer.h>
> > >  #include <linux/module.h>
> > > +#include <linux/bits.h>
> > > 
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > > @@ -28,16 +29,13 @@
> > >  #define AD7780_ID1             BIT(4)
> > >  #define AD7780_ID0             BIT(3)
> > >  #define AD7780_GAIN            BIT(2)
> > > -#define AD7780_PAT1            BIT(1)
> > > -#define AD7780_PAT0            BIT(0)    
> > 
> > I don't see a problem to leave the bitfields;  they can be read & matched
> > easier with the datasheet.
> >   
> > > 
> > > -#define AD7780_PATTERN         (AD7780_PAT0)
> > > -#define AD7780_PATTERN_MASK    (AD7780_PAT0 | AD7780_PAT1)
> > > 
> > > -#define AD7170_PAT2            BIT(2)    
> >   
> > > +#define AD7780_PATTERN_GOOD    1    
> > 
> > It was also nice before that the PAT0..PAT2 bitfields were used to define a
> > good pattern, since it's easier to match with the datasheet.  
> This one was much suggestion.  Not particularly important one.
Not enough sleep this week clearly :)  
This one was _my_ suggestion.

> 
> Personally if a datasheet is pointlessly confusing I tend to ignore it.
> This is a two bit field as the bits don't have independent meaning!
> 
> I'm not strongly tied to it though and as it's an Analog driver and
> you all do a good job maintaining the set I'll go with your preference!
> I do prefer the naming of PATTERN_GOOD though if nothing else!
> > 
> >   
> > > +#define AD7780_PATTERN_MASK    GENMASK(1, 0)    
> > 
> > I like the general usage of GENMASK, but I'm not sure in this case it's
> > worth doing. Maybe I missed a discussion somewhere, about doing this
> > change, but it is mostly a cosmetic without any functional change.
> > 
> >   
> > > 
> > > -#define AD7170_PATTERN         (AD7780_PAT0 | AD7170_PAT2)
> > > -#define AD7170_PATTERN_MASK    (AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
> > > +#define AD7170_PATTERN_GOOD    5
> > > +#define AD7170_PATTERN_MASK    GENMASK(2, 0)
> > > 
> > >  #define AD7780_GAIN_MIDPOINT   64
> > >  #define AD7780_FILTER_MIDPOINT 13350
> > > @@ -209,25 +207,25 @@ static const struct ad_sigma_delta_info
> > > ad7780_sigma_delta_info = {
> > >  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
> > >         [ID_AD7170] = {
> > >                 .channel = AD7170_CHANNEL(12, 24),
> > > -               .pattern = AD7170_PATTERN,
> > > +               .pattern = AD7170_PATTERN_GOOD,
> > >                 .pattern_mask = AD7170_PATTERN_MASK,
> > >                 .is_ad778x = false,
> > >         },
> > >         [ID_AD7171] = {
> > >                 .channel = AD7170_CHANNEL(16, 24),
> > > -               .pattern = AD7170_PATTERN,
> > > +               .pattern = AD7170_PATTERN_GOOD,
> > >                 .pattern_mask = AD7170_PATTERN_MASK,
> > >                 .is_ad778x = false,
> > >         },
> > >         [ID_AD7780] = {
> > >                 .channel = AD7780_CHANNEL(24, 32),
> > > -               .pattern = AD7780_PATTERN,
> > > +               .pattern = AD7780_PATTERN_GOOD,
> > >                 .pattern_mask = AD7780_PATTERN_MASK,
> > >                 .is_ad778x = true,
> > >         },
> > >         [ID_AD7781] = {
> > >                 .channel = AD7780_CHANNEL(20, 32),
> > > -               .pattern = AD7780_PATTERN,
> > > +               .pattern = AD7780_PATTERN_GOOD,
> > >                 .pattern_mask = AD7780_PATTERN_MASK,
> > >                 .is_ad778x = true,
> > >         },
> > > --
> > > 2.21.0
> > >     
> 

