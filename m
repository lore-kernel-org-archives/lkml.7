Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083D1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5F120674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGtY+ws+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfDCDuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:50:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37195 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfDCDuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:50:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so13527627ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=DGtY+ws+cQFaHerybIIJvFiY/kSl4DrRhgWaXdXuuThf6g38vqQiaD9Ed8N5SOyUN6
         WPkWRnm5YMXrGdPJr5QgP1zxyzL1CIeSNVfXE9hFyBWJ2nfzyMkYidqkS51MGJ+qRvP1
         sueexCoo72FkU0AC2i08/1KlrQw7xY4PoV0/xS2pWhEH87FDTJqqzypLDdHPedI4ySV1
         ttJaOQh9rSlBrGv315FzB0m6+cN2bskh0OnIlOiova4PT6CWeiAa+kTx023E4PmCYqkO
         /sTtOhkiS/iKFjvtKX6GgK0UDa0AHZaRDZVZDcXGfihGX7jphpwhufSe95rlXNX1rXzA
         3SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=dvF+uNg7ksQ4lfwibCzTHkYy4IldKe7sE6pTAxGHBNuJ/GcuF/6h1BQhJITdHbtN1x
         rzsGC+28e+ArHCdBHLZWbO3iFsfef4kcwiNpM5QS0mIiZmx1Ngk3saWYX4DtDLOfoKKb
         H9xm6+oi0FFAUEjLsUJerizM5skVRWwSmVuTlUAImKm6tehSdvPdBBafu/dRsHWDoyPH
         VgZmz4AiePXS7Igk5cjv0m5l3u2OOvtYjZsauWE3ODugYaQu8vSaz6gqesm0MYzuM2ad
         SHOIO1RHbICioDPtWD7rSiiL2CoYZPvOlYkAd76+hDtu6q2zOauYB7yPmGWaLDBhrtBa
         Q7OQ==
X-Gm-Message-State: APjAAAUlFF7UB1ZyZZ7MPKBc0JNq3b83AfcbC2rnmalxO2Y2tTclqAZE
        1LEJBjbZQklO/MxnLRhhxkxyQlfAb+KZyfns9XW6xQ==
X-Google-Smtp-Source: APXvYqzOTAF7lCpOM+FQuHW+r3Rq8B7v8Qb+i3DmNtLTD90Suw36BTqo5oN4jJlSubEzu1VwARv+Dp7EVTcHTJwJNMg=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr23093879ljg.103.1554263453023;
 Tue, 02 Apr 2019 20:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-37-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-37-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:50:40 +0700
Message-ID: <CACRpkdaRg5NKp0btcxM4tCn8+MqgYBOC1SAL88mTx4jMoQ7B9g@mail.gmail.com>
Subject: Re: [PATCH 37/42] drivers: gpio: vf610: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:56 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
