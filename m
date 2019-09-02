Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8667EC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596A32342E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dN7IQbc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfIBENE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 00:13:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34488 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBENE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:13:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so2226953qke.1;
        Sun, 01 Sep 2019 21:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEtrc1rdzh/Z7dC3mMEoNjpzKu9VEPrGxsmA4Ux5oa0=;
        b=dN7IQbc7odvWieIZ5FEdT/iecR2k9co0ZKCiVEoF2+XtJgJEdBx8dxIzOy3zhL02jM
         Ng4NLHSa7h/5wwE7q5SJd047yMm+wIvJm2pobbFMrlKBydk8kDSkH9Vuy1khb04sb0IG
         QvFDdo4L8E5TGP0OzMn69C3bccFG0s+t/Y2hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEtrc1rdzh/Z7dC3mMEoNjpzKu9VEPrGxsmA4Ux5oa0=;
        b=orcVABPt4ULBT+94U0s03B1Zlt25T7Au5CY7K4BwxixIggbbSsh+3DmqSL/BAJ4h+C
         0xf11/39xkewqQF6845saZZCt0QgasBnlVkROvJ3qDhSCZZzcw0Jsu0m1XdO2HrPioE5
         Onj+GLL7CvAQU7fCm3wHWJKdGFN13E3hgpxXnpOjcIp3lfGPClFZayAU7yn5rqwjXtbJ
         EvsZL3UjAMeKPW8nBAPnz0X0yoA3rGYDHSNrNh+ANx83tFyalMDdXx7SYAw41decAJgV
         nLk90URF1cKFrVnNV1jlbmbnBk+pLVub6tn1owO3aw9+14t4FH4Jn9KMVaMmKpdVRYL/
         EK2Q==
X-Gm-Message-State: APjAAAUeBQG9mBnYBJF8B3j7MgTDa4d6JTVJ82Zifyol7x3jpvJrCBTY
        aqvgA83U5SzAe8UBEGye1y/Y8tsyzTUuEzvrykRbunPU
X-Google-Smtp-Source: APXvYqx0AbdqwDb0w0SXIQPBfCsiY91eO/PaLq21Y0/TBBmbdFC4DKJXXqARBT3GurZhBmBSWqMC8OS98b5LFv7L5rI=
X-Received: by 2002:a37:4f4c:: with SMTP id d73mr13799291qkb.171.1567397583086;
 Sun, 01 Sep 2019 21:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190902035842.2747-1-andrew@aj.id.au> <20190902035842.2747-2-andrew@aj.id.au>
In-Reply-To: <20190902035842.2747-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 2 Sep 2019 04:12:51 +0000
Message-ID: <CACPK8XfYgEUfaK6rtr+FdEq-Vau6d4wE2Rvfp6Q4G2-kjVLT0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-of-aspeed: Fix link failure for SPARC
To:     Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2019 at 03:58, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Resolves the following build error reported by the 0-day bot:
>
>     ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!
>
> SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Guard the
> callsite to maintain build coverage for the rest of the driver.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 38 ++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index d5acb5afc50f..96ca494752c5 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -224,10 +224,30 @@ static struct platform_driver aspeed_sdhci_driver = {
>         .remove         = aspeed_sdhci_remove,
>  };
>
> -static int aspeed_sdc_probe(struct platform_device *pdev)
> -
> +static int aspeed_sdc_create_sdhcis(struct platform_device *pdev)
>  {
> +#if defined(CONFIG_OF_ADDRESS)

This is going to be untested code forever, as no one will be running
on a chip with this hardware present but OF_ADDRESS disabled.

How about we make the driver depend on OF_ADDRESS instead?

Cheers,

Joel



>         struct device_node *parent, *child;
> +
> +       parent = pdev->dev.of_node;
> +
> +       for_each_available_child_of_node(parent, child) {
> +               struct platform_device *cpdev;
> +
> +               cpdev = of_platform_device_create(child, NULL, &pdev->dev);
> +               if (!cpdev) {
> +                       of_node_put(child);
> +                       return -ENODEV;
> +               }
> +       }
> +#endif
> +
> +       return 0;
> +}
> +
> +static int aspeed_sdc_probe(struct platform_device *pdev)
> +
> +{
>         struct aspeed_sdc *sdc;
>         int ret;
>
> @@ -256,17 +276,9 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, sdc);
>
> -       parent = pdev->dev.of_node;
> -       for_each_available_child_of_node(parent, child) {
> -               struct platform_device *cpdev;
> -
> -               cpdev = of_platform_device_create(child, NULL, &pdev->dev);
> -               if (!cpdev) {
> -                       of_node_put(child);
> -                       ret = -ENODEV;
> -                       goto err_clk;
> -               }
> -       }
> +       ret = aspeed_sdc_create_sdhcis(pdev);
> +       if (ret)
> +               goto err_clk;
>
>         return 0;
>
> --
> 2.20.1
>
