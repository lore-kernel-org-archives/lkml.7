Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06CCC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 12:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B370920850
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 12:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfGGMLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 08:11:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfGGMLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 08:11:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9A1FE5D50037484CFA55;
        Sun,  7 Jul 2019 20:11:30 +0800 (CST)
Received: from localhost (10.45.56.64) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sun, 7 Jul 2019
 20:11:26 +0800
Date:   Sun, 7 Jul 2019 13:11:23 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 05/10] iio: using dev_get_drvdata directly
Message-ID: <20190707131031.00000f0a@huawei.com>
In-Reply-To: <20190704023613.4643-1-huangfq.daxian@gmail.com>
References: <20190704023613.4643-1-huangfq.daxian@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.56.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 10:36:13 +0800
Fuqian Huang <huangfq.daxian@gmail.com> wrote:

> Several drivers cast a struct device pointer to a struct
> platform_device pointer only to then call platform_get_drvdata().
> To improve readability, these constructs can be simplified
> by using dev_get_drvdata() directly.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Hi.

I applied a version from Kefeng Wang a while back.  It'll be queued
up for the merge window that is about to open.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Make the commit message more clearly.
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 12 ++++--------
>  drivers/iio/adc/at91_adc.c         |  4 ++--
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index d384cf0250ff..a2837a0e7cba 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1578,8 +1578,7 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
>  static ssize_t at91_adc_get_fifo_state(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
>  {
> -	struct iio_dev *indio_dev =
> -			platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
> @@ -1588,8 +1587,7 @@ static ssize_t at91_adc_get_fifo_state(struct device *dev,
>  static ssize_t at91_adc_get_watermark(struct device *dev,
>  				      struct device_attribute *attr, char *buf)
>  {
> -	struct iio_dev *indio_dev =
> -			platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
> @@ -1841,8 +1839,7 @@ static int at91_adc_remove(struct platform_device *pdev)
>  
>  static __maybe_unused int at91_adc_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev =
> -			platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	/*
> @@ -1862,8 +1859,7 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
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
> index d23709ed9049..32f1c4a33b20 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1359,7 +1359,7 @@ static int at91_adc_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int at91_adc_suspend(struct device *dev)
>  {
> -	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *idev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(idev);
>  
>  	pinctrl_pm_select_sleep_state(dev);
> @@ -1370,7 +1370,7 @@ static int at91_adc_suspend(struct device *dev)
>  
>  static int at91_adc_resume(struct device *dev)
>  {
> -	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
> +	struct iio_dev *idev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(idev);
>  
>  	clk_prepare_enable(st->clk);


