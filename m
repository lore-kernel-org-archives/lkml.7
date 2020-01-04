Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA4AC32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15CA21734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knC3R+Jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgADQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:30:55 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33010 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:30:55 -0500
Received: by mail-pj1-f65.google.com with SMTP id u63so3469876pjb.0;
        Sat, 04 Jan 2020 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SF6jQ6Us3Rm1ak3vLMeXdgaGr4D7O4/vI9dVN14WAWU=;
        b=knC3R+JzRicRScYWvNV/GJT03sMkk14T/0w/QorA2Kf+KmidJJ/YxlUNA6fyjXj4b3
         xmn4nUJhBUDBBaAMR5HIf8Udb17co8B7dmoE/35G8RRhnaPHpUYqu3i+Q5YvooOOx0N5
         OnmBqeP8lbmWKGIY1L8ys3B1lljJLjz1cPUuc7Vz2Qn6CxtEXuzynRLUjL/3tfFVJG1X
         uw7ehhIE849UzlniFvsToVnhVsHno6y2ekKwVbdahtRFFCK/XGWeJNGmVt1L6CwLhvPm
         isy554OKMzQMMqdBSb+uHGeY5mpNu06+d6ebXHsorKuepWaSYKbYwQT1ojvLUYuTMOIZ
         6URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SF6jQ6Us3Rm1ak3vLMeXdgaGr4D7O4/vI9dVN14WAWU=;
        b=GDFD5tBvqWE4HxhgSjk+iSuqpUSoDDnDp0lfyT/HRJ8RFLaWLzgeVIyLfnnYKrBitC
         MtrfKq6MaAxZ7zluH9gyC7To/cQ8WwfWcBeO0FRGbPsU1755eNO49McY6YQvNwiptCh5
         AX8Nq1ZdjsvFz0hUvQ2Gnnul7oAA7u5UZW0NE4HGE4QFqk53m3lmjyu6uNDsAAdx1peQ
         T5rSTPzvY6xsayq72h9wCjJZMDpTeb+7Jc9nI9FCf4eM8kdrgHbmeriUC9N0Tl8FVLaH
         f1pEmrMiDUZkaV419FEpT2r28R2TcDJzNYkJuOpQPzmlS8CUM4VDirw7CZH18edb7xWd
         hfKA==
X-Gm-Message-State: APjAAAUbOMWpMtZOxzUR0lffoecNi6x1uyTzzVxnALZ7ru5akKzc0HMJ
        cTnOXxcgDuTpxNrYbciF/kM=
X-Google-Smtp-Source: APXvYqxE2Qu80RJuBDvv94/ffMEz1m48VFn6ZRy8UdkbTXgNv2eYpFmBVzLVQ/TpBl+7BacWiq703Q==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr82430814plk.47.1578155454710;
        Sat, 04 Jan 2020 08:30:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y20sm7049393pfe.107.2020.01.04.08.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 08:30:54 -0800 (PST)
Date:   Sat, 4 Jan 2020 08:30:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, bjwyman@gmail.com
Subject: Re: [PATCH 3/3] hwmon: (pmbus/ibm-cffps) Fix the LED behavior when
 turned off
Message-ID: <20200104163053.GA13266@roeck-us.net>
References: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
 <1576788607-13567-4-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576788607-13567-4-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:50:07PM -0600, Eddie James wrote:
> The driver should remain in control of the LED on the PSU, even while
> off, not the PSU firmware as previously indicated.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index b37faf1..1c91ee1 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -47,13 +47,9 @@
>  #define CFFPS_MFR_VAUX_FAULT			BIT(6)
>  #define CFFPS_MFR_CURRENT_SHARE_WARNING		BIT(7)
>  
> -/*
> - * LED off state actually relinquishes LED control to PSU firmware, so it can
> - * turn on the LED for faults.
> - */
> -#define CFFPS_LED_OFF				0
>  #define CFFPS_LED_BLINK				BIT(0)
>  #define CFFPS_LED_ON				BIT(1)
> +#define CFFPS_LED_OFF				BIT(2)
>  #define CFFPS_BLINK_RATE_MS			250
>  
>  enum {
> @@ -436,6 +432,9 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
>  	rc = devm_led_classdev_register(dev, &psu->led);
>  	if (rc)
>  		dev_warn(dev, "failed to register led class: %d\n", rc);
> +	else
> +		i2c_smbus_write_byte_data(client, CFFPS_SYS_CONFIG_CMD,
> +					  CFFPS_LED_OFF);
>  }
>  
>  static struct pmbus_driver_info ibm_cffps_info[] = {
