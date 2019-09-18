Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95006C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBAA208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6m4J1Zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfIRNk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:40:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37017 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfIRNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:40:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so4511929pfo.4;
        Wed, 18 Sep 2019 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljkWDHXlIkSy7NckWtNI1aeaRwQExF2XsDwU+t0+zEw=;
        b=d6m4J1ZbQIhGPIwQcfje4nR1f6w8yt1CI3u+GQsXd/WQ1L2b7HiGOo+ApFiyEKkMUz
         fJGlZWaoFe9UtwkqSU0vmw1VkNdRcxb+CXVmCSbqWhkZbSrFcUynODzmo7gVZEpyZoy0
         9Y+INFsUmKqAIi1Qk6xO2WbrJmDt/LlLPQiy1U9Wx2KKJm5acHGrieZc6e3Yx4dfgZbF
         jxE6Md+B18XEdp4C9MnCAbAMFBA3x9lJ23xbEJkT8ElPTbHCe0XhiOQtRH1FRGUQtCvZ
         wXxS2muJjV9/MUPbkdhYAkEQKyy19DWNyQjMB7w3zwp9IrK3jCq32poQVV3sS3ziHy+5
         R3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljkWDHXlIkSy7NckWtNI1aeaRwQExF2XsDwU+t0+zEw=;
        b=N4OFk9GgwARP0x4NFfktzBRG32DcKpYZQ8hJV7Q44jeYWau6VBd+3AAnPwQsCdsE7n
         HZJExhj9u69MvHU+gYH+D/yTfYvS4BtN3lNM/mUC6SNI9ar9oJ1uNPL5sPPzEpAiCY8p
         WB72uuyjNse4jXODuG1JEsiQxWAXVkFa7L0LyMxcZy6dXKZu5k/85+CaROqe6WCC3rNi
         NpeEDti4cA4CP+jcU0+8sSRE0VptLqzmW1XDL3nj2Yp2QrLdXnQirCpW6B9H37wllz1Z
         SPjwcRe1ldFmQ6kWdhgSxF2OR4G45HX4+9enOEjSG1ka+7+pjIzDUEGihbZXmDbVWQY2
         ng6A==
X-Gm-Message-State: APjAAAW5ctEZmsZj5P/FYADF8E75G8qZNCX/kugpeeS4hkpxc2LlRISu
        shgBGzpAMv9mKxVPL3sckAo=
X-Google-Smtp-Source: APXvYqwGmHrbLJCm4e7l/PHYfffMMtNA0UN+h8KyCp/tNWvDUeqDrbJ96Xivomf1/vTNRC4C9tCfzw==
X-Received: by 2002:a62:64c9:: with SMTP id y192mr4444109pfb.6.1568814058533;
        Wed, 18 Sep 2019 06:40:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1sm12644118pfg.2.2019.09.18.06.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 06:40:57 -0700 (PDT)
Date:   Wed, 18 Sep 2019 06:40:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        bichan.lu@advantech.com.tw, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,1/1] hwmon: (nct7904) Fix the incorrect value of vsen_mask
 in nct7904_data struct.
Message-ID: <20190918134056.GA21721@roeck-us.net>
References: <20190918084801.9859-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918084801.9859-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 04:48:00PM +0800, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> Voltage sensors overlap with external temperature sensors. Detect
> the multi-function of voltage, thermal diode and thermistor from
> register VT_ADC_MD_REG to set value of vsen_mask in nct7904_data
> struct.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
> Changes in v3:
> - Simplified the bit map.
> - Modified the if statement.
> Changes in v2:
> - Moved the if statement to outside.
> 
>  drivers/hwmon/nct7904.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 95b447cfa24c..f62dd1882451 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -915,12 +915,15 @@ static int nct7904_probe(struct i2c_client *client,
>  
>  	data->temp_mode = 0;
>  	for (i = 0; i < 4; i++) {
> -		val = (ret & (0x03 << i)) >> (i * 2);
> +		val = (ret >> (i * 2)) & 0x03;
>  		bit = (1 << i);
> -		if (val == 0)
> +		if (val == 0) {
>  			data->tcpu_mask &= ~bit;
> -		else if (val == 0x1 || val == 0x2)
> -			data->temp_mode |= bit;
> +		} else {
> +			if (val == 0x1 || val == 0x2)
> +				data->temp_mode |= bit;
> +			data->vsen_mask &= ~(0x06 << (i * 2));
> +		}
>  	}
>  
>  	/* PECI */
