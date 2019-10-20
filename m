Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624AFCA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3523C21929
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB3IJn6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfJTQX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 12:23:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36398 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfJTQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 12:23:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so6789728pfr.3;
        Sun, 20 Oct 2019 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jl6vWWyzWrmqvShh0G8ezuUFzcCrumASaBZUoNE85pc=;
        b=qB3IJn6jtYpo1a3DOZKe9tv4/FHs6GP9odcHE/IyoglBPT1BZGemW3P/p0yRhCTs50
         jJju8KBshDo0pTpWOqSU+mW31bMlyStkcnGdKG8kff3Xte4/GQ+IjfFHnZEF5Vwuk42G
         k6qU7mHCmuSOvptVKod7Ecmvki3l8Vob1vIV21SazZ6wMo07d5UfdK+jZbdYCngEGOc1
         2FiLEFsq91P8CfNZh+OSsUd/g+z+NnzGw4iP2VQpf/Gir6ECdb+lTJkGiNVDgIKOIJCR
         QazWMbO7GQMsT2ivs5mSvNhbVaadLqO8XDchzItzTxe6Mz/yDrcB1Cmv9sYoAFjoTdsV
         sSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jl6vWWyzWrmqvShh0G8ezuUFzcCrumASaBZUoNE85pc=;
        b=Dk5sTeMENCrzYUjwj4WmJD3kn7DLb2b6GeU8Zcbak0C4ooRCEAH2g5nN3H6jCbAwwV
         4VG1hd/19z8+PPgHMwvkn+RTlbnAyBuIdOgL0YJqsGIbuoHtmOeNog2tCpQEjEJdnCiL
         0UtUzgVhbYVYTtL2MhKQCFg3UtYINOBJ7Y2F1v4dAALCyhB473xmpBiAWe4zzpfVEEk0
         7Se9cN1Q9lTBJcyfygLDPUWoU0Lat6EvaXTGBG/hFs0Sbd49gVaAgM9pag8iNmg8Fd3M
         JIpKULmYjLctRb3waI5fr81TnKaqgwhEW1THG9nWzc7ju1wj93GK/t6+PvJ7Vag4LrYd
         o33g==
X-Gm-Message-State: APjAAAUaYMcYv1EQ9fso2o5SEEaPWlO40nY2M3gA4ro7TBxjWCFFeO81
        QLjZXSQxqPF4Uaq/EOdTJo8=
X-Google-Smtp-Source: APXvYqyzwxFfW23iC403pkMFqhI9TaeVTSv2vGRGc747IjgO1v0PiKLxvIN8loAqZ96A9s1ImO+Eog==
X-Received: by 2002:a63:2348:: with SMTP id u8mr21011865pgm.422.1571588606393;
        Sun, 20 Oct 2019 09:23:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s97sm17454686pjc.4.2019.10.20.09.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Oct 2019 09:23:25 -0700 (PDT)
Date:   Sun, 20 Oct 2019 09:23:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v1,1/1] hwmon: (nct7904) Fix the incorrect value of vsen_mask &
 tcpu_mask & temp_mode in nct7904_data struct.
Message-ID: <20191020162325.GA16156@roeck-us.net>
References: <20191014082451.2895-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014082451.2895-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 04:24:51PM +0800, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> Voltage sensors overlap with external temperature sensors. Detect
> the multi-function of voltage, thermal diode, thermistor and
> reserved from register VT_ADC_MD_REG to set value of vsen_mask &
> tcpu_mask & temp_mode in nct7904_data struct. If the value is
> reserved, needs to disable the vsen_mask & tcpu_mask.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7904.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index b26419dbe840..281c81edabc6 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -82,6 +82,10 @@
>  #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
>  #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
>  
> +#define VOLT_MONITOR_MODE	0x0
> +#define THERMAL_DIODE_MODE	0x1
> +#define THERMISTOR_MODE		0x3
> +
>  #define ENABLE_TSI	BIT(1)
>  
>  static const unsigned short normal_i2c[] = {
> @@ -935,11 +939,16 @@ static int nct7904_probe(struct i2c_client *client,
>  	for (i = 0; i < 4; i++) {
>  		val = (ret >> (i * 2)) & 0x03;
>  		bit = (1 << i);
> -		if (val == 0) {
> +		if (val == VOLT_MONITOR_MODE) {
>  			data->tcpu_mask &= ~bit;
> +		} else if (val == THERMAL_DIODE_MODE && i < 2) {
> +			data->temp_mode |= bit;
> +			data->vsen_mask &= ~(0x06 << (i * 2));
> +		} else if (val == THERMISTOR_MODE) {
> +			data->vsen_mask &= ~(0x02 << (i * 2));
>  		} else {
> -			if (val == 0x1 || val == 0x2)
> -				data->temp_mode |= bit;
> +			/* Reserved */
> +			data->tcpu_mask &= ~bit;
>  			data->vsen_mask &= ~(0x06 << (i * 2));
>  		}
>  	}
