Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9470BC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE70218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555247359;
	bh=+phI17XlM+LO6uN7sRwpFGtOM45ZiT+oE2iqIwejCHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=i7PCXoQOYaf7FzQ8XkApb/v/hz3DBspcuoZ9NQCC2/H0IfeM3LAk3K5q47JE8Oek6
	 rgScBuPnSk7oZWuDP90V2UHZID0UXNjr3rbn/T7pEwKt3mCFVLQKwYXqugMxUJrrhP
	 dvDKg1u5AjgaucD2HHVZuTfulVhn2e8XXH5GlwKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDNNJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfDNNJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 09:09:17 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D572148E;
        Sun, 14 Apr 2019 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555247357;
        bh=+phI17XlM+LO6uN7sRwpFGtOM45ZiT+oE2iqIwejCHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q4VQnQFriBxgV5lopZsuYQZIpSJ23Mdf1usuGRMsg7Z4jsOYkI+GXEV9nRye/b8bS
         6uSnrtvz0I/cBNeAcuVbDU8Wio6k5WvGrv3EXT2v9oKQkwoPRj6DC7TnfuZ2m2Q8eM
         B1a6Ql7dSHT6h23N7aKsuQzGu84eBGTKUKA+gQgU=
Date:   Sun, 14 Apr 2019 14:09:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, songqiang1304521@gmail.com,
        robh@kernel.org, m.othacehe@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] Kconfig: change configuration of srf04 ultrasonic
 iio sensor
Message-ID: <20190414140909.104c9795@archlinux>
In-Reply-To: <20190409191126.lkjujjnvjyxua3fn@arbad>
References: <20190409191126.lkjujjnvjyxua3fn@arbad>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 21:11:28 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> reword configuration option for SRF04
> 
> list supported types in help text
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied and pushed out as testing for the autobuilders to play with it.

thanks,

Jonathan

> ---
>  drivers/iio/proximity/Kconfig | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 12a3d3d40a91..e9f254ae3892 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -68,12 +68,19 @@ config RFD77402
>  	  module will be called rfd77402.
>  
>  config SRF04
> -	tristate "Devantech SRF04 ultrasonic ranger sensor"
> +	tristate "GPIO bitbanged ultrasonic ranger sensor (SRF04, MB1000)"
>  	depends on GPIOLIB
>  	help
> -	  Say Y here to build a driver for Devantech SRF04 ultrasonic
> +	  Say Y here to build a driver for GPIO bitbanged ultrasonic
>  	  ranger sensor. This driver can be used to measure the distance
>  	  of objects. It is using two GPIOs.
> +	  Actually Supported types are:
> +	  - Devantech SRF04
> +	  - Maxbotix mb1000
> +	  - Maxbotix mb1010
> +	  - Maxbotix mb1020
> +	  - Maxbotix mb1030
> +	  - Maxbotix mb1040
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called srf04.

