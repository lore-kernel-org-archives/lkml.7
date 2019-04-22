Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD937C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3D720811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555929995;
	bh=VSsijdAi/P+KpbiDeudlQODER7NeAzvFbyG+WPDabEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hBkd88Syp5pU7iRpBQhCXyT1QnyhK7iOy1acv2s2B1LOEmUwkMnLUCUeaB30/jR4O
	 x8sof+HoK0PBQyJv1PLqLT9iHNJprj1cM4ki0jSQ8JEGXjtbnBw0VIq9D1SzhddKy6
	 ShOesU/u+eyyRFsYpvYDeGhl/i3QQh/FtKHIB3T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDVKqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:46:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C5720874;
        Mon, 22 Apr 2019 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555929993;
        bh=VSsijdAi/P+KpbiDeudlQODER7NeAzvFbyG+WPDabEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AAck04Df6JUUBlkG9S0J4Q06QfIvdn/h/0meNM9iHITKAyql70dbqIy4w+GmLYGyQ
         VvLhuHsMdhixvypmw9XRpZSZXV7DugIX6kGD5r9B7jeb5F1hu4cmoPCrrTnp64xzRD
         Lt9lReu+nyDkVYqhm+Vbo6QVV9Xgzfglyx1iiCOg=
Date:   Mon, 22 Apr 2019 11:46:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: dummy_evgen: fix possible memleak in evgen init
Message-ID: <20190422114628.03ab91a5@archlinux>
In-Reply-To: <1555556576-6927-1-git-send-email-bianpan2016@163.com>
References: <1555556576-6927-1-git-send-email-bianpan2016@163.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 11:02:56 +0800
Pan Bian <bianpan2016@163.com> wrote:

> The memory allocated in the function iio_dummy_evgen_create is not
> released if it fails to add the evgen device to device hierarchy. This
> may result in a memory leak bug.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
Hi. Not sure why the patch doesn't have the standard [PATCH] prefix
in the title.

This issue has been there a long time, but as the driver is only
a testing stub I'm not going to add a fixes tag or mark it for stable.
That would just be noise I think.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dummy/iio_dummy_evgen.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
> index efd0005..f96c0a3 100644
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -196,7 +196,10 @@ static __init int iio_dummy_evgen_init(void)
>  		return ret;
>  	device_initialize(&iio_evgen_dev);
>  	dev_set_name(&iio_evgen_dev, "iio_evgen");
> -	return device_add(&iio_evgen_dev);
> +	ret = device_add(&iio_evgen_dev);
> +	if (ret)
> +		put_device(&iio_evgen_dev);
> +	return ret;
>  }
>  module_init(iio_dummy_evgen_init);
>  

