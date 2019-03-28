Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B218C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0799B2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mqzjSW6T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q7QFWRUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfC1PhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:37:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1PhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:37:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5AB3B6083E; Thu, 28 Mar 2019 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553787442;
        bh=9OSZ7fzfG3d01D+l5MXs6Upgx4v+kNfAM8E5DKDzZ+M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mqzjSW6Tz6eimweMkI7FN3nJ+68pweV6q7wCnLyp8Y2yQ2zpzSMafqeIhc5eyQnh5
         m8sqbeNf/Qz+PuoFO7BpRpuqZBntutl0VKwSpHHWnj+0W2IxaGIyrVImCzwDgelST2
         WaGta0i9I3z6+Z3UmNptQSKcDjO86YjtOZIAJgIE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E37936083E;
        Thu, 28 Mar 2019 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553787440;
        bh=9OSZ7fzfG3d01D+l5MXs6Upgx4v+kNfAM8E5DKDzZ+M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q7QFWRUqB3YGTXYOgGA1JwdrgoQEaSJvgOim3yo7deQRPAshfkIp0A3aYYHG/QiyV
         9pmzMZXNLIm/Nq4h9nmyMyp3poYgDWii3uEuxu5K81hDJ10tMZR73MR1xpCM8c/bGK
         OKDFOE2SvHypCCXd0cMGxZtLuxa+GD3futmZ/zeU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E37936083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 1/3] gpio: of: Fix of_gpiochip_add() error path
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190328131349.18838-1-geert+renesas@glider.be>
 <20190328131349.18838-2-geert+renesas@glider.be>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <144289c1-4051-5a2f-3e8d-f1d5a44661c3@codeaurora.org>
Date:   Thu, 28 Mar 2019 21:07:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328131349.18838-2-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 6:43 PM, Geert Uytterhoeven wrote:
> If the call to of_gpiochip_scan_gpios() in of_gpiochip_add() fails, no
> error handling is performed.  This lead to the need of callers to call
> of_gpiochip_remove() on failure, which causes "BAD of_node_put() on ..."
> if the failure happened before the call to of_node_get().
>
> Fix this by adding proper error handling.
>
> Note that calling gpiochip_remove_pin_ranges() multiple times causes no
> harm: subsequent calls are a no-op.
>
> Fixes: dfbd379ba9b7431e ("gpio: of: Return error if gpio hog configuration failed")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/gpio/gpiolib-of.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 8b9c3ab70f6eade4..257be7bac032a855 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -717,7 +717,13 @@ int of_gpiochip_add(struct gpio_chip *chip)
>   
>   	of_node_get(chip->of_node);
>   
> -	return of_gpiochip_scan_gpios(chip);
> +	status = of_gpiochip_scan_gpios(chip);
> +	if (status) {
> +		of_node_put(chip->of_node);
> +		gpiochip_remove_pin_ranges(chip);
> +	}
> +
> +	return status;
>   }
>   
>   void of_gpiochip_remove(struct gpio_chip *chip)
