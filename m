Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699412082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgLDixlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfC0E3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:29:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37532 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfC0E3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:29:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id q6so2691163pll.4;
        Tue, 26 Mar 2019 21:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R7Rmr3usMoANrgDOamrtcO1wr1qw8ia6MH66MyE2lrI=;
        b=lgLDixlkWeXMYgp9DCksWEDEs3WdX4oWmo9oYFgDULSWkr8bab36p/rr9f2GSfoF4l
         MGLx6zkbvC7ZforxAa/zY01J6UYt7Io01ToCI4H/f2NQ9XlrGGbESsbZ0wxqGLScyf2n
         i/G8t+kOPC3MQggz9LBq2P50EovCOkucE/kq6hjdpF6IM+yA2KgHfqftbObLDQRElCxF
         NJTAOWBGI6ZF5XsW0/5ZdNCcC27o3N6Qu20qxiGw91e4wDiACFe+BUKDzRxnukDxoFce
         V4i0VGeT8NUFsIgPQoCfFDI86KjtDxWsRfCl9ZjdTSE3oYTpN350tKb7CN7KfzibS87N
         YMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R7Rmr3usMoANrgDOamrtcO1wr1qw8ia6MH66MyE2lrI=;
        b=f9mUTFZzSsdo4RTiYnIR5Onk6vQEDRSGTI0P3efVIRnqFbSDzKRomuLgXvXE1mKKVc
         6/K+sS/Nyd8AOadNWbDBd5l1an2NtoWMrxNqGnNeMuBAE0fQ1HUcW6w1Lbin2NtPJ6vp
         KU8tG1Lus1Nm4MMnoHd6rFYTUZ0fmu9OtYjKKa93EWpdo5bN2w0Sehf4v+v+uBcZ3Azb
         XbAQbLGySDyIzdH+sAzRo5I7kYBRkGDGMILpqKIOfxLyIktexquhBWOA/LTAyhURp/aI
         bDjo6FIhQz7W5PLxRpYw5shOszK9CxL4XHCQrqZdg1y6cRHFtpaKhzG6NSKv6feQzbJc
         4NNw==
X-Gm-Message-State: APjAAAV+s6hy0aDs0mPYawKSo0amY592jkQv8y9FXC82/aIh1WKlrftI
        +8bJLdvUkoQYKUA1bAh+Kds=
X-Google-Smtp-Source: APXvYqzsxpRkRru9gWNxaPdIIIqXZgU/oMXoKpk2NsK4OC8Tk/6jJ+C7NYk83wp39vPHzfHdUVN/rg==
X-Received: by 2002:a17:902:396a:: with SMTP id e39mr12899189plg.220.1553660946182;
        Tue, 26 Mar 2019 21:29:06 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v7sm13731014pgh.53.2019.03.26.21.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 21:29:05 -0700 (PDT)
Date:   Tue, 26 Mar 2019 21:29:03 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] input: keyboard: snvs: make sure irq is handled correctly
Message-ID: <20190327042903.GA40550@dtor-ws>
References: <1553654517-7810-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553654517-7810-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Mar 27, 2019 at 02:47:06AM +0000, Anson Huang wrote:
> SNVS IRQ is requested before necessary driver data initialized,
> if there is a pending IRQ during driver probe phase, kernel
> NULL pointer panic will occur in IRQ handler. To avoid such
> scenario, need to move the IRQ request to after driver data
> initialization done. This patch is inspired by NXP's internal
> kernel tree.
> 
> Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index effb632..6ff41fd 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -148,15 +148,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> -	error = devm_request_irq(&pdev->dev, pdata->irq,
> -			       imx_snvs_pwrkey_interrupt,
> -			       0, pdev->name, pdev);
> -
> -	if (error) {
> -		dev_err(&pdev->dev, "interrupt not available.\n");
> -		return error;
> -	}
> -
>  	error = input_register_device(input);
>  	if (error < 0) {
>  		dev_err(&pdev->dev, "failed to register input device\n");
> @@ -166,6 +157,14 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	pdata->input = input;
>  	platform_set_drvdata(pdev, pdata);
>  
> +	error = devm_request_irq(&pdev->dev, pdata->irq,
> +				 imx_snvs_pwrkey_interrupt,
> +				 0, pdev->name, pdev);
> +	if (error) {
> +		dev_err(&pdev->dev, "interrupt not available.\n");
> +		return error;
> +	}

Instead of moving devm_request_irq() around could you simply move
pdata->input = input assignment higher? It is perfectly fine to try
calling input_event() on input device that is allocated but not yet
registered.

> +
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);

Unrelated suggestion:

Can you try calling dev_pm_set_wake_irq(&pdev->dev, pdata->irq) here and
I think you will be able to get rid of suspend/resume methods in the
driver.

Thanks.

-- 
Dmitry
