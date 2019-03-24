Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81CBC10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964062147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553447909;
	bh=+nuFAnvr7Z5REGjHMMxSmFfzF7WEhP7mgB9Ts+69wkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Olwzld67IV6Gkw1yLvEZX3eP8hkEGAloonyZ8ma/zb0VLpl0weup52xD1d9tJnA2/
	 y6u+Y7Rd3pEpOrZQtGeuLSvhu/YnyRHBnl5YszU8YPP7noAN60ps8nBzLS9/OeXFsc
	 sU2ogV14gu/9JG9jcprDBJfO5N6Yd7IWTpQh2g+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfCXRS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfCXRS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:18:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295852087F;
        Sun, 24 Mar 2019 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553447907;
        bh=+nuFAnvr7Z5REGjHMMxSmFfzF7WEhP7mgB9Ts+69wkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YgvgC/maque3nqKteG8nR8TKYjddEn1/3ljMbrJVxlCEXSsfSS8Iy8gnEq6AUYzwC
         r72o5hbV+9b0nWksbXlsUSKX3u1t3lrLQi9SESf6hW9FdW7DTRKG3PBWyOFvQ4Wdku
         F/az9n0Bo5cKZVkKCgBzWcvd69GWtB8/hAchU1S0=
Date:   Sun, 24 Mar 2019 17:18:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: light: vcnl4000 use word writes instead of
 byte writes
Message-ID: <20190324171821.4deba8be@archlinux>
In-Reply-To: <20190321154047.23236-2-angus@akkea.ca>
References: <20190321154047.23236-1-angus@akkea.ca>
        <20190321154047.23236-2-angus@akkea.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 08:40:43 -0700
"Angus Ainslie (Purism)" <angus@akkea.ca> wrote:

> The VCNL4200 datasheet says that word read and writes should be used
> to access the registers.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Tested-by: Tomas Novotny <tomas@novotny.cz>

So we did discuss if this was a fix for any of the existing devices.
Not sure we reached a conclusion as clearly the worked for Tomas without
this.  Anyhow, for now applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 04fd0d4b6f19..5e0a8eb83ebc 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -140,10 +140,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	data->rev = (ret >> 8) & 0xf;
>  
>  	/* Set defaults and enable both channels */
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 0x00);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 0);
>  	if (ret < 0)
>  		return ret;
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 0x00);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 0);
>  	if (ret < 0)
>  		return ret;
>  

