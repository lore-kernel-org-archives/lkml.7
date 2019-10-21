Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911CCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242B12089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HE5jNR0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfJUMqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:46:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36829 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfJUMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:46:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id c22so3544712wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oxlugiViiQE3cSKhufhby1ti8KNom5JSbs6PQgpr2f4=;
        b=HE5jNR0m/8rCwUemPzMdlN05lJ+BtFDbrnxh1nyjX6n4kA0QGZCHW0p8ybDWYI2Fyl
         SSW3rtr0Xx8IOJ7EmV6C1jYIWURaAevNwN+YRk+XxTvVLNomfz1+tTejV7v4yv2zddpq
         5LztFvZNYJHd/rTBr1EXQ3ZM/5kG25+ixWmEwz2o9x54YrmW5P+JlketwitxX/0rxG1B
         0IKlkOgXQoZ1eqKUQ1zL4WjlcOIGRb6Lqp+2GNbadLJjTRccTE5jIe1ompVqCxVHAPlh
         G2NSWukRHIGZYd4GXkcmWePz/hzTZfrF6yRAIS5f3gDiEI6us0xiNDRFYf4s+AExOzIf
         py1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oxlugiViiQE3cSKhufhby1ti8KNom5JSbs6PQgpr2f4=;
        b=IDhavDuSdDQrsw9QnNA7Lcul5LKGMVnPdrU/omKcnO+KxMeqQq+j6pIidfxSgz92GZ
         WQgKkqtBegI3ySHhB26C3RS5bg6D6ghEq7Bo65aXIbtgwwqdyPC1jFNJhblihmm6mj+m
         IvMa9mBDgY709FqS4ll2XfI8TF1R3jPgpO8g6RelK6AGVW1LPYmIvhbW8NQ0RS7z1Cfj
         p/BlSaVgLZh+s7LYF+Rtdfd9c2PoHz4fpljI2LGxMDfvkDIsXc74l0HK6i6cQXP+/CiH
         4x/WldMaUlnVC4ulDKPBTjPyFQpo5FzBV4UCqvi1Vr/46jRrwWhud4jffuP9fMxgHsY9
         TTbQ==
X-Gm-Message-State: APjAAAWyvy09cFA41U/pkxupthzGTuOg26Nz3OpFWvgktAqgkNUgrmqI
        w4Ana/MOw0h/xylZUKalX4806w==
X-Google-Smtp-Source: APXvYqzN83CIOvU7h1VI/upm+FMF8KlXoDHQuZQPMn0sUbaplEuqAC9iJ5IdsyG4SkF4yRVs8RanRg==
X-Received: by 2002:a1c:1f14:: with SMTP id f20mr5765595wmf.147.1571661994201;
        Mon, 21 Oct 2019 05:46:34 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id z1sm14850654wrn.57.2019.10.21.05.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 05:46:33 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:46:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 3/9] mfd: cs5535-mfd: Request shared IO regions
 centrally
Message-ID: <20191021124632.GH4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-4-lee.jones@linaro.org>
 <20191021122606.5q22j6wtyslwljco@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021122606.5q22j6wtyslwljco@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Daniel Thompson wrote:

> On Mon, Oct 21, 2019 at 11:58:16AM +0100, Lee Jones wrote:
> > Prior to this patch, IO regions were requested via an MFD subsytem-level
> > .enable() call-back and similarly released by a .disable() call-back.
> > Double requests/releases were avoided by a centrally handled usage count
> > mechanism.
> > 
> > This complexity can all be avoided by handling IO regions only once during
> > .probe() and .remove() of the parent device.  Since this is the only
> > legitimate user of the aforementioned usage count mechanism, this patch
> > will allow it to be removed from MFD core in subsequent steps.
> > 
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/cs5535-mfd.c | 72 +++++++++++++++++-----------------------
> >  1 file changed, 30 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> > index 9ce6bbcdbda1..053e33447808 100644
> > --- a/drivers/mfd/cs5535-mfd.c
> > +++ b/drivers/mfd/cs5535-mfd.c
> > @@ -27,38 +27,6 @@ enum cs5535_mfd_bars {
> >  	NR_BARS,
> >  };
> >  
> > -static int cs5535_mfd_res_enable(struct platform_device *pdev)
> > -{
> > -	struct resource *res;
> > -
> > -	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> > -	if (!res) {
> > -		dev_err(&pdev->dev, "can't fetch device resource info\n");
> > -		return -EIO;
> > -	}
> > -
> > -	if (!request_region(res->start, resource_size(res), DRV_NAME)) {
> > -		dev_err(&pdev->dev, "can't request region\n");
> > -		return -EIO;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static int cs5535_mfd_res_disable(struct platform_device *pdev)
> > -{
> > -	struct resource *res;
> > -
> > -	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> > -	if (!res) {
> > -		dev_err(&pdev->dev, "can't fetch device resource info\n");
> > -		return -EIO;
> > -	}
> > -
> > -	release_region(res->start, resource_size(res));
> > -	return 0;
> > -}
> > -
> >  static struct resource cs5535_mfd_resources[NR_BARS];
> >  
> >  static struct mfd_cell cs5535_mfd_cells[] = {
> > @@ -81,17 +49,11 @@ static struct mfd_cell cs5535_mfd_cells[] = {
> >  		.name = "cs5535-pms",
> >  		.num_resources = 1,
> >  		.resources = &cs5535_mfd_resources[PMS_BAR],
> > -
> > -		.enable = cs5535_mfd_res_enable,
> > -		.disable = cs5535_mfd_res_disable,
> >  	},
> >  	[ACPI_BAR] = {
> >  		.name = "cs5535-acpi",
> >  		.num_resources = 1,
> >  		.resources = &cs5535_mfd_resources[ACPI_BAR],
> > -
> > -		.enable = cs5535_mfd_res_enable,
> > -		.disable = cs5535_mfd_res_disable,
> >  	},
> >  };
> >  
> > @@ -109,7 +71,6 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
> >  	if (err)
> >  		return err;
> >  
> > -	/* fill in IO range for each cell; subdrivers handle the region */
> >  	for (i = 0; i < NR_BARS; i++) {
> >  		struct mfd_cell *cell = &cs5535_mfd_cells[i];
> >  		struct resource *r = &cs5535_mfd_resources[i];
> > @@ -122,22 +83,47 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
> >  		r->end = pci_resource_end(pdev, i);
> >  	}
> >  
> > +	err = pci_request_region(pdev, PMS_BAR, DRV_NAME);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Failed to request PMS_BAR's IO region\n");
> > +		goto err_disable;
> > +	}
> > +
> >  	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
> >  			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
> >  	if (err) {
> >  		dev_err(&pdev->dev,
> >  			"Failed to add CS5532 sub-devices: %d\n", err);
> > -		goto err_disable;
> > +		goto err_release_pms;
> >  	}
> >  
> > -	if (machine_is_olpc())
> > -		mfd_clone_cell("cs5535-acpi", olpc_acpi_clones, ARRAY_SIZE(olpc_acpi_clones));
> > +	if (machine_is_olpc()) {
> > +		err = pci_request_region(pdev, ACPI_BAR, DRV_NAME);
> > +		if (err) {
> > +			dev_err(&pdev->dev,
> > +				"Failed to request ACPI_BAR's IO region\n");
> > +			goto err_remove_devices;
> > +		}
> > +
> > +		err = mfd_clone_cell("cs5535-acpi", olpc_acpi_clones,
> > +				     ARRAY_SIZE(olpc_acpi_clones));
> > +		if (err) {
> > +			dev_err(&pdev->dev, "Failed to clone MFD cell\n");
> > +			goto err_release_acpi;
> > +		}
> > +	}
> 
> Making the request_region() conditional on machine_is_olpc() seems to be
> best on the assumption that the cs5535-acpi is not otherwise used.
> 
> I suspect the assumption is true but you have to combine knowledge from
> several bits of code to figure that out.

It is not used.

Will reply to your other comment.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
