Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737CFC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D64420882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYnpAhqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDCDri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:47:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41740 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfDCDrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:47:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id 10so10579339lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0LO8i/P4ocbb21SDQpdrOuCyeO4aCMaVaU0YL0U9YA=;
        b=BYnpAhqjKMk2oZyHXFOiDwsXVGqhLLI35jncD7tsF+cZW/QCSXUTqIJBXPefca3jus
         hVh9miEUVSqTmc1P71e2qsKWlj9g7WaJJfAgUTm7AOj98G9q29IRAxOyXEINCh2XI0cJ
         YPelO8bT7WdNewwXlGuiZ/Hq+tfYHk+NHeke3iZaCh5/+3+Kxz2BCXKwox535lvhPySW
         LwvIbmGK69WUw9pvy70j3oHq5brq/IzGgGPdMl8w2yDDA3PTu+3r7cJfJZXK0a3sjFUG
         i1GcsArTWrMYBbRcdFwMoEJ2KwWA5z8/ahyeSgBfWruVQwAq7DpAbkeVcFsfZebSVAp3
         KITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0LO8i/P4ocbb21SDQpdrOuCyeO4aCMaVaU0YL0U9YA=;
        b=VKAWJ7iF6MqZaL5IeZcsEOf6jkAHHdc5OpDF2imb6yntNJb0CRL57Q04lhqXscSUsy
         MHedFiwbZ98YFUJ/WC3iEQAyLS05UAqrC3D0ZtLzCLo+7n009lXxZCw0aGlY3AC1u/vG
         QwkkbL+8ez9fjC6bT//3Pjs+gjwU/NsfnUufY7likxgKchnob/D5HGX4Z83wBVp9+NqJ
         yL5zYdYbKteYJdVeizmY3RAiFdnybMU2lxEmK+DZdIkQ4DdMB1bbGdQuXUUr3N9zWuto
         6tp7iHwY5zYVTZZlK1ObMrgKmVCIvwofBW+ykfSbutmCjfx8oZDh+B5GHuqmpw3iSery
         urrw==
X-Gm-Message-State: APjAAAUABSYffqIZkPhIqCNy5mMr8CuZ3CN2xwhiP8Zp8XSi8O7B+Vf1
        08+lYvVusSYj6ocLa4u8HXslf4Fk32l8UhAFvYpUyQ==
X-Google-Smtp-Source: APXvYqzGUo6j+SMp8NeyH98A7srm1WdFMacQ6ObhR1rCua8oq0m6NIzR70Q7J1dqhAUiSXce0dHzbfZuQfYLd5VCX/w=
X-Received: by 2002:ac2:5479:: with SMTP id e25mr1750153lfn.121.1554263252682;
 Tue, 02 Apr 2019 20:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-34-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-34-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:47:21 +0700
Message-ID: <CACRpkdZmnkS-8gS6u6-xBWeuVUPk0iKs-3-B9dapzvezOO4sGw@mail.gmail.com>
Subject: Re: [PATCH 34/42] drivers: gpio: timberdale: use devm_platform_ioremap_resource()
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
