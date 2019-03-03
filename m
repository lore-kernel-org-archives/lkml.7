Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A84C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9485220866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551624304;
	bh=NKKHQ1vP3S5N8WcQqCp7WEZYRCYJBAIyRhjYZyrD0KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=roBqrU2poaA5U50uGpMSKqG079V/SkYIx4fGrBo5n3Zk7qayeJtOibUcsV6H8HZAW
	 qyqws0JiaHL2GYPJTyh0yUsFuWxH5oG2Q/iNHq4uNDkLm7OJGfMLxDA7vU2xVBWHBB
	 RBrC6VCdQb5ljAOL6haoH0+2FZsE9TORX/nwvAF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfCCOpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCCOpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:45:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F7A020835;
        Sun,  3 Mar 2019 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551624300;
        bh=NKKHQ1vP3S5N8WcQqCp7WEZYRCYJBAIyRhjYZyrD0KQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PEQYaWCSBIyBxkd4nrLGIZMtkomSFum33X4o/TfpcT1+gfvOEzpB4M8EYoUqkjMGv
         d+9lOwVYeedOIEPlAtO55svlug96EajbxRX2yfZZrIJlCBUs6/3PFlQw2iXgf2QPD4
         /npvDdj460asTkdbVoXsqTPvawXhcnWO4gWh/vjY=
Date:   Sun, 3 Mar 2019 14:44:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 2/4] iio:adc:ad7923: Use BIT macro instead of bitshift
Message-ID: <20190303144454.0a663b47@archlinux>
In-Reply-To: <20190222203159.15116-3-barbara.fernandes@usp.br>
References: <20190222203159.15116-1-barbara.fernandes@usp.br>
        <20190222203159.15116-3-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 17:31:57 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Replace use of the operation '<<' by the BIT macro. Solves checkpath.pl's
> message:
>=20
> CHECK: Prefer using the BIT macro
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7923.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index ebae7522710a..b39ea834cdd6 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -24,9 +24,9 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> =20
> -#define AD7923_WRITE_CR		(1 << 11)	/* write control register */
> -#define AD7923_RANGE		(1 << 1)	/* range to REFin */
> -#define AD7923_CODING		(1 << 0)	/* coding is straight binary */
> +#define AD7923_WRITE_CR		BIT(11)		/* write control register */
> +#define AD7923_RANGE		BIT(1)		/* range to REFin */
> +#define AD7923_CODING		BIT(0)		/* coding is straight binary */
>  #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
>  #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
>  #define AD7923_PM_MODE_OPS	(3)		/* normal operation */

