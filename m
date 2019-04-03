Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E5CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DEF20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU2rpH7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDCWPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:15:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45736 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDCWPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:15:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so251085pfi.12;
        Wed, 03 Apr 2019 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Az05Byjbi39gVeSPN+5P1P1OUjZcYnTpOvK2uoHmEew=;
        b=rU2rpH7SvSZZsZ54XP17p96C+GO5K/ho/tkDrSKL7+GXjVDlW6DamcmJyGowaKgx6H
         0rgqdkf3RhQUeEk5D2h4qqRjphSSjhBa9+mSSlycJ7pbMfXOl+33pNhECgtJaZAHMeur
         EF/acj+7oLvDBqoEex2htmZqEl+TvAYCBD4d0Fs874XOyN7fKJsZnh3f7Xey5QwOadXV
         pe+IbhoIeKFGlGGlXYNf8yV9XD+jaoLMFQ0kKvOawqvwK0Z4X1mED/6zyY4x+WFyWFuN
         rygPHXSoQdnbULguBPjzGlU3f8g4R9RGhkjNz5lW9y58OXABen8cl6qz04nhS1AfB/XA
         Z6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Az05Byjbi39gVeSPN+5P1P1OUjZcYnTpOvK2uoHmEew=;
        b=sZgKBIYieMtbNfTznAGbjbWXAGBrJRE8ujR6d58ViCuvdsKgvSrd9L4xUYOyQ4OeBC
         +hVB5G27O+8BK961Pyz0ym43socX+xiOXQGB/3/MEp7mzHndgRLxRIV/vUe3r1ZeFcW9
         DOqerO0B4rWTKVNqumnpofVjt6mkqUdsD+d5oG6x7HfpaApQoa7UPX4BiB+D49Li57+a
         7AtHQZeDf/db8pywF6A3KAoiem8w2EfBWw0mt7ZGHzjy/u1CtZFQ7+QxaxXgxB9uRTic
         r7+KhXinVaQqHwM7M0mZLpEhCebCMxTuTJH0VAIaU7QT1vfMH0V7y+S4Gy4+IHvxuLKQ
         T9FA==
X-Gm-Message-State: APjAAAVjaUbK1r28eMVpK20RKLrKJtOp2CgjXqC+fhUSet6UwCtHveG8
        +8ivwIicBB5L8q7kv8aPP1mwb7nP
X-Google-Smtp-Source: APXvYqx8m/DVOiCjdB4tXZ4wftBpFjX+ybY85F7WbxRLtp8MG2e7iL6kmTvT833eJr41Nl12oMCGpQ==
X-Received: by 2002:aa7:864a:: with SMTP id a10mr1950530pfo.181.1554329731231;
        Wed, 03 Apr 2019 15:15:31 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s79sm47845105pfa.31.2019.04.03.15.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 15:15:30 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:15:28 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] input: keyboard: snvs: initialize necessary driver
 data before enabling IRQ
Message-ID: <20190403221528.GE53104@dtor-ws>
References: <1553666514-21505-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553666514-21505-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 06:07:06AM +0000, Anson Huang wrote:
> SNVS IRQ is requested before necessary driver data initialized,
> if there is a pending IRQ during driver probe phase, kernel
> NULL pointer panic will occur in IRQ handler. To avoid such
> scenario, just initialize necessary driver data before enabling
> IRQ. This patch is inspired by NXP's internal kernel tree.
> 
> Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thank you.

> ---
> Changes since V1:
> 	- move the platform data initialization to before IRQ enable instead of moving the IRQ enable
> 	  to the end of probe function.
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index effb632..4c67cf3 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -148,6 +148,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> +	pdata->input = input;
> +	platform_set_drvdata(pdev, pdata);
> +
>  	error = devm_request_irq(&pdev->dev, pdata->irq,
>  			       imx_snvs_pwrkey_interrupt,
>  			       0, pdev->name, pdev);
> @@ -163,9 +166,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> -	pdata->input = input;
> -	platform_set_drvdata(pdev, pdata);
> -
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);
>  
>  	return 0;
> -- 
> 2.7.4
> 

-- 
Dmitry
