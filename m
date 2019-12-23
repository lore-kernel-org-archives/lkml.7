Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BF3C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FDF207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577103845;
	bh=Vgx5kkZxq6WSwi2yMCs7kTKdgl096+zl5Kn0qpcdGXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jUhP5kFdMqYThcepNrzgkqztI1yw2gHoR8pocPZeA1Qs1osZIpkRTDLGLrU1c2JNX
	 krkZmespQdOYWrV7V2F487Kl9nGHm135t/PwbwQWW0b/QacD8qXbmnoYKf892cZMJ0
	 phPrU5+l+UFU1IgyK276UhuPdXjC8g9UFinrs+Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLWMYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLWMYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 07:24:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49060206D3;
        Mon, 23 Dec 2019 12:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577103843;
        bh=Vgx5kkZxq6WSwi2yMCs7kTKdgl096+zl5Kn0qpcdGXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q9DMPPFOz/+LcUdzqXvoP02fVbupfL3O7o9COhqUulh4Ja1VMN0mPY5YV4wD1Sw3M
         qwj5ze01u7GvIb8htE+nKT6vobbvZjpuE8laFrEPAtj4XMDHOgejgTQi2BkB8ik5D5
         Hp+Pn5yu+KY04xuk4WyQpcVddfgbbh8YiwBXDHHc=
Date:   Mon, 23 Dec 2019 12:23:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 07/10] iio: adc: at91-sama5d2_adc: fix differential
 channels in triggered mode
Message-ID: <20191223122357.52d0ac11@archlinux>
In-Reply-To: <1576686157-11939-8-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
        <1576686157-11939-8-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 16:24:02 +0000
<Eugen.Hristev@microchip.com> wrote:

> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> The differential channels require writing the channel offset register (COR).
> Otherwise they do not work in differential mode.
> The configuration of COR is missing in triggered mode.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
I'm not totally sure whether this predates the changes here, but if it does
please pull it to the front of the set and give it a fixes tag.

Otherwise, look at merging it in with where-ever it was introduced.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index a6b4dff..ccffa48 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -900,6 +900,7 @@ static int at91_adc_buffer_postenable(struct iio_dev *indio)
>  
>  	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
>  		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
> +		u32 cor;
>  
>  		if (!chan)
>  			continue;
> @@ -908,6 +909,17 @@ static int at91_adc_buffer_postenable(struct iio_dev *indio)
>  		    chan->type == IIO_PRESSURE)
>  			continue;
>  
> +		cor = at91_adc_readl(st, AT91_SAMA5D2_COR);
> +
> +		if (chan->differential)
> +			cor |= (BIT(chan->channel) | BIT(chan->channel2)) <<
> +			       AT91_SAMA5D2_COR_DIFF_OFFSET;
> +		else
> +			cor &= ~(BIT(chan->channel) <<
> +			       AT91_SAMA5D2_COR_DIFF_OFFSET);
> +
> +		at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
> +
>  		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
>  		if (use_irq) {
>  			at91_adc_writel(st, AT91_SAMA5D2_IER,

