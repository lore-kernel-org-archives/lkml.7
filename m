Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E032C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0166A20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551617223;
	bh=QobnAs5fOiwwbycf6aMuSzEd1F5dsBqeV/ac/fnB6FM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bUy6EJhXzz/em0mH+z8Qr0ZT5Ah+rm2TO9M6zLz2bzgZObicga8EY59IG9n4ymbOJ
	 yJzeiH4k4En0C9XEE6QnMzHMy9dd8Nkken/Y43+QR6T8W9SsSVyN/skEEQV0QzdQHO
	 nYDv02mubhYlzIEXqKOnvWWt6L8cdvoBO/8IGUlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCCMrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfCCMrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:47:01 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB38220857;
        Sun,  3 Mar 2019 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551617221;
        bh=QobnAs5fOiwwbycf6aMuSzEd1F5dsBqeV/ac/fnB6FM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TEVq7aHbRHzwdqPEiJq85neTyqsUzrARVbgX/Owyr7ESQta0cy5aQ4Ku2In3Kk0Sq
         I6sJoe1gSVu+9POT6jCCDnHwgk0BJ4C8ucqsQyQSjBTP5uHT31nOtI8yGxTFmgU5tv
         Bc/3+t/OtLs0IwyBM1gAhZeFLqvHl0zc0my0v6HE=
Date:   Sun, 3 Mar 2019 12:46:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] iio: imu: adis16480: Add OF device ID table
Message-ID: <20190303124655.6ebe92d2@archlinux>
In-Reply-To: <1551284068-4882-3-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
        <1551284068-4882-3-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 18:14:23 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The driver does not have a struct of_device_id table, but supported
> devices are registered via Device Trees. This patch adds OF device ID
> table.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 98a23ac..150d814 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -991,9 +991,19 @@ static const struct spi_device_id adis16480_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, adis16480_ids);
>  
> +static const struct of_device_id adis16480_of_match[] = {
> +	{ .compatible = "adi,adis16375" },
> +	{ .compatible = "adi,adis16480" },
> +	{ .compatible = "adi,adis16485" },
> +	{ .compatible = "adi,adis16488" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adis16480_of_match);
> +
>  static struct spi_driver adis16480_driver = {
>  	.driver = {
>  		.name = "adis16480",
> +		.of_match_table = adis16480_of_match,
>  	},
>  	.id_table = adis16480_ids,
>  	.probe = adis16480_probe,

