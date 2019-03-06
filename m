Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D41DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1EF20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBnr/hHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfCFQPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:15:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34683 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCFQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:15:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so8987374pfn.1;
        Wed, 06 Mar 2019 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hftjxlzHQuDZAC7EoQ4seygcnqDzV3vTUkyqN4y/l1U=;
        b=IBnr/hHJYwumTM5vlWv9N4GsMaLmJCp1UIp7eCa2nehoArERnzj5rv7fBHNFbS2R5d
         WRyWNNCRqV9/sNEleOlOCHLUvOQT5O8yQ89QA0Oizgh2zst28lsDX7Rv+2VC550mzmA1
         S9kE1bnOFQVVJFV2mCU2YaQGEV9JafGuXHbxJKSauVcjy9R86yjSTFGJTcuQ1CKQCnyx
         A7QacctpbUmfdXGEyuycKg2onLyjaPJnjehIRo5/3fytry/Yd+3gCqMqf6QujLEeTKBq
         9FMBFKu9rfqcGZ8kfSHCjAv+6jA1T3RvqI2VRySR+g2epHi3910iJEe+h5kMb8gc0MiG
         Lm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hftjxlzHQuDZAC7EoQ4seygcnqDzV3vTUkyqN4y/l1U=;
        b=YxuxsmJgY2/zywNB1O4Gie1G+X7qsrdfxKsTAc89bpNDicxRX9oPyN+l5GlkArWpf0
         WFMd8QVcnffVWMIY8N6KoK0of3RyKCUuiAmJeqqY4fKISUZn2NEcE36LJi2bsP20YS2M
         oafBD+CFcjrDOP9O1trkXb7Qnp0OZ2o29HZnH3BteKeI4728bTBXw45YTIKPsAZOrwhE
         Kreph0LxZJSQUNdqfPbbRyYFBmAoG5QbSDhu6szDrvM79jDaJtnIf9HFe4DgKnI6RUFz
         BKVW8y70wuEA/R6PeL6NhavIvIYciWQeSH0we+NTtC7V1dO2YrRDNKNIYggUG+2Amo07
         BS1g==
X-Gm-Message-State: APjAAAUbArjA5zcI00lFJzhFq77oSnNaDtf5Bj2E86ICDFneZ4fa+tAv
        QuMbmWMGSiWTxFZncr/9ufzQt/Q3
X-Google-Smtp-Source: APXvYqyEwl9EshbJayRBfmHRNXuwFsLIanMFDNtFE0dcdVdpgDRNANB2QIuRXMRh1AS37/lmHH35Xw==
X-Received: by 2002:a62:1752:: with SMTP id 79mr7885212pfx.127.1551888923309;
        Wed, 06 Mar 2019 08:15:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1sm2587678pgv.30.2019.03.06.08.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:15:17 -0800 (PST)
Subject: Re: [PATCH] drivers: watchdog: Kconfig: pedantic cleanups
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
References: <1551885336-22650-1-git-send-email-info@metux.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8a1297c7-f1f2-5742-0ef6-f83799510735@roeck-us.net>
Date:   Wed, 6 Mar 2019 08:15:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551885336-22650-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 7:15 AM, Enrico Weigelt, metux IT consult wrote:
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>


Checkpatch says:

WARNING: Missing commit description - Add an appropriate one

There needs to be some kind of description of those pedantic cleanups.

On top of that, while the affected Kconfig file generates 42 checkpatch
warnings, this patch doesn't fix a single one of them. I don't really
see the point of this patch.

Thanks,
Guenter

> ---
>   drivers/watchdog/Kconfig | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 57f017d..38509d5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -279,10 +279,10 @@ config ARMADA_37XX_WATCHDOG
>   	select MFD_SYSCON
>   	select WATCHDOG_CORE
>   	help
> -	   Say Y here to include support for the watchdog timer found on
> -	   Marvell Armada 37xx SoCs.
> -	   To compile this driver as a module, choose M here: the
> -	   module will be called armada_37xx_wdt.
> +	  Say Y here to include support for the watchdog timer found on
> +	  Marvell Armada 37xx SoCs.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called armada_37xx_wdt.
>   
>   config ASM9260_WATCHDOG
>   	tristate "Alphascale ASM9260 watchdog"
> @@ -606,10 +606,10 @@ config MAX77620_WATCHDOG
>   	tristate "Maxim Max77620 Watchdog Timer"
>   	depends on MFD_MAX77620 || COMPILE_TEST
>   	help
> -	 This is the driver for the Max77620 watchdog timer.
> -	 Say 'Y' here to enable the watchdog timer support for
> -	 MAX77620 chips. To compile this driver as a module,
> -	 choose M here: the module will be called max77620_wdt.
> +	  This is the driver for the Max77620 watchdog timer.
> +	  Say 'Y' here to enable the watchdog timer support for
> +	  MAX77620 chips. To compile this driver as a module,
> +	  choose M here: the module will be called max77620_wdt.
>   
>   config IMX2_WDT
>   	tristate "IMX2+ Watchdog"
> @@ -1632,10 +1632,10 @@ config BCM7038_WDT
>   	depends on HAS_IOMEM
>   	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>   	help
> -	 Watchdog driver for the built-in hardware in Broadcom 7038 and
> -	 later SoCs used in set-top boxes.  BCM7038 was made public
> -	 during the 2004 CES, and since then, many Broadcom chips use this
> -	 watchdog block, including some cable modem chips.
> +	  Watchdog driver for the built-in hardware in Broadcom 7038 and
> +	  later SoCs used in set-top boxes.  BCM7038 was made public
> +	  during the 2004 CES, and since then, many Broadcom chips use this
> +	  watchdog block, including some cable modem chips.
>   
>   config IMGPDC_WDT
>   	tristate "Imagination Technologies PDC Watchdog Timer"
> 

