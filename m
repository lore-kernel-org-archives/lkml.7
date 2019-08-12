Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E004420651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amI4Hi4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfHLNaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:30:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42516 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbfHLNaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:30:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so47932290plb.9;
        Mon, 12 Aug 2019 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LzmsQjTfCAGfzgibtgJwWGGyOUUejcSfXVXPD/fec0Q=;
        b=amI4Hi4DT6040meOqfNQLY2WyBYscAzRYwN6NIwGbgHq5vJuPvt+GjCO+OqaZbS5+n
         VVRYwOqdCv125crYWfUlXLIkcpJyFTzEn+cOmfGegKjmOQiKXSQdHODgyXXfUqGLN3WB
         KmB8ODgHLEy6fGHVju3bNibRry7jW2hRVi0tPH8nR4gPHY7wEbh80/DMsTpSJRG32aNu
         s8i/zn/do1aJfY2rnIdINvOmhe+NdjskEzgNgJJ43pnhTRzW3TcNfGejpmvRGHZSiQ+1
         X2estHNsOoeeEddAwvLDkmejJmzYZH6W8tsj0/6N6PT1f18MhXmQeJfLGUfTMWpVY5sz
         jNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LzmsQjTfCAGfzgibtgJwWGGyOUUejcSfXVXPD/fec0Q=;
        b=LJkI0cfAoH6hjLm9SyPZVPXSusb1wgUXxpDvAae2DTzrVY/bK8cxwg8nH851YtIl4Y
         U5vr7vMqyANu4gK/4lzNjFNVpk1nlB2WGT++f3ATywYVMbfd8ZVxXhr7bJL+/vHa0Ru5
         Mtac12Ib8GRMZhvUbSTOjSNmXbp+lPW0T4DPBzQCnQAu7+vKUEku8KlWDPttQzy9q4Lh
         ztN7L1l+OO7sTykE7OauxYU+PPxESX/BIBgIJbr5oAxQNEdZKs1mQUGSwa2fKQmhkXRm
         pkXqjaZjELPvo8GIeGriY47kfRNI32SAju/pN7iRcIeHhkCgpWZW5PFdvKr54e208KMh
         Dvxw==
X-Gm-Message-State: APjAAAXldsqDSnPOfY3ev5t9/TZWO8lS5Uy9bGJp7G6O0Pv+T2HYjz1B
        QlAHsjs5Bb36Ct5ZJG+7j50=
X-Google-Smtp-Source: APXvYqzopTD9eHQVPq9aezbMoLuvpwalDJYSit6Z18zj7hBJORCL//WTJigjX27R5vaD8/VkptKZXg==
X-Received: by 2002:a17:902:d917:: with SMTP id c23mr32901603plz.248.1565616612021;
        Mon, 12 Aug 2019 06:30:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v138sm120654857pfc.15.2019.08.12.06.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 06:30:11 -0700 (PDT)
Subject: Re: [PATCH] watchdog: imx_sc: Remove unnecessary error log
To:     Anson.Huang@nxp.com, wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <20190812084434.13316-1-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <611fe8c6-f907-d022-3484-ff53b2bd4331@roeck-us.net>
Date:   Mon, 12 Aug 2019 06:30:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812084434.13316-1-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 1:44 AM, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> An error message is already displayed by watchdog_register_device()
> when failed, so no need to have error log again for failure of
> calling devm_watchdog_register_device().
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/imx_sc_wdt.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
> index 78eaaf7..9260475 100644
> --- a/drivers/watchdog/imx_sc_wdt.c
> +++ b/drivers/watchdog/imx_sc_wdt.c
> @@ -175,11 +175,8 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
>   	watchdog_stop_on_unregister(wdog);
>   
>   	ret = devm_watchdog_register_device(dev, wdog);
> -
> - 	if (ret) {
> - 		dev_err(dev, "Failed to register watchdog device\n");
> +	if (ret)
>    		return ret;
> - 	}
>    
>   	ret = imx_scu_irq_group_enable(SC_IRQ_GROUP_WDOG,
>   				       SC_IRQ_WDOG,
> 

