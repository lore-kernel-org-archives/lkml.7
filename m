Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B58CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0F121D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9ySKPlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393215AbfJYIuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:50:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34743 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfJYIuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:50:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so1363434wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mU3F3IzQsPzzpNMBmUrZ0k4gyWNr/xsuP+XBZgHlZiI=;
        b=p9ySKPlS9CNE3I642lywwJwYWHSeWJ9DGHcyQdi7nLgOCastK730EcWtbWLXygr+fm
         9eQHwbWqdxVvm2DOqrL7oMHN51DUgMFxM+cRVifrC01I0s7k58M3dGxNkJ0+lGYD56zj
         frJ0Dgtwniy4hA1wY07UrYK2VcTBbRpzatr1t/3VvRbb0MqBCZ/YqqtJg1H7boP7oagn
         Bj199e/JrmyTrpSL0oYa29LqOM+Csdk+KjptXRXjCORcNGHFDvTWZ5RUHpmSy/TAqkaj
         F/1oHtQdEYq6ZhmDArWWdh5yGn8khR/6P/HBErqDYUfCYFSN7IL7XX0eBoVlbMVo+X/T
         gnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mU3F3IzQsPzzpNMBmUrZ0k4gyWNr/xsuP+XBZgHlZiI=;
        b=qIb72svIHPlj6lZf+OpwX1hLBPmLxZx38KSrac9QrE+eycrctswhqB3ZhGixrkUWvM
         C+8nkC9//GVuqGfAtTsIpttrZxMWHDYWIg1sin2mRSA3ffi5J+k5Swl0O9RTHD574Kw+
         XHj/ZlOS15YlvkyvdpJK2/B2RM7P54AkF1rBjWIgHx0Ot6ZxbTN6j7KY8giJxuLGaOjB
         RpkZTe7z/zr3lGVJ7sBIFaOOLlp8SlRqXEkperTTbUHDXlDh6NFBiZ4GAGibg2v+X88h
         f98geEIGGmoIl0JwIXTgJwMgK12hh8MJAXZdD+pGgx1/fIUN5JSoZ5RnQmgMpKqMRaSg
         DW0Q==
X-Gm-Message-State: APjAAAVjColo3PFMxkJ/eG585Ex7rYMdEuMpvXyb6SAyeOujs8HKqUKM
        LKUi39s8Ci6f7i6ELrh9LEcrMj+qkOFKCQ==
X-Google-Smtp-Source: APXvYqwQWWDw+ev8qSt1hiQb9lllvs7w8XNgT6hvwO+lq09EWS1MIQJ+LfOcBj9V8FxR0ij3fVCxOQ==
X-Received: by 2002:a5d:4341:: with SMTP id u1mr1880473wrr.306.1571993453132;
        Fri, 25 Oct 2019 01:50:53 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id p5sm1924303wmi.4.2019.10.25.01.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:50:52 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:50:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v3 04/10] mfd: cs5535-mfd: Register clients using their
 own dedicated MFD cell entries
Message-ID: <20191025085050.lwrhdwccof5vleie@holly.lan>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-5-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:38:26PM +0100, Lee Jones wrote:
> CS5535 is the only user of mfd_clone_cell().  It makes more sense to
> register child devices in the traditional way and remove the quite
> bespoke mfd_clone_cell() call from the MFD API.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/mfd/cs5535-mfd.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index 27fa8fa1ec9b..4c034c9f2303 100644
> --- a/drivers/mfd/cs5535-mfd.c
> +++ b/drivers/mfd/cs5535-mfd.c
> @@ -50,16 +50,19 @@ static struct mfd_cell cs5535_mfd_cells[] = {
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[PMS_BAR],
>  	},
> +};
> +
> +static struct mfd_cell cs5535_olpc_mfd_cells[] = {
>  	{
> -		.name = "cs5535-acpi",
> +		.name = "olpc-xo1-pm-acpi",
> +		.num_resources = 1,
> +		.resources = &cs5535_mfd_resources[ACPI_BAR],
> +	},
> +	{
> +		.name = "olpc-xo1-sci-acpi",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[ACPI_BAR],
>  	},
> -};
> -
> -static const char *olpc_acpi_clones[] = {
> -	"olpc-xo1-pm-acpi",
> -	"olpc-xo1-sci-acpi"
>  };
>  
>  static int cs5535_mfd_probe(struct pci_dev *pdev,
> @@ -101,10 +104,14 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
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
> +				"Failed to add CS5535 OLPC sub-devices: %d\n",
> +				err);
>  			goto err_release_acpi;
>  		}
>  	}
> -- 
> 2.17.1
> 
