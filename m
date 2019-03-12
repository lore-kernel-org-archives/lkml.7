Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACED214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfCLJR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:17:56 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:58619 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfCLJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:17:55 -0400
Received: from [78.40.148.180] (helo=[0.0.0.0])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h3dXi-0001gc-7k; Tue, 12 Mar 2019 09:17:50 +0000
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        thierry.reding@gmail.com, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr,
        yamada.masahiro@socionext.com, jun.nie@linaro.org,
        shawnguo@kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-16-git-send-email-info@metux.net>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
Date:   Tue, 12 Mar 2019 09:17:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1552330521-4276-16-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2019 18:54, Enrico Weigelt, metux IT consult wrote:
> don't need the temporary variable "dev", directly use &pdev->dev
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

This is quite usual to do, and I like it as it saves typing.
Personally I would say don't bother with this change.

> ---
>   drivers/gpio/gpio-janz-ttl.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-janz-ttl.c b/drivers/gpio/gpio-janz-ttl.c
> index b97a911..91f91f6 100644
> --- a/drivers/gpio/gpio-janz-ttl.c
> +++ b/drivers/gpio/gpio-janz-ttl.c
> @@ -144,18 +144,17 @@ static void ttl_setup_device(struct ttl_module *mod)
>   static int ttl_probe(struct platform_device *pdev)
>   {
>   	struct janz_platform_data *pdata;
> -	struct device *dev = &pdev->dev;
>   	struct ttl_module *mod;
>   	struct gpio_chip *gpio;
>   	int ret;
>   
>   	pdata = dev_get_platdata(&pdev->dev);
>   	if (!pdata) {
> -		dev_err(dev, "no platform data\n");
> +		dev_err(&pdev->dev, "no platform data\n");
>   		return -ENXIO;
>   	}
>   
> -	mod = devm_kzalloc(dev, sizeof(*mod), GFP_KERNEL);
> +	mod = devm_kzalloc(&pdev->dev, sizeof(*mod), GFP_KERNEL);
>   	if (!mod)
>   		return -ENOMEM;
>   
> @@ -181,9 +180,9 @@ static int ttl_probe(struct platform_device *pdev)
>   	gpio->base = -1;
>   	gpio->ngpio = 20;
>   
> -	ret = devm_gpiochip_add_data(dev, gpio, NULL);
> +	ret = devm_gpiochip_add_data(&pdev->dev, gpio, NULL);
>   	if (ret) {
> -		dev_err(dev, "unable to add GPIO chip\n");
> +		dev_err(&pdev->dev, "unable to add GPIO chip\n");
>   		return ret;
>   	}
>   
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
