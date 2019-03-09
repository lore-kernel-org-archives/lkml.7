Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1DC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8588207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ineb8Wgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCIPTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:19:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38124 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfCIPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:19:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id 199so455510ljj.5;
        Sat, 09 Mar 2019 07:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDxE/HEDyJoD5tX+9P8Nq9NwskV+Yl6zaHGMjoV6/Yw=;
        b=ineb8WgbsY1bRzUL6isp8eJf1wP8C25M/7IzzFe+V6sqsdUY9/ayWJmzq6WanZkFmn
         0a7fFk/HoEHFkoVvbqLSX1KKi0yWkIeTTxIEic2BQ6iapxNg1sq5qP0rsu8Ux1YKRtXJ
         WzmOIt2u3Y5wgs04BaIRzu+goHoKFP6BUD+ZM2pilU1Lyq+Zai2UaTm3OdG2cuqCC8Ng
         R2+6MaSgmeED43GxcUXVzhlwU3b9tkdOF5y0MLK6uqGGkRg9TVQ4wbECPivu2I5Xosp2
         nsIuxUB/ZofLy4eJS/LQynhiapD8gC2E2Igs95YcAqybu9Axuy8OgjRD+7dbKz4acttq
         eXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDxE/HEDyJoD5tX+9P8Nq9NwskV+Yl6zaHGMjoV6/Yw=;
        b=X1XLzkgBUGLb4bmmyjBvUyeOqk5wmXUQmTRvuK+BS/J1CnZMkfg65krMVa0lg09CCZ
         9rFGUxyfxR+Pzwop3LPtcTQV2gMsnKp2W73EuBMwk3J2PEisgJYVNvs1xGbPUC7jzw9J
         WBR8Gl615Tml61Rps6WNNElBVj/spEiAAp4EB7vt3ijSpk2LBSonAanteicFv86NzZul
         OflzDxvk3X9SsSV+9EePXxh1xdLnPeyspckM33rvRKzsjRJp5pLQ/o5WxURLURcUn1rV
         nd+yxQoq1LCBhYYfmjA9zDYSc6FnfPIwjhZhqwnUWs09P/Hts5jztZAGQ4lnZKWHQydX
         rb5w==
X-Gm-Message-State: APjAAAWgjFPT0I93OU20R/PsUEolmBob0E8Gf2PbFzN2SYJIyDar1pEM
        2WI2vBF85E/84uz8bgmdckI=
X-Google-Smtp-Source: APXvYqwomoFR+RcMzNK+swVGqgHSfo0zDuHpqXXS/Q2CYI/vmJ+K9kXfV8A4fvWsExdkqYkd7YYrZg==
X-Received: by 2002:a2e:93ca:: with SMTP id p10mr2982844ljh.16.1552144783334;
        Sat, 09 Mar 2019 07:19:43 -0800 (PST)
Received: from localhost (89-64-59-159.dynamic.chello.pl. [89.64.59.159])
        by smtp.gmail.com with ESMTPSA id c26sm157122lfi.96.2019.03.09.07.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 07:19:42 -0800 (PST)
Date:   Sat, 9 Mar 2019 16:19:17 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stefan Agner <stefan@agner.ch>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: max9611: fix a NULL pointer dereference
Message-ID: <20190309151916.GB7820@arch>
References: <20190309045141.8015-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190309045141.8015-1-kjlu@umn.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:51:40PM -0600, Kangjie Lu wrote:
> of_match_device may return NULL when it fails, and in this case,
> there will be a NULL pointer dereference. The fix returns
> EINVAL when of_match_device returns NULL.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/iio/adc/max9611.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 917223d5ff5b..531b6614ea29 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -524,13 +524,16 @@ static int max9611_probe(struct i2c_client *client,
>  {
>  	const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
>  	const struct device_node *of_node = client->dev.of_node;
> -	const struct of_device_id *of_id =
> -		of_match_device(max9611_of_table, &client->dev);

Given we got to this point how this can go wrong?

> +	const struct of_device_id *of_id;
>  	struct max9611_dev *max9611;
>  	struct iio_dev *indio_dev;
>  	unsigned int of_shunt;
>  	int ret;
>
> +	of_id = of_match_device(max9611_of_table, &client->dev);
> +	if (!of_id)
> +		return -EINVAL;
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max9611));
>  	if (!indio_dev)
>  		return -ENOMEM;
> --
> 2.17.1
>
