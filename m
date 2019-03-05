Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF56CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BBA20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YCjgZBKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfCER1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:27:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36370 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfCER1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:27:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so6216739pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Tw8B+9dl5M+qG13zllqE3uJafdO3lFaK6AkwIiiHLA=;
        b=YCjgZBKXK8fZt4TGt9pxlRE20txRF4XbadKVLvDfg7bL/+7OatY9gTVQ5YW5fUQq+0
         0tVRrT62VNn4968dKncr6pIushx58f/OuliV2o3PiCjUwUhCDSIe8+oa9DMeW29auxwv
         ChwLRxQkV8tcR5EsrSDOHEjZf6m1k0gTR9ROg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Tw8B+9dl5M+qG13zllqE3uJafdO3lFaK6AkwIiiHLA=;
        b=oXvnyY+/zmQqt8Ia9md3LZh74aOj70TvfMj3z0vdKh0lAVb2kYz/HHstEEtQjJMzzJ
         3eGprEuI/eN6hCO8yjIRQVCY7SeM3dwMc7YFRgMMpQL77+ZG7GLfOo9HkwdrQyhbDPQM
         lcBn+ATy14rY7y1IlEU8SJ6yhKRoDZasddFWPCMFqOR8GfAkufhdtXMc9YXQkUFOkRQ3
         uQqgpIxmzwjeqGVkwD51zhnuFVhFIfDJ43xlTYe9s3UObJCzYr5s3BdFQrWozgSCqjqI
         r3/ib828vaFeskX7V0SRS6g/4xNTfv31cXeUNUK9esEpAU0wNZ7x67KKVfxhLD158n4m
         pWHg==
X-Gm-Message-State: APjAAAWLN/cRNdkRO8sna3Ww8KRXH4x8TXHklNjZlPnUWH7HjZfhcYdV
        GD8RZkSU6+0JSMDw12o7XZfVWA==
X-Google-Smtp-Source: APXvYqynNU5AEbhzX5gpwi/uLwYHOpYIYu2e1qbuRGYbF/0+kvCi5ljzvKen/ONB1mfstEFng4hddw==
X-Received: by 2002:a63:d205:: with SMTP id a5mr2372488pgg.142.1551806832665;
        Tue, 05 Mar 2019 09:27:12 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y6sm19786029pfy.87.2019.03.05.09.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 09:27:11 -0800 (PST)
Subject: Re: [PATCH v2 02/15] ARM: bcm: fix a leaked reference by adding
 missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <1551785646-46173-2-git-send-email-wen.yang99@zte.com.cn>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <67d1be96-ad8a-a453-996f-731a363677ae@broadcom.com>
Date:   Tue, 5 Mar 2019 09:24:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551785646-46173-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2019 3:33 AM, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-bcm/board_bcm281xx.c:43:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 35, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v2->v1: add a missing space between "adding" and "missing"
> 
>  arch/arm/mach-bcm/board_bcm281xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
> index b81bb38..1238ac8 100644
> --- a/arch/arm/mach-bcm/board_bcm281xx.c
> +++ b/arch/arm/mach-bcm/board_bcm281xx.c
> @@ -38,6 +38,7 @@ static void bcm281xx_restart(enum reboot_mode mode, const char *cmd)
>  		return;
>  	}
>  	base = of_iomap(np_wdog, 0);
> +	of_node_put(np_wdog);
>  	if (!base) {
>  		pr_emerg("Couldn't map brcm,kona-wdt\n");
>  		return;
> 

Change looks good to me. Thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>
