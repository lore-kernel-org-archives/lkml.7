Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF028C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8292022DD6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqEU5RQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfHUDUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:20:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33937 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHUDUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:20:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so481606pgc.1;
        Tue, 20 Aug 2019 20:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LzDQ1uoO2SpyVOT5FGWb4IORX7EKp5J+tij1Lu0cj5o=;
        b=HqEU5RQfOZMKYvYhq7nhdWvUpBVD5Tue+TBRxLYeM7sssFt4rl/bjHUDwb6UAVIDLs
         jNqHw8sYwf7qm409tlo/z/PDoHCIffIlIUkdaHHXWUlxZBlDU3hZn7qxiezHIVM9AUAv
         v44ec76h3is6u1A6oCJjn2x2KL3LB9XhA3z5hdstUJ4tgKhW6r+cGO659Pwl+PmNElor
         2TM6XjjtqRCI3msQF7jngqXEFdiAtwPS/uWrsyUHCvoFvFKd2l7Ku6Ly81QfVmycMJvT
         wIdbogK00K2gcBTmj6ksOTBWmGbTAZorS9AqLvPf2D5M0nKZSgvuNi5fHweV9fV1w3Ke
         RTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LzDQ1uoO2SpyVOT5FGWb4IORX7EKp5J+tij1Lu0cj5o=;
        b=LBZZP1AK6QTauh1gQ+r4GAk+hkPHvo6PJcA0i+Pm7KditSWp+FjmJ9v7GS383cI7Hw
         HkF/wguF/qHn5Q7IoleuNF9oEFJPUvn+i0x5imq++cNytVvOzBHsuRQRUYS/PzkwYbpe
         NMVtv6/J2CZxlkjNMG2p9MgNedbG90d5HgGMaqddQ7AmdJVMX108QSkUkeJluY3GQdoo
         nO5ochYN9c8+uTaeGlaJQLT3E/M4FjOcTOOUjG066bkKcasLUWZLblXVcPrgF9TIp2eO
         sy55IeqRP0CYCwHdm3mQuxpaW4afKMRa7JAuxPRD634l1dfixgqMLZCKXZSS/zHiAN1t
         cmrw==
X-Gm-Message-State: APjAAAXCLBkVQ1j+2P+SWAcr59FtYKetxL0vutQgpk9NsYMJsZ/fNpT8
        t0a+1+cz7HeEOk3k4NhU7DHgwLOz
X-Google-Smtp-Source: APXvYqybKR/1e9MFwTH4J0r05eyXIDuKH8zpxgb6cBWwJdHr3Vn3Izn980vhvSv24EvE7TMIeM/2bw==
X-Received: by 2002:a63:e610:: with SMTP id g16mr26903872pgh.392.1566357618757;
        Tue, 20 Aug 2019 20:20:18 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d18sm18015565pgi.40.2019.08.20.20.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:20:17 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:20:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] (submitted) input: misc: soc_button_array: use
 platform_device_register_resndata()
Message-ID: <20190821032015.GR121898@dtor-ws>
References: <1566303944-15321-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566303944-15321-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Tue, Aug 20, 2019 at 02:25:44PM +0200, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> The registration of gpio-keys device can be written much shorter
> by using the platform_device_register_resndata() helper.
> 
> v2:
>     * pass &pdev->dev to platform_device_register_resndata()
>     * fixed errval on failed platform_device_register_resndata()
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/input/misc/soc_button_array.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 5e59f8e5..27550f9 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -110,25 +110,24 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
>  	gpio_keys_pdata->nbuttons = n_buttons;
>  	gpio_keys_pdata->rep = autorepeat;
>  
> -	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
> -	if (!pd) {
> -		error = -ENOMEM;
> +	pd = platform_device_register_resndata(
> +		&pdev->dev,
> +		"gpio-keys",
> +		PLATFORM_DEVID_AUTO,
> +		NULL,
> +		0,
> +		gpio_keys_pdata,
> +		sizeof(*gpio_keys_pdata));
> +
> +	error = PTR_ERR_OR_ZERO(pd);
> +
> +	if (IS_ERR(pd)) {

I changed this and the PTR_ERR() to simply "error" and applied.

> +		dev_err(&pdev->dev, "failed registering gpio-keys: %ld\n", PTR_ERR(pd));
>  		goto err_free_mem;
>  	}
>  
> -	error = platform_device_add_data(pd, gpio_keys_pdata,
> -					 sizeof(*gpio_keys_pdata));
> -	if (error)
> -		goto err_free_pdev;
> -
> -	error = platform_device_add(pd);
> -	if (error)
> -		goto err_free_pdev;
> -
>  	return pd;
>  
> -err_free_pdev:
> -	platform_device_put(pd);
>  err_free_mem:
>  	devm_kfree(&pdev->dev, gpio_keys_pdata);
>  	return ERR_PTR(error);
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
