Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89709C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E8F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt9wS9MG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfCFQFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:05:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35836 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCFQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:05:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so8771738pgd.2;
        Wed, 06 Mar 2019 08:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V0XKKRvlkjY8iv3557p4UkcOTCqjFcfgjbKI194klvo=;
        b=gt9wS9MG0Qt8lbVWmyE460QYpCU+INmUEcpxu8Iko9WiksWsLN+kBWE9ga8QDX7PaI
         R6DRNCgtKPB/2OTig2QS9/sXEDN3PpTWGcHk2nLQjaX9KIvo4MGxb3BrNaSafBXiBlZg
         cEZJRQA5Ny5uc02cdtr6visVRBy/lVBoGmz08ZwDajzU7mhq/746Zy8858jdPIgEAiV8
         7BTAORv+aGh5vIiJ7MDY5Ck7txseAcj0XAN8/Om3FXe2418cPPSluwuEeNELir+KXz33
         KTXyxtfQkrEKLTawJCi/LBawAiDDVOE79cu/n7Mm2GDDhe4uUc1iTJ4TiPgvtptzSnDS
         aLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0XKKRvlkjY8iv3557p4UkcOTCqjFcfgjbKI194klvo=;
        b=ioMlSSplccGB8J52BZm1QFquy8SMqaGueL+eZ1HmRkY3pT8hKG4NXFeOZFN9/HMwzQ
         nz90xUzW8MSe0JKUIbpKy1pHGv1g7+cZfNuuiVIp+i5cfEcB2x6OM6lEsh/P+squY1Cd
         OfuxokFSxFYa7XSb7rH1MqeU+h0IeMovhojxoW++NNy6GuxOGQaYIVP9ZbAEztdByFXF
         A3u0uxfv5u3qKyYIQuDdKA3/8C+IaCsbuia5+wnKnpV5D+NdsAAzEsd+Rn8VggQyob0j
         gZ7xkNDO9OlBFBHGF/DMRf4fi3wT8qujJLFvDbZI0cvU1OySXbl2p6QAUfdfnAjtr9+Y
         eSgw==
X-Gm-Message-State: APjAAAW2B1/LMdH1WDxloat9h0zc4oYkvBFr56/05cJWbruCzcLAfjCZ
        6Rguwg/Ro9RcvkRJwDIguCQ=
X-Google-Smtp-Source: APXvYqyGDcVeqhTwOdL/SFc9N0mD13JgPjlVFbC6OCt8f8P6jsWWii6DmXlABNQDtY3CLVT/NKFZ8Q==
X-Received: by 2002:a63:ee05:: with SMTP id e5mr6381629pgi.83.1551888335435;
        Wed, 06 Mar 2019 08:05:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t23sm6356316pfa.111.2019.03.06.08.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:05:34 -0800 (PST)
Subject: Re: [PATCH V7 3/3] firmware: imx: imx-scu: register build-in child
 devices
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
 <1551834095-19950-3-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <90ff94d9-6f15-5353-c5a1-f2ec5ee744ad@roeck-us.net>
Date:   Wed, 6 Mar 2019 08:05:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551834095-19950-3-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/5/19 5:06 PM, Anson Huang wrote:
> For some devices which are controlled by system controller,
> they are NOT present in device tree since no hardware info
> needed, just register these devices as children of SCU device.
> This patch registers i.MX system controller watchdog platform
> device as child device of SCU.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>   drivers/firmware/imx/imx-scu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 2bb1a19..df75ead 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -196,6 +196,7 @@ EXPORT_SYMBOL(imx_scu_call_rpc);
>   
>   static int imx_scu_probe(struct platform_device *pdev)
>   {
> +	struct platform_device *child_pdev;
>   	struct device *dev = &pdev->dev;
>   	struct imx_sc_ipc *sc_ipc;
>   	struct imx_sc_chan *sc_chan;
> @@ -248,6 +249,13 @@ static int imx_scu_probe(struct platform_device *pdev)
>   
>   	dev_info(dev, "NXP i.MX SCU Initialized\n");
>   
> +	/* register SCU child devices which are NOT in device tree */
> +	child_pdev = platform_device_register_data(dev, "imx-sc-wdt",
> +				PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(child_pdev))
> +		dev_warn(dev, "failed to register scu watchdog device %ld!\n",
> +			 PTR_ERR(child_pdev));
> +

I just realized ... since this is not a devm_ function, we now also need
error handling (if devm_of_platform_populate() fails) and a remove function.
Sorry for that - I should have noticed earlier.

Guenter

>   	return devm_of_platform_populate(dev);
>   }
>   
> 

