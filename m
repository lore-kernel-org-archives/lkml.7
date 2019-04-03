Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F38C20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmkxdSO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDCDtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:49:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34388 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:49:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so10590591lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpU/xVxBv9WEG+3g7U9648HQVl2f7NlFys1Xmj7hepg=;
        b=tmkxdSO+rb89A084WPto+VexCa+WwxrARfqz4RtKxjj79sPgiXdxYK3UIt7ksiLs7L
         OPDsJPj1QHEqAl0EpmPJpPUMqZYy53N3FOFrUImGgY1P0+xNBEn3Rdtg6l1sT0AQJ4wE
         GKKJZgEn0UdzS7EqsSHy4vO1141TQOVLot8LxKNRheQGAVahC1LXDFY7Lf7v7UksnUqs
         1x4EoDzg3YfJcx5ELdIiZuIWIeSjmYZXK71vDIAueNe62K2+i8bTsPN9+GdWROkwoPS6
         Ta96AOma2MRi0V5tQJlClerj8QRvH+QlLZ4Agt8108RIAZeROoti45TaZB8rmEQtoiBm
         wqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpU/xVxBv9WEG+3g7U9648HQVl2f7NlFys1Xmj7hepg=;
        b=GwvkWCmPK6QL87pGH3Cc50IM/qaJV3PE2iPPfMSnTBBKIyfOL1q942uBmbYtf4C2JJ
         Vxh8Tl2cQqrpzTgvkpeLaZN50dWpO/JwKIF+f36F5H5XW2DzjRhNy+4AeP3af3di196l
         EdT992sH/PYZ/UM5ckLvWaOPL/E/EWyQbJQTcCStMzkrjN9ePz2h1+KsEXXJRHLOYDfD
         lbs4IVjBKgdiLwEzn2kfNnLE8fL+6BIP0oFk1H8NYStiGX4rOwNi76KWvYP/nLo4yPfE
         RjxzusfXxZ9ZOhJfIZNoBDf/41UVD57Dsn5lgcYJVoILuhR/HUW/TBmLlXCGiETu2962
         Kklg==
X-Gm-Message-State: APjAAAXQ4O6PZzMfcr+33G4affUu8hsch+HZrM10orMNZVJfJzvw8xfP
        GxteJQRXqQE7HTRbM5p5ZSBPGPQ9u3rGml/FyA9Z+A==
X-Google-Smtp-Source: APXvYqzyM/9XxtV6zaPsy/6WzV0bMFhvjVBpG+Pd/TUBfIpczrZGXBhbPCaXlWvCXW8fZYYC9NmEoT71O+e0veseDxI=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr11297261lfh.103.1554263390092;
 Tue, 02 Apr 2019 20:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-36-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-36-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:49:38 +0700
Message-ID: <CACRpkdZx+Y5s0n6=AuTmmKhQZWsZs-sLTrfgnkqt4DtWrYZ1wg@mail.gmail.com>
Subject: Re: [PATCH 36/42] drivers: gpio: uniphier: use devm_platform_ioremap_resource()
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

Patch applied with Masahiro's ACK.

Yours,
Linus Walleij
