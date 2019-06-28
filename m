Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA755C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878FB208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGp4BB8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfF1R3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:29:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43467 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF1R3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:29:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so3312234pfg.10;
        Fri, 28 Jun 2019 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IUIM664RuoYp3t0CJ+jRlG/fXRbmpr3H3CbNoUOniDQ=;
        b=cGp4BB8iY/HWK5zSL1tKXdzRHmLWKqHLCreucH7JfY1yeOY3DHoNakSACj3A0aFAJo
         OakQmivazjArkrRSmNhPjpV/jcy8VjjUd1IFxxa4hc+kLucQqfcMg0bb/xDsbGVQVAoI
         F1Fxezhdv3lN1JNcqTtn1X8TLL3gOoNwkBI2N3yrtTEvF/TKHx7Pk7EfP/JYugOIvMdO
         S2Ai/UA1iER+L6zw/y38bjqLYboYCf2osWqU5uaf5126nrMPjJ10DorGo0Spqv3cBKKC
         CeWAfpc0hD3VPxe4kYI2TAZB3ia9xdVH4Y5NT/rMsO0K1IQuyZYGgCkop5262nFpo55D
         yxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=IUIM664RuoYp3t0CJ+jRlG/fXRbmpr3H3CbNoUOniDQ=;
        b=ERq+akFlT9hXnbKr2bVk4KvPrSIKaVn5KwuL1ZxX8e1c18ieapO/NfEU7vSn1ND75I
         HdeoLwpwRWEitnEYI/hoPlcEVMY5q2iIp9OERPqLbuEcP6cTfxk5IBv4IV/5JjF2oxWI
         h2a6wWbOeMYw1TjQq4mK162rJr56ti5rOh54TmLYolTVqpahL4Vad7r9fHBPs18xHY09
         NYIkmuaeZ3+LkoWnQhJTHC1bD66nJQM/GKIq158dfv7kNtb9iixKDJA2tKgTIbgqRM1u
         UqXz62ks8N1KsJtsCfKjOrJQTOo2kpyMCHAb7XmurahcHgK+9U3gOpHzwqpBaLPaLNMm
         kLig==
X-Gm-Message-State: APjAAAX0XTTVC8K2X6dWfP7IYjHTai0cBQjsnBwYa1kHeC64mJHVs+Df
        YWdi7FLxtz4WzR/RaNCfMNKF7kCM
X-Google-Smtp-Source: APXvYqx8BGf9qHObqT1DPpPcVSIXG/e1ybzvtIB73TWeZ38DOH92dPuLOD5eLh6hI6sucwHlkfXakw==
X-Received: by 2002:a63:125c:: with SMTP id 28mr901781pgs.255.1561742990198;
        Fri, 28 Jun 2019 10:29:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u21sm4051401pfm.70.2019.06.28.10.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 10:29:49 -0700 (PDT)
Date:   Fri, 28 Jun 2019 10:29:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 2/9] hwmon: (nct7904) Changes comments in probe function.
Message-ID: <20190628172948.GA25799@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:10:00AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> Linux style for comments is the C89 "/* ... */" style,
> changes the comments to Linux style.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> - Fix wrong style of comments.
> 
>  drivers/hwmon/nct7904.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 401ed4a4a576..710c30562fc1 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -542,13 +542,13 @@ static int nct7904_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  	if (ret & 0x80) {
> -		data->enable_dts = 1; //Enable DTS & PECI
> +		data->enable_dts = 1; /* Enable DTS & PECI */
>  	} else {
>  		ret = nct7904_read_reg(data, BANK_2, TSI_CTRL_REG);
>  		if (ret < 0)
>  			return ret;
>  		if (ret & 0x80)
> -			data->enable_dts = 0x3; //Enable DTS & TSI
> +			data->enable_dts = 0x3; /* Enable DTS & TSI */
>  	}
>  
>  	/* Check DTS enable status */
