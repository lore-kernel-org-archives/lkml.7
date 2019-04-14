Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BAC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB212148E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfDNKe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:34:59 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45428 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfDNKe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:34:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 709989E75AC;
        Sun, 14 Apr 2019 11:34:56 +0100 (BST)
Date:   Sun, 14 Apr 2019 11:34:54 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/4] iio: inkern: API for reading available iio
 channel attribute values
Message-ID: <20190414113454.53087ca6@archlinux>
In-Reply-To: <20190324152725.35fed317@archlinux>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
        <20190324152725.35fed317@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 15:27:25 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 23 Mar 2019 18:28:06 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
> 
> > Extend the inkern API with a function for reading available
> > attribute values of iio channels.
> > 
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>  
> If this goes through a route other than IIO (otherwise
> I'll just add a signed-off-by...)
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied to the ib-jz47xx-prereq branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

I'll merge that into the togreg branch as well shortly.

Thanks,

Jonathan
> 
> > ---
> > 
> > Changes:
> > 
> > v2: no change
> > 
> >  drivers/iio/inkern.c         | 20 ++++++++++++++++++++
> >  include/linux/iio/consumer.h | 14 ++++++++++++++
> >  2 files changed, 34 insertions(+)
> > 
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 06ca3f7fcc44..f19dbde3c945 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -733,6 +733,26 @@ static int iio_channel_read_avail(struct iio_channel *chan,
> >  						 vals, type, length, info);
> >  }
> >  
> > +int iio_read_avail_channel_attribute(struct iio_channel *chan,
> > +				     const int **vals, int *type, int *length,
> > +				     enum iio_chan_info_enum attribute)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&chan->indio_dev->info_exist_lock);
> > +	if (!chan->indio_dev->info) {
> > +		ret = -ENODEV;
> > +		goto err_unlock;
> > +	}
> > +
> > +	ret = iio_channel_read_avail(chan, vals, type, length, attribute);
> > +err_unlock:
> > +	mutex_unlock(&chan->indio_dev->info_exist_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iio_read_avail_channel_attribute);
> > +
> >  int iio_read_avail_channel_raw(struct iio_channel *chan,
> >  			       const int **vals, int *length)
> >  {
> > diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> > index 9887f4f8e2a8..b2d34831ed7c 100644
> > --- a/include/linux/iio/consumer.h
> > +++ b/include/linux/iio/consumer.h
> > @@ -290,6 +290,20 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
> >  int iio_read_avail_channel_raw(struct iio_channel *chan,
> >  			       const int **vals, int *length);
> >  
> > +/**
> > + * iio_read_avail_channel_attribute() - read available channel attribute values
> > + * @chan:		The channel being queried.
> > + * @vals:		Available values read back.
> > + * @type:		Type of values read back.
> > + * @length:		Number of entries in vals.
> > + * @attribute:		info attribute to be read back.
> > + *
> > + * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
> > + */
> > +int iio_read_avail_channel_attribute(struct iio_channel *chan,
> > +				     const int **vals, int *type, int *length,
> > +				     enum iio_chan_info_enum attribute);
> > +
> >  /**
> >   * iio_get_channel_type() - get the type of a channel
> >   * @channel:		The channel being queried.  
> 

