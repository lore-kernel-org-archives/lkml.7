Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7E8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F7C21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMzj0MJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393195AbfJYIuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:50:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51431 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfJYIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:50:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id q70so1175536wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lRw/HB9cs0P4tEenIW1OQJEsVhGUoZlMNerElFOWtvc=;
        b=sMzj0MJ9/h1HCNuIsf7Rz6+lrrL0m4lFXm8/9rU9bydl0zwMq0ka2eToPYJumIYt41
         kH46+4jayoge4n3So13+aPBWLad3P8wt8qF20bx3WR2GaUrQ2HWy0/Ux6gY89YE/iJCs
         Nbcx0WiYZthyflzw79Ps7ISbGS+UsqPpfJW4dybIookg6K/mYmPywjPYb6ZUqu+d5YXD
         vlCi8jSBK06+hHFYroazF17Fsoenpc0TCDxc5Bk79IYaD59BMVSvl9SFNnvN30WfBqN0
         Zc8Ki1M00LMpSec+ZGL9Lbobi3+5oLupSvxMcy8Sueu7D4pUFaTudee+8UwVjYrz9tTI
         dC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lRw/HB9cs0P4tEenIW1OQJEsVhGUoZlMNerElFOWtvc=;
        b=dgyJeIKnGzOsu9hGUb3lSPk/MBp11QZEX5JETU9+kkssIiM9kssizbH5I0RHAfPB5/
         2TtdOovYqrzKL3xROBBCrgXZjURAmR1QO7GEulXfmE9byJqadmO8Gg/vBXFhyGPm9MSx
         9c8lzWfb0K9L7OzR9NDwUDtUWWRZr7GeBfRUIf/gLugcr2fvpKSTSNN0dRnbWZkeZyXb
         6ny18IbTyiarNx9cBqag4bnT08QE0UxEbAxKQsGmtN6qbQ0bT2J5SV10CRN64hselbmi
         1I7GE1lZU4Lg2+sUW1bPe/9x02iDXIigjzzJOmYFhJTrWo734blN2Dh/EuZLbiL34+h+
         qHnw==
X-Gm-Message-State: APjAAAVGJEIeHGKXFc9X8Ie0tDjvbjkEMwfUilFdipSTcW81r8a0U/1/
        +pqts2PV3LhGz+1xfcO4qoJpwQ==
X-Google-Smtp-Source: APXvYqyVNCUwL+zbMIQYijH0nGElvkNZYDgn3r2MdehDdUtgyhppVljV36JwyibkLIy+VZvozzobaw==
X-Received: by 2002:a1c:6702:: with SMTP id b2mr2287107wmc.107.1571993419746;
        Fri, 25 Oct 2019 01:50:19 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f8sm1339404wmb.37.2019.10.25.01.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:50:19 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:50:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v3 03/10] mfd: cs5535-mfd: Request shared IO regions
 centrally
Message-ID: <20191025085017.46bdt6kc6zfoda4g@holly.lan>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-4-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:38:25PM +0100, Lee Jones wrote:
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
> ---
>  drivers/mfd/cs5535-mfd.c | 71 +++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index b35f1efa01f6..27fa8fa1ec9b 100644
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

I agree cs5535-acpi isn't used is the kernel but I think it stills
fails a w.t.f. per minute test to have a mismatch between when
a device is added and when it requests resources.

Especially since I don't think this is transient within the patch
series.


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
> @@ -141,6 +128,8 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  static void cs5535_mfd_remove(struct pci_dev *pdev)
>  {
>  	mfd_remove_devices(&pdev->dev);
> +	pci_release_region(pdev, ACPI_BAR);

This will issue a warning if !machine_is_olpc() .

For the release region family of calls "the described resource region
must match a currently busy region."


Daniel.
