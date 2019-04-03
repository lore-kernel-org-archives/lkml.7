Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A567AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E7820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="st5nkKmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfDCCh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:37:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33292 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDCCh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:37:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so13417854ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=st5nkKmCzGYRmswYnOYUEEw9t91vDKq2nmDPsxOMI3swVsvXiqe+T6H5BaXZsLVUf8
         4iyg/Q//wa5CYuo5pm3dj8bghd8fvSCB6s02i9nDLNvMrnYuG1Z/B099REUgLRprZRCQ
         YGk6wa7e8rdzP5oz4ZwibSa9invEDGBYmRCH8Ryk4GHj8Gi17+qZbQuriHCXCbeJH07A
         /QfHMeEb2MmdZ+EISyhn+aOr6N8qIZPZdWZgTCKyQ8W1ej3hoHPycuwbwi8AKU71CfWe
         ysRozyye17+rKA1XUZZrg0QjBnwxpqGNSThUZcDzzCRA0LrA70MaulouOs2ahNZ/l2Jl
         lrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=dPybAHG4zuNALlgJHYczEFDt2AP0u5LPJjojovSY8SEk8FQBjT2nPpFRO4IfJ2oqic
         NdLB/sT8H8OgBIj2X+tJIPDKghicnLIDcuTAL7CxB9A+ppSXqwEqFzgUXts1Qga2LWXP
         U5MJ8hsc25s6WrKWUbmQnzbsEN0wuMe1yIbnkTstbrg9Q/QmuOxfJmFlu8ztgje/BFud
         ycuw2y/YTVVl1nUVl9+31jlCBswnM0abj9FS4W+fbER5eQ2Bz9IGUE2QnsDdgOAwWedO
         nx+CSVwRtYiO5RbOB4n4LgnSqLc8DaWy4nBYt8EJ1eAldyGNpa+vcWlwXO6t8WDWLWwn
         xW2A==
X-Gm-Message-State: APjAAAUVn3DGQve7u83sipSWwRjmv2/my3awfX4vXGdHShcVPuw8OLTH
        +3lSmD5kOoRl1VwH8XyKsz+gZ717iHdiamjdd8rBTg==
X-Google-Smtp-Source: APXvYqyfqk8mV/ayFiROibrSgxPm2PCIKYdeRzUFulDCskRLOs+xN5O63mPzUMSk1fi3E1LuWmu0rFka+xyiFeNRIa8=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr37407307lje.138.1554259044742;
 Tue, 02 Apr 2019 19:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-19-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-19-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:37:13 +0700
Message-ID: <CACRpkdZ1g5NghOMaN3CgZ5KUyemhguQOuapZDG1gNqR-veC7RA@mail.gmail.com>
Subject: Re: [PATCH 19/42] drivers: gpio: mb86s7x: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:55 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
