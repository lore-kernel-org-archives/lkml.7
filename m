Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A225AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DBE20883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfCVOp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:45:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42616 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfCVOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:45:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id j89so1877875edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 07:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xOo8RTKSNX1A4+gdRrirbBSbKTeTwZAM8/xzsL/i1fs=;
        b=HmLiJ6DmTMijKnWk1ruWb3rzGz5Nws/Q+uE6KoCcxLQkgtb+AdShuzr4Z+LjyJd5OG
         2vGSmgv1pApW8tNDPsmmJw8Iij0cGqAiO4l/ob4xYQVAjY5w72Hw6d/e+eilgJRRCLML
         tdCZksaYi6+10MR+W0go2mMO8VMSDhUpAfql2XLbhUGfn594HPQsRNY74pM4AwHA7lQX
         St5/TNixzxRf10FxmyXSBwenKfBt5QHYWg6n8k/Ah8LJYKILr+Gym6kxbdmDDg7iGTzG
         RZzmLhWCf/E9PMpC+2wvuHbLoGsAMwBnlEyWtmiSrUAzBKNeb77jeeZ0BYg2Xt7uX/s9
         YxVQ==
X-Gm-Message-State: APjAAAWXbaiCCfzZ05t6byg361a5RmZgsx+643d0FkIIpzf09/Oidy1P
        2Sx6/PV/GsZ5Iix01EZ5Hu8hHw==
X-Google-Smtp-Source: APXvYqywtMXdB5A5HTtoObm2C6+7JEm8MqXls7GOd5eZO3UfYnali5/HAnxFS8nSCjqpIDz+kMcWkQ==
X-Received: by 2002:a50:f4d8:: with SMTP id v24mr6940300edm.13.1553265926230;
        Fri, 22 Mar 2019 07:45:26 -0700 (PDT)
Received: from dhcp-44-202.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id h34sm2728046edb.13.2019.03.22.07.45.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 07:45:25 -0700 (PDT)
Subject: Re: [PATCH] Skip deferred request irqs for devices known to fail
To:     Ian W MORRISON <ianwmorrison@gmail.com>,
        benjamin.tissoires@redhat.com, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190322110515.21499-1-ianwmorrison@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b5a7b895-e08d-f432-8606-4d8c776d4a8a@redhat.com>
Date:   Fri, 22 Mar 2019 15:45:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322110515.21499-1-ianwmorrison@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/22/19 12:05 PM, Ian W MORRISON wrote:
> Patch ca876c7483b6 "gpiolib-acpi: make sure we trigger edge events at
> least once on boot" causes the MINIX family of mini PCs to fail to boot
> resulting in a "black screen".
> 
> This patch excludes MINIX devices from executing this trigger in order
> to successfully boot.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>

IMHO we need to root-cause this problem a bit more before applying this
kludge.

Can you provide an ACPI dump of one of the affected machines ?

Regards,

Hans



> ---
>   drivers/gpio/gpiolib-acpi.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 259cf6ab969b..8d855dc9b020 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -16,9 +16,21 @@
>   #include <linux/interrupt.h>
>   #include <linux/mutex.h>
>   #include <linux/pinctrl/pinctrl.h>
> +#include <linux/dmi.h>
>   
>   #include "gpiolib.h"
>   
> +static const struct dmi_system_id skip_deferred_request_irqs_table[] = {
> +	{
> +		.ident = "MINIX Z83-4",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
> +		},
> +	},
> +	{}
> +};
> +
>   /**
>    * struct acpi_gpio_event - ACPI GPIO event handler data
>    *
> @@ -1219,18 +1231,24 @@ bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
>   }
>   
>   /* Run deferred acpi_gpiochip_request_irqs() */
> +/* but exclude devices known to fail */
>   static int acpi_gpio_handle_deferred_request_irqs(void)
>   {
>   	struct acpi_gpio_chip *acpi_gpio, *tmp;
> +	const struct dmi_system_id *dmi_id;
>   
> -	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
> -	list_for_each_entry_safe(acpi_gpio, tmp,
> +	dmi_id = dmi_first_match(skip_deferred_request_irqs_table);
> +
> +	if (! dmi_id) {
> +		mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
> +		list_for_each_entry_safe(acpi_gpio, tmp,
>   				 &acpi_gpio_deferred_req_irqs_list,
>   				 deferred_req_irqs_list_entry)
> -		acpi_gpiochip_request_irqs(acpi_gpio);
> +			acpi_gpiochip_request_irqs(acpi_gpio);
>   
> -	acpi_gpio_deferred_req_irqs_done = true;
> -	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
> +		acpi_gpio_deferred_req_irqs_done = true;
> +		mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
> +	}
>   
>   	return 0;
>   }
> 
