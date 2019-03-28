Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BF62082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553731441;
	bh=eLWxc42EdSX0yY2VqsyWBNmeShcdc3u5LU8Y11nY2tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UCWiQGxGbGuZMqIlJs6627KPkxA/+4aLtnLwz44q7Mj4KO4b9cEr3LxOXIkqgogcW
	 ojp1IqD8Z7dwYmU2tpCoVdldfwwH6JhDIsu753hHl6RpYKQ/zStpYD5hnB+/qgZGC1
	 Z8Jnj1v0eZwBvAp6O6gELiuTZq0wIUQIPsXEIedc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfC1AEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:04:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33394 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1AD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:03:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id e5so2802768oii.0;
        Wed, 27 Mar 2019 17:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RcO+9FE+Ru1vWqF/9QY5++Yy8jBVB8RD4RHgWrhHzjw=;
        b=DWD1t6MEVm3nGTfmPS/OSoCW5G5Nf161xOd1kCQJB61ZHqwvuNdj8VZ8dPogFkmpbh
         sDd1VSNZJSb9PAyfnulfDZfaXu7MqxKW2m2U7bpa25qoPTZ6RbWa3RQU/ehjl504LIxg
         nTn3qfvPL4/0Z8GcqwMF5QbU350Jn0UIkTxEp4QqfXrjHHnrDcDBYAa7ML+rtCyZEPBL
         6HCEMRnV4BGpONJpSPxU0mGYLYUmH8iT2iMo3ppvwsru+0JfcfYMSFCaLGs6hOuBKsd8
         yHkMGHU1ZLA4gUlvByWDsN+4T6GB3LGtGJlJNa8gMQ6q+B9B/PEJmcn62xBKuhqoXIwm
         pBFw==
X-Gm-Message-State: APjAAAX7L1uKzRlvZWMDICeqwaloNO74VIfa+th1So3lqygNbDNE923H
        r2ZUOAJl7M6EVKX+9Xa37Q==
X-Google-Smtp-Source: APXvYqzTVSR0VCtDFGlU2pnHIafcToKcVrFTWigZQ4uB1lxI0b+C1PAbUiolcx79HyuVJ1uBbfm0Eg==
X-Received: by 2002:aca:b587:: with SMTP id e129mr3504279oif.143.1553731438802;
        Wed, 27 Mar 2019 17:03:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c84sm8832060oia.41.2019.03.27.17.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 17:03:57 -0700 (PDT)
Date:   Wed, 27 Mar 2019 19:03:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 03/25] dt-bindings: leds: Add LED_FUNCTION definitions
Message-ID: <20190328000357.GA3399@bogus>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-4-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310182836.20841-4-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 07:28:14PM +0100, Jacek Anaszewski wrote:
> Add common LED function definitions for use in Device Tree.
> The function names were extracted from existing dts files
> after eliminating oddities.

I'd like this to be suggestions of what to use rather than what's 
already out there. So my comments are in that context.

> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  include/dt-bindings/leds/common.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index e171d0a6beb2..ffcd46317307 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -19,4 +19,42 @@
>  #define LEDS_BOOST_ADAPTIVE	1
>  #define LEDS_BOOST_FIXED	2
>  
> +/* Standard LED functions */
> +#define LED_FUNCTION_ACTIVITY "activity"

of what?

> +#define LED_FUNCTION_ADSL "adsl"

wan?

> +#define LED_FUNCTION_ALARM "alarm"
> +#define LED_FUNCTION_BACKLIGHT "backlight"
> +#define LED_FUNCTION_BLUETOOTH "bluetooth"
> +#define LED_FUNCTION_BOOT "boot"

What about boot?

> +#define LED_FUNCTION_CHRG "chrg"
> +#define LED_FUNCTION_DEBUG "debug"
> +#define LED_FUNCTION_DISK "disk"
> +#define LED_FUNCTION_DISK_READ "disk-read"
> +#define LED_FUNCTION_DISK_WRITE "disk-write"
> +#define LED_FUNCTION_FAULT "fault"
> +#define LED_FUNCTION_FLASH "flash"
> +#define LED_FUNCTION_HDDERR "hdderr"

disk-err for consistency?

> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
> +#define LED_FUNCTION_INDICATOR "indicator"
> +#define LED_FUNCTION_INFO "info"

of what?

> +#define LED_FUNCTION_INTERNET "internet"

Same as wan? 

> +#define LED_FUNCTION_LAN "lan"
> +#define LED_FUNCTION_MMC "mmc"

Same as disk?

> +#define LED_FUNCTION_NAND "nand"
> +#define LED_FUNCTION_ON "on"
> +#define LED_FUNCTION_PROGRAMMING "programming"
> +#define LED_FUNCTION_PWR "pwr"
> +#define LED_FUNCTION_RX "rx"
> +#define LED_FUNCTION_SD "sd"

> +#define LED_FUNCTION_SLEEP "sleep"
> +#define LED_FUNCTION_STANDBY "standby"

Same things?

> +#define LED_FUNCTION_STATUS "status"
> +#define LED_FUNCTION_TORCH "torch"
> +#define LED_FUNCTION_TV "tv"
> +#define LED_FUNCTION_TX "tx"
> +#define LED_FUNCTION_USB "usb"
> +#define LED_FUNCTION_WAN "wan"
> +#define LED_FUNCTION_WLAN "wlan"
> +#define LED_FUNCTION_WPS "wps"
> +
>  #endif /* __DT_BINDINGS_LEDS_H */
> -- 
> 2.11.0
> 
