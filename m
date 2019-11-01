Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF306CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A559A21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/symlXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfKAICE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:02:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36822 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKAICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:02:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so8285109wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WwG4RNOHvFkOsKEQAuSUlL4bFdysEsHDNGpaWR/Pat0=;
        b=S/symlXrnyXbV1Hv4N/GknnDwdxNxfdAmVeZAKQWJn34mc1nhmrnlQs85nwSBGvkwL
         YNMZGZ7N5SDuQkQb/7Y6V+470SFCP6zuBobyPpjFUYuHhi6PueWQaPseVM/0KJRYl4Ds
         OSRSiJZxTu0xp0XE3ITDXvUYdhd/G2eMC6OjgyLR5BgPenPusZfTZw9q7p1z6tjTiT17
         2HTp89XVF1SlvEY0u+iMvSXmyFNTyjwRYxCs/Fw4r5pDG3aWT/nsxWIvsq3EhIap8PmK
         IjfT0GEo9rkv8elPYVLbO22e46RHYghbr0Frz7Zdlbxxh9YXvwIm5Zkd/QPQ/KWbo2u0
         a18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WwG4RNOHvFkOsKEQAuSUlL4bFdysEsHDNGpaWR/Pat0=;
        b=ARQ8Ldh9NRmUUBG2l1Y1YfhFyAfEsZIsFhlVZoTy/g/4G4uCNu8StKZvpS+43JCAkF
         70mA7wmsQmUa/0J1GouAzlqbb67nMAoA4tKwQe/xw84nOmwm2RpHSE1XsZwQijG/AK06
         yZHhbT/yFg+MJLlLK804KDukAGXrfuuGHkwsdxfbqryYSsnoUjtxztnmqIagq62ki+5S
         ZvkMQ4bOsJ0vrpk/+us6ju1CdNcbQo1Ums4hSp/2AAfxSwf4kUTPMfrrHVNeAgWTSOYs
         t7xzi0/ZH3lZ0VVJIg1nKn21/eye+vMykYYAnzCR9b8tCwcjFvQXEuJhunV858y6k9mP
         bQKg==
X-Gm-Message-State: APjAAAU7x4iQydiBxQJ9HVd01jkEuBwSMIiu+LaL5q9MTF5kkEv8c4jb
        HC4iEa2Fqx5ES7NNYNFLAKXuUg==
X-Google-Smtp-Source: APXvYqzAu9rjXRQJt17v4CuXCsldu15N/gdJvnPJsgnG1YrRx55OmuZHRv1YBOicGoG7XtVA35wNIQ==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr8235809wmg.148.1572595319436;
        Fri, 01 Nov 2019 01:01:59 -0700 (PDT)
Received: from pine ([185.204.209.109])
        by smtp.gmail.com with ESMTPSA id u1sm4977950wrp.56.2019.11.01.01.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 01:01:58 -0700 (PDT)
Date:   Fri, 1 Nov 2019 09:01:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        linus.walleij@linaro.org, baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v4 03/10] mfd: cs5535-mfd: Request shared IO regions
 centrally
Message-ID: <20191101080153.bvws43z2n6gsjnym@pine>
References: <20191101074518.26228-1-lee.jones@linaro.org>
 <20191101074518.26228-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101074518.26228-4-lee.jones@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 07:45:11AM +0000, Lee Jones wrote:
> Prior to this patch, IO regions were requested via an MFD subsytem-level
> .enable() call-back and similarly released by a .disable() call-back.
> Double requests/releases were avoided by a centrally handled usage count
> mechanism.
> 
> This complexity can all be avoided by handling IO regions only once during
> .probe() and .remove() of the parent device.  Since this is the only
> legitimate user of the aforementioned usage count mechanism, this patch
> will allow it to be removed from MFD core in subsequent steps.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/mfd/cs5535-mfd.c | 74 ++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index b35f1efa01f6..3b569b231510 100644
> --- a/drivers/mfd/cs5535-mfd.c
> +++ b/drivers/mfd/cs5535-mfd.c
> @@ -27,38 +27,6 @@ enum cs5535_mfd_bars {
>  	NR_BARS,
>  };
>  
> -static int cs5535_mfd_res_enable(struct platform_device *pdev)
> -{
> -	struct resource *res;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "can't fetch device resource info\n");
> -		return -EIO;
> -	}
> -
> -	if (!request_region(res->start, resource_size(res), DRV_NAME)) {
> -		dev_err(&pdev->dev, "can't request region\n");
> -		return -EIO;
> -	}
> -
> -	return 0;
> -}
> -
> -static int cs5535_mfd_res_disable(struct platform_device *pdev)
> -{
> -	struct resource *res;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "can't fetch device resource info\n");
> -		return -EIO;
> -	}
> -
> -	release_region(res->start, resource_size(res));
> -	return 0;
> -}
> -
>  static struct resource cs5535_mfd_resources[NR_BARS];
>  
>  static struct mfd_cell cs5535_mfd_cells[] = {
> @@ -81,17 +49,11 @@ static struct mfd_cell cs5535_mfd_cells[] = {
>  		.name = "cs5535-pms",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[PMS_BAR],
> -
> -		.enable = cs5535_mfd_res_enable,
> -		.disable = cs5535_mfd_res_disable,
>  	},
>  	{
>  		.name = "cs5535-acpi",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[ACPI_BAR],
> -
> -		.enable = cs5535_mfd_res_enable,
> -		.disable = cs5535_mfd_res_disable,
>  	},
>  };
>  
> @@ -117,22 +79,47 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  		r->end = pci_resource_end(pdev, bar);
>  	}
>  
> +	err = pci_request_region(pdev, PMS_BAR, DRV_NAME);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to request PMS_BAR's IO region\n");
> +		goto err_disable;
> +	}
> +
>  	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
>  			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"Failed to add CS5535 sub-devices: %d\n", err);
> -		goto err_disable;
> +		goto err_release_pms;
>  	}
>  
> -	if (machine_is_olpc())
> -		mfd_clone_cell("cs5535-acpi", olpc_acpi_clones, ARRAY_SIZE(olpc_acpi_clones));
> +	if (machine_is_olpc()) {
> +		err = pci_request_region(pdev, ACPI_BAR, DRV_NAME);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to request ACPI_BAR's IO region\n");
> +			goto err_remove_devices;
> +		}
> +
> +		err = mfd_clone_cell("cs5535-acpi", olpc_acpi_clones,
> +				     ARRAY_SIZE(olpc_acpi_clones));
> +		if (err) {
> +			dev_err(&pdev->dev, "Failed to clone MFD cell\n");
> +			goto err_release_acpi;
> +		}
> +	}
>  
>  	dev_info(&pdev->dev, "%zu devices registered.\n",
>  			ARRAY_SIZE(cs5535_mfd_cells));
>  
>  	return 0;
>  
> +err_release_acpi:
> +	pci_release_region(pdev, ACPI_BAR);
> +err_remove_devices:
> +	mfd_remove_devices(&pdev->dev);
> +err_release_pms:
> +	pci_release_region(pdev, PMS_BAR);
>  err_disable:
>  	pci_disable_device(pdev);
>  	return err;
> @@ -141,6 +128,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  static void cs5535_mfd_remove(struct pci_dev *pdev)
>  {
>  	mfd_remove_devices(&pdev->dev);
> +
> +	if (machine_is_olpc())
> +		pci_release_region(pdev, ACPI_BAR);
> +
> +	pci_release_region(pdev, PMS_BAR);
>  	pci_disable_device(pdev);
>  }
>  
> -- 
> 2.17.1
> 
