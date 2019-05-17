Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AC0C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2A82168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjBZlJ0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfEQQSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:18:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44056 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbfEQQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:18:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id z65so5535767oia.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pjtxzayk8uLZnkYZMztMOmWVVABDJ2taMu016Zq6Tmo=;
        b=KjBZlJ0JSbUXlbui2suPITnuZWI5Yjd4i1oN9NNbzxPduGZST+TbLfK+JIN169N1Fd
         Fnl8Z0DMQ7b5pKukMS6Cbi/VNSbzrSKXF2tD5WrGX9KxgjzxGyJdyQRgcX80jtcys9kg
         QyMAGn5/wBoLoUWh6Yx9duZfjV86BxyMir1dI17D/IaBxw0GYv4+boWloQno6jlGJCNX
         OnkkRbU1RsiUHV1PPoiYNIP/64K5uZ2ZYny4ZSt8luMaN2YR6UfV2Pq79tnyQgXidnoZ
         qDMgQqOAP9OhbgEa425om3b46XG3YDNGFjdqQe2YXWA2b3e+b6yrX+0LfzZ7yLujBF3i
         JJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=Pjtxzayk8uLZnkYZMztMOmWVVABDJ2taMu016Zq6Tmo=;
        b=ldJS+OWc08wRiRc27pFihVz+aW9ZFwyUI1pTjxoA+UK723jhIya3wiSE40g4+rNiwg
         t7+rP8GYjBWwnDrpco94Ytexs9edU2yFbLniOi/BuLGlHvXPoNqW+yG5X5WXGmAzxtNY
         Iqegj87+47V+LQzLL4zJGPOA7GvU9DyyKHtSAIRNlFOqhHIYgI1kffWa+e5pZTazZFQP
         DodX0ecs1NPC03fRGgEIPDGa52NM+4epHqDgCw+WiQXH6rXUuulvpbkUzIUqEbexFkac
         2XLd8GrOMEctWeSmpi3zhb3RdeEA9AuoSpOVZ0f94+AHz3ZBf85NmmcK4CmG0zWfTSiX
         lzpw==
X-Gm-Message-State: APjAAAUw0oWU7DbX6iDLsfzIpUtHzwW1HX1PhwTCIqU9K5errfaqYDOT
        7SGqIQPeE46z/wSRxhgc+A==
X-Google-Smtp-Source: APXvYqwAQl1srkMegz0Iea1ZjhMsuTAE5+XcuEWJggggpeFGjX9cB0FVSEhEjbAVUdkNUgfziJFrbQ==
X-Received: by 2002:aca:bac3:: with SMTP id k186mr5907623oif.160.1558109903270;
        Fri, 17 May 2019 09:18:23 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id q82sm3199778oif.28.2019.05.17.09.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 09:18:22 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 315C7182A49;
        Fri, 17 May 2019 16:18:22 +0000 (UTC)
Date:   Fri, 17 May 2019 11:18:21 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] ipmi_si: fix unexpected driver unregister warning
Message-ID: <20190517161821.GB11017@minyard.net>
Reply-To: minyard@acm.org
References: <20190517101245.4341-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517101245.4341-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 06:12:44PM +0800, Kefeng Wang wrote:
> If ipmi_si_platform_init()->platform_driver_register() fails,
> platform_driver_unregister() called unconditionally will trigger
> following warning,
> 
> ipmi_platform: Unable to register driver: -12
> ------------[ cut here ]------------
> Unexpected driver unregister!
> WARNING: CPU: 1 PID: 7210 at drivers/base/driver.c:193 driver_unregister+0x60/0x70 drivers/base/driver.c:193
> 
> Fix it by adding platform_registered variable, only unregister platform
> driver when it is already successfully registered.

This is good, but have you found out why the driver was unable to
register in the first place?  That really shouldn't happen.

This patch is queued for 5.3.

-corey

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_si_platform.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index f2a91c4d8cab..0cd849675d99 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -19,6 +19,7 @@
>  #include "ipmi_si.h"
>  #include "ipmi_dmi.h"
>  
> +static bool platform_registered;
>  static bool si_tryplatform = true;
>  #ifdef CONFIG_ACPI
>  static bool          si_tryacpi = true;
> @@ -469,9 +470,12 @@ void ipmi_si_platform_init(void)
>  	int rv = platform_driver_register(&ipmi_platform_driver);
>  	if (rv)
>  		pr_err("Unable to register driver: %d\n", rv);
> +	else
> +		platform_registered = true;
>  }
>  
>  void ipmi_si_platform_shutdown(void)
>  {
> -	platform_driver_unregister(&ipmi_platform_driver);
> +	if (platform_registered)
> +		platform_driver_unregister(&ipmi_platform_driver);
>  }
> -- 
> 2.20.1
> 
