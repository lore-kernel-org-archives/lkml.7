Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA34C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B712147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553447978;
	bh=TMw/UYNCgfgbO838VeRbfI4lIv1JvldzfOElLXpYmOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pAJCG+u3femn4pCpflEYvGemyINpE/cSJhayN+3nNrNMU8qKHKg6ignn/xt5bhHA5
	 wmNQh1/N1Hmk3EZM+UggZ5b6G7zq2qVG+XfeI6oZ95pzKEFJKpI9LboQza3fuQ13g6
	 1gQgQaQdMwtBsh7Y5lzdqUoDWbu4cisPZ7Wvenho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfCXRTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfCXRTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:19:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF0A20989;
        Sun, 24 Mar 2019 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553447976;
        bh=TMw/UYNCgfgbO838VeRbfI4lIv1JvldzfOElLXpYmOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0oqXzyfmHsLtNogn2gGP+0S3M+y/0kp4rWj8tFzsktRfsg2sp4+zdGw5OxQcP7P7P
         RQyGzcrzTrMq8zk/KNPGK+p7QccyWAH2KPQxouxSg+551FXTXrDMHrk70wWELZa3W6
         uvQbqwb2Z2RXWDprsvBWBCMBKnP4CPjqlSveUuRU=
Date:   Sun, 24 Mar 2019 17:19:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: light: vcnl4000 add devicetree hooks
Message-ID: <20190324171930.7580e6bb@archlinux>
In-Reply-To: <20190321154047.23236-3-angus@akkea.ca>
References: <20190321154047.23236-1-angus@akkea.ca>
        <20190321154047.23236-3-angus@akkea.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 08:40:44 -0700
"Angus Ainslie (Purism)" <angus@akkea.ca> wrote:

> Add an of_match table for devicetree probing.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

I made a small tweak (see inline) for an issue I'd missed
previously (which is pretty obscure!)

Jonathan
> ---
>  drivers/iio/light/vcnl4000.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 5e0a8eb83ebc..308cb2d2b641 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -363,9 +363,31 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> +static const struct of_device_id vcnl_4000_of_match[] = {
> +	{
> +		.compatible = "vishay,vcnl4000",
> +		.data = "VCNL4000",
> +	},
> +	{
> +		.compatible = "vishay,vcnl4010",
> +		.data = "VCNL4010",
> +	},
> +	{
> +		.compatible = "vishay,vcnl4010",
> +		.data = "VCNL4020",
> +	},
> +	{
> +		.compatible = "vishay,vcnl4200",
> +		.data = "VCNL4200",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, vcnl4000_of_match);
> +
>  static struct i2c_driver vcnl4000_driver = {
>  	.driver = {
>  		.name   = VCNL4000_DRV_NAME,
> +		.of_match_table = of_match_ptr(vcnl_4000_of_match),
Ah. I'd missed this previously.  Don't use the of_match_ptr
magic anymore. It prevents ACPI probing via the weird
DSDT entry that basically says "here be devicetree".
>  	},
>  	.probe  = vcnl4000_probe,
>  	.id_table = vcnl4000_id,

