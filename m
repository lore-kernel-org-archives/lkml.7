Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B2520856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaEu1ZvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfDBJTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:19:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46001 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDBJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:19:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so10856165ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=savQo5tfN+y45IL1LSRmkM0pmYjRsdkEuwf8ptUdZY4=;
        b=iaEu1ZvE7i+aceOKthhQa0wG7pJ1PrfGYDtQuOrb88tEELV+yUJ3wP6a+J/dxCJXME
         hMGXODlxFPg05q96NazwqlLEW9lQHQWLy++oZdizqu0eY7/OyckXnxk2fQaXaGpO6AbS
         +0PJXtlLcIRc0biHtRDT7o7WXzdI+DvreDHNsZpeDldYeHmtVGc5R4VEO03unCCS5Dig
         O3BPYQdef+tcAAY+AYBbvFNrdsOJBwp3MNYpuvOgnlcBc6Xw4Xpai1T4KJDr0rjrrIVG
         RjvJAiB2/nMa+/CoS0Zli3dQyWaQ4aPiebrSKRv2g1p+tgVdpwLcUMC7b8Lm7Ukz/N+k
         F/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=savQo5tfN+y45IL1LSRmkM0pmYjRsdkEuwf8ptUdZY4=;
        b=r0SGER0b6yp7A2cqL1SOx6SmvK+BCpSimKzcwpjzJI2v5E86KvtvDCXMuuf5+CT17Z
         zP8FenJeWkOV2Jjgc8gct1PNk2LH4Y8/N6G2P12VczpiGf2cv+1k2T2/y+s83DVxwTig
         P/0gi4dvtSOeFyUk1845G7HpS88NkiapPZCqTnI/OwURhFOwJ/38F1ICdSC+/KtqGM38
         8Nc93P3Fyl0q0A4xngdF2gghdnBOGRD+AEUsbClSOdWUzpR9LiRleAdZ8g0unNrb88qe
         /b5Y6gg0Qe6zE8ldXJwoDYGUVnAK3NasqUo+9mN1QN2R+XCyyOQ1AMoI8T1t15yLHPbV
         VtLQ==
X-Gm-Message-State: APjAAAVcJRpX8B5cj1mMRYv1KC6+KdVvlkgAZO+G8HvNHkkYuLnFhp00
        GrdA8MCWMp8yGzxo5TJDn4w7PYGLIDysZr7YTG9pVg==
X-Google-Smtp-Source: APXvYqyXmxbb7LdXRf28JxrEktA/coioA9BJXfYztWmnUpHCcGCupbQgKpB+sSfZB1SxugdWFY9VxLuTyZxq3TZf69k=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr20135284ljg.103.1554196745108;
 Tue, 02 Apr 2019 02:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-29-git-send-email-info@metux.net> <CACRpkdYa+oaw-P9aYL6KApvetVBZLt7USVV3kx7xZ4R7U=Hfew@mail.gmail.com>
 <CAMz4ku+L_iAGB4HrBuS8w5AQus1AZgKpbWbABbHwzDPWj9-rqg@mail.gmail.com>
In-Reply-To: <CAMz4ku+L_iAGB4HrBuS8w5AQus1AZgKpbWbABbHwzDPWj9-rqg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 16:18:53 +0700
Message-ID: <CACRpkdZMpZMHR22USj_m+_j6=nKCsZbJ6FumSO0EtYvw0OsH3A@mail.gmail.com>
Subject: Re: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 4:10 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Tue, 2 Apr 2019 at 17:04, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Tue, Mar 12, 2019 at 1:57 AM Enrico Weigelt, metux IT consult
> > <info@metux.net> wrote:
> >
> > > Use the new helper that wraps the calls to platform_get_resource()
> > > and devm_ioremap_resource() together.
> > >
> > > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> >
> > Patch applied with Baolin's ACK.
>
> This patch had some problems which I've pointed out and I did not ack
> this patch. Please do not apply it now until fixing the problem.

Sorry, it's the gmail threading that confuse the different patches.

The patch I actually applied is for gpio-sprd.c and looks like this:

commit 851f66daeab961328507dcce0980cd7e4ff5f9ae (HEAD -> devel)
Author: Enrico Weigelt, metux IT consult <info@metux.net>
Date:   Mon Mar 11 19:55:08 2019 +0100

    drivers: gpio: sprd: use devm_platform_ioremap_resource()

    Use the new helper that wraps the calls to platform_get_resource()
    and devm_ioremap_resource() together.

    Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
    Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 55072d2b367f..f5c8b3a351d5 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -219,7 +219,6 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 {
        struct gpio_irq_chip *irq;
        struct sprd_gpio *sprd_gpio;
-       struct resource *res;
        int ret;

        sprd_gpio = devm_kzalloc(&pdev->dev, sizeof(*sprd_gpio), GFP_KERNEL);
@@ -232,8 +231,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
                return sprd_gpio->irq;
        }

-       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-       sprd_gpio->base = devm_ioremap_resource(&pdev->dev, res);
+       sprd_gpio->base = devm_platform_ioremap_resource(pdev, 0);
        if (IS_ERR(sprd_gpio->base))
                return PTR_ERR(sprd_gpio->base);

Yours,
Linus Walleij
