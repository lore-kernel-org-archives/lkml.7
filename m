Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7748C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8789520842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551631671;
	bh=/WUQLVfiVQQ6IEi/ZjL2VXXVtZTzFkcrR1n6HytZEpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yfpYYHyhH/YalYHmua1M94aCmabDV666aYgJurK1CLMGeftl3G3rPWl1DPYyTlbSA
	 kMVCHP61wgb/Vb0M5XvKr19tAQ6VYNrCZFp2hU4Ojt7aEwa1yfm/X0ZuXFQN2Gr3dw
	 7aS1ACaIguVHfieQEO9uC9RsvuCU0NqXvRIRu2ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCCQru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfCCQrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:47:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A831206DD;
        Sun,  3 Mar 2019 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551631667;
        bh=/WUQLVfiVQQ6IEi/ZjL2VXXVtZTzFkcrR1n6HytZEpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XbAXpB4be+mLM1OKqgHjwY0igy+UJ5+du3BPTZP1Kuni+W5d9BHOSivYFAiHIcCiP
         tkHyPhWXqhcCFIXm/SaXVMrEL7oUqSj33LK2VQM78IYVcEX2V0RCTnPxEWvmcW0EaS
         NHJKrl8SzvzsjZKVxR/FCiVpnQ9ZzjavLSKMANyE=
Date:   Sun, 3 Mar 2019 16:47:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: cros_ec: Fix gyro scale calculation
Message-ID: <20190303164741.6cb3c58b@archlinux>
In-Reply-To: <7d36153b-65e9-6702-e72f-caaeeb032077@collabora.com>
References: <20190220150300.3302-1-enric.balletbo@collabora.com>
        <20190220160126.12568f92@archlinux>
        <7d36153b-65e9-6702-e72f-caaeeb032077@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 11:24:24 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Jonathan,
> 
> On 20/2/19 17:01, Jonathan Cameron wrote:
> > On Wed, 20 Feb 2019 16:03:00 +0100
> > Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> >   
> >> From: Gwendal Grignou <gwendal@chromium.org>
> >>
> >> Calculation was copied from IIO_DEGREE_TO_RAD, but offset added to avoid
> >> rounding error is wrong. It should be only half of the divider.
> >>
> >> Fixes: c14dca07a31d ("iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver")
> >> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>  
> > 
> > This one is kind of interesting. See below.
> >   
> >> ---
> >>
> >>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> >> index 89cb0066a6e0..600942af9f9c 100644
> >> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> >> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> >> @@ -103,7 +103,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
> >>  			 * Do not use IIO_DEGREE_TO_RAD to avoid precision
> >>  			 * loss. Round to the nearest integer.
> >>  			 */
> >> -			*val = div_s64(val64 * 314159 + 9000000ULL, 1000);
> >> +			*val = div_s64(val64 * 314159 + 500ULL, 1000);  
> > That is only one of two divides going on.  Firstly we divide by 1000 here,
> > then we provide it in fractional form which means that the actual value you get
> > from sysfs etc is 
> > val/val2.  It's this one we are protecting against rounding error on I guess.
> > Now this is even less obviously because it's not 18000 either, but 
> > 18000 * 2^CROS_EC_SENSOR_BITS.
> > 
> > Which ultimately means neither answer is correct. Hmm.
> > Not totally sure what the right answer actually is..
> >   
> 
> If I understood well the Gwendal's patch the problem that we're trying to solve
> is that current calculation is not closer from the float calculation.
> 
> For 1000dps, the result should be:
> 
>     (1000 * pi ) / 180 >> 15 ~= 0.000532632218
> 
> But with current calculation we get
> 
>     $ cat scale
>     0.000547890
> 
> With that patch (modifying the offset to avoid the rounding error) we get a
> closer result
> 
>     $ cat scale
>     0.000532631
> 
> So, what we're trying to do is have val/val2 closer to the real value. Makes
> this sense to you or I'm missing something? I can improve the commit message if
> it's not clear.

I think we are in enough of a mess here with the different dividers that we
should just do the maths here, then we can avoid the bia.

aiming for nano value.
val * pi * 10e12 / (180 * 2^15)
div_s64(val * 3141592653000 + 2949120, 5898240) = 532632
vs 532632 for floating point division.
Then use IIO_INT_PLUS_NANO to return it.

Even then I suspect the +2949120 is only effecting the last digit so
you could probably drop it safely enough.

I'd certainly rather we had all the magic in one place rather than
trying to correct for divisions that aren't apparent here.

> 
> -- Enric
> 
> > Jonathan
> >   
> >>  			*val2 = 18000 << (CROS_EC_SENSOR_BITS - 1);
> >>  			ret = IIO_VAL_FRACTIONAL;
> >>  			break;  
> >   

