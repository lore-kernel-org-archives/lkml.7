Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0EFC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9D20828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lLSPXtlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfGEM7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:59:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41489 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbfGEM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:59:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so8969627ota.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SKIXJ9uk8+noml0z1EOUmEbUXXdqORK26jJChLARAIU=;
        b=lLSPXtlFTXfLtYLuxrSByeoKH+54f9rR1agmM+dC5pxulQnGUWLjTFcuRDTIAgl4nY
         jz8u2J60wKT9TodJaxIzc5alXgeawJ0ut//xd5TtqLN7mWXZE8f24jbHnml6biC/KmCc
         d7/aTeQTMgjA0Ti508aD+82RxsmxkGXzENhjmZXbpCX/UekuBlAA31AADLUre9dWPf4P
         c4OAaokBMZHBVeHC4INq6/S+Y4DKjpXeH6COB0S2oK2ARQSasn0DiYB2iA/YcdOzOsQK
         xr0q+dqGAzo+buPuJy5K/9tReDi0us66oZex+ZWjewgPs2qY+1jqrjguSkxXuXltJY3V
         ZmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SKIXJ9uk8+noml0z1EOUmEbUXXdqORK26jJChLARAIU=;
        b=THCF+qh1xy9yxXqqrmGGo281VeWsyNCDXJsT/Ndfnag3yh4Yk3u52am17ef3eKCyfI
         /6EUs/+dDZ+WN2RgcifBaUE5dJW18XViEe5cLFFQmfJ40hKMr3gxv26m2ssNUr3eA8p1
         mBhloFJovMfPqpwdpU5i3r6v0Eup41Lh6moz8X95i+aEIpitOhV41sOToCsEgcFRm4Ic
         knOTnZKfdEJHzkbbY1cOjKkBn8JDWl98OSryc3fqKkOq7PGIpo3dARNS+55tVab/N0OE
         oKvXO8BRrj+024qLsZrVqnLhgmNDXQQv7pWOu8VmDIWNoFmDL13wFMDe4iMUtlSc5hS0
         c1jA==
X-Gm-Message-State: APjAAAWnB0VMAkO++YBxiuglSwwIi1ePvqtHAgQxylxII6GrJ3gAkBNo
        /V18mngnJwH74Rzc3K+R1q4oZ5i/9g2fr14hAd0Cxw==
X-Google-Smtp-Source: APXvYqwLnjRS1N0l8kyPkSp9JvN2k5UC4a9CdQbJjg1HT4pSpnVmzCKv3R2jlbbjvy0HlbrPDPMbJ0DcaX7Mr7kPPLM=
X-Received: by 2002:a05:6830:1681:: with SMTP id k1mr2706281otr.256.1562331575545;
 Fri, 05 Jul 2019 05:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190705123220.54008-1-yuehaibing@huawei.com> <CAMpxmJVZHJKQ7bbHo=T9R99qguF315bZ=YVRrCdqti2SyzAnDg@mail.gmail.com>
 <74ffe8ea-e6fb-bd2a-42bd-08392eb27c69@huawei.com> <CAMpxmJUeg1jVZdCeiRqTZykBZNPGAeQkaNfA7qc1zt+sL9HPjA@mail.gmail.com>
In-Reply-To: <CAMpxmJUeg1jVZdCeiRqTZykBZNPGAeQkaNfA7qc1zt+sL9HPjA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 5 Jul 2019 14:59:24 +0200
Message-ID: <CAMpxmJU0=w=htiY3CL9GDBU+waBjV0X7yh1UG6ip5BiV3J7nXA@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra: Fix build error without CONFIG_DEBUG_FS
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 5 lip 2019 o 14:56 Bartosz Golaszewski
<bgolaszewski@baylibre.com> napisa=C5=82(a):
>
> pt., 5 lip 2019 o 14:44 Yuehaibing <yuehaibing@huawei.com> napisa=C5=82(a=
):
> >
> > On 2019/7/5 20:40, Bartosz Golaszewski wrote:
> > > pt., 5 lip 2019 o 14:34 YueHaibing <yuehaibing@huawei.com> napisa=C5=
=82(a):
> > >>
> > >> If CONFIG_DEBUG_FS is not set, building fails:
> > >>
> > >> drivers/gpio/gpio-tegra.c: In function tegra_gpio_probe:
> > >> drivers/gpio/gpio-tegra.c:665:2: error: implicit declaration of func=
tion debugfs_create_file;
> > >>  did you mean bus_create_file? [-Werror=3Dimplicit-function-declarat=
ion]
> > >>   debugfs_create_file("tegra_gpio", 0444, NULL, tgi,
> > >>   ^~~~~~~~~~~~~~~~~~~
> > >>   bus_create_file
> > >> drivers/gpio/gpio-tegra.c:666:9: error: tegra_dbg_gpio_fops undeclar=
ed (first use in this function);
> > >>  did you mean tegra_gpio_pm_ops?
> > >>         &tegra_dbg_gpio_fops);
> > >>          ^~~~~~~~~~~~~~~~~~~
> > >>          tegra_gpio_pm_ops
> > >>
> > >> Reported-by: Hulk Robot <hulkci@huawei.com>
> > >> Fixes: a4de43049a1d ("gpio: tegra: Clean-up debugfs initialisation")
> > >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > >> ---
> > >>  drivers/gpio/gpio-tegra.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> > >> index 59b99d8..40fd6bd 100644
> > >> --- a/drivers/gpio/gpio-tegra.c
> > >> +++ b/drivers/gpio/gpio-tegra.c
> > >> @@ -662,8 +662,10 @@ static int tegra_gpio_probe(struct platform_dev=
ice *pdev)
> > >>                 }
> > >>         }
> > >>
> > >> +#ifdef CONFIG_DEBUG_FS
> > >>         debugfs_create_file("tegra_gpio", 0444, NULL, tgi,
> > >>                             &tegra_dbg_gpio_fops);
> > >> +#endif
> > >>
> > >>         return 0;
> > >>  }
> > >> --
> > >> 2.7.4
> > >>
> > >>
> > >
> > > Nack, there are inline stubs for all debugfs functions in
> > > ./include/linux/debugfs.h if CONFIG_DEBUG_FS is not selected. Just
> > > move the #include <linux/debugfs.h> to the top of the source file.
> >
> > yes, agree this, but 'tegra_dbg_gpio_fops' is still undeclared.
> >
> > >
> > > Bart
> > >
> > > .
> > >
> >
>
> Can you attach the config you're using?
>
> Bart

Wait, nevermind. I think that commit a4de43049a1d ("gpio: tegra:
Clean-up debugfs initialisation") is wrong and we missed that. Linus
what do you think about reverting it?

Bart
