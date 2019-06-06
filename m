Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722A8C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FB920866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfFFO4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:56:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728011AbfFFO4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:56:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 664D46298DBADB926477;
        Thu,  6 Jun 2019 22:56:51 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Jun 2019
 22:56:46 +0800
Date:   Thu, 6 Jun 2019 15:56:37 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>,
        Justin Chen <justinpopo6@gmail.com>,
        "Sasha Levin" <sashal@kernel.org>
Subject: Re: [PATCH 4.19 189/276] iio: adc: ti-ads7950: Fix improper use of
 mlock
Message-ID: <20190606155637.00002b4f@huawei.com>
In-Reply-To: <20190606131300.GE27432@amd>
References: <20190530030523.133519668@linuxfoundation.org>
        <20190530030537.017297326@linuxfoundation.org>
        <20190606131300.GE27432@amd>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019 15:13:00 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> (stable removed from cc list)
> 
> > Indio->mlock is used for protecting the different iio device modes.
> > It is currently not being used in this way. Replace the lock with
> > an internal lock specifically used for protecting the SPI transfer
> > buffer.
> > 
> > Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/iio/adc/ti-ads7950.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >   
> 
> > @@ -277,6 +280,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
> >  	struct ti_ads7950_state *st = iio_priv(indio_dev);
> >  	int ret;
> >  
> > +	mutex_lock(&st->slock);
> >  	ret = spi_sync(st->spi, &st->ring_msg);
> >  	if (ret < 0)
> >  		goto out;
> > @@ -285,6 +289,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
> >  					   iio_get_time_ns(indio_dev));
> >  
> >  out:
> > +	mutex_unlock(&st->slock);
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  
> >  	return IRQ_HANDLED;  
> 
> Does trigger_handler run from interrupt context? Prototype suggests
> so... If so, it can not really take mutexes...

It's an interrupt thread so taking mutexes should be fine.
For this particular case there is no 'top half' provided to
the call to iio_triggered_buffer_setup so nothing runs in interrupt context.

The spi_sync call can sleep anyway so this code can only run where
sleeping is fine.

Thanks,

Jonathan


> 
> Best regards,
> 								Pavel
> 								


