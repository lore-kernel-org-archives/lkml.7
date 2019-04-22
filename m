Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17195C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9C120874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555927792;
	bh=Zm4kFyxaYpjA3xZUn9W7OaivDnOYv903zZ9QVmhEDOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Mmtiy4f4Q1U5jYHhGxNbxc4CvbgrogG1pMOqkI69eiQ+FJThiA3YuZR89Z+qAlqhf
	 vxQfQ/HxyrlPw5+H4pYlNlIgojcnsf1mDEg2Py7vVjIIug9TF0zgUtWg5SITLO/MgL
	 L1kaiz7oSGxLMhJHh+BfrFj69MUOfdMKzL/DFPTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfDVKJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:09:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD9E20811;
        Mon, 22 Apr 2019 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555927791;
        bh=Zm4kFyxaYpjA3xZUn9W7OaivDnOYv903zZ9QVmhEDOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jK8NA6dO4acD2oqws+ZJa9zUBN7asRljKu/XcfPHZt7RzwMKJ0n/Nax/A+Npf4Wdl
         cjDXa4ujaT/VwJn4EN3ORQaRy4bgeFVlQwsegyw0F/n8EO0MjIhZ8y3yZqakQe/SAn
         oo8nllKdBvoj2Xfudsomff3YJ18UJHsprE9X5lC4=
Date:   Mon, 22 Apr 2019 11:09:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: imx7d_adc: Use devm_iio_device_register()
Message-ID: <20190422110946.4b1fb234@archlinux>
In-Reply-To: <20190414183504.23286-7-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
        <20190414183504.23286-7-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019 11:35:04 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Use devm_iio_device_register() and drop imx7d_adc_remove().
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index c5b0dc7d0e49..958a34dd88ac 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -554,7 +554,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Couldn't register the device.\n");
>  		return ret;
> @@ -563,21 +563,10 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int imx7d_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
> -
>  static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_disable, imx7d_adc_enable);
>  
>  static struct platform_driver imx7d_adc_driver = {
>  	.probe		= imx7d_adc_probe,
> -	.remove		= imx7d_adc_remove,
>  	.driver		= {
>  		.name	= "imx7d_adc",
>  		.of_match_table = imx7d_adc_match,

