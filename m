Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3114C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FA620851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCHU0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:26:48 -0500
Received: from mleia.com ([178.79.152.223]:37814 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfCHU0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:26:46 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 1E225457450;
        Fri,  8 Mar 2019 20:26:45 +0000 (GMT)
Subject: Re: [PATCH serial] sc16is7xx: missing unregister/delete driver on
 error in sc16is7xx_init()
To:     Mao Wenan <maowenan@huawei.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190308140933.55262-1-maowenan@huawei.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <d2888b44-2475-ebe1-bbc7-844147e9d11a@mleia.com>
Date:   Fri, 8 Mar 2019 22:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190308140933.55262-1-maowenan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190308_202645_145327_089369F5 
X-CRM114-Status: GOOD (  13.54  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2019 04:09 PM, Mao Wenan wrote:
> Add the missing uart_unregister_driver() and i2c_del_driver() before return
> from sc16is7xx_init() in the error handling case.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 268098681856..114e94f476c6 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1509,7 +1509,7 @@ static int __init sc16is7xx_init(void)
>  	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
>  	if (ret < 0) {
>  		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
> -		return ret;
> +		goto err_i2c;
>  	}
>  #endif
>  
> @@ -1517,10 +1517,18 @@ static int __init sc16is7xx_init(void)
>  	ret = spi_register_driver(&sc16is7xx_spi_uart_driver);
>  	if (ret < 0) {
>  		pr_err("failed to init sc16is7xx spi --> %d\n", ret);
> -		return ret;
> +		goto err_spi;
>  	}
>  #endif
>  	return ret;
> +
> +err_spi:
> +#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
> +	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
> +#endif
> +err_i2c:
> +	uart_unregister_driver(&sc16is7xx_uart);
> +	return ret;
>  }
>  module_init(sc16is7xx_init);
>  
> 

Nice catch, thank you!

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
