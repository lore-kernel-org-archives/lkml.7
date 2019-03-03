Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47362C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E00120842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551629778;
	bh=YdZeHK05d26IuePhawNCPu5oOUZT6kJbdTCFG9iyqbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hAVJS6h9xhiiYydEowbAeqfYDeGB1zutVM8gdc8wzLdRy6WH8QQp0cM/9opqWHvSv
	 5jnqVHlWbpZX9Ougy7rr3Hy/7ZpNmEVqp4AQjHbsV2qMLGfBawY9dEsYJZBRpliiZp
	 yc34aHeE3ru6UPvCs6N2gAeD1/2xqVLdK2TOTsrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCCQQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:16:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfCCQQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:16:16 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D762075B;
        Sun,  3 Mar 2019 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551629776;
        bh=YdZeHK05d26IuePhawNCPu5oOUZT6kJbdTCFG9iyqbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z+uaMVe60yGOESlwpcKw44Rh61XkkIIARMe9JUVhvLkghOiOVJWfF9zHU9KBI+FN+
         Hnp0jbFUhgx+V2E5+r+y0XfFi7VE2XPQ++20iejYhf1FlZF2p4/Ndo/LocTA3y7jW3
         Sqb9Pe4+BGfe0XNsph+rcCLxP5vnUIczOP9bB7Jg=
Date:   Sun, 3 Mar 2019 16:16:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: st_accel: remove redundant unsigned less
 than zero check
Message-ID: <20190303161610.43a03ffa@archlinux>
In-Reply-To: <20190221104636.1922-1-colin.king@canonical.com>
References: <20190221104636.1922-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 10:46:36 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The check that variable val is less than zero is redundant since val
> is an unsigned int and hence can never be less than zero. Remove it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/st_accel_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index a3c0916479fa..9930edf423bf 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -992,7 +992,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>  			goto out;
>  
>  		val = elements[i].integer.value;
> -		if (val < 0 || val > 2)
> +		if (val > 2)
>  			goto out;
>  
>  		/* Avoiding full matrix multiplication, we simply reorder the

