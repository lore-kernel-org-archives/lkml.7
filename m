Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E845C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D941C2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552156337;
	bh=6lPZlMTvvri4ScMoHSfcP+yxbIS9i4YA7ALgI779Fn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gF2fSLgY0zTDOL4mPDqfiEHz1XK0x1JOO1FhsJHn2vGmJ1iNYci/yt4kHqGAdvLeT
	 VqnNBVAF2lEDEGHtdXNcDFFUD23/CkloU+wr/MRxY+lQnCPH45LpOJC8BEga0uToRK
	 R89vVFEWcXlfWoKi45g7rT8cKJgaWWYsjZrsdvSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCIScP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:32:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfCIScO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:32:14 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C40207E0;
        Sat,  9 Mar 2019 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552156334;
        bh=6lPZlMTvvri4ScMoHSfcP+yxbIS9i4YA7ALgI779Fn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HQWnHMIpJfmK0sEV1+od5GAII9LkllxxeWL/0FhrGqzcSZ8YBaziZ07n2pY38BHKq
         Dx7a5YB9IIbNLV/6xU/0xlOZfh0nkhZo5whWtg3dJtKW8SaDQ8jV8lykDalvKqLMkb
         ZvUjA9TZASBOZ0I0oKstc1o1G1Cr1YY0T+m3R7Ps=
Date:   Sat, 9 Mar 2019 18:32:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fix a potential NULL pointer dereference
Message-ID: <20190309183207.42b68d90@archlinux>
In-Reply-To: <20190309045356.8892-1-kjlu@umn.edu>
References: <20190309045356.8892-1-kjlu@umn.edu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 22:53:55 -0600
Kangjie Lu <kjlu@umn.edu> wrote:

> devm_iio_trigger_alloc may fail and return NULL. The fix returns
> ENOMEM when it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Seems obviously correct to me.  As it's been there a 'while'
I'm not going to rush it in however. This can wait for the next
merge window.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index c627513d9f0f..5384472b6c4d 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -465,6 +465,8 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
>  
>  	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
>  				      iio->id);
> +	if (!trig)
> +		return -ENOMEM;
>  
>  	trig->dev.parent = adc->dev;
>  	iio_trigger_set_drvdata(trig, iio);

