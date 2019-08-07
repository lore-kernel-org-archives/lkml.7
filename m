Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A2C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1829321E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+j9hINe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbfHGNvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:51:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47097 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388123AbfHGNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:51:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so40898733plz.13;
        Wed, 07 Aug 2019 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U6Bb6izZEXCKygUNKpmGB/5X9OObdOmDXW9moj2OUms=;
        b=a+j9hINeX2PtxO6lsjPbiHYOdvo6hwV1ozSfBAfXoDMWvNOuj/y8+70+eE7DOVLEQS
         XoT5KIzlrg2RbBsAY6PUgOomb+jjs4zxUgsyzskcDxnI3FcDpSf4IbUcdDUK0s99Trgn
         RtLDO8lzJpU9JEPFOoJeQg6JyJfRQtwP9UvYWN9AOSiVwLA4Dwos49IAXoNCfagqriaO
         zH9aYbQIh0GUZAH0fx0diy0MXcnN4GtV/66xzqZzZao8T7aiCsPMNEIIJAhNTlKHXg84
         mtVo45/gul0LoDqpuANs7fJXtHVzdFs9+A2yftQ/bVOgbuBCO81JY6kcSZ4gSt5EExWA
         lutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U6Bb6izZEXCKygUNKpmGB/5X9OObdOmDXW9moj2OUms=;
        b=T6VqvOtV90koSTWRPsSNAK5JKg4n9yGYiAuQv5MiQZQgZrl+YzCntlcRPFmFZpwqSt
         /kaSUfea/YylZDn+E+8NDq+hfpAhdOOnWRs0CQ4ADCpWlmI3FSU55GR8Wvilog2d8i1C
         lnAyHp5LqLLb8/2KksQLZUWVtcPKRywBtPvpE38kKMuqi6k0LQrU8y/z0ZhSBnq31LMT
         1hHuqLfjXyBvCb55Uo+UkHiTWn4NWuLHRopBdhUuBaln+3f1wxo7NF5zeQuIBkeq4LAf
         8Hm8KGC2uFJ+TUfYsniXryZbfMC/EIot1SQI7sBqP9Cr2pgODk3LzclBEc33PJeTJwzm
         /+gQ==
X-Gm-Message-State: APjAAAWSl3TcnXzTn+hlMZhVvhaLPJV93gJI6fId6HnEwPBxTKzv6pbF
        /rbzeDfq97t+iJYC8c3/fnl3l19x
X-Google-Smtp-Source: APXvYqym8erQGmZSYnozYbiIPUJsaf9KBcaplq46vU/M8mOpe3PICGR42FhVrnGyNN+6tH/2Ch+szw==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr89872pja.104.1565185880137;
        Wed, 07 Aug 2019 06:51:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e5sm20669517pgt.91.2019.08.07.06.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 06:51:19 -0700 (PDT)
Date:   Wed, 7 Aug 2019 06:51:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Iker Perez <iker.perez@codethink.co.uk>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] hwmon: (lm75) Add new fields into lm75_params_
Message-ID: <20190807135117.GA11447@roeck-us.net>
References: <20190806091107.13322-1-iker.perez@codethink.co.uk>
 <20190806091107.13322-4-iker.perez@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806091107.13322-4-iker.perez@codethink.co.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:11:06AM +0100, Iker Perez wrote:
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
>  drivers/hwmon/lm75.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 477ac0732ddf..a8d0a6fb9762 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -58,15 +58,24 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>   *			the chip.
>   * @resolution:		Number of bits to represent the temperatue value.
>   * @resolution_limits:	Resolution range.
> + * @num_sample_times:	Number of possible sample times to be set.

Please add something like:
				Optional. Should be set if the number
				of sample times is larger than one.

>   * default_sample_time:	Sample time to be set by default.
> + * @sample_times:	All the possible sample times to be set.

Please add something like:
				Mandatory if num_sample_times is larger than 1.
				If set, number of entries must match
				num_sample_times.

> + * @sample_set_masks:	All the set_masks for the possible sample times.

Please add something like:
				Mandatory if num_sample_times is larger than 1.
				If set, number of entries must match
				num_sample_times.

> + * @sample_clr_mask:	Clear mask to set the default sample time.

Please add something like:

 * @resolutions:		List of resolutions associated with sample
				times.
				Optional. Should be set if num_sample_times is
				larger than 1, and if the resolution changes
				with sample times. If set, number of entries
				must match num_sample_times.

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
> @@ -214,7 +223,14 @@ static const struct lm75_params device_params[] = {
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
> -- 
> 2.11.0
> 
