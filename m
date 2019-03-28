Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767BAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399C8206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ah3mYQbd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IvRyCtlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfC1Pbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:31:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1Pbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:31:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A97E615E6; Thu, 28 Mar 2019 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553787110;
        bh=ekY/aAthvQkAaPSnvEmgypuBryjqNG/WtGqPPo2knLA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ah3mYQbdcYlOaACZmXWiF/teORv+t45Dm4fVUU4mC44ARmCv8/YC+hrmXDvoAgXDh
         L7BGLw2dQ8MZ8RQLeFC9EZ5Kl+9ltYFZdiC8vli6wdqZjyCmUrDmIZ2SpYHSXP83Ip
         SdmvJCPukjfw6MK3q9WmCjrlUaLn2+R8ZyHn7ZQE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5027609CD;
        Thu, 28 Mar 2019 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553787105;
        bh=ekY/aAthvQkAaPSnvEmgypuBryjqNG/WtGqPPo2knLA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IvRyCtlv1wQ2IXH1TrHbC6kWVEn9u4EunCsg6CQONLTaCkRsV/03KV/v3GrX9rLvi
         pgeSExm5WsK+vvGLy3VIngHbdWZvTxFap4kibNk0wbegXV6rCH3urTgbNYCszuLvHR
         D+ORcanRp/Q/znOyScb/V/4pYUiDhUW0Ni+44rzo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5027609CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/3] gpio: Fix gpiochip_add_data_with_key() error path
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190328131349.18838-1-geert+renesas@glider.be>
 <20190328131349.18838-3-geert+renesas@glider.be>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c7b93076-4016-5413-dc03-0be1965bf498@codeaurora.org>
Date:   Thu, 28 Mar 2019 21:01:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328131349.18838-3-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 6:43 PM, Geert Uytterhoeven wrote:
> The err_remove_chip block is too coarse, and may perform cleanup that
> must not be done.  E.g. if of_gpiochip_add() fails, of_gpiochip_remove()
> is still called, causing:
>
>      OF: ERROR: Bad of_node_put() on /soc/gpio@e6050000
>      CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted 5.1.0-rc2-koelsch+ #407
>      Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>      Workqueue: events deferred_probe_work_func
>      [<c020ec74>] (unwind_backtrace) from [<c020ae58>] (show_stack+0x10/0x14)
>      [<c020ae58>] (show_stack) from [<c07c1224>] (dump_stack+0x7c/0x9c)
>      [<c07c1224>] (dump_stack) from [<c07c5a80>] (kobject_put+0x94/0xbc)
>      [<c07c5a80>] (kobject_put) from [<c0470420>] (gpiochip_add_data_with_key+0x8d8/0xa3c)
>      [<c0470420>] (gpiochip_add_data_with_key) from [<c0473738>] (gpio_rcar_probe+0x1d4/0x314)
>      [<c0473738>] (gpio_rcar_probe) from [<c052fca8>] (platform_drv_probe+0x48/0x94)
>
> and later, if a GPIO consumer tries to use a GPIO from a failed
> controller:
>
>      WARNING: CPU: 0 PID: 1 at lib/refcount.c:156 kobject_get+0x38/0x4c
>      refcount_t: increment on 0; use-after-free.
>      Modules linked in:
>      CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc2-koelsch+ #407
>      Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>      [<c020ec74>] (unwind_backtrace) from [<c020ae58>] (show_stack+0x10/0x14)
>      [<c020ae58>] (show_stack) from [<c07c1224>] (dump_stack+0x7c/0x9c)
>      [<c07c1224>] (dump_stack) from [<c0221580>] (__warn+0xd0/0xec)
>      [<c0221580>] (__warn) from [<c02215e0>] (warn_slowpath_fmt+0x44/0x6c)
>      [<c02215e0>] (warn_slowpath_fmt) from [<c07c58fc>] (kobject_get+0x38/0x4c)
>      [<c07c58fc>] (kobject_get) from [<c068b3ec>] (of_node_get+0x14/0x1c)
>      [<c068b3ec>] (of_node_get) from [<c0686f24>] (of_find_node_by_phandle+0xc0/0xf0)
>      [<c0686f24>] (of_find_node_by_phandle) from [<c0686fbc>] (of_phandle_iterator_next+0x68/0x154)
>      [<c0686fbc>] (of_phandle_iterator_next) from [<c0687fe4>] (__of_parse_phandle_with_args+0x40/0xd0)
>      [<c0687fe4>] (__of_parse_phandle_with_args) from [<c0688204>] (of_parse_phandle_with_args_map+0x100/0x3ac)
>      [<c0688204>] (of_parse_phandle_with_args_map) from [<c0471240>] (of_get_named_gpiod_flags+0x38/0x380)
>      [<c0471240>] (of_get_named_gpiod_flags) from [<c046f864>] (gpiod_get_from_of_node+0x24/0xd8)
>      [<c046f864>] (gpiod_get_from_of_node) from [<c0470aa4>] (devm_fwnode_get_index_gpiod_from_child+0xa0/0x144)
>      [<c0470aa4>] (devm_fwnode_get_index_gpiod_from_child) from [<c05f425c>] (gpio_keys_probe+0x418/0x7bc)
>      [<c05f425c>] (gpio_keys_probe) from [<c052fca8>] (platform_drv_probe+0x48/0x94)
>
> Fix this by splitting the cleanup block, and adding a missing call to
> gpiochip_irqchip_remove().
>
> Fixes: 28355f81969962cf ("gpio: defer probe if pinctrl cannot be found")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I'm not so sure about the need for the call to
> gpiochip_irqchip_remove(), as add/remove are not really symmetrical.
> Any comments?
> ---
>   drivers/gpio/gpiolib.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 144af07335815998..ed4da07effe0ac40 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1379,7 +1379,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>   
>   	status = gpiochip_add_irqchip(chip, lock_key, request_key);
>   	if (status)
> -		goto err_remove_chip;
> +		goto err_free_irqchip_mask;

Name is quite confusing
this should be

s/err_free_irqchip_mask/err_free_gpiochip_mask


>   
>   	status = of_gpiochip_add(chip);
>   	if (status)
> @@ -1387,7 +1387,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>   
>   	status = gpiochip_init_valid_mask(chip);
>   	if (status)
> -		goto err_remove_chip;
> +		goto err_remove_of_chip;
>   
>   	for (i = 0; i < chip->ngpio; i++) {
>   		struct gpio_desc *desc = &gdev->descs[i];
> @@ -1415,14 +1415,18 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>   	if (gpiolib_initialized) {
>   		status = gpiochip_setup_dev(gdev);
>   		if (status)
> -			goto err_remove_chip;
> +			goto err_remove_acpi_chip;
>   	}
>   	return 0;
>   
> -err_remove_chip:
> +err_remove_acpi_chip:
>   	acpi_gpiochip_remove(chip);
> +err_remove_of_chip:
>   	gpiochip_free_hogs(chip);
>   	of_gpiochip_remove(chip);
> +err_remove_chip:
> +	gpiochip_irqchip_remove(chip);
> +err_free_irqchip_mask:


same here.

After reviewing back and forth it looks good, apart from the naming.
Please fix.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


>   	gpiochip_free_valid_mask(chip);
>   err_remove_irqchip_mask:
>   	gpiochip_irqchip_free_valid_mask(chip);
