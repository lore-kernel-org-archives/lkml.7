Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0FCC04E87
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C362053B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558288348;
	bh=6Lga5+qclP2sw4nWQGZpibGDqbeXADq87If2cmO73Ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=foYeDKlq++GaKX5ioT7peOKvQYDtqsGHaN643exj2wYD532siKU7Px3kNvgx6hil+
	 ION+TOLOL4h5IJpnNZPPOefOaoBl4oOnwiiOud3qXMiWw/5QSWQWqPaO23UUObQL4Z
	 /hsIgN5wC/hDVikeqSnBVuBamyGQ4RvOHriW551I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfESRw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfESRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:52:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A480B2173C;
        Sun, 19 May 2019 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558262799;
        bh=6Lga5+qclP2sw4nWQGZpibGDqbeXADq87If2cmO73Ec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aXLqKfSVLtysUxZFN6QFWMsZXVZui8ZCTidRNkvAfyD+6SEhmAp+3q5PbJ22nr9/8
         P8ukThxwV0lMxaJITTdf3RHXAIU15zYTUSurczupwVkg+YfPukbb1jU70tqHg9zGJa
         BakT02RTGjfHpxerUDxNK8K2m3ZNzx3LDoUDbGdg=
Date:   Sun, 19 May 2019 11:46:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Wilson Sales <spoonm@spoonm.org>
Subject: Re: [RESEND PATCH] staging: iio: ad7192: create of_device_id array
Message-ID: <20190519114634.0e2a9389@archlinux>
In-Reply-To: <20190518224435.18266-1-barbara.fernandes@usp.br>
References: <20190518224435.18266-1-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2019 19:44:35 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Create list of compatible device ids to be matched with those stated in
> the device tree.
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
> Signed-off-by: Wilson Sales <spoonm@spoonm.org>
> Co-developed by: Wilson Sales <spoonm@spoonm.org>
Hi B=C3=A1rbara, Wilson,

One minor issue inline about code ordering.
Actual content is fine.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/a=
d7192.c
> index 3d74da9d37e7..cc886f944dbf 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -810,11 +810,23 @@ static const struct spi_device_id ad7192_id[] =3D {
>  	{"ad7195", ID_AD7195},
>  	{}
>  };
> +
> +static const struct of_device_id ad7192_of_spi_match[] =3D {
> +	{ .compatible =3D "adi,ad7190" },
> +	{ .compatible =3D "adi,ad7192" },
> +	{ .compatible =3D "adi,ad7193" },
> +	{ .compatible =3D "adi,ad7195" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad7192_of_spi_match);
> +
Please keep the declaration of the table alongside the relevant
MODULE_DEVICE_TABLE.

In short, better to have your additions after this next line.
>  MODULE_DEVICE_TABLE(spi, ad7192_id);
> =20
>  static struct spi_driver ad7192_driver =3D {
>  	.driver =3D {
>  		.name	=3D "ad7192",
> +		.of_match_table =3D ad7192_of_spi_match,
>  	},
>  	.probe		=3D ad7192_probe,
>  	.remove		=3D ad7192_remove,

