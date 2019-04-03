Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6313220830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogFTqOLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfDCDfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:35:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35173 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:35:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so13512635ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=ogFTqOLO2MLcnspVE4LUYx9IWdK4ZbnbVw/2VYGpL1hPAcWFu4RHUrcXgxmfLbkKd4
         f3WjjMXhmbzd81YFZ1B3y+GMLwtJAESkvG1MgqlqXTs2AED8FOACUa6YQig+96oGoed6
         JwE3j6491VB1QjMwGv6ekj1qA/D1PWfnPTVUmcw8H1wJB5ddk6A1Wp18ivyTj6XffR63
         95ZpyUjRQ3gIthZt9+YtVAK58bmEI8L8WbXQSUF+0/hqEjo9TRf0irisSJGeHSAgNkRz
         maOgrXwe2z2mTC3loV44yQmLSjyOdi3doQ2XnQ4tILAa/ATayjjiq8DmzAm5cSFYEMzA
         Bocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=i6teUQSe/KPHus8jVGLYIwayLwYAVrZRiNZlET4RS2k7niwy4Q4qAnyzVD5VA13Xi5
         jKS8aW9I8VPtwWWEaOku8kNwuoQJA4wZLm5mQ5GG9SCMw1tMaRqr7+nBZqhD///nxmuV
         ldk1k9wdmi5RwdBWaWVzcCICoj+Lfk0FOqAeDlwlxbqyyWQvXliFe3P5SvDQkMPtsJO/
         5XMdGf0Vt25dZV3gdK1gZVZiV7BZnNbH6L63qTQLVRJuVMVbOzyO4suLI9kCYqPk8Odg
         n7is05BlEOPz52RqS4H6tHvjoD0Hv0DoIimGXF2A0Ij2JWmWMAm7gHyzN3kmrSMQW23E
         n3tg==
X-Gm-Message-State: APjAAAXMjXG7iEBdtPp/DX5xKOJEkIiulVo9ZFcqnHh/6jmL5ND55oWY
        tEBpUBxPXc3x4E7y0xecv0cN+Pd2UPfioxkTEHD/yA==
X-Google-Smtp-Source: APXvYqx/ScQJ6VRnAmR7nvec87msNEZrF3vtzqQzB97GZXvAUd9iWJscRsXX42d9K5sscsQOqkWo6xLjGSjI4nTnIcY=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr5094376lja.49.1554262552446;
 Tue, 02 Apr 2019 20:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-28-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-28-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:35:41 +0700
Message-ID: <CACRpkdbF9=0issP2K44HxA=pMkrg8oavrGhO==b=iEeaU4mFsQ@mail.gmail.com>
Subject: Re: [PATCH 28/42] drivers: gpio: spear-spics: use devm_platform_ioremap_resource()
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
