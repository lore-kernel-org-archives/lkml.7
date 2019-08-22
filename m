Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5070BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA49233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391980AbfHVTlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:41:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37782 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731942AbfHVTlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:41:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C0F0428D4C2
Subject: Re: [PATCH] platform: chrome: chromeos_laptop: drop checks of
 NULL-safe functions
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org
References: <20190820153449.7866-1-wsa+renesas@sang-engineering.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b6612ae3-9d6f-baf7-98db-f3d26f4a5108@collabora.com>
Date:   Thu, 22 Aug 2019 21:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820153449.7866-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/8/19 17:34, Wolfram Sang wrote:
> No need to check the argument of i2c_unregister_device() and
> property_entries_free() because the functions do check it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for chrome-platform-5.4

Thanks,
 Enric

> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 
>  drivers/platform/chrome/chromeos_laptop.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
> index 7abbb6167766..8723bcf10c93 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -838,18 +838,14 @@ static void chromeos_laptop_destroy(const struct chromeos_laptop *cros_laptop)
>  		i2c_dev = &cros_laptop->i2c_peripherals[i];
>  		info = &i2c_dev->board_info;
>  
> -		if (i2c_dev->client)
> -			i2c_unregister_device(i2c_dev->client);
> -
> -		if (info->properties)
> -			property_entries_free(info->properties);
> +		i2c_unregister_device(i2c_dev->client);
> +		property_entries_free(info->properties);
>  	}
>  
>  	for (i = 0; i < cros_laptop->num_acpi_peripherals; i++) {
>  		acpi_dev = &cros_laptop->acpi_peripherals[i];
>  
> -		if (acpi_dev->properties)
> -			property_entries_free(acpi_dev->properties);
> +		property_entries_free(acpi_dev->properties);
>  	}
>  
>  	kfree(cros_laptop->i2c_peripherals);
> 
