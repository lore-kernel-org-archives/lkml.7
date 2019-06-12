Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E036C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152F2208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouZ+5TNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438850AbfFLMVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:21:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37473 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfFLMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:21:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so859037otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWad4IK91eIASjJZ1C4Z6FDQBRJ2DNHxK5AHNDN3DxI=;
        b=ouZ+5TNpdz8bpVVcZxHn465IRjMhanw/P1IZf5RiC+Ctj9KTQGTqgyAOfLgugdYTli
         RY0rKwb/QIWNHTZlFKqUfdbRCaSVp6vRBI18ssp5E2mPG8yTVK+wZvXNNJNUtmeeP8QY
         zZkB6ZJ6JlZQ4QnyGERECy1vW7Ma/F2ax461rNvG31gObXD9+sWcFsGMtbl3cp5GurE5
         I+y34SRT8Te/CUfpTK21/IeFHep3/YDdVtNOqIJVxd+joAZnTv/tW1QpR10pKyWbQiiu
         tz+N3ejE8iWxwvbS6J4ZGE72Jw3Q2ubJumN0w2jNhnlvwIQpXcZV4+t7Yaas4byUBRc0
         HABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=WWad4IK91eIASjJZ1C4Z6FDQBRJ2DNHxK5AHNDN3DxI=;
        b=gHW4+tu8Fd6M45MLPmuKQBiHr/5V5XT8stZ8W9FCAgVVQXvIjH0SXh/1k+LV6ErKv6
         HGCA06/YZ7PC96VPV9FpjuNAc3zGWu8mMKnQvP2EbGVCzShO7XBba/F0nmvlZSrE5YPR
         eDUtbxWV/XdOqHba+Z30IluvBVQsTFHsLfiRb6s9BgRQA4Lys4cdKSRMPFA6alMcUIDz
         Rgj2Q/8d79XaeFqxANS9kFadcvqg5a23YGUxavRAJ/p8muYtpgXC0NcvV0HfF9mkgVod
         NAoPG2Vbe3nT2Q0CUlnnglzRBNyRb2GFTOIyrE26vKpWxTL28f+YZBMlhJygfLWYV3hZ
         xzUw==
X-Gm-Message-State: APjAAAUJVBK0ca61WRKzYvrgUg+SakXcueYtUxGOR9w/LaCfqBUlpguG
        R//u4el4+X84MHy9238Vuw==
X-Google-Smtp-Source: APXvYqy3zAhi1c4KA8Or+ZFhTTPC3KHvQYf2cssJ78oc+jFhngqZ5UPki38Uzwwu8Y7ye954PxbqQg==
X-Received: by 2002:a9d:7559:: with SMTP id b25mr6139798otl.360.1560342074399;
        Wed, 12 Jun 2019 05:21:14 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id n32sm1608287ota.7.2019.06.12.05.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 05:21:13 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:1d3c:a5aa:3fdf:3942])
        by serve.minyard.net (Postfix) with ESMTPSA id 52DAB1800CE;
        Wed, 12 Jun 2019 12:21:13 +0000 (UTC)
Date:   Wed, 12 Jun 2019 07:21:11 -0500
From:   Corey Minyard <minyard@acm.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, Asmaa@mellanox.com,
        vadimp@mellanox.com, linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] ipmi: ipmb: Fix build error while CONFIG_I2C is set to m
Message-ID: <20190612122111.GA4787@minyard.net>
Reply-To: minyard@acm.org
References: <20190612031825.24732-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612031825.24732-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:18:25AM +0800, YueHaibing wrote:
> If CONFIG_I2C is m and CONFIG_I2C_SLAVE is y,
> building with CONFIG_IPMB_DEVICE_INTERFACE setting to
> y will fail:

Ok, I have added this to my linux-next tree.

-corey

> 
> drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_remove':
> ipmb_dev_int.c: undefined reference to `i2c_slave_unregister'
> drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_write':
> ipmb_dev_int.c: undefined reference to `i2c_smbus_write_block_data'
> drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_probe':
> ipmb_dev_int.c: undefined reference to `i2c_slave_register'
> drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_driver_init':
> ipmb_dev_int.c: undefined reference to `i2c_register_driver'
> drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_driver_exit':
> ipmb_dev_int.c: undefined reference to `i2c_del_driver'
> 
> Add I2C Kconfig dependency to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 51bd6f291583 ("Add support for IPMB driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/char/ipmi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> index 987191b..4bad061 100644
> --- a/drivers/char/ipmi/Kconfig
> +++ b/drivers/char/ipmi/Kconfig
> @@ -135,6 +135,7 @@ config ASPEED_BT_IPMI_BMC
>  
>  config IPMB_DEVICE_INTERFACE
>  	tristate 'IPMB Interface handler'
> +	depends on I2C
>  	depends on I2C_SLAVE
>  	help
>  	  Provides a driver for a device (Satellite MC) to
> -- 
> 2.7.4
> 
> 
