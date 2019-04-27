Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D3C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3682087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556369816;
	bh=Lz6otYx7mFcj2Y/1fzaDIfrFjPlmohwy1PTAiBZEAY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ahaGdvVjLnh6uZCHJwGQ8Sv8CX4fwFUMX1k4atm59542yFWD2T1LAK8e3eSypX3gl
	 sCSnBgXp5pbI8cHqT6rix7SeSu6/QGowngS8O9V/GrxF/08V6kKxjP/gLN6Pp8pGLM
	 HSZue6ncN5CsSQ5MQKMVM/nUZgA51yeSk0RqK0Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfD0M4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfD0M4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:56:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A9B208C2;
        Sat, 27 Apr 2019 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556369812;
        bh=Lz6otYx7mFcj2Y/1fzaDIfrFjPlmohwy1PTAiBZEAY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zvox9MptHNGUzMG/+YrVYCyroAup7JSzs8fSsrq+y2JRbixRwZg1xErIsvMXrD4pA
         1D02TwnznPfUNEjgI7k+i0DXcASo6SMKnRs3VOcjGs2aJFoyz89j27XMue/cOcTbCp
         OeSdamrDAI4903LZFbyNfqXkY4LTLAeTvrqFFzOU=
Date:   Sat, 27 Apr 2019 13:56:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list), javier@dowhile0.org
Subject: Re: [PATCH v2] iio: accel: kxsd9: declare missing of table
Message-ID: <20190427135645.53cb78f7@archlinux>
In-Reply-To: <1556055659-14658-1-git-send-email-dagmcr@gmail.com>
References: <1556055659-14658-1-git-send-email-dagmcr@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 23:40:59 +0200
Daniel Gomez <dagmcr@gmail.com> wrote:

> Add missing <of_device_id> table for SPI driver relying on SPI
> device match since compatible is in a DT binding or in a DTS.
> 
> Before this patch:
> modinfo drivers/iio/accel/kxsd9-spi.ko  | grep alias
> alias:          spi:kxsd9
> 
> After this patch:
> modinfo drivers/iio/accel/kxsd9-spi.ko  | grep alias
> alias:          spi:kxsd9
> alias:          of:N*T*Ckionix,kxsd9C*
> alias:          of:N*T*Ckionix,kxsd9
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/kxsd9-spi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> index b7d0078..3027917 100644
> --- a/drivers/iio/accel/kxsd9-spi.c
> +++ b/drivers/iio/accel/kxsd9-spi.c
> @@ -1,5 +1,7 @@
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -40,10 +42,17 @@ static const struct spi_device_id kxsd9_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
>  
> +static const struct of_device_id kxsd9_of_match[] = {
> +        { .compatible = "kionix,kxsd9" },
> +        { },
> +};
> +MODULE_DEVICE_TABLE(of, kxsd9_of_match);
> +
>  static struct spi_driver kxsd9_spi_driver = {
>  	.driver = {
>  		.name = "kxsd9",
>  		.pm = &kxsd9_dev_pm_ops,
> +		.of_match_table = kxsd9_of_match,
>  	},
>  	.probe = kxsd9_spi_probe,
>  	.remove = kxsd9_spi_remove,

