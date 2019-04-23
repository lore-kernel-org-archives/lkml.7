Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PqnS01Ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfDWN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:28:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61972 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfDWN2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:28:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44pPQZ3fBBz9v083;
        Tue, 23 Apr 2019 15:28:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PqnS01Ri; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id W8mHEisNH4V8; Tue, 23 Apr 2019 15:28:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44pPQZ2Scnz9v07b;
        Tue, 23 Apr 2019 15:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556026086; bh=Ez5mm6PUM5Ypfk0XAkoOaZApQ4Vwg8mS5qSiVgOCC1c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PqnS01RiGIWVynuSYd8Xp6pjQtSMPC46ftQ3a3WkAAOsNNKSdE8VbRoMqIekLZOhx
         IEfIMi7knhwrdAjupdYpE1Kfm182fNgHzRsDnQBoYWt3hf57U7atXaDWWZMdzxboVn
         oKB+GLwCREiqDQx3GekM1Jb/Hs9fY4GXQLY0Fcyo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B58048B8DD;
        Tue, 23 Apr 2019 15:28:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VjckJo6gfVqE; Tue, 23 Apr 2019 15:28:07 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 328778B8C4;
        Tue, 23 Apr 2019 15:28:07 +0200 (CEST)
Subject: Re: [PATCH 21/22] watchdog: mpc8xxx_wdt: Convert to use device
 managed functions and other improvements
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
 <1554913683-25454-22-git-send-email-linux@roeck-us.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3631a90f-7c77-d2c2-ef68-01f9daf40ae6@c-s.fr>
Date:   Tue, 23 Apr 2019 15:28:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554913683-25454-22-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/04/2019 à 18:28, Guenter Roeck a écrit :
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
> - Drop empty remove function
>    This also drops the inaccurate message on remove; the driver won't be
>    removed if the hardware watchdog is running, no matter if the watchdog
>    device is open or not.
> - Use local variable 'struct device *dev' consistently
> - Use devm_watchdog_register_driver() to register watchdog device
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   drivers/watchdog/mpc8xxx_wdt.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 3b5b446b690c..9b6d6a5a27ad 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -204,9 +204,10 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>   	if (ddata->wdd.timeout < ddata->wdd.min_timeout)
>   		ddata->wdd.timeout = ddata->wdd.min_timeout;
>   
> -	ret = watchdog_register_device(&ddata->wdd);
> +	ret = devm_watchdog_register_device(dev, &ddata->wdd);
>   	if (ret) {
> -		dev_err(dev, "cannot register watchdog device (err=%d)\n", ret);
> +		dev_err(dev, "cannot register watchdog device (err=%d)\n",
> +			ret);
>   		return ret;
>   	}
>   
> @@ -218,17 +219,6 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>   	return 0;
>   }
>   
> -static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
> -{
> -	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
> -
> -	dev_crit(&ofdev->dev, "Watchdog removed, expect the %s soon!\n",
> -		 reset ? "reset" : "machine check exception");
> -	watchdog_unregister_device(&ddata->wdd);
> -
> -	return 0;
> -}
> -
>   static const struct of_device_id mpc8xxx_wdt_match[] = {
>   	{
>   		.compatible = "mpc83xx_wdt",
> @@ -259,7 +249,6 @@ MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
>   
>   static struct platform_driver mpc8xxx_wdt_driver = {
>   	.probe		= mpc8xxx_wdt_probe,
> -	.remove		= mpc8xxx_wdt_remove,
>   	.driver = {
>   		.name = "mpc8xxx_wdt",
>   		.of_match_table = mpc8xxx_wdt_match,
> 
