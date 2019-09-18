Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C4C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F18C218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I0HjyZYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfIRQht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:37:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47072 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387640AbfIRQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:37:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so181993plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J1GkKLG6lvp/GtC0MAMhWfOb994e64EiCwfOJPxf8RM=;
        b=I0HjyZYmt7lgF05P8+nOoOIyNjRfcLWECZitfwk5PAP2klJk3jejiBnRCUDDt09hJg
         BH+gAJQa+UeOpN53giu+MThtAinc39ChY9NOwhYQAA34u97TKZnaYLUxjjJJq5i8/oee
         85iANBtFodXnXr5Fv6FzHWHQkSHdrOux63uLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J1GkKLG6lvp/GtC0MAMhWfOb994e64EiCwfOJPxf8RM=;
        b=popMsZp/1Zu9QHooDbTCLMh7w8q1ckHs62gPZVa9L50O0zFKG+hnEuWzgiotr79Apf
         aOrKCVuOXQ/LHDNcDAGVzVG2FLzjk3hTTregd2dPZ1HMvscB5qObNxo4g/lc02NC7k+S
         Q3w95aMyBPudaovc1g/4wWhzuzcom7MHRExG9pPfM9i6QOHNZy42JQKiCAxaXyyEmeom
         xUIgnpdp2QtvpgtMkb9OEci+TMSCu0wpeW564x9TKVEJDNqBDK+/Ir1KB4FkPa1tDkGL
         /HLF6RsW/UfPLY2cqKhYn01Ze72TuPo1ins2taV3yQbDiu3lygMb6d+WDGCBphu8aIg4
         JJ+Q==
X-Gm-Message-State: APjAAAWwNna+HOMGo/N6YTi2F53ptDmERRHBkTDGrn2ZcMeu+/OF4C+W
        zZY+HLwQbvM6+ru93EczLMGz+g==
X-Google-Smtp-Source: APXvYqznLi1akMyvUhQjFSDE6RFyBEIeeFSwv7tfyPa8JsRx7uUSxWx9D9JPEV56WoHDBaJwAZ3Bvw==
X-Received: by 2002:a17:902:7489:: with SMTP id h9mr1598620pll.166.1568824668412;
        Wed, 18 Sep 2019 09:37:48 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g12sm5367137pgb.26.2019.09.18.09.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:37:47 -0700 (PDT)
Subject: Re: [PATCH] hwrng: iproc-rng200 - Use
 devm_platform_ioremap_resource() in iproc_rng200_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <0ecb0679-0558-6cbe-af2f-6ee9122a4a7e@web.de>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <667911b3-602e-e5a9-5e83-bd8c17625bb7@broadcom.com>
Date:   Wed, 18 Sep 2019 09:37:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0ecb0679-0558-6cbe-af2f-6ee9122a4a7e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/19 12:19 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 09:09:22 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/char/hw_random/iproc-rng200.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
> index 92be1c0ab99f..899ff25f4f28 100644
> --- a/drivers/char/hw_random/iproc-rng200.c
> +++ b/drivers/char/hw_random/iproc-rng200.c
> @@ -181,7 +181,6 @@ static void iproc_rng200_cleanup(struct hwrng *rng)
>   static int iproc_rng200_probe(struct platform_device *pdev)
>   {
>   	struct iproc_rng200_dev *priv;
> -	struct resource *res;
>   	struct device *dev = &pdev->dev;
>   	int ret;
> 
> @@ -190,13 +189,7 @@ static int iproc_rng200_probe(struct platform_device *pdev)
>   		return -ENOMEM;
> 
>   	/* Map peripheral */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(dev, "failed to get rng resources\n");
> -		return -EINVAL;
> -	}
> -
> -	priv->base = devm_ioremap_resource(dev, res);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->base)) {
>   		dev_err(dev, "failed to remap rng regs\n");
>   		return PTR_ERR(priv->base);
> --
> 2.23.0
> 

Change looks good to me, thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
