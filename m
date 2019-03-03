Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C89C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6691720866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551624459;
	bh=Ldejzf8jupG2qN/3MS05lPeJ0Rmi6kaNmQH+mgKbkHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zLKAzdTn/PKooEPyHsyztcnnJruu/jQbn1juC70wlNaG1n2BscDaLc3vjBON6uNwC
	 MZA994i2XJq8Wspff1PgUOJNZa5fMQ3TuFGDp8zyLudAfHExpbBB/0ehr37lfNEblA
	 sB3gEfdLZ6VWbECdinX2ZcYyQjk/2NQ0Q7WlaDpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCCOri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCCOrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:47:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69CCB20835;
        Sun,  3 Mar 2019 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551624457;
        bh=Ldejzf8jupG2qN/3MS05lPeJ0Rmi6kaNmQH+mgKbkHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZSvZ3aazne/NZRPZrMkAJpzRyziwjO0veMEyd0aO7eR2/9csUJJPspjsFBWS4yIst
         50pR7nnk0bJDyuYrrHukgHJKuv6TUyY3/Z0U1dKgFON6AN56E7O4V3n0rEODUrA5Qm
         1eItRKuIF9o3bc4mYkxD4hld8iYLEXS1CVoXjOIc=
Date:   Sun, 3 Mar 2019 14:47:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 4/4] iio:adc:ad7923: Rewrite comparison to NULL
Message-ID: <20190303144732.38f57096@archlinux>
In-Reply-To: <20190222203159.15116-5-barbara.fernandes@usp.br>
References: <20190222203159.15116-1-barbara.fernandes@usp.br>
        <20190222203159.15116-5-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 17:31:59 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Solves checkpath.pl's message:
>=20
> CHECK: Comparison to NULL could be written "!indio_dev"
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
Applied, thanks.

It's nice to get some cleanup for drivers that aren't in staging
sometimes.  After all, in recent years the kernel coding style
and tools to check it have improved considerably.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7923.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index dbece44e26e4..cb7b854df00c 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -272,7 +272,7 @@ static int ad7923_probe(struct spi_device *spi)
>  	int ret;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (indio_dev =3D=3D NULL)
> +	if (!indio_dev)
>  		return -ENOMEM;
> =20
>  	st =3D iio_priv(indio_dev);

