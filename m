Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D96CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E190121D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpHNFF6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394358AbfJRQGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:06:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52358 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfJRQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:06:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so6758026wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oHAE10EktnPOoE/+c84l9YTUjXRghji4T7W4SFCNp1E=;
        b=SpHNFF6AuB9nbvorwHz1NPDQGPyA5QEAi+SaVBWB/ZEM8nCNIUC1b1kw74uVYZPj1r
         RAeHyDYh19zzMHflkvWMWRIuJ5slQapPu10XslSLSqVtsthQGRCuIzORgk2DamDFgRnP
         huXopPO79qkWyBvwCGydLsRA6xfRxfqb7nmAWw1zbD4yv8jmu9zLQB8kOT/BRmL6x63y
         vxGi8st5rytavEcUBYR+Ylp2TRzLFTUwti9KR10q+YLbbSunzKNTsnt0ePUR4QTdjdIE
         iAJXNjHqgF8qhL1/ESTCDoOfWodoWGxV9FIe7LG9jBkWq05mN58EJCVlSFTWUq5wrnAo
         gpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oHAE10EktnPOoE/+c84l9YTUjXRghji4T7W4SFCNp1E=;
        b=fdcCx8SWLSYQeNQM2lRFmSVOS5cC1gkqVU+ZRkzVQvXLaMF/aUgyYwtJpw+9ET68PZ
         HblvoPwfh6xZWm/d3PqsFwoJVxxsXZjVlJqnGNn5tJhksaS0wtkWIFzxQJBSDocgjlvk
         GB1mQKIaUAANHPB+QJFODA6fjyB9+vVr32nRhV/sKN9cVLcq5ZSU7Htio8xiB+dOPpma
         wXbOepKq5IPifhaWun5ltb7DmN/+1jW78emjYHS+EtlU0wIdfN8LsK8yOyqFoeN7SglB
         KDYBN23AWCVhws8jHYrFA/N1CNWHTD7WdKzFs+AoBT40NvzZhS5mUTEGHGUa6HB/xffI
         R8ug==
X-Gm-Message-State: APjAAAX0j4e0LenhdFASEO6mXy2BIbl0qFOpELeom9KCAzdFpfeH7Iz2
        GdQpAVCot37JbRYIs7QG12GDSg==
X-Google-Smtp-Source: APXvYqxRumX3eY6AHsUEC/o5rl4dqf9DY80FPCLCWDYduYYilpMUolht6vRsw3UkTL3A4wl0iUD4zg==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr7895964wmc.132.1571414799007;
        Fri, 18 Oct 2019 09:06:39 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s9sm6622703wme.36.2019.10.18.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:06:37 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:06:36 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linus.walleij@linaro.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dilinger@queued.net
Subject: Re: [PATCH 3/4] mfd: cs5535-mfd: Register clients using their own
 dedicated MFD cell entries
Message-ID: <20191018160636.pt4im3m3hlruobms@holly.lan>
References: <20191018125608.5362-1-lee.jones@linaro.org>
 <20191018125608.5362-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018125608.5362-4-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:56:07PM +0100, Lee Jones wrote:
> CS5535 is the only user of mfd_clone_cell().  It makes more sense to
> register child devices in the traditional way and remove the quite
> bespoke mfd_clone_cell() call from the MFD API.

Like the other thread... this looks like it takes a shared (cloned)
reference counter and creates two independant ones instead.


Daniel.

> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/cs5535-mfd.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index b01e5bb4ed03..2711e6e42742 100644
> --- a/drivers/mfd/cs5535-mfd.c
> +++ b/drivers/mfd/cs5535-mfd.c
> @@ -95,9 +95,23 @@ static struct mfd_cell cs5535_mfd_cells[] = {
>  	},
>  };
>  
> -static const char *olpc_acpi_clones[] = {
> -	"olpc-xo1-pm-acpi",
> -	"olpc-xo1-sci-acpi"
> +static struct mfd_cell cs5535_olpc_mfd_cells[] = {
> +	{
> +		.name = "olpc-xo1-pm-acpi",
> +		.num_resources = 1,
> +		.resources = &cs5535_mfd_resources[ACPI_BAR],
> +
> +		.enable = cs5535_mfd_res_enable,
> +		.disable = cs5535_mfd_res_disable,
> +	},
> +	{
> +		.name = "olpc-xo1-sci-acpi",
> +		.num_resources = 1,
> +		.resources = &cs5535_mfd_resources[ACPI_BAR],
> +
> +		.enable = cs5535_mfd_res_enable,
> +		.disable = cs5535_mfd_res_disable,
> +	},
>  };
>  
>  static int cs5535_mfd_probe(struct pci_dev *pdev,
> @@ -130,8 +144,18 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  		goto err_disable;
>  	}
>  
> -	if (machine_is_olpc())
> -		mfd_clone_cell("cs5535-acpi", olpc_acpi_clones, ARRAY_SIZE(olpc_acpi_clones));
> +	if (machine_is_olpc()) {
> +		err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +				      cs5535_olpc_mfd_cells,
> +				      ARRAY_SIZE(cs5535_olpc_mfd_cells),
> +				      NULL, 0, NULL);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to add CS5532 OLPC sub-devices: %d\n",
> +				err);
> +			goto err_disable;
> +		}
> +	}
>  
>  	dev_info(&pdev->dev, "%zu devices registered.\n",
>  			ARRAY_SIZE(cs5535_mfd_cells));
> -- 
> 2.17.1
> 
