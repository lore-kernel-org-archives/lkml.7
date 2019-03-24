Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB4221741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553450711;
	bh=InLDRxTT0DeFS5jdevByEVrbFHtq8bA35lvEl/NIEsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iDTymD5kvFYIq2od6e6RHSsFi+0HlL5gIh3ae7YBn074c/elQJ3twUuc5GKdaiq3O
	 Ph4/IcSBXgMlf8rU73z1bcU0ciwgMJVZ4GxyoMp6gCaJ5N4P9xKZTzRPuRZd1Uphc8
	 68zph1ljzPjg40a1quiJIcs5ZZbAUr/TIf970oMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfCXSFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfCXSFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:05:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CC72147C;
        Sun, 24 Mar 2019 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553450709;
        bh=InLDRxTT0DeFS5jdevByEVrbFHtq8bA35lvEl/NIEsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pJ6SJxsKfJuEZqYUOy43OJgCO5MN3K5ly2IGHMCXGPA2LJnYEmH2l9Q1nTF9hcNON
         9hiGq0vUCDNPZ9rakhPcuUkUyUKrbxKJpujTvkDg7CHuZUhumesm8oVqGIuXXYpLA5
         m4HERnlvM19s0cw4QABJh0nwrSAwD+jtqv1xjbGY=
Date:   Sun, 24 Mar 2019 18:05:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH 1/2] iio: gyro: bmg160: add device tree compatibility
 table
Message-ID: <20190324180503.6dc1e36e@archlinux>
In-Reply-To: <090c92487ada60e81fca341ef24e5de33a11ec4b.1552922054.git.hns@goldelico.com>
References: <cover.1552922054.git.hns@goldelico.com>
        <090c92487ada60e81fca341ef24e5de33a11ec4b.1552922054.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 16:14:14 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Add of_match_table.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
I'm not against doing this, but do note that there is still a back up
path in which the i2c_device_id table is used to match but without
the vendor part of the string.

I theory the plan is to eventually remove that, but it's not the
case that this driver could not be probed from devicetree previously.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/bmg160_i2c.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 90126a5a7663..934a092134f0 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -54,10 +54,19 @@ static const struct i2c_device_id bmg160_i2c_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
>  
> +static const struct of_device_id bmg160_of_match[] = {
> +	{ .compatible = "bosch,bmg160" },
> +	{ .compatible = "bosch,bmi055_gyro" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, bmg160_of_match);
> +
>  static struct i2c_driver bmg160_i2c_driver = {
>  	.driver = {
>  		.name	= "bmg160_i2c",
>  		.acpi_match_table = ACPI_PTR(bmg160_acpi_match),
> +		.of_match_table = bmg160_of_match,
>  		.pm	= &bmg160_pm_ops,
>  	},
>  	.probe		= bmg160_i2c_probe,

