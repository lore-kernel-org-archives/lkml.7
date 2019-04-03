Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D3BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E320830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaMbLQhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDCDbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:31:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37327 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfDCDbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:31:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so13502768ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0LO8i/P4ocbb21SDQpdrOuCyeO4aCMaVaU0YL0U9YA=;
        b=FaMbLQhMPfjN/XTO1EnbG8xYFTf6Rh988SHDiwqLcdyZa2D6KYSRvIYeFFcCjKB5P4
         YrGZowx/JU+ZB7EAOK+hL1ShPt8qeCAQKynQs5qAEiMzPB2JGW2yjwA/rA8K5ceGPFWi
         dfB8M1hZJUnYC2NrfE1xKcGpN6ulOZaQ/0jikMcSIA691nWoBSuyJEn1DbWa/ah9cdfJ
         HrSKR+gct0O7Q9nGt8uY8tBoqyiBC8BD/Mf6/LQD45+YucGgL5wFJflz7/cF/EvlDmI2
         vuc194BqyqNdGc8kINdz/qOzCcMR8oJ9BOjTQK65G98V2reB8zwe8QTk920Mc28RgT+k
         h75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0LO8i/P4ocbb21SDQpdrOuCyeO4aCMaVaU0YL0U9YA=;
        b=k1y+5JPE+yEJbp3CSfPUVWByiACXBd/xFcEr7YSEV/08VFX03Y6WYCYGadXHOaUMHX
         qA84ACf97qbMzKyPVK954kb6nX29HmOGxomTfI8ZS0FmCZn+ylcfIa7DjBdSurpFinxT
         8paCaFmFOC9i0d8Oda1KR0VhlPHtsC2/wihQ0kkO/HpD7pFMkyHFLj6ldFth9yl5jZwt
         8LB3tijl1CcJsS25NIyP9i6783c+Q7RNDBwHxLYB/jjLOtYtKbe+uOSlS0ZNHXJ0spxq
         /7sfvmSVRgPDCAYCS9fYPN3UiR9lRMS1iz1d3gekGy7qWkqXLULylS1x5kdNe0+3jMQl
         yIXg==
X-Gm-Message-State: APjAAAUuGDZAvi0xJ9bhDgkx5IaLc0PGxpxKpbWCw/uyHKFLjl6F4jYG
        4/qnLYFso/746qPtsEkJ+V1R5n0SmQnhyHgQItBBsQ==
X-Google-Smtp-Source: APXvYqxssvdCWqw2uQg953gn+PPx/qQPPtJfFlNS7rypo2lP3nt4nnnnx3YadGJEUDr4u3ODc8r6KRYW0sQcgV7kZHU=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr5086505lja.49.1554262308728;
 Tue, 02 Apr 2019 20:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-25-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-25-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:31:36 +0700
Message-ID: <CACRpkdZ=u9q9BB4-kz0Y96oA3QNRsukQX7ke0z_pnoSzhgsrDA@mail.gmail.com>
Subject: Re: [PATCH 25/42] drivers: gpio: pxa: use devm_platform_ioremap_resource()
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
