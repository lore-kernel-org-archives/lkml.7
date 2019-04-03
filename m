Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C192C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B9B20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjzAan6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfDCDs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:48:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42185 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfDCDs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:48:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id b7so10564456lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0LO8i/P4ocbb21SDQpdrOuCyeO4aCMaVaU0YL0U9YA=;
        b=CjzAan6DwDxTWf1n2O+o3/ZRxxlw1gzD0X+HcCbyvKj+N0F91i87u/vZ10217mDjgP
         4KR0EMWqcKqCRVFkV1sBvrD3abgQGF0FGvYv/d7cXBDDwOGJ7n8ZdHEkbBFPBux5DiE+
         edhynx5vAnDTd62IXd7TJbJuliuA2uiBDTC/WVWiLIXJhN9bC3NsDSxDAOjE/iL2u9Zp
         LD1cKltYOvuPi3LeoMe/2N4FjXUWiTsb7MxPG/xsnCqwYdVFJn9q6Kte7fx6flHsrXW9
         ySGgn2YZiJNYG8Szon57bIB0LxNjpQvsvd+FTCKPsnyELx4DDVCBUWb+S5IshX60yBI0
         NWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0LO8i/P4ocbb21SDQpdrOuCyeO4aCMaVaU0YL0U9YA=;
        b=hLkrMbYhqretHB+QU34Ar3B7dJ/EGtKuCYsylG/a/RhPotFt3u8DaOwjDimuoDMGFh
         K4GTZbP9qHK8CJzUtiUlX9qd56GZ+9TtLFEm+EhP71b2Dedt6URLnkfWzvXDn9rqynek
         Wclv2ZJdusqff+z8YoqYDhKRK/xS/pQaqEGoiaKw9oxK6ZqcMdDIsDGz4t0Q6sZ54B85
         ey9IeRKlXdMptMoy/QrRZUtrYyZTD4l3vjic27dk3q1UoDRngTqqX7m922GpM27YI+Ji
         by4pr0qFJ6n09zCGoI1bG4V/FQUh3tlnNL/jawoWx4ZkwIKuXr6iBJoh9UMufAUyv3mU
         4Ajg==
X-Gm-Message-State: APjAAAUvhuwqd79Uouk8C9gM2emQ4GajEl9gdAx438lnctSjQzxM407A
        Sk4in9+l+TE7MhDGkiHDXC21HSBwTloeFDNeiIj0LA==
X-Google-Smtp-Source: APXvYqyaqpOMpBJa5Npe6J2zf5/kQPqvfsPwjNgLRPm1+GDkG/FPbz/tJoF6AUXcc7pUHSnArRQ8N3jh413H0Ky4y8o=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr4459585lfk.138.1554263306442;
 Tue, 02 Apr 2019 20:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-35-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-35-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:48:14 +0700
Message-ID: <CACRpkdYxL1SXt7yDHzfo12JFudVrS=4ag9nPBRUtbvs3NNTa1Q@mail.gmail.com>
Subject: Re: [PATCH 35/42] drivers: gpio: ts4800: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
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

On Tue, Mar 12, 2019 at 1:57 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
