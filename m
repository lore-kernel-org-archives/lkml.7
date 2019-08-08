Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56396C32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8B32086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGN+VVdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbfHHN37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:29:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40650 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbfHHN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:29:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so44114158pfp.7;
        Thu, 08 Aug 2019 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eAHc4PXH4W80rIzb0P4YR5zSPB3pQZ2IAYO2JR2Za1c=;
        b=iGN+VVdmYfA4zte+LhxYoLoG8ril+vwki+24TO4FpCqXv0hWmOkcpKxYojxt1VW5TV
         44TyDOQfqVurgs8GpEIpQ85sV/lVRSgYzwGyKyOOmWk0qivuGIua5HWxz1S6mIc0sajC
         G0eeFEwNXsfLgJzOEtdQKTlmmMYH0t6v0M9iFbfFVVs4+YU1W6AxOLakX/NdA+Gy4W0B
         a2v61xtBD8UWsux0K3oJeieS3NnwDV7vJpz1P0auuYNO2Uhb7HKfAejCTW1Qs44hLxeU
         1MaCexhRxK2V/e5MKU8c5VUz091wqWrSzvYBE5h/wwSDJGkYLlYw+TwceqRJP2SsLi7u
         /BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eAHc4PXH4W80rIzb0P4YR5zSPB3pQZ2IAYO2JR2Za1c=;
        b=XV5SsLAzLpQ8t0ZGr/MZ1fAPPVs/6l/WsbeUfuVuxMj3cmnNp4d/p5/PyMxGyNPBVP
         Z977mQTYzf/wturoauO+6UL1MY+m74PhTVF2+UoK1rcbBK/OWP3cufYjcohhT6u6x7iV
         EL/AlyQnqYJjZ0yxxaveaxsiY657ns3jgBNT8xoDkLRavcHsAG4+FUcHZIDjixhK2GUg
         Ug7pRKwDXbp4nuNCh0KXjt3pa2FJQyJ3enUb5EWSTUV+L+XZNPp8d7SogDxMEY69Mwgc
         z24WwD2EQ8bvMxXXhW0Hp5lVHRjX+CyC2ja1S5tFNpexwGoA/3c1R02P+1whGeAeYZvJ
         mQjA==
X-Gm-Message-State: APjAAAXnagGm3xOHySu6HD2nPPRE3p+DwRDMuZTMvfAuIa7KS/w888wL
        a1g0/NysrHmU31SLJM8pXqZtRcO8/kY=
X-Google-Smtp-Source: APXvYqzsY6UsECuf4DosK1dwgKNHz/fB378Lz71BI9XL/gfpkQKAQ1yCdaEuA5+HtdgpHjIldJ4jxg==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr13016625pgi.70.1565270998661;
        Thu, 08 Aug 2019 06:29:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o24sm175272521pfp.135.2019.08.08.06.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:29:57 -0700 (PDT)
Date:   Thu, 8 Aug 2019 06:29:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kbuild test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH][next] hwmon: pmbus: ucd9000: remove unneeded include
Message-ID: <20190808132956.GA30151@roeck-us.net>
References: <20190808080144.6183-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808080144.6183-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:01:44AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Build bot reports the following build issue after commit 9091373ab7ea
> ("gpio: remove less important #ifdef around declarations):
> 
>    In file included from drivers/hwmon/pmbus/ucd9000.c:19:0:
> >> include/linux/gpio/driver.h:576:1: error: redefinition of 'gpiochip_add_pin_range'
>     gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
>     ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/hwmon/pmbus/ucd9000.c:18:0:
>    include/linux/gpio.h:245:1: note: previous definition of 'gpiochip_add_pin_range' was here
>     gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
>     ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/hwmon/pmbus/ucd9000.c:19:0:
> >> include/linux/gpio/driver.h:583:1: error: redefinition of 'gpiochip_add_pingroup_range'
>     gpiochip_add_pingroup_range(struct gpio_chip *chip,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/hwmon/pmbus/ucd9000.c:18:0:
>    include/linux/gpio.h:254:1: note: previous definition of 'gpiochip_add_pingroup_range' was here
>     gpiochip_add_pingroup_range(struct gpio_chip *chip,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/hwmon/pmbus/ucd9000.c:19:0:
> >> include/linux/gpio/driver.h:591:1: error: redefinition of 'gpiochip_remove_pin_ranges'
>     gpiochip_remove_pin_ranges(struct gpio_chip *chip)
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/hwmon/pmbus/ucd9000.c:18:0:
>    include/linux/gpio.h:263:1: note: previous definition of 'gpiochip_remove_pin_ranges' was here
>     gpiochip_remove_pin_ranges(struct gpio_chip *chip)
> 
> This is caused by conflicting defines from linux/gpio.h and
> linux/gpio/driver.h. Drivers should not include both the legacy and
> the new API headers. This driver doesn't even use linux/gpio.h so
> remove it.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ucd9000.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
> index c846759bc1c0..a9229c6b0e84 100644
> --- a/drivers/hwmon/pmbus/ucd9000.c
> +++ b/drivers/hwmon/pmbus/ucd9000.c
> @@ -15,7 +15,6 @@
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/pmbus.h>
> -#include <linux/gpio.h>
>  #include <linux/gpio/driver.h>
>  #include "pmbus.h"
>  
