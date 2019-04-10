Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7332C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B4A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfDJLUk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:20:40 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:35072 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbfDJLUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:20:40 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 8F29417C68; Wed, 10 Apr 2019 12:20:38 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH 23/23] watchdog: tangox_wdt: Convert to use device managed functions and other improvements
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
        <1554830641-9247-24-git-send-email-linux@roeck-us.net>
Date:   Wed, 10 Apr 2019 12:20:38 +0100
In-Reply-To: <1554830641-9247-24-git-send-email-linux@roeck-us.net> (Guenter
        Roeck's message of "Tue, 9 Apr 2019 10:24:01 -0700")
Message-ID: <yw1xftqqxg1l.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Drop assignments to otherwise unused variables
> - Drop unnecessary braces around conditional return statements
> - Drop empty remove function
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Replace stop on remove with call to watchdog_stop_on_unregister()
> - Use devm_watchdog_register_driver() to register watchdog device
>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/tangox_wdt.c | 37 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)

Acked-by: Mans Rullgard <mans@mansr.com>

> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
> index 16611fe0d9d1..1afb0e9d808c 100644
> --- a/drivers/watchdog/tangox_wdt.c
> +++ b/drivers/watchdog/tangox_wdt.c
> @@ -108,6 +108,11 @@ static const struct watchdog_ops tangox_wdt_ops = {
>  	.restart	= tangox_wdt_restart,
>  };
>
> +static void tangox_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
>  static int tangox_wdt_probe(struct platform_device *pdev)
>  {
>  	struct tangox_wdt_device *dev;
> @@ -129,12 +134,14 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>  	err = clk_prepare_enable(dev->clk);
>  	if (err)
>  		return err;
> +	err = devm_add_action_or_reset(&pdev->dev,
> +				       tangox_clk_disable_unprepare, dev->clk);
> +	if (err)
> +		return err;
>
>  	dev->clk_rate = clk_get_rate(dev->clk);
> -	if (!dev->clk_rate) {
> -		err = -EINVAL;
> -		goto err;
> -	}
> +	if (!dev->clk_rate)
> +		return -EINVAL;
>
>  	dev->wdt.parent = &pdev->dev;
>  	dev->wdt.info = &tangox_wdt_info;
> @@ -168,31 +175,16 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>
>  	watchdog_set_restart_priority(&dev->wdt, 128);
>
> -	err = watchdog_register_device(&dev->wdt);
> +	watchdog_stop_on_unregister(&dev->wdt);
> +	err = devm_watchdog_register_device(&pdev->dev, &dev->wdt);
>  	if (err)
> -		goto err;
> +		return err;
>
>  	platform_set_drvdata(pdev, dev);
>
>  	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
>
>  	return 0;
> -
> - err:
> -	clk_disable_unprepare(dev->clk);
> -	return err;
> -}
> -
> -static int tangox_wdt_remove(struct platform_device *pdev)
> -{
> -	struct tangox_wdt_device *dev = platform_get_drvdata(pdev);
> -
> -	tangox_wdt_stop(&dev->wdt);
> -	clk_disable_unprepare(dev->clk);
> -
> -	watchdog_unregister_device(&dev->wdt);
> -
> -	return 0;
>  }
>
>  static const struct of_device_id tangox_wdt_dt_ids[] = {
> @@ -204,7 +196,6 @@ MODULE_DEVICE_TABLE(of, tangox_wdt_dt_ids);
>
>  static struct platform_driver tangox_wdt_driver = {
>  	.probe	= tangox_wdt_probe,
> -	.remove	= tangox_wdt_remove,
>  	.driver	= {
>  		.name		= "tangox-wdt",
>  		.of_match_table	= tangox_wdt_dt_ids,
> -- 
> 2.7.4
>

-- 
Måns Rullgård
