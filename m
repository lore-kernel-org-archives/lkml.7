Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD5CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432D420862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572705477;
	bh=4aKFoWXZC1vBWmdZBlN+4gGl3ioFIQxorsLJ/K+QKgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kgDzbMqkxsTXHj99/zQiPEEjxMb1iLHyRkplFPR15eBFWC+G15Pfo1194i2/nGhNE
	 zYWlAMZ72a7iQYaEJ2Atr1U260Ar7KmTW7UAU1tRgZyai8TQwLniPmtiikc+CCdAI/
	 6n7hf/Xjd0sSKWGwHDrZRMexui89951Hhxn6mpnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfKBOh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 10:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfKBOh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 10:37:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E42FF20862;
        Sat,  2 Nov 2019 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572705474;
        bh=4aKFoWXZC1vBWmdZBlN+4gGl3ioFIQxorsLJ/K+QKgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1/w6ds4HNlKHGvY2ce7ceUj/K7rOCWW6SdHN1y1fCUjckmfhh97cNX+U6IkUzgMY3
         Lvfe8F42cjeZHh+//BQjwPoEOivxfDcwxbkoFY2pFAiuLqtlZ+o5xuZD9XOa5FhmvU
         qdmsVxotGna/1NwT9Z0NHx1R9YCnMCUzlsJmya+Y=
Date:   Sat, 2 Nov 2019 14:37:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jack Andersen <jackoalan@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dln2-adc: fix iio_triggered_buffer_postenable()
 position
Message-ID: <20191102143750.17beeb16@archlinux>
In-Reply-To: <CAPHBK3a-EQVZzF-LZC-jNCinF3i09PRG7ZA+hporMr5JvFpDtQ@mail.gmail.com>
References: <20191023082634.18195-1-alexandru.ardelean@analog.com>
        <20191027165651.1da18263@archlinux>
        <CAPHBK3a-EQVZzF-LZC-jNCinF3i09PRG7ZA+hporMr5JvFpDtQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:58:16 -1000
Jack Andersen <jackoalan@gmail.com> wrote:

> These changes look fine to me as well.
> 
> I no longer have access to a DLN2 for empirical testing, but since this is
> mainly integration improvements with the IIO side of things, it shouldn't make
> a difference for the hardware.

Whilst I have one of these, it'll will be a while before I'm in any position
to test it.  Hence let's gamble a tiny bit.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> 
> 
> On Sun, 27 Oct 2019 at 06:56, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 23 Oct 2019 11:26:34 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >  
> > > The iio_triggered_buffer_postenable() hook should be called first to
> > > attach the poll function. The iio_triggered_buffer_predisable() hook is
> > > called last (as is it should).
> > >
> > > This change moves iio_triggered_buffer_postenable() to be called first. It
> > > adds iio_triggered_buffer_predisable() on the error paths of the postenable
> > > hook.
> > > For the predisable hook, some code-paths have been changed to make sure
> > > that the iio_triggered_buffer_predisable() hook gets called in case there
> > > is an error before it.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > +CC Jack who wrote the driver.
> >
> > Looks fine to me, but I always like these to sit for a while and ideally get
> > review from the authors / maintainers of the drivers.
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/adc/dln2-adc.c | 20 ++++++++++++++------
> > >  1 file changed, 14 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> > > index 5fa78c273a25..65c7c9329b1c 100644
> > > --- a/drivers/iio/adc/dln2-adc.c
> > > +++ b/drivers/iio/adc/dln2-adc.c
> > > @@ -524,6 +524,10 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> > >       u16 conflict;
> > >       unsigned int trigger_chan;
> > >
> > > +     ret = iio_triggered_buffer_postenable(indio_dev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > >       mutex_lock(&dln2->mutex);
> > >
> > >       /* Enable ADC */
> > > @@ -537,6 +541,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> > >                               (int)conflict);
> > >                       ret = -EBUSY;
> > >               }
> > > +             iio_triggered_buffer_predisable(indio_dev);
> > >               return ret;
> > >       }
> > >
> > > @@ -550,6 +555,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> > >               mutex_unlock(&dln2->mutex);
> > >               if (ret < 0) {
> > >                       dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> > > +                     iio_triggered_buffer_predisable(indio_dev);
> > >                       return ret;
> > >               }
> > >       } else {
> > > @@ -557,12 +563,12 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> > >               mutex_unlock(&dln2->mutex);
> > >       }
> > >
> > > -     return iio_triggered_buffer_postenable(indio_dev);
> > > +     return 0;
> > >  }
> > >
> > >  static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
> > >  {
> > > -     int ret;
> > > +     int ret, ret2;
> > >       struct dln2_adc *dln2 = iio_priv(indio_dev);
> > >
> > >       mutex_lock(&dln2->mutex);
> > > @@ -577,12 +583,14 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
> > >       ret = dln2_adc_set_port_enabled(dln2, false, NULL);
> > >
> > >       mutex_unlock(&dln2->mutex);
> > > -     if (ret < 0) {
> > > +     if (ret < 0)
> > >               dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> > > -             return ret;
> > > -     }
> > >
> > > -     return iio_triggered_buffer_predisable(indio_dev);
> > > +     ret2 = iio_triggered_buffer_predisable(indio_dev);
> > > +     if (ret == 0)
> > > +             ret = ret2;
> > > +
> > > +     return ret;
> > >  }
> > >
> > >  static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {  
> >  

