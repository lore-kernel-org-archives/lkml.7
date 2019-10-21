Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFC4CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A202089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vL0xgiFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfJUNVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:21:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfJUNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:21:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so13967922wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GWUlVpoqUQXWKWTK3K8LLo2ls8MnItL75dW5lr6yLXg=;
        b=vL0xgiFa4qmexqBA8NPWnkoSkwm7i3GEjYXLhFkLT1gANwzLZsO3RLW8C3VKYsYPKa
         cloQVpoz8FMnhTpHgu7IPmmcfApJYcI+Z3NojtberRYgYg/Ck9OBB6lx2OxEWARU/iVC
         yTBgVe/ONo50K6kDSROkcKN6fERS1DRT4o6D+UpSOKb5tnJEebMpqbuvQtLmPN8jsz7r
         JuA5lZzi+3rt19mA/4/5fxfpDiG49My6QC05M9ZbdT7dOYy74l/dzUTkaIT7dF0/duy2
         iAWN+XBKyNmLzBWvSgwd23RfbVJPGqEx9Ruk76LGVbaucXlsKPgq5fOEPQL9bHIoPHxQ
         Ks/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GWUlVpoqUQXWKWTK3K8LLo2ls8MnItL75dW5lr6yLXg=;
        b=gwKPf9zV/sKpQdbU4xxtu7sbPcJsVak+c0lWahUdayXqvDPqM7vq1cCUVCbUXTFjiL
         VEhnSRjqm+oGnchoIBw32zp5ffu6RMA5Jbn7ftgZCnKibG48bjCR+TnXmb/XvIEQgz2H
         yzQwEdCSMNLX0JVQBKhR5gJztoRTETzgXVKh0gzLCWhyKi4kwNlJYs0KfDp4r0z2hkH1
         8FF1hLV/eFVlPN3BEm4c/Pf8A51MiAlUyin6cka/BWJlKi4kSMr+/CrPXef//x27zPLE
         AA5sz9ytdpq+a/KYgqy744xvc/bkgCgPnUKbLPyBdofPIVt9iauEytbOqddX496DnU5W
         4/fg==
X-Gm-Message-State: APjAAAXLAiC7vuslneWTfCmS9Haf4wPsSmBY9YPiBz4d+kJjqh97tLZB
        H0vi+8BBNGaGO392M37ryeK/hw==
X-Google-Smtp-Source: APXvYqxIB3aCYpteCi+A2z2E9wvQWBs9QBIZ5UFKQ7LCbAwjoKC+qyJmubZvaKbuFSsyml1GaGJqsg==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr20819925wrw.318.1571664070419;
        Mon, 21 Oct 2019 06:21:10 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id c16sm1263643wrw.32.2019.10.21.06.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 06:21:09 -0700 (PDT)
Date:   Mon, 21 Oct 2019 14:21:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 4/9] mfd: cs5535-mfd: Register clients using their own
 dedicated MFD cell entries
Message-ID: <20191021132108.GK4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-5-lee.jones@linaro.org>
 <20191021122924.qmaio5oe5j66tfdj@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021122924.qmaio5oe5j66tfdj@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Daniel Thompson wrote:

> On Mon, Oct 21, 2019 at 11:58:17AM +0100, Lee Jones wrote:
> > CS5535 is the only user of mfd_clone_cell().  It makes more sense to
> > register child devices in the traditional way and remove the quite
> > bespoke mfd_clone_cell() call from the MFD API.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/cs5535-mfd.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> > index 053e33447808..96a99ac13384 100644
> > --- a/drivers/mfd/cs5535-mfd.c
> > +++ b/drivers/mfd/cs5535-mfd.c
> > @@ -57,9 +57,17 @@ static struct mfd_cell cs5535_mfd_cells[] = {
> >  	},
> >  };
> >  
> > -static const char *olpc_acpi_clones[] = {
> > -	"olpc-xo1-pm-acpi",
> > -	"olpc-xo1-sci-acpi"
> > +static struct mfd_cell cs5535_olpc_mfd_cells[] = {
> > +	{
> > +		.name = "olpc-xo1-pm-acpi",
> > +		.num_resources = 1,
> > +		.resources = &cs5535_mfd_resources[ACPI_BAR],
> > +	},
> > +	{
> > +		.name = "olpc-xo1-sci-acpi",
> > +		.num_resources = 1,
> > +		.resources = &cs5535_mfd_resources[ACPI_BAR],
> > +	},
> 
> Is the cs5535-acpi cell actually used by anything? I think it was only
> ever used as a template and can be removed; I didn't spot any driver that
> uses it.

I did think about this, but I assumed removing it at this stage would
make the resource matching below more convoluted.

I'll take another look at see what I can do.

> PS If the cell were removed then my review comment on the previous patch
>    becomes moot ;-)
> 
> 
> >  };
> >  
> >  static int cs5535_mfd_probe(struct pci_dev *pdev,
> > @@ -105,10 +113,14 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
> >  			goto err_remove_devices;
> >  		}
> >  
> > -		err = mfd_clone_cell("cs5535-acpi", olpc_acpi_clones,
> > -				     ARRAY_SIZE(olpc_acpi_clones));
> > +		err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> > +				      cs5535_olpc_mfd_cells,
> > +				      ARRAY_SIZE(cs5535_olpc_mfd_cells),
> > +				      NULL, 0, NULL);
> >  		if (err) {
> > -			dev_err(&pdev->dev, "Failed to clone MFD cell\n");
> > +			dev_err(&pdev->dev,
> > +				"Failed to add CS5532 OLPC sub-devices: %d\n",
> > +				err);
> >  			goto err_release_acpi;
> >  		}
> >  	}

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
