Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D89C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686FF20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556369880;
	bh=u1MZzdayxtERIFHMbtGhNUz7kgsCpba86bQZy6SbmMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oH0KEC2ckYdvPddiylW1tSakhTl5VadHjcQ5IUTyQl75aM7Iu87C6js7DKlOfPJo/
	 hd1d/A2zA1HfK0LfB+T2PV3QjI6s1k0n5sTZB54YcF9ApV4xWZE0QVJ1pfs9z/mTnI
	 WMUq14MiS9DZls/uAOT/f/IrMw/0+7CifRpcWJgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfD0M57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfD0M57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:57:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3803E2087C;
        Sat, 27 Apr 2019 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556369878;
        bh=u1MZzdayxtERIFHMbtGhNUz7kgsCpba86bQZy6SbmMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E2nTilpONA+R746fWElEOBdXq4xh0DCgB8VMDkbiDJcsz5RjY9k72kZpVltnYndjk
         8SrIXUL11j02RdWNhmcDef8rQlxOlm63qyc4QYIhyGWhw8LWT+i3T7oOCy1YMZBmAP
         KXpUbzV5p0Sqvt4Hxoem+8TdjdPZ8Wjn0aNsbVwA=
Date:   Sat, 27 Apr 2019 13:57:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list), javier@dowhile0.org
Subject: Re: [PATCH v2] iio: adxl372: declare missing of table
Message-ID: <20190427135752.29d41c8b@archlinux>
In-Reply-To: <1556055697-14723-1-git-send-email-dagmcr@gmail.com>
References: <1556055697-14723-1-git-send-email-dagmcr@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 23:41:37 +0200
Daniel Gomez <dagmcr@gmail.com> wrote:

> Add missing <of_device_id> table for SPI driver relying on SPI
> device match since compatible is in a DT binding or in a DTS.
> 
> Before this patch:
> modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> 
> After this patch:
> modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> alias:          spi:adxl372
> alias:          of:N*T*Cadi,adxl372C*
> alias:          of:N*T*Cadi,adxl372
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl372_spi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> index e14e655..3ef7e3a 100644
> --- a/drivers/iio/accel/adxl372_spi.c
> +++ b/drivers/iio/accel/adxl372_spi.c
> @@ -7,6 +7,8 @@
>  
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/spi/spi.h>
>  
>  #include "adxl372.h"
> @@ -37,9 +39,16 @@ static const struct spi_device_id adxl372_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
>  
> +static const struct of_device_id adxl372_of_match[] = {
> +        { .compatible = "adi,adxl372" },
> +        { },
> +};
> +MODULE_DEVICE_TABLE(of, adxl372_of_match);
> +
>  static struct spi_driver adxl372_spi_driver = {
>  	.driver = {
>  		.name = "adxl372_spi",
> +		.of_match_table = adxl372_of_match,
>  	},
>  	.probe = adxl372_spi_probe,
>  	.id_table = adxl372_spi_id,

