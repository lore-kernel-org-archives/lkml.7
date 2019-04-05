Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ABB20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mduK7u77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbfDESO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:14:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35372 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDESO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:14:27 -0400
Received: by mail-it1-f193.google.com with SMTP id w15so11067908itc.0;
        Fri, 05 Apr 2019 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1g4UncIzNz0S8lDSNvRfJmGv62riWXsPRegnkO/ZEKU=;
        b=mduK7u774Y08UB4on0eNhnt6RJT1AZuy8dKjyyjYsBK8WDRohr8pIRDdJ0w0N9Vl6h
         og0aIH/vM2akJLWRCRskCGQt3jR1VeoqxvNrg/xETId0WueCmccT5NLj5yLFhn14rtfV
         wHkeuWksJrEdXVk4TmvQC35Yl2eeT+lUjQi3nVm2ZJcqisbaB7Dy2MlSg/0Ksi/TtRIE
         R8yBzfcQjqEN4bBR1mQMdS5PaS/81y4v2sCJ9Em4Pa/sXuSct9Fa4gcA/lU/1jPPpZx2
         0J6hVQgb4gmdhkucdle8Cjnvwp6BhzaU2KGBU+lz83wGos5XiJsv44UmZxVsVQTzWvv7
         EEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1g4UncIzNz0S8lDSNvRfJmGv62riWXsPRegnkO/ZEKU=;
        b=UlyanZPRMvd9aEcxCPsDTYhquUsXrqVDIga+v6LfEXOkgwJf457Q0++iCtiQ5GvE2M
         RoDiILcZ8xrkf3cYkc04vuPyEtLZYuSdVxgFpa1IPsWQ2Jg7nVCpCoBDpnhDTBu6icaK
         LF0tYyxULOB3Po9w5liUnglr8UDZKuaZTbtMVnAt4n3a01FhIawcKaWmjEEv6Jq+ZlEU
         LFgNLOBiiC2WptKH/Z7Fpy9yyenHspKGMNxfEcqY7bShhhO+g9/dLwxUlqOlApLTsdLO
         FwKhcBfKp2LpHjxOrMaCb5jMnZs/Zy/2ijF1ge7f9Be1le1xRz2po3LvI90fPirKL9dt
         jXFA==
X-Gm-Message-State: APjAAAVEb7SNh7YYIBix7uQhF2ovkewehx7hpB0+TiKfB4hGqmzYpkhg
        +mwvPM5DFZoAinSPM3SM0QbXhTyqq/fuWem7WKk=
X-Google-Smtp-Source: APXvYqzSxu2e6x3i3g5/xjUjq9e3PMBKYjs1wdhxVnGxyOvGGCFB1fICFi6LTc+kS8P0aJIBFP2TnUQOgblCwzHA3Ww=
X-Received: by 2002:a02:942c:: with SMTP id a41mr10769730jai.61.1554488066928;
 Fri, 05 Apr 2019 11:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-9-andrew.smirnov@gmail.com> <4d17af42-9db4-685e-799d-7b7981344129@linaro.org>
In-Reply-To: <4d17af42-9db4-685e-799d-7b7981344129@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 5 Apr 2019 11:14:15 -0700
Message-ID: <CAHQ1cqFgS1euUwc=vuUX1W24fBPcvb3tUsTwwFTKUb9tEdWNzg@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] thermal: qoriq: Convert driver to use devm_ioremap()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:23 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Convert driver to use devm_ioremap() to simplify memory deallocation
> > and error handling code. No functional change intended.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index a3ddb55740e4..4f9a2543f9c3 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -192,6 +192,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >       struct qoriq_tmu_data *data;
> >       struct device_node *np = pdev->dev.of_node;
> >       struct device *dev = &pdev->dev;
> > +     struct resource *io;
> >
> >       data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
> >                           GFP_KERNEL);
> > @@ -200,7 +201,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >
> >       data->little_endian = of_property_read_bool(np, "little-endian");
> >
> > -     data->regs = of_iomap(np, 0);
> > +     io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!io) {
> > +             dev_err(dev, "Failed to get memory region\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     data->regs = devm_ioremap(dev, io->start, resource_size(io));
>
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         base = devm_ioremap_resource(&pdev->dev, res);
> ?
>

devm_ioremap_resource() will call devm_request_mem_region() which
would change original behavior. I don't know if original code was
purposefully written to not request underlying memory region or not,
but I didn't want to change the behavior. I am more than happy to
change the code to use devm_ioremap_resource() (or probably even
devm_platform_ioremap_resource()) if we agree that such a change is
acceptable.

Thanks,
Andrey Smirnov
