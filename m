Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E14BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B50220840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrNMAfbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfCGPVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:21:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46342 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:21:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so13765091edy.13;
        Thu, 07 Mar 2019 07:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlCc/OfCp8Rh0Vzj5bUYp8P/YmDfx1Q9BDUZQbX5Ugw=;
        b=DrNMAfbwc8dvTtXiWRqOqbc024BFGDZUgDOpka2J+EcDRQHPFJ5pDfxYDgejpDU0f+
         9A8q/mL9Gnxoo/SNt3R5vLZn0CiekcyMuoU5iJyqX2tGvBK8rK8aPCrzIWNRZ2bC/WdB
         tYXoxpLGm6rS40xWwqCsPfAwm+QxQkJuJCzXPIJqrEcsOrcLAMkp7+M9gisGy9wy4VR3
         AmMXclfT1dLheuELHeWGu/YegdDLtHDn4Hj352Lgq6MErZ2UZ97ZQPGTWnzZcCCCJDYB
         WbnTQPWWGk5s0LCpabEkKdzohF1gDLVa5V/FvKawWb+LDoq4LB6c06H1kRCsJmsc8bVC
         l+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlCc/OfCp8Rh0Vzj5bUYp8P/YmDfx1Q9BDUZQbX5Ugw=;
        b=Hph84eXblwN0ysIRSBPWKW9vtz5Z6ZjE9L01/s0XlZULPs6v0DKvaUgDVWMQoqxRt4
         goyAShSeVzvI44r98t/ABLmWhyJGG1ZGYopZTWV8HW0dt5HOWceAieIh9JiXFb+TD/pq
         6gN4byCZT57MoGpwImaLi37+0zuCFvWZjH4GR7LV/8SxdZNYy1KMoSzvw0kCqhHh79y/
         51Hh48hCazPLvxYOxSyINqeLgKUflhU6tqcSQFHeTHCSEPbBJFhAQSDwvbQethGBjTeJ
         Pf8a4uY3cDaPyufTglebbDfAWPIpnGU8bOI8//yJuKsb+nHZOnwzVBUJ3ZIvQSRNwePv
         Xsfg==
X-Gm-Message-State: APjAAAXAkABRoAramvoSkP7a2cYe0UmvkbiYLqyB5C/L97AsnP3cq/jQ
        HsfkhCkftnt3k8kdYtiKH/c=
X-Google-Smtp-Source: APXvYqzdgiDaS1oF+sR23RWCf4dHnIOZ9H0PdU2JUVIEyZ6bEyLaJTB29teqGw9HgsUFtOO2SK37Aw==
X-Received: by 2002:a50:8bf9:: with SMTP id n54mr28025875edn.197.1551972081101;
        Thu, 07 Mar 2019 07:21:21 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b24sm1415294ede.93.2019.03.07.07.21.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:21:20 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:21:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: davinci: remove extraneous __init annotation
Message-ID: <20190307152118.GE20201@archlinux-ryzen>
References: <20190307101024.594587-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307101024.594587-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:10:11AM +0100, Arnd Bergmann wrote:
> Building with clang finds a mistaken __init tag:
> 
> WARNING: vmlinux.o(.text+0x5e4250): Section mismatch in reference from the function davinci_mmcsd_probe() to the function .init.text:init_mmcsd_host()
> The function davinci_mmcsd_probe() references
> the function __init init_mmcsd_host().
> This is often because davinci_mmcsd_probe lacks a __init
> annotation or the annotation of init_mmcsd_host is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 49e0daf2ef5e..f37003df1e01 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1117,7 +1117,7 @@ static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
>  {
>  }
>  #endif
> -static void __init init_mmcsd_host(struct mmc_davinci_host *host)
> +static void init_mmcsd_host(struct mmc_davinci_host *host)
>  {
>  
>  	mmc_davinci_reset_ctrl(host, 1);
> -- 
> 2.20.0
> 
