Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF32C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17B421019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zaltys-org.20150623.gappssmtp.com header.i=@zaltys-org.20150623.gappssmtp.com header.b="Tot6V3up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfEMLdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:33:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45786 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbfEMLdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:33:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so6335826pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zaltys-org.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vIAiIlRHFlvzv9k+xH8nEYUaTAu5zyVCWpRcJP2mCII=;
        b=Tot6V3up2+HWtknpsoM4dHvQa7QQqbVninOPpnopo2wzgPQUAtmIPR0dsqOARVECTG
         K97IFaLXAZx/3L6Rw9Vk12yDr0VM9rR/4+eI6mUIKZssBdcQ1E5+evvEn9o3vdaGN7uO
         ut5FnC0LFECAz1oyoCOghV1Q27MHaHqouNqZH9wX54oQHFME8GnUcXKqiMoCgscnaivW
         aN7g33w4UYFpW2BrrNaepLE2akGZYkmaboYLaXH/+YR6Q+HyIAPH6s9srT0DzeLghCg5
         zU0D/Nk8pmjUlcsXkdQe3Y+FP++WAkzz9cp0//FzG3p3GWmpUwA28cFyZoGoyvk07rVO
         BCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vIAiIlRHFlvzv9k+xH8nEYUaTAu5zyVCWpRcJP2mCII=;
        b=EAUk5vEUiHezHJXM7DIgIt+2dSaIzNNJPqlyZqVi5N+b2j9J33X9leRoIQ/mbrNIx0
         /pir6ix1xs7hfGSOh48PvMIZduRdzr3Sk6QJf9oWWytatU+6AmUeA2ninaafELvOaUk/
         2MnTih4443JP7dZu8PuQ652l9kImauS6838kB/19VeLPtIVVJRky8vhzamzrETpEJtl0
         25045fOalMlJcJMHKclbAINMtvtXOu+NuLgg/AN+8TjoplEKHw3FljZ8AzYlk+59htQh
         aUzCmRAcgACa6tprK7rJNLc4TdfNVgAA3WP+eSO6qG4VViYgVRjrF3dWfyZ8+Znsx05K
         kAqg==
X-Gm-Message-State: APjAAAX5FW4yasbyQKp27zWQx1cc5NJvR22V8Q7XLhN6T+p6La+a7L7A
        h6/woCNbBevqTp8sja0UTkfnDw==
X-Google-Smtp-Source: APXvYqwAEFg6Wul3VsCH7RrW8iX3qzuipuHAYVcRiGC6fovckro06GFeujxxW1Fd612upFEtypRy0Q==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr30192640pls.80.1557747197055;
        Mon, 13 May 2019 04:33:17 -0700 (PDT)
Received: from [172.28.0.10] (122-59-127-127-fibre.sparkbb.co.nz. [122.59.127.127])
        by smtp.googlemail.com with ESMTPSA id r124sm12699914pgr.91.2019.05.13.04.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:33:16 -0700 (PDT)
From:   James Grant <jamesg@zaltys.org>
Subject: Re: [PATCH] usb: gadget: udc: lpc32xx: allocate descriptor with
 GFP_ATOMIC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <balbi@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Grant <james.grant@jci.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190510124248.2430-1-alexandre.belloni@bootlin.com>
Message-ID: <417966d0-e656-b4e6-c1ea-b53bf687a870@zaltys.org>
Date:   Mon, 13 May 2019 23:33:11 +1200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510124248.2430-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with a board containing LPC3250 SOC and STOTG04 PHY by using 
serial gadget.

Needed patch series starting with "[PATCH 0/5] usb: gadget: udc: 
lpc32xx: add stotg04 phy support" also.

Tested-by: James Grant <jamesg@zaltys.org>

Regards,
James Grant.

On 11/05/2019 00:42, Alexandre Belloni wrote:
> Gadget drivers may queue request in interrupt context. This would lead to
> a descriptor allocation in that context. In that case we would hit
> BUG_ON(in_interrupt()) in __get_vm_area_node.
>
> Signed-off-by: Alexandre Belloni<alexandre.belloni@bootlin.com>
> ---
>   drivers/usb/gadget/udc/lpc32xx_udc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index d8f1c60793ed..b706d9c85a35 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -938,7 +938,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
>   	struct lpc32xx_usbd_dd_gad	*dd;
>   
>   	dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
> -			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
> +			udc->dd_cache, (GFP_ATOMIC | GFP_DMA), &dma);
>   	if (dd)
>   		dd->this_dma = dma;
>   
