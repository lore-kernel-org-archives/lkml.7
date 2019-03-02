Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB228C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3672086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551553646;
	bh=Got5M72eLr+FNoBlLU2Pqul+4+E/Hdd7DPUJ1wUKzMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=q0fRJm4Iqo1rmCdo7ifxidCy7Rp07YYm2A6T4BvUBGmu3yP0tAm3mX1unlgPRQw6y
	 THwx+p8PmOg20TsJLZ3plss98cAOrBL1ROIqKAYSTA7LCXK+0XDQp9siSHRQ7ey0RR
	 gOsV4Ud/ySacRXyQsJ7J6jRtxrsoGEpmrJgg1+zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCBTHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCBTHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 14:07:24 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E9420863;
        Sat,  2 Mar 2019 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551553643;
        bh=Got5M72eLr+FNoBlLU2Pqul+4+E/Hdd7DPUJ1wUKzMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HRFkhNdPwpvpmraP88M+2MCo1Oc40G1DWkYa758Oba+3PF/V9cgY82XTNY61QWVy2
         ZtSWanImaIgIgbOg504dpDkUzHHrS65/NEhQCqmn6uo3jieJx9LQEzaB951MWsbzAh
         YoHvCT/aBoGrNTuw1uc5j5g9OdvW0TV2LkCGr19U=
Date:   Sat, 2 Mar 2019 19:07:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20190302190716.26838b52@archlinux>
In-Reply-To: <efc42dc6be92871f03e5f8dc3d5aa9ebad5bedb8.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
        <9c8331166124ec2bd52794a9c9f844bfb70d1cd9.1551358569.git.renatogeh@gmail.com>
        <efc42dc6be92871f03e5f8dc3d5aa9ebad5bedb8.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 07:17:04 +0000
"Ardelean, Alexandru" <Alex.Ardelean@analog.com> wrote:

> On Thu, 2019-02-28 at 11:24 -0300, Renato Lui Geh wrote:
> > 
> > 
> > The AD7780 driver contains status pattern bits designed for checking
> > whether serial transfers have been correctly performed. Pattern macros
> > were previously generated through bit fields. This patch sets good
> > pattern values directly and masks through GENMASK.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7780.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index 7a68e90ddf14..56c49e28f432 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> > +#include <linux/bits.h>
> > 
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -28,16 +29,13 @@
> >  #define AD7780_ID1             BIT(4)
> >  #define AD7780_ID0             BIT(3)
> >  #define AD7780_GAIN            BIT(2)
> > -#define AD7780_PAT1            BIT(1)
> > -#define AD7780_PAT0            BIT(0)  
> 
> I don't see a problem to leave the bitfields;  they can be read & matched
> easier with the datasheet.
> 
> > 
> > -#define AD7780_PATTERN         (AD7780_PAT0)
> > -#define AD7780_PATTERN_MASK    (AD7780_PAT0 | AD7780_PAT1)
> > 
> > -#define AD7170_PAT2            BIT(2)  
> 
> > +#define AD7780_PATTERN_GOOD    1  
> 
> It was also nice before that the PAT0..PAT2 bitfields were used to define a
> good pattern, since it's easier to match with the datasheet.
This one was much suggestion.  Not particularly important one.

Personally if a datasheet is pointlessly confusing I tend to ignore it.
This is a two bit field as the bits don't have independent meaning!

I'm not strongly tied to it though and as it's an Analog driver and
you all do a good job maintaining the set I'll go with your preference!
I do prefer the naming of PATTERN_GOOD though if nothing else!
> 
> 
> > +#define AD7780_PATTERN_MASK    GENMASK(1, 0)  
> 
> I like the general usage of GENMASK, but I'm not sure in this case it's
> worth doing. Maybe I missed a discussion somewhere, about doing this
> change, but it is mostly a cosmetic without any functional change.
> 
> 
> > 
> > -#define AD7170_PATTERN         (AD7780_PAT0 | AD7170_PAT2)
> > -#define AD7170_PATTERN_MASK    (AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
> > +#define AD7170_PATTERN_GOOD    5
> > +#define AD7170_PATTERN_MASK    GENMASK(2, 0)
> > 
> >  #define AD7780_GAIN_MIDPOINT   64
> >  #define AD7780_FILTER_MIDPOINT 13350
> > @@ -209,25 +207,25 @@ static const struct ad_sigma_delta_info
> > ad7780_sigma_delta_info = {
> >  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
> >         [ID_AD7170] = {
> >                 .channel = AD7170_CHANNEL(12, 24),
> > -               .pattern = AD7170_PATTERN,
> > +               .pattern = AD7170_PATTERN_GOOD,
> >                 .pattern_mask = AD7170_PATTERN_MASK,
> >                 .is_ad778x = false,
> >         },
> >         [ID_AD7171] = {
> >                 .channel = AD7170_CHANNEL(16, 24),
> > -               .pattern = AD7170_PATTERN,
> > +               .pattern = AD7170_PATTERN_GOOD,
> >                 .pattern_mask = AD7170_PATTERN_MASK,
> >                 .is_ad778x = false,
> >         },
> >         [ID_AD7780] = {
> >                 .channel = AD7780_CHANNEL(24, 32),
> > -               .pattern = AD7780_PATTERN,
> > +               .pattern = AD7780_PATTERN_GOOD,
> >                 .pattern_mask = AD7780_PATTERN_MASK,
> >                 .is_ad778x = true,
> >         },
> >         [ID_AD7781] = {
> >                 .channel = AD7780_CHANNEL(20, 32),
> > -               .pattern = AD7780_PATTERN,
> > +               .pattern = AD7780_PATTERN_GOOD,
> >                 .pattern_mask = AD7780_PATTERN_MASK,
> >                 .is_ad778x = true,
> >         },
> > --
> > 2.21.0
> >   

