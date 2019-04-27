Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF46C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AD208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556369954;
	bh=SCMQ+UkQFCeEOlSoiyp8ynwOrB4RzkdmSZX/WHkprsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PPtqDdmc7UDPwXPlwukMNiQn0K8qoUFdoc445+R7eCcYUS7h7ltiU1nio+oAGhV+z
	 V/7/r7Ojwkf4+pCEpJhhWFPXii7UmF9yf1vByrjpiEFb9A33+hpW7G3Cje2Q2suE8R
	 pvWS4NpkgshrG30dAxTaPRVVGUMkiZ53bdnaXiyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfD0M7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfD0M7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:59:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341312087C;
        Sat, 27 Apr 2019 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556369952;
        bh=SCMQ+UkQFCeEOlSoiyp8ynwOrB4RzkdmSZX/WHkprsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tOmLf8J/SQRk6PiMizBtZB/sNTgbv5YFKb57LtEtb5UaunXHd73BQ5rN0MiOQaPJX
         IK6q9Tp7zAtQcwpHQG+iV8PjFmK5YVqUFz2p28IU5LvecuEEpGKgUT9RRb/6ApplQk
         MPCoj1zr9PEujz58neuBO9V7KKp5l4k9TxH5b3Io=
Date:   Sat, 27 Apr 2019 13:59:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:ANALOG DEVICES INC AD5758 DRIVER),
        linux-kernel@vger.kernel.org (open list), javier@dowhile0.org
Subject: Re: [PATCH v2] iio: dac: ad5758: declare missing of table
Message-ID: <20190427135906.455c468b@archlinux>
In-Reply-To: <1556055718-14782-1-git-send-email-dagmcr@gmail.com>
References: <1556055718-14782-1-git-send-email-dagmcr@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 23:41:58 +0200
Daniel Gomez <dagmcr@gmail.com> wrote:

> Add missing <of_device_id> table for SPI driver relying on SPI
> device match since compatible is in a DT binding or in a DTS.
> 
> Before this patch:
> modinfo drivers/iio/dac/ad5758.ko | grep alias
> alias:          spi:ad5758
> 
> After this patch:
> modinfo drivers/iio/dac/ad5758.ko | grep alias
> alias:          spi:ad5758
> alias:          of:N*T*Cadi,ad5758C*
> alias:          of:N*T*Cadi,ad5758
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5758.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> index 2bdf1b0..e8eaa48 100644
> --- a/drivers/iio/dac/ad5758.c
> +++ b/drivers/iio/dac/ad5758.c
> @@ -11,6 +11,8 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/spi/spi.h>
>  #include <linux/gpio/consumer.h>
>  
> @@ -904,9 +906,16 @@ static const struct spi_device_id ad5758_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, ad5758_id);
>  
> +static const struct of_device_id ad5758_of_match[] = {
> +        { .compatible = "adi,ad5758" },
> +        { },
> +};
> +MODULE_DEVICE_TABLE(of, ad5758_of_match);
> +
>  static struct spi_driver ad5758_driver = {
>  	.driver = {
>  		.name = KBUILD_MODNAME,
> +		.of_match_table = ad5758_of_match,
>  	},
>  	.probe = ad5758_probe,
>  	.id_table = ad5758_id,

