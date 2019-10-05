Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B1C32792
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C3B207FF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqyMZ2Ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfJEELY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 00:11:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40363 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfJEELX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 00:11:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so4054220pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 21:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t0KK5kDc3BGvKYa9NLsd7g6q4Th9UgAo7OcVPXPPYO4=;
        b=dqyMZ2FtDdESvf1uGmYhkStDK+KlEYZpOVgofMrfaOM4jUYKePjP9qYp3llBEX5UhS
         NySHtjJSP7Qpp7I2GGdFis+TE7L10nvOeImksy/suvcWAJeB9JhiwKP190GWrRr0eEa3
         5s91lgT4qdRXTaaKOTjLOmpxoiPJdpJAm7mxCHcPIAVaMkROMpCL656h9Al41tGZUU7e
         2PFkd9eGF4FnKxovQ0rHEG9xAzCNJBjyOyAu6b8vcE3l8E8GyYO9seW/vJJCa7U4dmtv
         Lisfe3A0yM6cd5Gjh8HhlP65jOXPdXHUv4Yw379hErm77/HVNVov22uDZJJrBzaLFzdW
         EEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t0KK5kDc3BGvKYa9NLsd7g6q4Th9UgAo7OcVPXPPYO4=;
        b=BOgpuilveubrs48GesWWd3hXoHEEFeaMASMtz3iCcvc2ZLtAGYzwp7nKl7jM2l5etV
         qK5e9bPxVmCge7J/1qTgLE31ByGYO8b6rsuYamtcTrIaW/rM5m/Gv6sNXuhj3K0OTgXf
         A75+3e0VjRxMlL1H1rVGOjlGg37euexzctMU5Ky7el9C1njSP08lArmK8eic52B0QiwT
         ISmIVesTiIBEcerUUovnNCBWM23yW9Ne+hl7Jl6H2H9Ugh+Ih1W3QFWv/Jh5BqOzJv2h
         2xj+gxxeFnRf/Dzy//nTX93mqPqFdKmkSX2eAez7OJJrg+dU+3hCc/ItUDM1MZNSZaHe
         YzUQ==
X-Gm-Message-State: APjAAAV3InEr73aH3aVOA/jtt8L7RpXNVl/S5qru1XNhxCNoAzfD0FAi
        nWriBmA3jft+JV+fOwZvMsCOYg==
X-Google-Smtp-Source: APXvYqzJ5RoSNwhtxPC9J1Ys7yTYGq1XbNqiQf5PeMcJF90tciZpgcs207IUEEzj0IhsIGfGbX10kQ==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr17251748pls.99.1570248683083;
        Fri, 04 Oct 2019 21:11:23 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y15sm7989127pfp.111.2019.10.04.21.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 21:11:22 -0700 (PDT)
Date:   Fri, 4 Oct 2019 21:11:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     ohad@wizery.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] hwspinlock: sprd: Use devm_hwspin_lock_register() to
 register hwlock controller
Message-ID: <20191005041120.GD5189@tuxbook-pro>
References: <cover.1569567749.git.baolin.wang@linaro.org>
 <e8f1db04571f62298c7a4f72be803b9b9974d12d.1569567749.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f1db04571f62298c7a4f72be803b9b9974d12d.1569567749.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Sep 00:10 PDT 2019, Baolin Wang wrote:

> Use devm_hwspin_lock_register() to register the hwlock controller instead of
> unregistering the hwlock controller explicitly when removing the device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Thanks Baolin, series applied.

Regards,
Bjorn

> ---
>  drivers/hwspinlock/sprd_hwspinlock.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
> index e76c702..44d69db 100644
> --- a/drivers/hwspinlock/sprd_hwspinlock.c
> +++ b/drivers/hwspinlock/sprd_hwspinlock.c
> @@ -135,8 +135,9 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, sprd_hwlock);
>  	pm_runtime_enable(&pdev->dev);
>  
> -	ret = hwspin_lock_register(&sprd_hwlock->bank, &pdev->dev,
> -				   &sprd_hwspinlock_ops, 0, SPRD_HWLOCKS_NUM);
> +	ret = devm_hwspin_lock_register(&pdev->dev, &sprd_hwlock->bank,
> +					&sprd_hwspinlock_ops, 0,
> +					SPRD_HWLOCKS_NUM);
>  	if (ret) {
>  		pm_runtime_disable(&pdev->dev);
>  		return ret;
> @@ -147,9 +148,6 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
>  
>  static int sprd_hwspinlock_remove(struct platform_device *pdev)
>  {
> -	struct sprd_hwspinlock_dev *sprd_hwlock = platform_get_drvdata(pdev);
> -
> -	hwspin_lock_unregister(&sprd_hwlock->bank);
>  	pm_runtime_disable(&pdev->dev);
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 
