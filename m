Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF9C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CD920857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551632570;
	bh=R3eamD6lN/JCMxElhyRFMoPpOHrBWl6fRgkw7wq0Z2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=x+QgrJYBzEVqYfD+dHRAFz0mjznNJeKoETe9zhRwataPwXMrARhbqzyODQx0ReBgG
	 PAAd/nVLUEX1oNAAgp2/zOoMAIsmYOgsj/sgE+aRDiK16koXeX0SKJF6PJGlUlDOc2
	 jyMVp82rP7/FaAiCBZEoBj0S8+wWCxrh29lIaHyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCCRCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfCCRCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:02:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADEB2070B;
        Sun,  3 Mar 2019 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551632566;
        bh=R3eamD6lN/JCMxElhyRFMoPpOHrBWl6fRgkw7wq0Z2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jSfnibrBMSLY8g7boqQPVREloqjyZ32NjTdtPWx0SP82BWiMIFm/1Gg9viVZHftxc
         +sDO/cVQZK1FybtiKNFTdaAR4RRx59kneCOTjbuU/adOveWlPBUtTzzSRCsiDDoGDO
         xBm+FNZCOoY//rMyp/EFTXYobsBRRCyDgerkkUKk=
Date:   Sun, 3 Mar 2019 17:02:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Bia, Beniamin" <Beniamin.Bia@analog.com>
Cc:     "biabeniamin@outlook.com" <biabeniamin@outlook.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] staging: iio: frequency: ad9834: Move frequency
 to standard iio types
Message-ID: <20190303170240.4105c0c1@archlinux>
In-Reply-To: <3b23e1b16272b3f45fa3cbe1811bbe85515d0606.camel@analog.com>
References: <20190214164130.30085-1-beniamin.bia@analog.com>
        <20190220115030.0de87cfc@archlinux>
        <3b23e1b16272b3f45fa3cbe1811bbe85515d0606.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 13:10:26 +0000
"Bia, Beniamin" <Beniamin.Bia@analog.com> wrote:

> Thank you for taking some time reviewing my code.
> Ad9833/ad9834 has two frequency and phase registers and only one
> output. The user can select which register is selected as input with a
> mux.Because I wanted to reduce as much as possible the custom
> attributes, I mapped the frequency 0 from register to channel 0 and
> frequency 1 to channel 1. Same rule applies for phase. 
I can see the argument, but really don't think this ends up as an
intuitive mapping.  I think we need something new to handle
values that change with 'symbol'.

> 
> In order to keep the same structure as before:
> out_altvoltage0_frequency0 and out_altvoltage1_frequency1,
> we would have to create custom attributes for every frequency and phase value.
> This is the only way as far as I know, but I don't have a lot of experience with iio. What is your opinion? Do you have a better solution?

Sorry it took me so long to reply to this.

So, we have had similar issues before, particularly around power
meters where we need a 'broader' concept of index to allow for multiple
related measurements.

However, in this case I think we can sort of think of the values being
aspects controlled by a symbol, which might map onto an 'axis' for
example (stretching the definition).

So maybe define some new modifiers, symbolA, symbolB for example giving
us
out_altvoltage0_symbolA_frequency
out_altvoltage0_symbolB_frequency.

This is a discussion I'd like others to contribute to though as
interface design is always a pain to get right!



> 
> Thanks,
> Ben 
> > [External]
> > 
> > 
> > On Thu, 14 Feb 2019 18:41:29 +0200
> > Beniamin Bia <beniamin.bia@analog.com> wrote:
> >   
> > > Frequency attribute is added with a standard type from iio
> > > framework
> > > instead of custom attribute. This is a small step towards removing
> > > any
> > > unnecessary custom attribute. Ad9834 will diverge from ad9833 in
> > > the
> > > future, that is why we have two identical arrays for ad9834 and
> > > 9833.
> > > 
> > > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>  
> > 
> > Hi Beniamin
> > 
> > When you make a change like this, please explain in detail how the
> > ABI
> > changes.  Here I'm not sure we can actually map it to channels like
> > this.
> > We are controlling the two frequencies of FSK not independent
> > channels.
> > 
> > The ABI around this needs very careful thinking out.  I would
> > document
> > your proposed ABI first and share that.  Once we reach agreement on
> > the
> > ABI, the actual code should be more straight forward!
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > Changes in v2:
> > >       -the personal email address was replaced by the work email
> > >       -separate define for frequency channel
> > >       -address field from channel specification was removed
> > >       -frequency variables were replaced by an array
> > >       -specified in comment why we have differente chan_spec for
> > > ad9834 and ad9833
> > >       -enum used for write_frequency function
> > > 
> > >  drivers/staging/iio/frequency/ad9834.c | 110 ++++++++++++++++++++-
> > > ----
> > >  1 file changed, 91 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/frequency/ad9834.c
> > > b/drivers/staging/iio/frequency/ad9834.c
> > > index f036f75d1f22..561617046c20 100644
> > > --- a/drivers/staging/iio/frequency/ad9834.c
> > > +++ b/drivers/staging/iio/frequency/ad9834.c
> > > @@ -81,6 +81,8 @@ struct ad9834_state {
> > >       struct spi_message              freq_msg;
> > >       struct mutex                    lock;   /* protect sensor
> > > state */
> > > 
> > > +     unsigned long                   frequency[2];
> > > +
> > >       /*
> > >        * DMA (thus cache coherency maintenance) requires the
> > >        * transfer buffers to live in their own cache lines.
> > > @@ -89,6 +91,11 @@ struct ad9834_state {
> > >       __be16                          freq_data[2];
> > >  };
> > > 
> > > +enum ad9834_ch_addr {
> > > +     AD9834_CHANNEL_ADDRESS0,
> > > +     AD9834_CHANNEL_ADDRESS1,
> > > +};
> > > +
> > >  /**
> > >   * ad9834_supported_device_ids:
> > >   */
> > > @@ -100,6 +107,24 @@ enum ad9834_supported_device_ids {
> > >       ID_AD9838,
> > >  };
> > > 
> > > +#define AD9833_CHANNEL(chan)
> > > {                                               \
> > > +             .type =
> > > IIO_ALTVOLTAGE,                                 \
> > > +             .indexed =
> > > 1,                                           \
> > > +             .output =
> > > 1,                                            \
> > > +             .channel =
> > > (chan),                                      \
> > > +             .info_mask_separate =
> > > BIT(IIO_CHAN_INFO_FREQUENCY)      \
> > > +}
> > > +
> > > +static const struct iio_chan_spec ad9833_channels[] = {
> > > +     AD9833_CHANNEL(0),
> > > +     AD9833_CHANNEL(1),
> > > +};
> > > +
> > > +static const struct iio_chan_spec ad9834_channels[] = {
> > > +     AD9833_CHANNEL(0),
> > > +     AD9833_CHANNEL(1),
> > > +};
> > > +
> > >  static unsigned int ad9834_calc_freqreg(unsigned long mclk,
> > > unsigned long fout)
> > >  {
> > >       unsigned long long freqreg = (u64)fout *
> > > (u64)BIT(AD9834_FREQ_BITS);
> > > @@ -109,10 +134,12 @@ static unsigned int
> > > ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
> > >  }
> > > 
> > >  static int ad9834_write_frequency(struct ad9834_state *st,
> > > -                               unsigned long addr, unsigned long
> > > fout)
> > > +                               enum ad9834_ch_addr addr,
> > > +                               unsigned long fout)
> > >  {
> > >       unsigned long clk_freq;
> > >       unsigned long regval;
> > > +     int ret;
> > > 
> > >       clk_freq = clk_get_rate(st->mclk);
> > > 
> > > @@ -121,13 +148,27 @@ static int ad9834_write_frequency(struct
> > > ad9834_state *st,
> > > 
> > >       regval = ad9834_calc_freqreg(clk_freq, fout);
> > > 
> > > -     st->freq_data[0] = cpu_to_be16(addr | (regval &
> > > -                                    RES_MASK(AD9834_FREQ_BITS /
> > > 2)));
> > > -     st->freq_data[1] = cpu_to_be16(addr | ((regval >>
> > > -                                    (AD9834_FREQ_BITS / 2)) &
> > > -                                    RES_MASK(AD9834_FREQ_BITS /
> > > 2)));
> > > +     if (addr == AD9834_CHANNEL_ADDRESS0) {  
> > 
> > So this if statement picks between the two addresses with no other
> > differences?
> > That's fine, but use a local variable for the register address to
> > simplify
> > the code.
> >   
> > > +             st->freq_data[0] = cpu_to_be16(AD9834_REG_FREQ0 |
> > > (regval &
> > > +                                            RES_MASK(AD9834_FREQ_B
> > > ITS / 2)));
> > > +             st->freq_data[1] = cpu_to_be16(AD9834_REG_FREQ0 |
> > > ((regval >>
> > > +                                            (AD9834_FREQ_BITS /
> > > 2)) &
> > > +                                            RES_MASK(AD9834_FREQ_B
> > > ITS / 2)));
> > > +     } else {
> > > +             st->freq_data[0] = cpu_to_be16(AD9834_REG_FREQ1 |
> > > (regval &
> > > +                                            RES_MASK(AD9834_FREQ_B
> > > ITS / 2)));
> > > +             st->freq_data[1] = cpu_to_be16(AD9834_REG_FREQ1 |
> > > ((regval >>
> > > +                                            (AD9834_FREQ_BITS /
> > > 2)) &
> > > +                                            RES_MASK(AD9834_FREQ_B
> > > ITS / 2)));
> > > +     }
> > > +
> > > +     ret = spi_sync(st->spi, &st->freq_msg);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     st->frequency[(int)addr] = fout;
> > > 
> > > -     return spi_sync(st->spi, &st->freq_msg);
> > > +     return 0;
> > >  }
> > > 
> > >  static int ad9834_write_phase(struct ad9834_state *st,
> > > @@ -140,6 +181,39 @@ static int ad9834_write_phase(struct
> > > ad9834_state *st,
> > >       return spi_sync(st->spi, &st->msg);
> > >  }
> > > 
> > > +static int ad9834_read_raw(struct iio_dev *indio_dev,
> > > +                        struct iio_chan_spec const *chan,
> > > +                        int *val, int *val2, long mask)
> > > +{
> > > +     struct ad9834_state *st = iio_priv(indio_dev);
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_FREQUENCY:
> > > +             *val = st->frequency[chan->channel];
> > > +             return IIO_VAL_INT;
> > > +     }
> > > +
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static int ad9834_write_raw(struct iio_dev *indio_dev,
> > > +                         struct iio_chan_spec const *chan,
> > > +                         int val, int val2, long mask)
> > > +{
> > > +     struct ad9834_state *st = iio_priv(indio_dev);
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_FREQUENCY:
> > > +             return ad9834_write_frequency(st,
> > > +                                           (enum
> > > ad9834_ch_addr)chan->channel,
> > > +                                           val);
> > > +     default:
> > > +             return  -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static ssize_t ad9834_write(struct device *dev,
> > >                           struct device_attribute *attr,
> > >                           const char *buf,
> > > @@ -157,10 +231,6 @@ static ssize_t ad9834_write(struct device
> > > *dev,
> > > 
> > >       mutex_lock(&st->lock);
> > >       switch ((u32)this_attr->address) {
> > > -     case AD9834_REG_FREQ0:
> > > -     case AD9834_REG_FREQ1:
> > > -             ret = ad9834_write_frequency(st, this_attr->address,
> > > val);
> > > -             break;
> > >       case AD9834_REG_PHASE0:
> > >       case AD9834_REG_PHASE1:
> > >               ret = ad9834_write_phase(st, this_attr->address,
> > > val);
> > > @@ -323,8 +393,6 @@ static
> > > IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
> > >   * see dds.h for further information
> > >   */
> > > 
> > > -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write,
> > > AD9834_REG_FREQ0);
> > > -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write,
> > > AD9834_REG_FREQ1);
> > >  static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write,
> > > AD9834_FSEL);
> > >  static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
> > > 
> > > @@ -342,8 +410,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0,
> > > ad9834_store_wavetype, 0);
> > >  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
> > > 
> > >  static struct attribute *ad9834_attributes[] = {
> > > -     &iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> > > -     &iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
> > >       &iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr
> > > ,
> > >       &iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
> > >       &iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> > > @@ -361,8 +427,6 @@ static struct attribute *ad9834_attributes[] =
> > > {
> > >  };
> > > 
> > >  static struct attribute *ad9833_attributes[] = {
> > > -     &iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> > > -     &iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,  
> > 
> > This may be a problem...  These don't fit in the existing ABI in that
> > they
> > are (IIRC) two different frequencies for the same channel, not two
> > different
> > channels...  This is meant for simple FSK modulation.
> >   
> > >       &iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr
> > > ,
> > >       &iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
> > >       &iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> > > @@ -384,11 +448,15 @@ static const struct attribute_group
> > > ad9833_attribute_group = {
> > >  };
> > > 
> > >  static const struct iio_info ad9834_info = {
> > > +     .write_raw = &ad9834_write_raw,
> > > +     .read_raw = &ad9834_read_raw,
> > >       .attrs = &ad9834_attribute_group,
> > >       .driver_module = THIS_MODULE,
> > >  };
> > > 
> > >  static const struct iio_info ad9833_info = {
> > > +     .write_raw = &ad9834_write_raw,
> > > +     .read_raw = &ad9834_read_raw,
> > >       .attrs = &ad9833_attribute_group,
> > >       .driver_module = THIS_MODULE,
> > >  };
> > > @@ -435,9 +503,13 @@ static int ad9834_probe(struct spi_device
> > > *spi)
> > >       switch (st->devid) {
> > >       case ID_AD9833:
> > >       case ID_AD9837:
> > > +             indio_dev->channels = ad9833_channels;
> > > +             indio_dev->num_channels =
> > > ARRAY_SIZE(ad9833_channels);
> > >               indio_dev->info = &ad9833_info;
> > >               break;
> > >       default:  
> > 
> > For future reference, I would definitely like to see the options that
> > lead to here explicitly listed.  Semantically it's not a 'default'
> > but rather an alternative equally valid choice.
> > People also tend to grep for their devid ;)
> >   
> > > +             indio_dev->channels = ad9834_channels;
> > > +             indio_dev->num_channels =
> > > ARRAY_SIZE(ad9834_channels);
> > >               indio_dev->info = &ad9834_info;
> > >               break;
> > >       }
> > > @@ -474,11 +546,11 @@ static int ad9834_probe(struct spi_device
> > > *spi)
> > >               goto error_clock_unprepare;
> > >       }
> > > 
> > > -     ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
> > > +     ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS0,
> > > 1000000);
> > >       if (ret)
> > >               goto error_clock_unprepare;
> > > 
> > > -     ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
> > > +     ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS1,
> > > 5000000);
> > >       if (ret)
> > >               goto error_clock_unprepare;
> > >   
> > 
> >   

