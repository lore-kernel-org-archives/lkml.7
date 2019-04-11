Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032902073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QedR1/ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDKPAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:00:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33739 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:00:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so7846381wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JwqE8390D206HmShrHOqPJgoEqitzFT+e7w6dFPa72M=;
        b=QedR1/ml2WAkb5ShkV46Ps7+Kk/Chzant5F6V04J0cyFGEp4DdqqFEATXfpSRNwL+V
         gUdu4/rZBuyw6VTPT9QimeSt81TGZdUQv+Hoaus5CAleKgN73Uu0ci910T5hHi2RYZ/N
         0Qbt7P8QkWlDv0m3qr7cwirczs4i+jeFb1GLR/PwKJ6tnSE1LAU1S6Sf3V453YcRH/7a
         /a3s1qIeyd3Zji25poGAL6zgUnRkxCy6WQAlyc3xWTEwVxo2vhqVp704sa4bheq4Yyjm
         3jjIXAvsCC0vaR+fg6Pd/GXmHUPCZzP7dnuZjuOO9q/22oYCZx7eKrz3rLtwzYezCcxz
         PlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JwqE8390D206HmShrHOqPJgoEqitzFT+e7w6dFPa72M=;
        b=f1xJWqtlaXWxAPikpB+Ni03SxUVKwcMDvWZL8tliFyXxH1Nl5u5kvCuTU7UQ693YcD
         ozSs9Dtnbja65C7n1g8BC2JszEiD6JMVM4O7/PIRvr+bOTiHxYBung6XKZIXGe8ddqIS
         J53egUQD/TCXgFxMOImkTHjbqYr/h/Xn2p/DG2ycvBMqHRLCs9U8F/qKlFzLlxh50seb
         O1FjL/xTNuTZPtTmBccC8kdK94r1gxhYY1Apw3ONouvkPpZHILUja/0O7ZxsiH4rRA/U
         UL8jWfJ3WlCFuEFakef9d8eDJUyfXfs31Jz+BQfmiVIA92F7ZlBV7J2TgQ8v4DTjmWDl
         GHbg==
X-Gm-Message-State: APjAAAXWvYpW1VB8O6fAYvCCBWw9GVwvfkcd+I5adn//rmA1oImmRQWz
        QGuiRY8jTmuTQrfTy7TZGQ0fpA==
X-Google-Smtp-Source: APXvYqwv7y5nhQML2ygeUKR12bMdHmjxHeYw56i2cPiG90ZHXI8aXtqL9Cc6s1JRd3GN4VRMhLUYmw==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr30342499wrv.49.1554994828655;
        Thu, 11 Apr 2019 08:00:28 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id b134sm10441548wmd.26.2019.04.11.08.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:00:27 -0700 (PDT)
Subject: Re: [PATCH 03/12] misc: atmel_tclib: move definitions to header file
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-4-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <63e25c2f-2e10-9c6e-9bfa-7b7220377bd8@linaro.org>
Date:   Thu, 11 Apr 2019 17:00:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403141120.32754-4-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 16:11, Alexandre Belloni wrote:
> Move atmel_tc_divisors and atmel_tcb_dt_ids definitions to the header file
> so they can be used without using tclib.

Why not kill those structure and use the TIMER_OF_DECLARE with the
corresponding probe function which will initialize to 16 or 32 counter
width?



> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/misc/atmel_tclib.c   | 24 ------------------------
>  include/soc/at91/atmel_tcb.h | 21 ++++++++++++++++++++-
>  2 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index 3af27ce7e514..c79190525862 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c
> @@ -17,10 +17,6 @@
>   * share individual timers between different drivers.
>   */
>  
> -/* AT91 has these divide MCK */
> -const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
> -EXPORT_SYMBOL(atmel_tc_divisors);
> -
>  static DEFINE_SPINLOCK(tc_list_lock);
>  static LIST_HEAD(tc_list);
>  
> @@ -72,26 +68,6 @@ void atmel_tc_free(struct atmel_tc *tc)
>  EXPORT_SYMBOL_GPL(atmel_tc_free);
>  
>  #if defined(CONFIG_OF)
> -static struct atmel_tcb_config tcb_rm9200_config = {
> -	.counter_width = 16,
> -};
> -
> -static struct atmel_tcb_config tcb_sam9x5_config = {
> -	.counter_width = 32,
> -};
> -
> -static const struct of_device_id atmel_tcb_dt_ids[] = {
> -	{
> -		.compatible = "atmel,at91rm9200-tcb",
> -		.data = &tcb_rm9200_config,
> -	}, {
> -		.compatible = "atmel,at91sam9x5-tcb",
> -		.data = &tcb_sam9x5_config,
> -	}, {
> -		/* sentinel */
> -	}
> -};
> -
>  MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
>  #endif
>  
> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> index c3c7200ce151..cb0c5f53cd46 100644
> --- a/include/soc/at91/atmel_tcb.h
> +++ b/include/soc/at91/atmel_tcb.h
> @@ -76,8 +76,27 @@ extern struct atmel_tc *atmel_tc_alloc(unsigned block);
>  extern void atmel_tc_free(struct atmel_tc *tc);
>  
>  /* platform-specific ATMEL_TC_TIMER_CLOCKx divisors (0 means 32KiHz) */
> -extern const u8 atmel_tc_divisors[5];
> +static const u8 atmel_tc_divisors[] = { 2, 8, 32, 128, 0, };
>  
> +static const struct atmel_tcb_config tcb_rm9200_config = {
> +	.counter_width = 16,
> +};
> +
> +static const struct atmel_tcb_config tcb_sam9x5_config = {
> +	.counter_width = 32,
> +};
> +
> +static const struct of_device_id atmel_tcb_dt_ids[] = {
> +	{
> +		.compatible = "atmel,at91rm9200-tcb",
> +		.data = &tcb_rm9200_config,
> +	}, {
> +		.compatible = "atmel,at91sam9x5-tcb",
> +		.data = &tcb_sam9x5_config,
> +	}, {
> +		/* sentinel */
> +	}
> +};
>  
>  /*
>   * Two registers have block-wide controls.  These are: configuring the three
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

