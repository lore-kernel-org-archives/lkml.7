Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AB4C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9569B222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/kc/+0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfJDWMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:12:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36826 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbfJDWMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:12:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so5507093lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPIZ+fnAlaRxQz6OBsn+7HePWQmLD0l/EqVuqSsBiGQ=;
        b=d/kc/+0AAPxHyj4k4cAv6qruF/pAxg2HxprKzH0JR59Lx5sxBCBEC8rcJEu8sb67zz
         uMohNjleIG119dLXR/yy589+cZcnQz+3hVsksxSlYtx9S4DNZNXXAfC1oebjlduvsXZq
         grVEKCW17JrM9rgWTh9vwlSUpftMuTZLBZZQ3F/GKWAtf5hCpw0aymvKGn6HO1khtNS+
         EfJ7vhCsCaFQUiJtsJBJ0nUQ55SmpX6bIpGRKgll4lUWxJYuejqcbrZNLP8BXj7784ao
         KdJFvysBjaFAWIsofJIrgJfvekaXoAV8L9JeDcxLetjHkpi2vI5ys3disBPoP+ybTEFw
         dfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPIZ+fnAlaRxQz6OBsn+7HePWQmLD0l/EqVuqSsBiGQ=;
        b=rbPg5kGoEDeDp44rz4lw+MDyUu2CfXmTZXtx2HNbUTL3Cy72p2rU8jdB+lhJjdyO9Q
         dLP8JY2jRbUC9Eius0BEA8/OmgxbfxBY8EVOLTaMDQoK6MRFHL4FtElg0HhKi2UyH2G/
         Kdc+Novs+wM0hmpt/mG6Rs6oPDb2mv1fQyEyq1bX9p44rsju7CBhYbDpqik37rgaIy0w
         dzTupZfeP0EV3yC/09B2AaUlocbFC4F5BeKF2D+hXMX23O609T3yLZ3EPNLWRt82UnUT
         ErXiUJDoqCwdfDV+3gyCF04PX3EsP3MYbjx3kYrBbJ3lPM2vIfD8+fXUxIgMGh8+gK6L
         hysA==
X-Gm-Message-State: APjAAAW2nCvTA6gRxMSK87h+NtQ54WskPoxFKwJR629momiV4SLyufr4
        MTSPKtj1+qmGOPqExGVgV3UJqO61dy4ttg56HawJtw==
X-Google-Smtp-Source: APXvYqza0oEk98S7EffaHqeKg0F1DfdTRYKAD3oRj+0+f3G+JoJId+R/3P3jR0kEIrJu2sD12zU3NtPZzFtzmkJCAow=
X-Received: by 2002:a05:6512:419:: with SMTP id u25mr9802400lfk.165.1570227148706;
 Fri, 04 Oct 2019 15:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191002170249.17366-1-brgl@bgdev.pl>
In-Reply-To: <20191002170249.17366-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 00:12:17 +0200
Message-ID: <CACRpkdbUb-x1nSZS5f-jK5mtWKzODeihxxWxym3vc0UKiyQEcw@mail.gmail.com>
Subject: Re: [PATCH 0/6] gpio: replace nocache ioremap functions with devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Alban Bedel <albeu@free.fr>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 7:02 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> This series converts all users of nocache ioremap variants that aren't
> ia64-specific to using devm_platform_ioremap_resource().

Do we have an ia64 gpio driver even?

> Most of these don't call request_mem_region() currently, which
> devm_platform_ioremap_resource() does implicitly, so testing would
> be appreciated.
>
> Included are two minor fixes for xgene and htc-egpio.

All the patches:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Send me a pull request at your earliest convenience!

Thanks,
Linus Walleij
