Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72291CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4617520659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fg+EZ8rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfJUM33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:29:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36605 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfJUM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:29:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id c22so3483589wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Bp8/Rt3sh+Dp54MmRulppkSlI3E35h5lLEu1NL/66s=;
        b=fg+EZ8rR6zQ3vBZkhEVTMSJIkRWVW81aPPY4whM0f85iUyAYYOdFB/Zlwa2IAdEeCe
         ab0iT+Taos9nYLyyrI3j3p3A269hUMedsQAmi/WkWVNLNbF+ovtsmMOFJdM7oPG0kX44
         HoLGCvc36n6D1UzBl1e4+EVcvtdF82Kic5pDSs7TKv+UWhax298piQMnJAKjdhPSNpNt
         u1yVwqWGzJxwNRSARVsdpIihgIJd6biiBL0XhfgL0Q6ofRhTIRPEt34P7v1GrImyAAPD
         IHEx0dd7OIBt7XB3pH05mvDopQ1vK3+bFG1NQr7+IO2/IUFlfHjo7NcDyJ1pkgSz+NDN
         RZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Bp8/Rt3sh+Dp54MmRulppkSlI3E35h5lLEu1NL/66s=;
        b=intc61kzUSlPHwLNEFPOqBzKV1FxR0AN57iCdzBh909r0D504N62TmDAeg3Isq0NWx
         Y6hRJ3nj8Ur8BE62e5SAVomIMe5TZnttvA3r3ydPYRE5BXNJADqaBdKmrCSw5lHTjj6n
         jjiIdLDb9r4rb8YQUDT7fawy/4tSO5LHbZL4ZWfJe1jRhxLQSih2oN698d4RI30BFCFI
         xRnxw4D6SQ4h3zXdwjxTzTBCLskJvliXTujg8XhneoPOK2tadF8MWA1nnPlfIjdPfa+k
         wUrIwzHxKCR2veJQfgh8EO0ORS9gTWV9mcu+QtKJgjNzUcIVUckS5oRSy1w7Qzn8Iuo2
         hz3w==
X-Gm-Message-State: APjAAAWTrHtMlxhdM7fuDWtJJD29JVMFilwPti/tk8E9AEYPjkLz7wu0
        WVmEtZeRoqEBfopKj3ZfkHosuw==
X-Google-Smtp-Source: APXvYqzINJ2+DBcQWI5LwLEFqSjji3k+FiqUhAU7wr8KOGRZc9tTARTg8q11xDs6VViDPVgwQwaOHA==
X-Received: by 2002:a1c:9894:: with SMTP id a142mr18467038wme.70.1571660966800;
        Mon, 21 Oct 2019 05:29:26 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id p20sm9987618wmc.23.2019.10.21.05.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:29:26 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:29:24 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 4/9] mfd: cs5535-mfd: Register clients using their own
 dedicated MFD cell entries
Message-ID: <20191021122924.qmaio5oe5j66tfdj@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-5-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:17AM +0100, Lee Jones wrote:
> CS5535 is the only user of mfd_clone_cell().  It makes more sense to
> register child devices in the traditional way and remove the quite
> bespoke mfd_clone_cell() call from the MFD API.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/cs5535-mfd.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index 053e33447808..96a99ac13384 100644
> --- a/drivers/mfd/cs5535-mfd.c
> +++ b/drivers/mfd/cs5535-mfd.c
> @@ -57,9 +57,17 @@ static struct mfd_cell cs5535_mfd_cells[] = {
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
> +	},
> +	{
> +		.name = "olpc-xo1-sci-acpi",
> +		.num_resources = 1,
> +		.resources = &cs5535_mfd_resources[ACPI_BAR],
> +	},

Is the cs5535-acpi cell actually used by anything? I think it was only
ever used as a template and can be removed; I didn't spot any driver that
uses it.

PS If the cell were removed then my review comment on the previous patch
   becomes moot ;-)


>  };
>  
>  static int cs5535_mfd_probe(struct pci_dev *pdev,
> @@ -105,10 +113,14 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  			goto err_remove_devices;
>  		}
>  
> -		err = mfd_clone_cell("cs5535-acpi", olpc_acpi_clones,
> -				     ARRAY_SIZE(olpc_acpi_clones));
> +		err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +				      cs5535_olpc_mfd_cells,
> +				      ARRAY_SIZE(cs5535_olpc_mfd_cells),
> +				      NULL, 0, NULL);
>  		if (err) {
> -			dev_err(&pdev->dev, "Failed to clone MFD cell\n");
> +			dev_err(&pdev->dev,
> +				"Failed to add CS5532 OLPC sub-devices: %d\n",
> +				err);
>  			goto err_release_acpi;
>  		}
>  	}
> -- 
> 2.17.1
> 
