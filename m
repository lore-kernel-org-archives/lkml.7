Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C5CC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBD2207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCISkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:40:07 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33066 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCISkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:40:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id B3B3B9E7D57;
        Sat,  9 Mar 2019 18:40:04 +0000 (GMT)
Date:   Sat, 9 Mar 2019 18:40:03 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     justinpopo6@gmail.com, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio: adc: ti-ads7950: Fix improper use of mlock
Message-ID: <20190309184003.7ec7fea4@archlinux>
In-Reply-To: <20190309183701.03afd62b@archlinux>
References: <1552082608-42603-1-git-send-email-justinpopo6@gmail.com>
        <1552082608-42603-2-git-send-email-justinpopo6@gmail.com>
        <20190309162935.GC7820@arch>
        <20190309183701.03afd62b@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2019 18:37:01 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 9 Mar 2019 17:29:36 +0100
> Tomasz Duszynski <tduszyns@gmail.com> wrote:
> 
> > On Fri, Mar 08, 2019 at 02:03:27PM -0800, justinpopo6@gmail.com wrote:  
> > > From: Justin Chen <justinpopo6@gmail.com>
> > >
> > > Indio->mlock is used for protecting the different iio device modes.
> > > It is currently not being used in this way. Replace the lock with
> > > an internal lock specifically used for protecting the SPI transfer
> > > buffer.
> > >
> > > Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> > > ---
> > >  drivers/iio/adc/ti-ads7950.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> > > index 0ad6359..1e47bef 100644
> > > --- a/drivers/iio/adc/ti-ads7950.c
> > > +++ b/drivers/iio/adc/ti-ads7950.c
> > > @@ -56,6 +56,9 @@ struct ti_ads7950_state {
> > >  	struct spi_message	ring_msg;
> > >  	struct spi_message	scan_single_msg;
> > >
> > > +	/* Lock to protect the spi xfer buffers */
> > > +	struct mutex		slock;
> > > +
> > >  	struct regulator	*reg;
> > >  	unsigned int		vref_mv;
> > >
> > > @@ -268,6 +271,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
> > >  	struct ti_ads7950_state *st = iio_priv(indio_dev);
> > >  	int ret;
> > >
> > > +	mutex_lock(&st->slock);
> > >  	ret = spi_sync(st->spi, &st->ring_msg);
> > >  	if (ret < 0)
> > >  		goto out;
> > > @@ -276,6 +280,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
> > >  					   iio_get_time_ns(indio_dev));
> > >
> > >  out:
> > > +	mutex_unlock(&st->slock);
> > >  	iio_trigger_notify_done(indio_dev->trig);
> > >
> > >  	return IRQ_HANDLED;
> > > @@ -286,7 +291,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
> > >  	struct ti_ads7950_state *st = iio_priv(indio_dev);
> > >  	int ret, cmd;
> > >
> > > -	mutex_lock(&indio_dev->mlock);
> > > +	mutex_lock(&st->slock);
> > >
> > >  	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
> > >  	st->single_tx = cmd;
> > > @@ -298,7 +303,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
> > >  	ret = st->single_rx;
> > >
> > >  out:
> > > -	mutex_unlock(&indio_dev->mlock);
> > > +	mutex_unlock(&st->slock);
> > >
> > >  	return ret;
> > >  }
> > > @@ -432,16 +437,19 @@ static int ti_ads7950_probe(struct spi_device *spi)
> > >  	if (ACPI_COMPANION(&spi->dev))
> > >  		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
> > >
> > > +	mutex_init(&st->slock);
> > > +
> > >  	st->reg = devm_regulator_get(&spi->dev, "vref");
> > >  	if (IS_ERR(st->reg)) {
> > >  		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
> > > -		return PTR_ERR(st->reg);
> > > +		ret = PTR_ERR(st->reg);
> > > +		goto error_destroy_mutex;
> > >  	}
> > >
> > >  	ret = regulator_enable(st->reg);
> > >  	if (ret) {
> > >  		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
> > > -		return ret;
> > > +		goto error_destroy_mutex;
> > >  	}
> > >
> > >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > > @@ -463,6 +471,8 @@ static int ti_ads7950_probe(struct spi_device *spi)
> > >  	iio_triggered_buffer_cleanup(indio_dev);
> > >  error_disable_reg:
> > >  	regulator_disable(st->reg);
> > > +error_destroy_mutex:
> > > +	mutex_destroy(&st->slock);    
> > 
> > If your intention was to do resources cleanup then this is not
> > what this api was designed for. This is actually for debugging unwanted
> > subsequent mutex usage.  
> 
> Yes. In a case like this where it is the last thing in a remove
> it adds little value as there should be nothing left to take the mutex
> anyway.  This is the reason (I guess) there has never been a 
> devm_mutex_init function to tidy this up automatically...
> 
Having said that, I just realised I applied this anyway last week.
I'm not fussed enough about this to revert the change, so right
now the mutex_destroys are there.

Jonathan

> >   
> > >
> > >  	return ret;
> > >  }
> > > @@ -475,6 +485,7 @@ static int ti_ads7950_remove(struct spi_device *spi)
> > >  	iio_device_unregister(indio_dev);
> > >  	iio_triggered_buffer_cleanup(indio_dev);
> > >  	regulator_disable(st->reg);
> > > +	mutex_destroy(&st->slock);
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.7.4
> > >    
> 

