Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F71C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BFD218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555247179;
	bh=cdKT5SX/27YJo1RnvVL65oI7CKIhKR5REnidkGm3c9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fLkptOZQSYPRTrC65AmEDJV8C22u7s3eVsuzKtseCSwqdTafhqJ+P+BTmr37bCbka
	 kMLpuVgcXsss21Wn2JaD+9mAHB5n4qnAqzQylW54yLF01oVtwF7rA42Elk8bcIe35W
	 HYyV4t6pEIrUv1lP72P1acbuS7xfB6FegaqVgcPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfDNNGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfDNNGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 09:06:17 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1742148E;
        Sun, 14 Apr 2019 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555247176;
        bh=cdKT5SX/27YJo1RnvVL65oI7CKIhKR5REnidkGm3c9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2r6V72ci8TqMN0SRj88mQzbc99Ui4nRAepwU6BUiEtAbqYB/O7RoukBLs3+SzIDck
         Ai3b3fj/FqZ5W+eJ6ltBSoA+BSMmoWNh63ou18qlKJmJYJD1J+iu14uBrWP73nIEJo
         wG7Xt1w+R7vTT/5QO89gm5dQZc+PyAEtsRrXe6og=
Date:   Sun, 14 Apr 2019 14:06:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, songqiang1304521@gmail.com,
        robh@kernel.org, m.othacehe@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] srf04.c: add maxbotix ultrasonic sensors
Message-ID: <20190414140610.20039659@archlinux>
In-Reply-To: <20190409191021.w6phf2q4m2pxcrkq@arbad>
References: <20190409191021.w6phf2q4m2pxcrkq@arbad>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 21:10:22 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> add Maxbotix LV ultrasonic sensor types mb1000, mb1010, mb1020, mb1030
> and mb1040
> 
> add a configuration struct with the different trigger pulse lengths
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/srf04.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 09c7b9c095b0..1bad4018d1aa 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -23,7 +23,7 @@
>   * trig:  --+   +------------------------------------------------------
>   *          ^   ^
>   *          |<->|
> - *         udelay(10)
> + *         udelay(trigger_pulse_us)
>   *
>   * ultra           +-+ +-+ +-+
>   * sonic           | | | | | |
> @@ -48,6 +48,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/sched.h>
> @@ -56,6 +57,10 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +struct srf04_cfg {
> +	unsigned long trigger_pulse_us;
> +};
> +
>  struct srf04_data {
>  	struct device		*dev;
>  	struct gpio_desc	*gpiod_trig;
> @@ -66,6 +71,15 @@ struct srf04_data {
>  	ktime_t			ts_falling;
>  	struct completion	rising;
>  	struct completion	falling;
> +	const struct srf04_cfg	*cfg;
> +};
> +
> +static const struct srf04_cfg srf04_cfg = {
> +	.trigger_pulse_us = 10,
> +};
> +
> +static const struct srf04_cfg mb_lv_cfg = {
> +	.trigger_pulse_us = 20,
>  };
>  
>  static irqreturn_t srf04_handle_irq(int irq, void *dev_id)
> @@ -102,7 +116,7 @@ static int srf04_read(struct srf04_data *data)
>  	reinit_completion(&data->falling);
>  
>  	gpiod_set_value(data->gpiod_trig, 1);
> -	udelay(10);
> +	udelay(data->cfg->trigger_pulse_us);
>  	gpiod_set_value(data->gpiod_trig, 0);
>  
>  	/* it cannot take more than 20 ms */
> @@ -215,6 +229,18 @@ static const struct iio_chan_spec srf04_chan_spec[] = {
>  	},
>  };
>  
> +static const struct of_device_id of_srf04_match[] = {
> +	{ .compatible = "devantech,srf04", .data = &srf04_cfg},
> +	{ .compatible = "maxbotix,mb1000", .data = &mb_lv_cfg},
> +	{ .compatible = "maxbotix,mb1010", .data = &mb_lv_cfg},
> +	{ .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg},
> +	{ .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg},
> +	{ .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_srf04_match);
> +
>  static int srf04_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -230,6 +256,7 @@ static int srf04_probe(struct platform_device *pdev)
>  
>  	data = iio_priv(indio_dev);
>  	data->dev = dev;
> +	data->cfg = of_match_device(of_srf04_match, dev)->data;
>  
>  	mutex_init(&data->lock);
>  	init_completion(&data->rising);
> @@ -280,13 +307,6 @@ static int srf04_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> -static const struct of_device_id of_srf04_match[] = {
> -	{ .compatible = "devantech,srf04", },
> -	{},
> -};
> -
> -MODULE_DEVICE_TABLE(of, of_srf04_match);
> -
>  static struct platform_driver srf04_driver = {
>  	.probe		= srf04_probe,
>  	.driver		= {

