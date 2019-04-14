Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38837C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068162148E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDNKfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:35:46 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45440 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfDNKfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:35:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 263219E74F4;
        Sun, 14 Apr 2019 11:35:44 +0100 (BST)
Date:   Sun, 14 Apr 2019 11:35:42 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/4] iio: inkern: Convert iio_read_avail_channel_raw
 into a wrapper
Message-ID: <20190414113542.27e1831f@archlinux>
In-Reply-To: <20190324152750.43edf737@archlinux>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
        <20190323172809.14407-2-contact@artur-rojek.eu>
        <20190324152750.43edf737@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 15:27:50 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 23 Mar 2019 18:28:07 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
> 
> > Convert "iio_read_avail_channel_raw" over to a wrapper around
> > "iio_read_avail_channel_attribute".
> > 
> > With the introduction of "iio_read_avail_channel_attribute",
> > the necessity of having a separate call to read raw channel values
> > became redundant.
> > 
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>  
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the ib-jz47xx-battery-prereq branch of iio.git

Thanks,

Jonathan

> 
> > ---
> > 
> > Changes:
> > 
> > v2: new patch
> > 
> >  drivers/iio/inkern.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index f19dbde3c945..4a5eff3f18bc 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -759,16 +759,8 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
> >  	int ret;
> >  	int type;
> >  
> > -	mutex_lock(&chan->indio_dev->info_exist_lock);
> > -	if (!chan->indio_dev->info) {
> > -		ret = -ENODEV;
> > -		goto err_unlock;
> > -	}
> > -
> > -	ret = iio_channel_read_avail(chan,
> > -				     vals, &type, length, IIO_CHAN_INFO_RAW);
> > -err_unlock:
> > -	mutex_unlock(&chan->indio_dev->info_exist_lock);
> > +	ret = iio_read_avail_channel_attribute(chan, vals, &type, length,
> > +					 IIO_CHAN_INFO_RAW);
> >  
> >  	if (ret >= 0 && type != IIO_VAL_INT)
> >  		/* raw values are assumed to be IIO_VAL_INT */  
> 

