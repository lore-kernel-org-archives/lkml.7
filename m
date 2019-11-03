Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A19CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 10:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C250214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 10:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572777076;
	bh=20l8v/y2V3ek5NI+W8ID8qa7S1TqL/BeyjegTojxYIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iPO/vEY3IzUIWH6xEnlGXsxDRj+LSGBA0OGcUJ/xblp133tLcFmpLye5TXtn3ClaC
	 W/oQKvfFAL0bz0BKnz6S2zFgkUtP4awJ9jzqoe9VupSjddUbZy8je1t545kQH7e0xZ
	 A2yB6H4jLq8he7bcWfpjgOKKBzzzow7QaZvIOvTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfKCKbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 05:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCKbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 05:31:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13992080F;
        Sun,  3 Nov 2019 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572777074;
        bh=20l8v/y2V3ek5NI+W8ID8qa7S1TqL/BeyjegTojxYIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MZX2QdfeJVHnNlbg1uGWwQTvF3A2/JmXrlYm6bNiiXpJxecg9O+lUkLqJIJaeAE4d
         wr7MeS0gQLvVS4XG1LqtIGBJlcMKDRqxn9MTdrqveO0TOzrKWVmKegNoaOCxD3aaRF
         7ThQWgAXtTZLt0fwygqYNrrNXEtaMpI4MasF6XV4=
Date:   Sun, 3 Nov 2019 10:31:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 05/10] iio: imu: adis: check ret val for non-zero vs
 less-than-zero
Message-ID: <20191103103109.37849bc2@archlinux>
In-Reply-To: <20191101093505.9408-6-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 11:35:00 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADIS library functions return zero on success, and negative values for
> error. Positive values aren't returned, but we only care about the success
> value (which is zero).
> 
> This change is mostly needed so that the compiler won't make any inferences
> about some about values being potentially un-initialized. This only
> triggers after making some functions inline, because the compiler can
> better follow return paths.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 1631c255deab..dc2f9e061d98 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -286,7 +286,7 @@ int adis_check_status(struct adis *adis)
>  	int i;
>  
>  	ret = adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	status &= adis->data->status_error_mask;

