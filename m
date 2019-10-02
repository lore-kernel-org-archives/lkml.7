Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A93BECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F1721783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfMmz+ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfJBNn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:43:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36565 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:43:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so3337822pgk.3;
        Wed, 02 Oct 2019 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M5CvC+h5yCnkY1BjUVLMtr/c8i3cN60VqIKOIpHtvR0=;
        b=SfMmz+yepUgjUJaZKZzn6gbu3Z5O9wNPukhpzN1stfdz6II8TX823NUGrXE8Zj5Iew
         xIBaBIIEH88OXjC4qkFTB196KxFxsjGgpkWGsPg+7VfO2nGWRfwXGOa3XOIBhl0uoI4m
         SlptoPG9K5jx4UshfZNSvQKRNGE0xvF64uTzj6ypgi86le2gJfq9O57tJ2Mkw6kIYRE/
         YRirAwlPLhfSb7YVPZ8fQU+RBr/SjbKt6fio88cAtIh4Q3BK0gCTDjsDK5OF6mkbgbMp
         4Y7oFenstdJWRx90Agw1AnXu8m4ohqOCCj+e2jGVt01wSloLlxcUa20NvZll70xZt2oC
         JHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=M5CvC+h5yCnkY1BjUVLMtr/c8i3cN60VqIKOIpHtvR0=;
        b=EA9Gcav2ENzWAi1jXJL41FDwf1i3JXISg92l6DK/vuL9YAAe7V9HdGIe+hLTxqSMhB
         I+bZni1IHawq4NS7yiwkVSAxldxIFW7+w9S1k3CL9d1L5zuvEzBXQKAZaX9cYeko8pPz
         SLjtbsamM3/LLoFinrEfmdPjCQ5NrQHnf18ue7DicUvAH2zpyK8SOFNmOgvZYbGF/Bzh
         6+yuVdtHVDSs9yhsEU8uVbd0O35ZVDvmBZiOdP75pZI15ZfigH+KXteVyHNAhXJHWexD
         1NUiywAXDA6XyvLMVkS9QMUM8zG+S7opaUcyBvoJqWyQ+ul5aDjAIWF2XAccT5oj3Mg6
         0NFg==
X-Gm-Message-State: APjAAAVcd4WrLm6KBkytq/rxy/QoA10jTNBY5Zg0hMHK9h28q0/TudD9
        J28JxSUedcjUc1C0oAKkhGI=
X-Google-Smtp-Source: APXvYqyBzSF286Q4c2p0CJNW+7hZ36KWzPniD4/7nOlUmTS6twkinQLBRBfgggDW7uT38NPPcd6/5g==
X-Received: by 2002:a63:d05:: with SMTP id c5mr3784421pgl.182.1570023808617;
        Wed, 02 Oct 2019 06:43:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z29sm27937773pff.23.2019.10.02.06.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 06:43:28 -0700 (PDT)
Date:   Wed, 2 Oct 2019 06:43:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        bichan.lu@advantech.com.tw, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v1,1/1] hwmon: (nct7904) Add array fan_alarm and vsen_alarm to
 store the alarms in nct7904_data struct.
Message-ID: <20191002134327.GA9272@roeck-us.net>
References: <20190919030205.11440-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919030205.11440-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 11:02:05AM +0800, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> SMI# interrupt for fan and voltage is Two-Times Interrupt Mode.
> Fan or voltage exceeds high limit or going below low limit,
> it will causes an interrupt if the previous interrupt has been
> reset by reading all the interrupt Status Register. Thus, add the
> array fan_alarm and vsen_alarm to store the alarms for all of the
> fan and voltage sensors.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7904.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index f62dd1882451..b26419dbe840 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -99,6 +99,8 @@ struct nct7904_data {
>  	u8 enable_dts;
>  	u8 has_dts;
>  	u8 temp_mode; /* 0: TR mode, 1: TD mode */
> +	u8 fan_alarm[2];
> +	u8 vsen_alarm[3];
>  };
>  
>  /* Access functions */
> @@ -214,7 +216,15 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
>  				       SMI_STS5_REG + (channel >> 3));
>  		if (ret < 0)
>  			return ret;
> -		*val = (ret >> (channel & 0x07)) & 1;
> +		if (!data->fan_alarm[channel >> 3])
> +			data->fan_alarm[channel >> 3] = ret & 0xff;
> +		else
> +			/* If there is new alarm showing up */
> +			data->fan_alarm[channel >> 3] |= (ret & 0xff);
> +		*val = (data->fan_alarm[channel >> 3] >> (channel & 0x07)) & 1;
> +		/* Needs to clean the alarm if alarm existing */
> +		if (*val)
> +			data->fan_alarm[channel >> 3] ^= 1 << (channel & 0x07);
>  		return 0;
>  	default:
>  		return -EOPNOTSUPP;
> @@ -298,7 +308,15 @@ static int nct7904_read_in(struct device *dev, u32 attr, int channel,
>  				       SMI_STS1_REG + (index >> 3));
>  		if (ret < 0)
>  			return ret;
> -		*val = (ret >> (index & 0x07)) & 1;
> +		if (!data->vsen_alarm[index >> 3])
> +			data->vsen_alarm[index >> 3] = ret & 0xff;
> +		else
> +			/* If there is new alarm showing up */
> +			data->vsen_alarm[index >> 3] |= (ret & 0xff);
> +		*val = (data->vsen_alarm[index >> 3] >> (index & 0x07)) & 1;
> +		/* Needs to clean the alarm if alarm existing */
> +		if (*val)
> +			data->vsen_alarm[index >> 3] ^= 1 << (index & 0x07);
>  		return 0;
>  	default:
>  		return -EOPNOTSUPP;
