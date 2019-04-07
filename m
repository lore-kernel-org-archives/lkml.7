Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20655C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44CB21738
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554635391;
	bh=2a3dqwlDSmIkS+TMHJFk5C6fafAc12OcldUsSPJ8hcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Qbpwat8NviRoY3W7GMPJbOnu6Jk+Yeb56YZgxyzT93Qy+bq0UpF9CPJM9YqmuYh9M
	 uLOqI2QivAh+6pCLoxlwKm8gepdVYoYcq3pXFjPRIB0ihlXzGw7pM19YeA8ZeLyOMm
	 DEC8f1EwW29/iS7sP5Id1nRP4eD+miQfWB6EErI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDGLJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:09:49 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D8920880;
        Sun,  7 Apr 2019 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554635388;
        bh=2a3dqwlDSmIkS+TMHJFk5C6fafAc12OcldUsSPJ8hcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uxXEfO3hWbOyzbv1qnGLdXoa4L+yHNmDiP24Ih3ijJpR0Yi6PaFYLsa7tt5kr1NkL
         RUcpXazZu9PjKUOsvn5w59pFVPjMlFo8S42/cE4gKAr3uF07omwG909vYzJs26DQL2
         gDKOEXmfLVLLgt22VXjDA9CkFO3tw4URCH+Dfwd0=
Date:   Sun, 7 Apr 2019 12:09:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imx7d_adc: Use
 devm_platform_ioremap_resource()
Message-ID: <20190407120943.3b0e316f@archlinux>
In-Reply-To: <20190403070325.1077-5-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
        <20190403070325.1077-5-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Apr 2019 00:03:23 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Use devm_platform_ioremap_resource() to be able to drop a bit of
> explicit boilerplate code.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
Great. That one is new to me. Looks like it only got added this cycle.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/imx7d_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 9a46838ec7cf..8bba92611d54 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -438,7 +438,6 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  {
>  	struct imx7d_adc *info;
>  	struct iio_dev *indio_dev;
> -	struct resource *mem;
>  	struct device *dev = &pdev->dev;
>  	int irq;
>  	int ret;
> @@ -452,8 +451,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	info = iio_priv(indio_dev);
>  	info->dev = dev;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	info->regs = devm_ioremap_resource(dev, mem);
> +	info->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(info->regs)) {
>  		ret = PTR_ERR(info->regs);
>  		dev_err(dev, "Failed to remap adc memory, err = %d\n", ret);

