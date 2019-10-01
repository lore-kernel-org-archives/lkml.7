Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B94ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760002053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="ApBg4e0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbfJAQBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:01:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39894 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732809AbfJAQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:01:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so8309413pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=idbzkM4Uy3IgWjz+crMW94nlfJxR/IgtZnRXVc7jjQk=;
        b=ApBg4e0yJjPYuGCRnLEys1GKToPLkmDDLlkuiZK8QZQy0EDHWuth01D6nqOvq4KAng
         Z0xcmh0o0od7yoNPG8gHR80kaxpgRzAAktzpBL8shUTR1GFsfJe4mSG1hMAwKDOT1yWg
         J8ljpl4j3PadYPdWA7eAqvUwMwNQAiR3H8bZ5IZlzKO3SjwsFmclT20PH9vcvMoqiuDA
         G+xYsPanBp0ne/KalGKxAYfevIt56y1/L7mABnxch+Hf7TVW/9H/b2IYS92klbfZ49/x
         ptovyq44ZiQdLsVxb7ilymFMi49nWOXlRWTSakofVVx4o4PqxI1ItGnIC/E2AthqF6uW
         XvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=idbzkM4Uy3IgWjz+crMW94nlfJxR/IgtZnRXVc7jjQk=;
        b=JdzCUn9qYOd64+f/AMloIbIab1jUYyemx/RoS5ZFoePG9z91mCcWHhJfQ500cAQ/RL
         6yGiooB1AlF0W/zea8KvIobcHhNU19Q0jjLvhrLZmUL1x0cOEF780iUyVx25wHnnvurg
         RTj1QkuKrfRUS37lRXmdGx9eVUgYrSs7iMZw9lv1GErU9JejB5XMDGQSP8vnnavUc5kp
         eKiKPiCuB6SNl3Rv7jxeE/qNDAJvNeHcrNkQ+HcVX8NusdRwZ7MbqLEGf6jxNeNnmtsS
         aXyIi70fAbKudy7x6UIDMLW37UCiFcDn8+OmPcbHCc5Fprsivgdi0e6uLbHUc2arNHX5
         fLOw==
X-Gm-Message-State: APjAAAU25yfxczmmTUnEk3YAoQaOdE9YM77oPaRii94ELG9DoKM+zrs7
        MZHRq3z4UauMMk6eiQ0ykwxhdtT9aUbm9w==
X-Google-Smtp-Source: APXvYqymArKhOXlsUJI+sJmVq0/SoBQOToYBm5aE+7kMNeRDvzhEE0tq8mcjkbbNZIgAEHyF3ePxZA==
X-Received: by 2002:a63:ec52:: with SMTP id r18mr31698670pgj.128.1569945704953;
        Tue, 01 Oct 2019 09:01:44 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id v4sm15064179pff.181.2019.10.01.09.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:01:44 -0700 (PDT)
Subject: Re: [PATCH] ionic: select CONFIG_NET_DEVLINK
To:     Arnd Bergmann <arnd@arndb.de>,
        Pensando Drivers <drivers@pensando.io>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191001142151.1206987-1-arnd@arndb.de>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <57c673d8-a1f2-e759-7a7d-3cbf9b370d55@pensando.io>
Date:   Tue, 1 Oct 2019 09:01:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001142151.1206987-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 7:21 AM, Arnd Bergmann wrote:
> When no other driver selects the devlink library code, ionic
> produces a link failure:
>
> drivers/net/ethernet/pensando/ionic/ionic_devlink.o: In function `ionic_devlink_alloc':
> ionic_devlink.c:(.text+0xd): undefined reference to `devlink_alloc'
> drivers/net/ethernet/pensando/ionic/ionic_devlink.o: In function `ionic_devlink_register':
> ionic_devlink.c:(.text+0x71): undefined reference to `devlink_register'
>
> Add the same 'select' statement that the other drivers use here.
>
> Fixes: fbfb8031533c ("ionic: Add hardware init and device commands")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/pensando/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/pensando/Kconfig b/drivers/net/ethernet/pensando/Kconfig
> index bd0583e409df..d25b88f53de4 100644
> --- a/drivers/net/ethernet/pensando/Kconfig
> +++ b/drivers/net/ethernet/pensando/Kconfig
> @@ -20,6 +20,7 @@ if NET_VENDOR_PENSANDO
>   config IONIC
>   	tristate "Pensando Ethernet IONIC Support"
>   	depends on 64BIT && PCI
> +	select NET_DEVLINK
>   	help
>   	  This enables the support for the Pensando family of Ethernet
>   	  adapters.  More specific information on this driver can be

Thanks!

Acked-by: Shannon Nelson <snelson@pensando.io>

