Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13821C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4205208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tl274JuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfF1R3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:29:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34351 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1R3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:29:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so3614922plt.1;
        Fri, 28 Jun 2019 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=50+KsCLc/3qurUhBj8v7YFMwfq6psog7my3R6nwogMI=;
        b=tl274JuYOixQzIpd9tDBxIYno1OrlnQLCIk8kTNSoe8HmOnZxy5988dPnYk6nAoNwz
         a5eHYNUe7XDseHneLgwst4SFBHDJrHFGjwL06rHZx0GKfRDgj45GhTz/4RiA4ykLSppL
         LJ7BCoSNORmZ144ebMxpPFppLU03bmx8XVQOeMSbi24ma4MYQxB1nhpo0rNk3klCGmDM
         rDa1G0o3jMEz7JJ3ewcEtJLCduz3SqHP9pigXrGgVoRnp2fE0JkcX1teeuISMxtYegyB
         HfwGJ5CCbk1QfQQWdOtaT41QEPPmFNQUFuvs7wnBxLKkdMwny2eq+3e+G816Yv/IN0HO
         XKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=50+KsCLc/3qurUhBj8v7YFMwfq6psog7my3R6nwogMI=;
        b=D3XanmfxxyZ6aCZ1g9SXQTgp9yRidyNFfWZ+tM6RsjXEJIp/I535lWFWWGauOqDeUP
         izKDFEATDWavJIJkGgbVtFCcdvcEeiet7S5nU8PhQrySADiohW281uezVXYz+tMRlPzq
         VSP8a6YMuilOPWNH72bs1RZEMcvV1vWOr3dEhR9PdKwl3YnKyV4I0T/RA7VGTe1ht8ve
         nf9UZSP++U7Y8grPl8LsigsmxWR5A1CXd8EH4kSYrlRxQ1yyL88tEKkIVvgJjD5lxVEa
         4PBWX6uJDkRnf9kjax8/KVdp6MsqNL9S7L3+yqftWir89BUy8xaHBvLslmitvX7nYqu5
         XHzA==
X-Gm-Message-State: APjAAAW4gOxzmmdllEKN5ekkP1uOeOMgCVg/F8dA3KGDCGajDPtWxwCr
        +19AMpDW7OPzzCajDcZ4fG0=
X-Google-Smtp-Source: APXvYqyQDEcKNMLDbaPf45burLtKol71foxYRfrALg8FQRU6vxFI5Ih2cIO9WycS+OECmw8Z6LQ4pA==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr12609457plp.227.1561742975429;
        Fri, 28 Jun 2019 10:29:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t29sm5001276pfq.156.2019.06.28.10.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 10:29:34 -0700 (PDT)
Date:   Fri, 28 Jun 2019 10:29:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 1/9] hwmon: (nct7904) Add error handling in probe function.
Message-ID: <20190628172932.GA25782@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:08:50AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> When register read and write operations return errors, needs to add
> error handling.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> - Check for errors on register read and write operations.
> 
>  drivers/hwmon/nct7904.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 5708171197e7..401ed4a4a576 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -506,6 +506,8 @@ static int nct7904_probe(struct i2c_client *client,
>  
>  	/* CPU_TEMP attributes */
>  	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL0_REG);
> +	if (ret < 0)
> +		return ret;
>  
>  	if ((ret & 0x6) == 0x6)
>  		data->tcpu_mask |= 1; /* TR1 */
> @@ -518,11 +520,15 @@ static int nct7904_probe(struct i2c_client *client,
>  
>  	/* LTD */
>  	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL2_REG);
> +	if (ret < 0)
> +		return ret;
>  	if ((ret & 0x02) == 0x02)
>  		data->tcpu_mask |= 0x10;
>  
>  	/* Multi-Function detecting for Volt and TR/TD */
>  	ret = nct7904_read_reg(data, BANK_0, VT_ADC_MD_REG);
> +	if (ret < 0)
> +		return ret;
>  
>  	for (i = 0; i < 4; i++) {
>  		val = (ret & (0x03 << i)) >> (i * 2);
> @@ -533,22 +539,29 @@ static int nct7904_probe(struct i2c_client *client,
>  
>  	/* PECI */
>  	ret = nct7904_read_reg(data, BANK_2, PFE_REG);
> +	if (ret < 0)
> +		return ret;
>  	if (ret & 0x80) {
>  		data->enable_dts = 1; //Enable DTS & PECI
>  	} else {
>  		ret = nct7904_read_reg(data, BANK_2, TSI_CTRL_REG);
> +		if (ret < 0)
> +			return ret;
>  		if (ret & 0x80)
>  			data->enable_dts = 0x3; //Enable DTS & TSI
>  	}
>  
>  	/* Check DTS enable status */
>  	if (data->enable_dts) {
> -		data->has_dts =
> -			nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
> +		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG);
> +		if (ret < 0)
> +			return ret;
> +		data->has_dts = ret & 0xF;
>  		if (data->enable_dts & 0x2) {
> -			data->has_dts |=
> -			(nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG) & 0xF)
> -								<< 4;
> +			ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG);
> +			if (ret < 0)
> +				return ret;
> +			data->has_dts |= (ret & 0xF) << 4;
>  		}
>  	}
>  
