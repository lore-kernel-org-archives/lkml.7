Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA4C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C80208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfD0MH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:07:29 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:41852 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfD0MH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:07:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id E00069E82A3;
        Sat, 27 Apr 2019 13:07:25 +0100 (BST)
Date:   Sat, 27 Apr 2019 13:07:22 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH next 08/25] iio: adc: at91: Use dev_get_drvdata()
Message-ID: <20190427130722.70ec290b@archlinux>
In-Reply-To: <20190423075020.173734-9-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
        <20190423075020.173734-9-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 15:50:03 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Using dev_get_drvdata directly.
> 
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

A sensible cleanup, thanks.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 12 ++++--------
>  drivers/iio/adc/at91_adc.c         |  4 ++--
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index d5ea84cf6460..a3a4ca946308 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1586,8 +1586,7 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
>  static ssize_t at91_adc_get_fifo_state(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
>  {
> -	struct iio_dev *indio_dev =
> -			platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
> @@ -1596,8 +1595,7 @@ static ssize_t at91_adc_get_fifo_state(struct device *dev,
>  static ssize_t at91_adc_get_watermark(struct device *dev,
>  				      struct device_attribute *attr, char *buf)
>  {
> -	struct iio_dev *indio_dev =
> -			platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
> @@ -1849,8 +1847,7 @@ static int at91_adc_remove(struct platform_device *pdev)
>  
>  static __maybe_unused int at91_adc_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev =
> -			platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	/*
> @@ -1870,8 +1867,7 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
>  
>  static __maybe_unused int at91_adc_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev =
> -			platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 596841a3c4db..1aa8af3491fd 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1360,7 +1360,7 @@ static int at91_adc_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int at91_adc_suspend(struct device *dev)
>  {
> -	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *idev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(idev);
>  
>  	pinctrl_pm_select_sleep_state(dev);
> @@ -1371,7 +1371,7 @@ static int at91_adc_suspend(struct device *dev)
>  
>  static int at91_adc_resume(struct device *dev)
>  {
> -	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *idev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(idev);
>  
>  	clk_prepare_enable(st->clk);

