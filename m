Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9172AC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 12:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B6213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 12:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDGMDU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 08:03:20 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34070 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDGMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 08:03:20 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5BADD9E7522;
        Sun,  7 Apr 2019 13:03:18 +0100 (BST)
Date:   Sun, 7 Apr 2019 13:03:16 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Vincent =?UTF-8?B?U3RlaGzDqQ==?= <vincent.stehle@laposte.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: ads124: avoid buffer overflow
Message-ID: <20190407130316.2ff07791@archlinux>
In-Reply-To: <20190407130242.6699b510@archlinux>
References: <20190331185423.11749-1-vincent.stehle@laposte.net>
        <95d93ae2-1b7b-76fc-f72b-014a006f4c21@ti.com>
        <20190407130242.6699b510@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2019 13:02:42 +0100
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> On Mon, 1 Apr 2019 07:41:37 -0500
> Dan Murphy <dmurphy@ti.com> wrote:
> 
> > On 3/31/19 1:54 PM, Vincent Stehlé wrote:  
> > > When initializing the priv->data array starting from index 1, there is one
> > > less element to consider than when initializing the full array.
> > > 
> > > Fixes: e717f8c6dfec8f76 ("iio: adc: Add the TI ads124s08 ADC code")
> > > Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> > > Cc: Dan Murphy <dmurphy@ti.com>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/iio/adc/ti-ads124s08.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> > > index 53f17e4f2f230..552c2be8d87ad 100644
> > > --- a/drivers/iio/adc/ti-ads124s08.c
> > > +++ b/drivers/iio/adc/ti-ads124s08.c
> > > @@ -202,7 +202,7 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
> > >  	};
> > >  
> > >  	priv->data[0] = ADS124S08_CMD_RDATA;
> > > -	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data));
> > > +	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data) - 1);
> > >  
> > >  	ret = spi_sync_transfer(priv->spi, t, ARRAY_SIZE(t));
> > >  	if (ret < 0)
> > >     
> > 
> > Reviewed-by: Dan Murphy <dmurphy@ti.com>  
> 
> Applied to the fixes-togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
Wrong finger memory. Not pushed out as testing. Pushed out as fixes-togreg!

Jonathan
> 
> Thanks,
> 
> Jonathan

