Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72021C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F4F20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHkrEVyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfDCDpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:45:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37064 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDCDpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:45:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id o19so221184lfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=bHkrEVydLiCLZfHPc8rmI9iDSgXet/KYrYzAOOmHySuoNLxCs267E7pT9xwtUbZKIp
         cx6TB3t0miNHrbzXozLIdh+gt6AYfF8ZeLSaCKxfKXifCF/DhlkYdFnWq+druAp2fiFZ
         veMt5zUfhrG7NEQLXoLOomspB3tueLRN0jqQ0t+pM+Ru5O7Br36dGTQYW5I4XX9Tlahn
         6e/o6LIipuHc5wnevObZzubmi6EdsOV4YXyDL49kAmxNHTbbo2uR/qwtxtpZBygBk+Yv
         zO3yCgu9JJi/3eIZOR13fHMndSdzn3Xv4YJlInWSl6gVcvzVDc3w52/4qcY2MnD7Uuod
         na/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=eoC9ckgCK4SKGEojlySaMhEAAN3Fi3kio5t4Q3wSxUsMEcYNldN8RmeLuTvWUSWy+B
         8Oi7NRCD0KlZ7+oyc2tvwIU+W9qQdFuI6DY+bdB/KaXMRwCYWqrBhGsCb8cvFne79NTB
         gLzkAwxu0t8FMASKIOVgG2QcYZPxCma5J8GrTA5LEsyyvvoSZHb26dmZchdgBaic9NF3
         v3omMCaDtdyKir/kPy0p2ebyNXbtoxPOmPjyXOGPPke83X6Rk89FF34DXB1svDe3m7kf
         v/qMuxcj7bM8i5skALdS4VKXDiQQhT6M/6PrD7T9mQ8pqvcXg4eNH4mlwk4aNFM/0Bpf
         OFdw==
X-Gm-Message-State: APjAAAUYty4nACnyDVVknJG7NWQFoioZ/yrPLGjI+X4dv3dYopZUTs8u
        ox1d3jWVcUJ0s0+HnMijPb4LFbZgpv+p422awVZZC18M
X-Google-Smtp-Source: APXvYqzJjAds/mKKQFW2y42ju+tULECCQZzMVfxlX4JWP1WZXO7zhkoRuitERd7nkhBCk6jz/T57FCqhL49QfDRocCA=
X-Received: by 2002:a19:ec14:: with SMTP id b20mr24286830lfa.55.1554263101351;
 Tue, 02 Apr 2019 20:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-32-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-32-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:44:49 +0700
Message-ID: <CACRpkdZqMMcYdK6GkPL=-PArZDc4F+8pfNcNPxAuzZ_KNcYgQQ@mail.gmail.com>
Subject: Re: [PATCH 32/42] drivers: gpio: tb10x: use devm_platform_ioremap_resource()
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
