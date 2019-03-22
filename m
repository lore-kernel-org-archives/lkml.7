Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D73A213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka312Lkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfCVNGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:06:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38113 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfCVNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:06:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so1516965pfo.5;
        Fri, 22 Mar 2019 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EbR7tLCqMyFhARbFglLKdOGf8XpFUsz8CBtqAcgU1go=;
        b=Ka312Lkq3/p54+MI300LaypS9JiuKg0sheuz1Ka8MxLcYOZ+VLMCzTjRShnb1LdhPz
         2s+tZRkjZ/QIX/dHlsV2Y+fMR6BjWHpqkxh2hf9+2sOOdjnOdpbBSj1bFtMnlclpCN8o
         GLQfKw9Q3Ggmf3SgHoQVqulXxSDSMdcZJeXUKRyVTl1kbwMR4T8WSXtEI8rV6jJx0MQE
         oDyvlPzJgJVS/WdqLYVqXrhmz30KnP3jua9GRSJGc6QwDG4Bi8+zknMiniB2imX8XHCH
         6Vflw6q4RIdIzAsrM2YetohXrD2cVXE29NouBRsNu3zy8P6AQxHoBu6Uu+fUndmxlQqu
         0vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EbR7tLCqMyFhARbFglLKdOGf8XpFUsz8CBtqAcgU1go=;
        b=s1hUnk8el1JUgmtuOM7BbG3DS17COD5eIpQU/Kk4ol8QfFuDQawf03oZATQSf2bwp6
         Bf1iFwQlm7esWtoRIZK2xapVK/d65YLh7UD6FGuxJ3QNFJCdrMcWA2UwAkmJl9ocNxMa
         LaMoxjrnLtEYIy06xYkZPPs7LWvQnVd0/ZLYG0Nt3TyLq/KvmnIcESJCf4hG8KIw6mBr
         opv3I6P1CJOEvwyYlJLbYyIz0DltoAjpS24Ql/gp9wtzASFw/ecBfb6TxfENSLsX3Sfu
         nxv0qtrwQIfU/KQvej3hwCrWckRBOJvz2n7bttZxLzE5jUP6WGROz8h5+GUinp60ygLR
         nSCA==
X-Gm-Message-State: APjAAAUU6xUgBas/+5mYECMJwje7IK+eMhLNE44/b7mJ0KUtM8XnRfvy
        yjYKDmis5RprHG0R/HMnTRs=
X-Google-Smtp-Source: APXvYqz7IuEZ2NQeh9DWeQv8PvQUVLUmzUUJkP6YaaQWWsrDdveTRPZgsorTB4eAS4YPwZIyemYTlA==
X-Received: by 2002:a62:e502:: with SMTP id n2mr9201973pff.242.1553259981494;
        Fri, 22 Mar 2019 06:06:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 139sm10035645pfw.98.2019.03.22.06.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:06:20 -0700 (PDT)
Subject: Re: [PATCH V1 1/1] watchdog: f71808e_wdt: fix F81866 bit operation
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        wim@linux-watchdog.orgw
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1553225816-24375-1-git-send-email-hpeter+linux_kernel@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <af4fba18-da99-2b48-7bbe-d59222081ab4@roeck-us.net>
Date:   Fri, 22 Mar 2019 06:06:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553225816-24375-1-git-send-email-hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 8:36 PM, Ji-Ze Hong (Peter Hong) wrote:
> Fix error bit operation in watchdog_start()
> 

Hmm ... does that mean it never worked ? Did you test it this time ?

A secondary concern is that the watchdog doesn't _have_ to trigger WDTRST,
but may also trigger PWOK. But that may be a separate issue.

Please add:

Fixes: 14b24a88a3660 ("watchdog: f71808e_wdt: Add F81866 support")

> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>   drivers/watchdog/f71808e_wdt.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 9a1c761258ce..9129485732c7 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -387,18 +387,17 @@ static int watchdog_start(void)
>   
>   	case f81866:
>   		/* Set pin 70 to WDTRST# */
> -		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
> -				  BIT(3) | BIT(0));
> -		superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
> -				BIT(2));
> +		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 3);
> +		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 0);
> +		superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 2);

Better use superio_inb()/superio_outb(). The above is (much) more expensive,
and  we have no real idea what the impact of changing one bit at a time may be.

Thanks,
Guenter

> +
>   		/*
>   		 * GPIO1 Control Register when 27h BIT3:2 = 01 & BIT0 = 0.
>   		 * The PIN 70(GPIO15/WDTRST) is controlled by 2Ch:
>   		 *     BIT5: 0 -> WDTRST#
>   		 *           1 -> GPIO15
>   		 */
> -		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1,
> -				  BIT(5));
> +		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1, 5);
>   		break;
>   
>   	default:
> 

