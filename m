Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88293C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574432086A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551624358;
	bh=e6hMBWvCf0/I4khZmvPOAG49OI3KZZXdn9hL+ThKQe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Eibuyb7yfUIcn0Kdxr7gNMRA7dNKFv6IfR6NX8hdc+aF9NO3d9wNOk0FMqLqQaZsg
	 WtXl/xs5ot9C+Olf7eMBF/VaJF+GmRL/G9SovMrWWdf/Nej+6xQdHIkeCWLpL2jo5S
	 nv+1SDE2L387Ar5vfwxBupgiq/A3wctl/8Qd6I3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCCOp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCCOp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:45:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEBE720835;
        Sun,  3 Mar 2019 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551624355;
        bh=e6hMBWvCf0/I4khZmvPOAG49OI3KZZXdn9hL+ThKQe8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tpYTcXEi4u+mJJJRZ49eUFvMBPFQuef9GZIvZKnUZO7trufqJnLkBbn9lR0N5LOIa
         8x00YWMRMpSXWYMo2PVEUB6y/H6DLQJMH/pGuoq3x6a+AZI/Ov/sGngsROZUtbP2Vq
         UMWrAa1o/VQvQ8k4CO+MwUVo/48xm3tkWVCnaEtY=
Date:   Sun, 3 Mar 2019 14:45:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 3/4] iio:adc:ad7923: Put macro argument between ()'s
Message-ID: <20190303144550.5a1b2039@archlinux>
In-Reply-To: <20190222203159.15116-4-barbara.fernandes@usp.br>
References: <20190222203159.15116-1-barbara.fernandes@usp.br>
        <20190222203159.15116-4-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 17:31:58 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Put macro argument between parenthesis in order to avoid precedence
> issues. Solves the following checkpath.pl's messages:
>=20
> CHECK: Macro argument 'mode' may be better as '(mode)' to avoid
> precedence issues
> CHECK: Macro argument 'channel' may be better as '(channel)' to
> avoid precedence issues
> CHECK: Macro argument reuse 'sequence' - possible side-effects?
> CHECK: Macro argument 'sequence' may be better as '(sequence)' to
> avoid precedence issues
> CHECK: Macro argument 'val' may be better as '(val)' to avoid
> precedence issues
> CHECK: Macro argument 'dec' may be better as '(dec)' to avoid precedence
> issues
> CHECK: Macro argument 'bits' may be better as '(bits)' to avoid
> precedence issues
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7923.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index b39ea834cdd6..dbece44e26e4 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -40,16 +40,16 @@
> =20
>  #define AD7923_MAX_CHAN		4
> =20
> -#define AD7923_PM_MODE_WRITE(mode)	(mode << 4)	/* write mode */
> -#define AD7923_CHANNEL_WRITE(channel)	(channel << 6)	/* write channel */
> -#define AD7923_SEQUENCE_WRITE(sequence)	(((sequence & 1) << 3) \
> -					+ ((sequence & 2) << 9))
> +#define AD7923_PM_MODE_WRITE(mode)	((mode) << 4)	 /* write mode */
> +#define AD7923_CHANNEL_WRITE(channel)	((channel) << 6) /* write channel =
*/
> +#define AD7923_SEQUENCE_WRITE(sequence)	((((sequence) & 1) << 3) \
> +					+ (((sequence) & 2) << 9))
>  						/* write sequence fonction */
>  /* left shift for CR : bit 11 transmit in first */
>  #define AD7923_SHIFT_REGISTER	4
> =20
>  /* val =3D value, dec =3D left shift, bits =3D number of bits of the mas=
k */
> -#define EXTRACT(val, dec, bits)		((val >> dec) & ((1 << bits) - 1))
> +#define EXTRACT(val, dec, bits)		(((val) >> (dec)) & ((1 << (bits)) - 1))
> =20
>  struct ad7923_state {
>  	struct spi_device		*spi;

