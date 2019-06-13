Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA5C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D80207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY4EEIKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfFMSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:05:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38361 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFMSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:05:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so11387411pgl.5;
        Thu, 13 Jun 2019 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6EdW1zQmAAxK0Wa2ppkGhsrx4V+WLwXRsMm+jl3+ewo=;
        b=CY4EEIKXVyaEX9Q2YU2gGkUHWd0Pp+IvLWSb6NtU47cM2RbPyozw/YKui7GvEIcwXu
         HKkMgmbcBo1EaMxgNpnwOvJZ6rOOjaKXtTQDMI18ftK6UlsiXnX69m3EuC4g+DFjMEP8
         /Y5jh4IvbkOXkTlRmwSGNP92wjUu191GVcrBMWSmso443/L3e96pZUErlVAOEZLit1tu
         71LtfO2NSARBP+p6M9M6EryIuIBu3VhwHn7lqcexvjPCcNB7rzothPlLhXbadTR04wqT
         z7t9JiGqQKfncKIS0AxAEC+07IoUXybdLqMag/zqJROoNbpYwOTXOWl6Hy8i2X1DyHWS
         VWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6EdW1zQmAAxK0Wa2ppkGhsrx4V+WLwXRsMm+jl3+ewo=;
        b=B329nxDxhP8B7FCzNqdtX7Jedvy47klGNjcJI+FLEqUs2xT9T5+M3qD8mebSUR0OJP
         xaT/CD4tqj7SMl3ChawQp0RGOh+LSBpkqZpedlrbgSl5xwQn2zVhs4w7YFWALDRZDkrb
         nSHaIgOEVtES1i9GLWS5yR8vbIgV6/TfhQEwi8Af4Gf3Sz5uN7fjg0f9DxGGsQU90G6v
         02iGAC9PxHFGg9s6i9BQUZ9VaKTrYf5zFC6sh7smxrnoiQKz+K/BJiiRjbAi5K/At5eS
         mT1uP63aKFNVUEqULfLGgLT4CKwqXbsBWIIXs0sUDXXpvCwcOuRSawkJwmBulhS7PIam
         ssQw==
X-Gm-Message-State: APjAAAX3bPM22rkAsv20az3oxmpOUW75etHs8vh5jQzWnJPD6cHFHEBG
        zE0fE33+qSgFpB2rdU8aZ3w=
X-Google-Smtp-Source: APXvYqw1YQzFVkNF9Msoqos5HCsJR3CRbWRv0JJz9cZgpC8b19GXB02dTSyHEal1BUYRQWmrQUAang==
X-Received: by 2002:a17:90a:2648:: with SMTP id l66mr6718507pje.65.1560449144861;
        Thu, 13 Jun 2019 11:05:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 16sm343780pfo.65.2019.06.13.11.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:05:43 -0700 (PDT)
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
To:     Fredrik Noring <noring@nocrew.org>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, JuergenUrban@gmx.de
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net> <20190611133223.GA30054@roeck-us.net>
 <20190611172654.GA2602@sx9> <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
 <20190613153414.GA909@sx9>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
Date:   Thu, 13 Jun 2019 11:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613153414.GA909@sx9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 8:34 AM, Fredrik Noring wrote:
> Hi Guenter,
> 
>> Thanks for the confirmation. Do you see the problem only with the
>> ohci-sm501 driver or also with others ?
> 
> All are likely affected, but it depends, because I believe the problem is
> that the USB subsystem runs out of memory. Please try the attached patch!
> 
> The pool assumed 4096 byte page alignment for every allocation, which is
> excessive given that many requests are for 16 and 32 bytes. In the patch
> below, I have turned down the order to 5, which is good enough for the ED
> and TD structures of the OHCI, but not enough for the HCCA that needs 256
> byte alignment. With some luck, the WARN_ON_ONCE will not trigger in your
> test, though. If it does, you may try to increase the order from 5 to 8.
> 

You are right, the patch below fixes the problem. I did not get the warning
with order==5. Nevertheless, I also tested with order==8; that works as well.

Thanks a lot for tracking this down!
Guenter

> I have observed strange things happen when the USB subsystem runs out of
> memory. The mass storage drivers often seem to busy-wait on -ENOMEM,
> consuming a lot of processor resources. It would be much more efficient
> to sleep waiting for memory to become available.
> 
> In your case I suspect that allocation failures are not correctly
> attributed. Certain kinds of temporary freezes may also occur, as the
> various devices are reset due to host memory allocation errors.
>  > Fredrik
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -3011,7 +3011,7 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
>   	int err;
>   	void __iomem *local_mem;
>   
> -	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, PAGE_SHIFT,
> +	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, 5,
>   						  dev_to_node(hcd->self.sysdev),
>   						  dev_name(hcd->self.sysdev));
>   	if (IS_ERR(hcd->localmem_pool))
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -517,6 +517,7 @@ static int ohci_init (struct ohci_hcd *ohci)
>   						GFP_KERNEL);
>   	if (!ohci->hcca)
>   		return -ENOMEM;
> +	WARN_ON_ONCE(ohci->hcca_dma & 0xff);
>   
>   	if ((ret = ohci_mem_init (ohci)) < 0)
>   		ohci_stop (hcd);
> 

