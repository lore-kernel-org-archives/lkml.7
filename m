Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45EDC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E7A2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMKUbQQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfIBQJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:09:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43769 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfIBQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:09:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so9195854pfn.10;
        Mon, 02 Sep 2019 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zShaFAP74aJga8P+EWAaD/eJPjKlvpwUgjAlhsNU3q0=;
        b=oMKUbQQDtpbqxTYcYhm+L0DV65dinVK3bO9v4Po7a/d+WRNahr4T0JkTc4Guvk8jnF
         7rR6chiOv0NVOFrA4bPyqwhFKdbdItjK/V/hKaaIFx58xwLwoASfdl75JyQ7LywlbgqR
         WszVm/mRPLEteW3h5VYFP9zpOhLsigSA/GOuxWzFHUI/UvElM1chJncbi4hSxOujBtXi
         X8O+BnSlYfPDScqWt4G8zSW951+uUr7o49WNl0zt9IDkegsAg4rBqYqyE6erCPY72TyN
         kaUzJF//+xwxvHRll2emJSOvUnKFN9dPe/7WMsggNQv0D/K5UyyiUQctyJlXqVyDr1ch
         8Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zShaFAP74aJga8P+EWAaD/eJPjKlvpwUgjAlhsNU3q0=;
        b=TgUF0RTXCSo2iKm/lCh0bpZAx86PyVbQGr7388CBBjQVgALnxqdV2YBG09paySO5o3
         f1+t5EqCyRD2YqJSJ/Cb3NtdP/QrL3MCQWQrA9dlScvlAgFTYHffVPf8rGqQVheFHRlP
         bhClh1d8MYAmWcmZf2L7A/IB1/B1zwcL/SPV+2MKKvB4rAOQZYDcqJC3v+1TuDF/74oy
         eVNdvdZIINcHIK3x3OhA2u0jgvUvLO51e4vR4x28gUS4jlDVekdvLeBN2WJ2sKhKFcc6
         vxe16k0ZlIJjeGglWplt68zF167oH8Rk8ARaVywyGGkj/YOJU77KhphpN4yRojjOmHLd
         OQaA==
X-Gm-Message-State: APjAAAXMSYEMk7vHLN7yUxOopKPN0auh3WjHgNDKN41ISxwBwQA4agwm
        NI7mO6T2F63JWjV2H5N+zM4=
X-Google-Smtp-Source: APXvYqz6Ye4Kedth37Js8pmu13MSfUKPp+rA9tdeUPxTCiYzZ/5vyqIUzexfHSL3uIiBnVkBoEPfRg==
X-Received: by 2002:a65:6259:: with SMTP id q25mr26388143pgv.145.1567440589640;
        Mon, 02 Sep 2019 09:09:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y128sm13823679pgy.41.2019.09.02.09.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 09:09:49 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:09:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        bichan.lu@advantech.com.tw, jia.sui@advantech.com.cn,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v6,1/1] hwmon: (nct7904) Fix incorrect temperature limitation
 register setting of LTD.
Message-ID: <20190902160948.GA16583@roeck-us.net>
References: <20850618155720.24857-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20850618155720.24857-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2085 at 03:57:19PM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> According to kernel hwmon sysfs-interface documentation, temperature
> critical max value, typically greater than corresponding temp_max values.
> Thus, reads the LTD_HV_HL (LTD HIGH VALUE HIGH LIMITATION) and LTD_LV_HL
> (LTD LOW VALUE HIGH LIMITATION) for case hwmon_temp_crit and
> hwmon_temp_crit_hyst. Reads the LTD_HV_LL (HIGH VALUE LOW LIMITATION)
> and LTD_LV_LL (LOW VALUE LOW LIMITATION) for case hwmon_temp_max
> and hwmon_temp_max_hyst.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
> ---
> 
> Changes in v6:
> - Fix incorrect temperature limitation register setting of LTD.

This is a separate (follow-up) patch; v6 is inappropriate here.
Nevertheless, applied on top of the previous patch to hwmon-next.

Thanks,
Guenter

> Changes in v5:
> - Squashed subsequent fixes of three patches into one patch.
> Changes in v4:
> - Fix the incorrect return value of case hwmon_fan_min in function "nct7904_write_fan".
> - Fix the confused calculation of case hwmon_fan_min in function
> Changes in v3:
> - Squashed subsequent fixes of patches into one patch.
> 
> -- Fix bad fallthrough in various switch statements.
> -- Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
> -- Fix incorrect register setting of voltage.
> -- Fix incorrect register bit mapping of temperature alarm.
> -- Fix wrong return code 0x1fff in function nct7904_write_fan.
> -- Delete wrong comment in function nct7904_write_in.
> -- Fix wrong attribute names for temperature.
> -- Fix wrong registers setting for temperature.
> 
> Changes in v2:
> - Fix bad fallthrough in various switch statements.
> - Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
> ---
>  drivers/hwmon/nct7904.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 76372f20d71a..ce688ab4fce2 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -398,22 +398,22 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  		}
>  		return 0;
>  	case hwmon_temp_max:
> -		reg1 = LTD_HV_HL_REG;
> +		reg1 = LTD_HV_LL_REG;
>  		reg2 = TEMP_CH1_W_REG;
>  		reg3 = DTS_T_CPU1_W_REG;
>  		break;
>  	case hwmon_temp_max_hyst:
> -		reg1 = LTD_LV_HL_REG;
> +		reg1 = LTD_LV_LL_REG;
>  		reg2 = TEMP_CH1_WH_REG;
>  		reg3 = DTS_T_CPU1_WH_REG;
>  		break;
>  	case hwmon_temp_crit:
> -		reg1 = LTD_HV_LL_REG;
> +		reg1 = LTD_HV_HL_REG;
>  		reg2 = TEMP_CH1_C_REG;
>  		reg3 = DTS_T_CPU1_C_REG;
>  		break;
>  	case hwmon_temp_crit_hyst:
> -		reg1 = LTD_LV_LL_REG;
> +		reg1 = LTD_LV_HL_REG;
>  		reg2 = TEMP_CH1_CH_REG;
>  		reg3 = DTS_T_CPU1_CH_REG;
>  		break;
> @@ -507,22 +507,22 @@ static int nct7904_write_temp(struct device *dev, u32 attr, int channel,
>  
>  	switch (attr) {
>  	case hwmon_temp_max:
> -		reg1 = LTD_HV_HL_REG;
> +		reg1 = LTD_HV_LL_REG;
>  		reg2 = TEMP_CH1_W_REG;
>  		reg3 = DTS_T_CPU1_W_REG;
>  		break;
>  	case hwmon_temp_max_hyst:
> -		reg1 = LTD_LV_HL_REG;
> +		reg1 = LTD_LV_LL_REG;
>  		reg2 = TEMP_CH1_WH_REG;
>  		reg3 = DTS_T_CPU1_WH_REG;
>  		break;
>  	case hwmon_temp_crit:
> -		reg1 = LTD_HV_LL_REG;
> +		reg1 = LTD_HV_HL_REG;
>  		reg2 = TEMP_CH1_C_REG;
>  		reg3 = DTS_T_CPU1_C_REG;
>  		break;
>  	case hwmon_temp_crit_hyst:
> -		reg1 = LTD_LV_LL_REG;
> +		reg1 = LTD_LV_HL_REG;
>  		reg2 = TEMP_CH1_CH_REG;
>  		reg3 = DTS_T_CPU1_CH_REG;
>  		break;
