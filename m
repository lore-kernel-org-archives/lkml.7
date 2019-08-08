Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1B1C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAB0214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGsb+zKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbfHHOL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:11:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42942 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732866AbfHHOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:11:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so44130173pgb.9;
        Thu, 08 Aug 2019 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PrXLz85S8ZkGS5czaPVrydA5nObeEkrWljwkkj0fXAk=;
        b=oGsb+zKHx5hVRjpU7EuRjLQTbwCmlbrR7otoZ252j+NJjCnVkhIUzblB+LWW/EIbmW
         Y/Y/HRtHu3u29Gxp1Xte4JO2JOIFm0HssJwSKB8ThRiYKdzlxHLAcOmrusJn32CI7e9Q
         CX6NQq6kqE5HPAduh4juWpRiQpGHs+TJk+4Fo1prYuwe7DV00xLDwPbPzK3WE5OcjXv2
         Y+8Di17csl3d8RkOytRWpOZ7EOy7VFqgeW0hx+X+KTYc6KFk6Rj+3Evgn+Gaa7mzyxDq
         wMXbQdrtfc1Wpr9MvjyMZeBE0pS/9KW1jXD4DdzMgT+oJF0Jdj3RdAv7L0RL3CgvjWg4
         nEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PrXLz85S8ZkGS5czaPVrydA5nObeEkrWljwkkj0fXAk=;
        b=mMLkx+9KCcyRzZsSiDI6a1zrssPzbPFUuxLb9o6kkhKJ/SlkRwF/Y6nRnR5mtvTtfd
         sIeeyMeYf2g/8DNlTHRwWsVDZd0byhVQz0fNMTooD+n8RfwPEZC/0DOmp+AVLHZS3maI
         ZDjp16cUj+TRRw5CVSNRRIWwCplztxNifePkPUpS91b99CSDo63WLpOHbhLp237vkMLW
         1euTX4IIO0rYDGEA0V4mO/t3LOFfOMcnHEsvURy9aiHZotXpg8PxW4qT0AO+BArBT0X7
         /15qOhOznnnR/8QwtUdJyJzIsDQtMEYoeTygp7xqHPCfMHfrAKQDX5P6Jyd6KrF6Z38V
         5yMg==
X-Gm-Message-State: APjAAAXUH4eP67OuZFM7EyJlr6HYii3Gq4bRLAYARs8dLI7U0MgwDRRI
        ejB42ikmDzrByd7thL0HW9A=
X-Google-Smtp-Source: APXvYqwKCRXKbG2A06Hfg7EOAhmQcB63uJxeLsjWcntxuFjKiI3YDw9eInd+0mibxaooMFkAZS91Yw==
X-Received: by 2002:a63:de07:: with SMTP id f7mr13255328pgg.213.1565273515921;
        Thu, 08 Aug 2019 07:11:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h26sm100736222pfq.64.2019.08.08.07.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:11:55 -0700 (PDT)
Date:   Thu, 8 Aug 2019 07:11:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Iker Perez <iker.perez@codethink.co.uk>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hwmon: (lm75) Add new fields into lm75_params_
Message-ID: <20190808141154.GA9369@roeck-us.net>
References: <20190808080246.8371-1-iker.perez@codethink.co.uk>
 <20190808080246.8371-4-iker.perez@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808080246.8371-4-iker.perez@codethink.co.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:02:45AM +0100, Iker Perez wrote:
> From: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
> 
> The new fields are included to prepare the driver for next patch. The
> fields are:
> 
> * *resolutions: Stores all the supported resolutions by the device.
> * num_sample_times: Stores the number of possible sample times.
> * *sample_times: Stores all the possible sample times to be set.
> * sample_set_masks: The set_masks for the possible sample times
> * sample_clr_mask: Clear mask to set the default sample time.
> 
> Signed-off-by: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
> ---
> 
> Changes since v1:
> - In the lm75_params structure documentation there have been the next changes:
>         - @num_sample_times description has been extended.
>         - @sample_times description has been extended.
>         - @sample_set_masks description has been extended.
>         - @resolutions description has been included.
> 
>  drivers/hwmon/lm75.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index a32d7952d799..ed72455bcfa3 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -61,15 +61,34 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>   * @resolution_limits:	Limit register resolution. Optional. Should be set if
>   *			the resolution of limit registers does not match the
>   *			resolution of the temperature register.
> + * @resolutions		List of resolutions associated with sample times.

@resolutions:

> + *			Optional. Should be set if num_sample_times is larger
> + *			than 1, and if the resolution changes with sample times.
> + *			If set, number of entries must match num_sample_times.
>   * default_sample_time:	Sample time to be set by default.

@default_sample_time:

No need to resend; I'll fix that up when applying.

> + * @num_sample_times:	Number of possible sample times to be set. Optional.
> + *			Should be set if the number of sample times is larger
> + *			than one.
> + * @sample_times:	All the possible sample times to be set. Mandatory if
> + *			num_sample_times is larger than 1. If set, number of
> + *			entries must match num_sample_times.
> + * @sample_set_masks:	All the set_masks for the possible sample times.
> + *			Mandatory if num_sample_times is larger than 1.
> + *			If set, number of entries must match num_sample_times.
> + * @sample_clr_mask:	Clear mask to set the default sample time.
>   */
>  
>  struct lm75_params {
> -	u8		set_mask;
> -	u8		clr_mask;
> -	u8		default_resolution;
> -	u8		resolution_limits;
> -	unsigned int	default_sample_time;
> +	u8			set_mask;
> +	u8			clr_mask;
> +	u8			default_resolution;
> +	u8			resolution_limits;
> +	const u8		*resolutions;
> +	unsigned int		default_sample_time;
> +	u8			num_sample_times;
> +	const unsigned int	*sample_times;
> +	const u8		*sample_set_masks;
> +	u8			sample_clr_mask;
>  };
>  
>  /* Addresses scanned */
> @@ -221,7 +240,14 @@ static const struct lm75_params device_params[] = {
>  	[tmp75b] = { /* not one-shot mode, Conversion rate 37Hz */
>  		.clr_mask = 1 << 7 | 3 << 5,
>  		.default_resolution = 12,
> +		.sample_set_masks = (u8 []){ 0 << 5, 1 << 5, 2 << 5,
> +			3 << 5 },
> +		.sample_clr_mask = 3 << 5,
>  		.default_sample_time = MSEC_PER_SEC / 37,
> +		.sample_times = (unsigned int []){ MSEC_PER_SEC / 37,
> +			MSEC_PER_SEC / 18,
> +			MSEC_PER_SEC / 9, MSEC_PER_SEC / 4 },
> +		.num_sample_times = 4,
>  	},
>  	[tmp75c] = {
>  		.clr_mask = 1 << 5,	/*not one-shot mode*/
