Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B26C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1C620882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXazteTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDCWQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:16:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45561 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDCWQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:16:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so80370plb.12;
        Wed, 03 Apr 2019 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qWogcakmliCnWA6g1zXhbplYsTnHQEuiNfytwIqmhw0=;
        b=tXazteTczgZ4b6Zb8BhHzvbVtwlbbNu4aL13+3OucVP0LsI1dLY81yJ9MPY08NovYx
         hRhV/vtVXvUbfEiEdPKjtrTOqN3iY45Ww13nfPB7otTMm/N1LVEBItYjGXK643sJ34rA
         T/Py2OauFYUlyeiKIBMkcKU8e0Pnrap6OhWRUWxYu9SHxByUIz+LhDprzgBRsIb/LQ/h
         xUH7IpiGIIryRIiZ0U092XMojrXJGYWHm7O1AHBkD69HBjE/rj6vuS0YUnVxpVTquI7U
         Nc7MEjYQ1OQOZLImZTn0eI00OJn35js1e8Gj/W4AHZRa4o5lGqis3yCNxRW+apzC1+tT
         io+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qWogcakmliCnWA6g1zXhbplYsTnHQEuiNfytwIqmhw0=;
        b=jbj9QIyYZXwQHFSAN/oHVTDnbl4c5PWZtXyVIqCwtyJrmqIbb4CkyJoSpqSdgi7iKV
         VUwvOVNBkOCqMJSfEvWlimzk3NH9H9zcsjK4RX/2I0QO+ULWYMRX0Rwo4MAIbioEL/Dd
         2G2VFcLEFbzJFeVxGQFGBVPT5d8mlYy8P8HLVi2yPkjjiw3WIAds8zs4oVmgCRnEKwKV
         E47Lj0qaWYg3OS6lrPezeEv1E2BFSOltyHIrJ6qa73qJ95ogWuz/Rgf53V+mzcnDMbtl
         HZEyuOJz83JWVmI4OVWVzheeBgPFn4pnUH0v0SajZBRw50LShkiC0TiS9fuaJLt2A5m+
         /RJg==
X-Gm-Message-State: APjAAAVqgLHhn51d50iQsr6ZGD2zO24zhYAAXonVkKamS/bNfh3yuyk0
        Kr2PqQ6YsVVqmuCzBElRTPE=
X-Google-Smtp-Source: APXvYqymrSyQX3XHMm0QmoQHSr6bHP9NMOTCCcZBhGgee+gvqXKIh/aFFAPIAOIPttHpBCZABEN2DQ==
X-Received: by 2002:a17:902:ba88:: with SMTP id k8mr2593113pls.268.1554329804443;
        Wed, 03 Apr 2019 15:16:44 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o76sm48644836pfa.156.2019.04.03.15.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 15:16:43 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:16:42 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] input: keyboard: snvs: use dev_pm_set_wake_irq() to
 simplify code
Message-ID: <20190403221642.GF53104@dtor-ws>
References: <1553666576-21621-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553666576-21621-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 06:08:05AM +0000, Anson Huang wrote:
> With calling dev_pm_set_wake_irq() to set SNVS ON/OFF button
> as wakeup source for suspend, generic wake irq mechanism
> will automatically enable it as wakeup source when suspend,
> then the enable_irq_wake()/disable_irq_wake() can be removed
> in suspend/resume callback, it simplifies the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 4c67cf3..5342d8d 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  
> @@ -167,28 +168,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	}
>  
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> -
> -	if (device_may_wakeup(&pdev->dev))
> -		enable_irq_wake(pdata->irq);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> -
> -	if (device_may_wakeup(&pdev->dev))
> -		disable_irq_wake(pdata->irq);
> +	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +	if (error)
> +		dev_err(&pdev->dev, "irq wake enable failed.\n");
>  
>  	return 0;
>  }
> @@ -199,13 +181,9 @@ static const struct of_device_id imx_snvs_pwrkey_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, imx_snvs_pwrkey_ids);
>  
> -static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops, imx_snvs_pwrkey_suspend,
> -				imx_snvs_pwrkey_resume);
> -
>  static struct platform_driver imx_snvs_pwrkey_driver = {
>  	.driver = {
>  		.name = "snvs_pwrkey",
> -		.pm     = &imx_snvs_pwrkey_pm_ops,
>  		.of_match_table = imx_snvs_pwrkey_ids,
>  	},
>  	.probe = imx_snvs_pwrkey_probe,
> -- 
> 2.7.4
> 

-- 
Dmitry
