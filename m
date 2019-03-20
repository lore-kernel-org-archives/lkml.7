Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82F4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CDA2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZbau5Ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfCTNj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:39:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38705 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfCTNj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:39:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so1968527pfo.5;
        Wed, 20 Mar 2019 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gvgShFxsyvxopfW49fzDitWCVQBux7QaA5Ll71IJ6qA=;
        b=dZbau5Oxi355K+hwCRGCL+KKd1xQzGiZaAXojHv5JexnL1acBoF1xXVL4CguqLI8aN
         WtambbK/qskl5/ZlNt7Ry6WqcFVLspKRvsXcf7WauC52e5q/3xu3lfo0axffyuvlYeRE
         5kxuPjgyC+z8krT37URCjOk999OROhszjAx98BXsKxwX6g645MOJFw41Q6D4/w8tyFL8
         FhAjWPHpGTUenYtoJw9AKuLrXZMrhRDgLGCHKemwt/6J1fZR1s7+tMTKFMLcnPaefUEz
         XSlfFN4aOUDzaxVL7JNqNj6BfPdnXD9W4OjFapuVqwUO5GYstIKE3cwSkQDxplwsMenc
         Ni2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gvgShFxsyvxopfW49fzDitWCVQBux7QaA5Ll71IJ6qA=;
        b=rZHZOADKCjj9WAdruHjStOjlS3ezcZpFQvCNwaBa6z1f6daF55x0XY5Das1XVzzbON
         HRxpJtKPjhLxPvxTyhXI2f7ZZHnUZbNNlZObK0zj5ygAKGu3Ak/1wD+ZUrJYGtIpzfKx
         OB4P4HRvk3yNgXbx2Cfbh0X3plHfCNFQU5ZAkA75G4q/fwjEb2XUZdoHCx3IqLHUA4D0
         PKBNiLQ1q2NGgKCfkOsQDzN75j4sH6ENcRBqGu/sGl6lLsb2OHXR4EYTZ0XHDqhN2EQN
         WY4tvBgCzWggzhvfyakIc7tywUGvj3W+ZyvNri9wgSl1lV0Wlo5LoPoUEO3pJahuVgB/
         WUTQ==
X-Gm-Message-State: APjAAAWro6y75x6YvSmV1e+wA4SRQB2irPywT+108hCCWwY2xpD54CXS
        kxhzhIg6QpU8M4yTISPqYCnqRoSF
X-Google-Smtp-Source: APXvYqwRXHBMgD5V5EFDtbXwswQr/tl0gn/TmIsuk2HAa3shQSY+YYCwSwrcQ9NoRNO8DoWHyJeUfQ==
X-Received: by 2002:a63:f556:: with SMTP id e22mr7910685pgk.321.1553089166946;
        Wed, 20 Mar 2019 06:39:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k72sm6183098pfb.122.2019.03.20.06.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 06:39:26 -0700 (PDT)
Date:   Wed, 20 Mar 2019 06:39:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] drivers: watchdog: Kconfig: pedantic formatting
Message-ID: <20190320133925.GA8106@roeck-us.net>
References: <8a1297c7-f1f2-5742-0ef6-f83799510735@roeck-us.net>
 <1551909125-20305-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551909125-20305-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:52:05PM +0100, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so just
> take damp cloth and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Having said that, I would really discourage this kind of cleanup,
and I was quite close to NACKing it. It doesn't fix a single checkpatch
issue in the affected Kconfig file, and that file currently reports 42
checkpatch warnings. Those would be more important issues to fix than
vertical help text alignments.

I won't apply this patch to my branch, and will leave it up to Wim to decide
what to do with it.

Guenter

> ---
>  drivers/watchdog/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 57f017d..38509d5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -279,10 +279,10 @@ config ARMADA_37XX_WATCHDOG
>  	select MFD_SYSCON
>  	select WATCHDOG_CORE
>  	help
> -	   Say Y here to include support for the watchdog timer found on
> -	   Marvell Armada 37xx SoCs.
> -	   To compile this driver as a module, choose M here: the
> -	   module will be called armada_37xx_wdt.
> +	  Say Y here to include support for the watchdog timer found on
> +	  Marvell Armada 37xx SoCs.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called armada_37xx_wdt.
>  
>  config ASM9260_WATCHDOG
>  	tristate "Alphascale ASM9260 watchdog"
> @@ -606,10 +606,10 @@ config MAX77620_WATCHDOG
>  	tristate "Maxim Max77620 Watchdog Timer"
>  	depends on MFD_MAX77620 || COMPILE_TEST
>  	help
> -	 This is the driver for the Max77620 watchdog timer.
> -	 Say 'Y' here to enable the watchdog timer support for
> -	 MAX77620 chips. To compile this driver as a module,
> -	 choose M here: the module will be called max77620_wdt.
> +	  This is the driver for the Max77620 watchdog timer.
> +	  Say 'Y' here to enable the watchdog timer support for
> +	  MAX77620 chips. To compile this driver as a module,
> +	  choose M here: the module will be called max77620_wdt.
>  
>  config IMX2_WDT
>  	tristate "IMX2+ Watchdog"
> @@ -1632,10 +1632,10 @@ config BCM7038_WDT
>  	depends on HAS_IOMEM
>  	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>  	help
> -	 Watchdog driver for the built-in hardware in Broadcom 7038 and
> -	 later SoCs used in set-top boxes.  BCM7038 was made public
> -	 during the 2004 CES, and since then, many Broadcom chips use this
> -	 watchdog block, including some cable modem chips.
> +	  Watchdog driver for the built-in hardware in Broadcom 7038 and
> +	  later SoCs used in set-top boxes.  BCM7038 was made public
> +	  during the 2004 CES, and since then, many Broadcom chips use this
> +	  watchdog block, including some cable modem chips.
>  
>  config IMGPDC_WDT
>  	tristate "Imagination Technologies PDC Watchdog Timer"
