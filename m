Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D363ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C93C205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzSgG/7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfJUM0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:26:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45454 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfJUM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:26:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so8774899wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qHVBYXsOO6hKuBWHsZEA4hqDK5PM7Cy9mG1hG95G+Fo=;
        b=YzSgG/7cGg5JlIO32eJye07LN/sVpd2NLEKr455bPImBsMOgQeP7sD0kkGc330R5hV
         jBwtzVRPQ3GWUGUNAxtaFO1uDNKdwUHhj00jIcbKxdjIQevX4RoKWf8JMqt9v7DtQyMF
         PTnrV8GfhzXM2ivArGXzKOXgctwP+cwNFvDxqvwJO/NLmknme0vvhaL0aFmv8730fsDk
         +Gi0UjX2OvA3cUOWlqTTeK3vADkdRv60eWE+mWp5QIKeIweJebdcmbU28oQRnvPVCIMq
         cid3PRPyq8uIjntF5zNf9alIUKoRszqZpdnVOFR6qjhcHfPyzCH3ndKGZFm/TtAFP+25
         UCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHVBYXsOO6hKuBWHsZEA4hqDK5PM7Cy9mG1hG95G+Fo=;
        b=jAI408oCV4+vjy8ERA37t1/HWk9pJAVUtmflNVMh98Km2u/uo42bsFqyNVoIiJdTsA
         t7BykvFYG6NsjJNmhOc8UWmnIxrxEnNkJz2wJirEHR6DX7KceBader4y2IF2UfJrICfv
         JN8JRIuChuI4jP2moQ3BGUKL2GmKyg90csg+G/z7til4++66MrOR94OaMXMypgg63Poe
         UfZXnDo9nwL5ndNZUN89jVpQgEBsYCK3DJVT/lX45gTXjnAYJnZFXg6XFHz4PKbkFvNl
         DaPg5udZkmFiMsbrg6apyYyYD9uiJd8KCO1m5xwLnRVrHoxqGp8ZGBSOaE7dLwZpvdCR
         bwfg==
X-Gm-Message-State: APjAAAUIKUGOtPOUbkzOQCTYgx+oZqHUbW+/nEVfe75s8NjW3rVFxVn4
        pG1EFRjSxQNLXeN7RBHaSUQa9A==
X-Google-Smtp-Source: APXvYqznawhtnnwpuBdog7pKe5gZ4rlqUbhqGD143d++D+Qqgj93ohS2ObHSBqr409thEWRRKDYxtw==
X-Received: by 2002:adf:e64f:: with SMTP id b15mr6699855wrn.372.1571660769331;
        Mon, 21 Oct 2019 05:26:09 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z1sm14789929wrn.57.2019.10.21.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:26:08 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:26:06 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 3/9] mfd: cs5535-mfd: Request shared IO regions
 centrally
Message-ID: <20191021122606.5q22j6wtyslwljco@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-4-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:16AM +0100, Lee Jones wrote:
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
>  drivers/mfd/cs5535-mfd.c | 72 +++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index 9ce6bbcdbda1..053e33447808 100644
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
>  	[ACPI_BAR] = {
>  		.name = "cs5535-acpi",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[ACPI_BAR],
> -
> -		.enable = cs5535_mfd_res_enable,
> -		.disable = cs5535_mfd_res_disable,
>  	},
>  };
>  
> @@ -109,7 +71,6 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  	if (err)
>  		return err;
>  
> -	/* fill in IO range for each cell; subdrivers handle the region */
>  	for (i = 0; i < NR_BARS; i++) {
>  		struct mfd_cell *cell = &cs5535_mfd_cells[i];
>  		struct resource *r = &cs5535_mfd_resources[i];
> @@ -122,22 +83,47 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  		r->end = pci_resource_end(pdev, i);
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
>  			"Failed to add CS5532 sub-devices: %d\n", err);
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

Making the request_region() conditional on machine_is_olpc() seems to be
best on the assumption that the cs5535-acpi is not otherwise used.

I suspect the assumption is true but you have to combine knowledge from
several bits of code to figure that out.


Daniel.


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
> @@ -145,6 +131,8 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  
>  static void cs5535_mfd_remove(struct pci_dev *pdev)
>  {
> +	pci_release_region(pdev, PMS_BAR);
> +	pci_release_region(pdev, ACPI_BAR);
>  	mfd_remove_devices(&pdev->dev);
>  	pci_disable_device(pdev);
>  }
> -- 
> 2.17.1
> 
