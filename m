Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A14C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21342175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcsCwriv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfDWLDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:03:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35782 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfDWLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:03:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id j20so11400373lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PiubGy9ByNwpv5piHSkClHKbawRSqgXU3ydjWaya2A=;
        b=LcsCwriv3Ef+96CmDtMlpTKKzPOXR8LmPfjgQXoK9+SsGI53RNKLCD1YZE6eGDBLP0
         ZBmgzbejDmSmfDS6K9lgUCN0uW1lBj4PZOFzCtFKtanJAWxduqkzOYFBxe/R6mY3epP4
         ZJbtDE8phlY8OQqnMD1kALpBX9yBod+SH1UIAnHV+G4JI5uYF+M9gpa1qWk1URU/Z/2m
         sVxNsAYVBogn8e518O9tXYOIPHWi9PIOzYikhHaBP9uYYVUSKKkPuLwHCHeOxjX6tIQG
         waAAWh4FSwx3I4rT/ejmSSCl3N0WwgsZqSxp1NGndLMAB004zuL4QKee6hY5tdJWZjoL
         COHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PiubGy9ByNwpv5piHSkClHKbawRSqgXU3ydjWaya2A=;
        b=QU85g9/+E9/BBo6psmExqRxOeZT5wh2ny2KLRcWQwqeoM1es4Jn0fHoEoLVf/CmLTR
         Zlg3QdF6UEoi9cMd14PsH5L1tc5h3QD+ZoOU72M3s86gQD8nRGdGqVYIA765DxjqLOaB
         lMGcO9drwXw1xhyf1LPDgnBfaTPlequ/7EcPJ79PBV6fE8ABApXMEBoCLi3qyDK0rj75
         bXrypRnqW0xt5ngizggW7B9KUiVOGX7Y9yh2N2MiaeYyO+7xkjw5XgU7ZZYmc/jXKiIm
         vKyPnO+tbLV8jL8C2bLrikSye0uvyJXvSNEMb5lqzbMuR9b8dT48+iT4vFdBOWCiOqdN
         EHBg==
X-Gm-Message-State: APjAAAWcxszhCcWFki3OnQUrpWND52XClC9ghXOe0TODxumoaAJ6hoOv
        gcw6PquYaDdlrC0YydNqqRsN43XOVl4Yp4tlK1470A==
X-Google-Smtp-Source: APXvYqzrsmnmuTXfbUzN6uxez15e8e+cVlU7dys8boY10K+kzdpk7nTe0A/scVnynwnfMaTQCGLhuc8YbyslwSo6l0s=
X-Received: by 2002:a19:f001:: with SMTP id p1mr14394729lfc.27.1556017378165;
 Tue, 23 Apr 2019 04:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190416145612.30364-1-yuehaibing@huawei.com>
In-Reply-To: <20190416145612.30364-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:02:39 +0200
Message-ID: <CACRpkdbTTaYV4+VuVPSH=dbH_6mMqYHbenSqAOvYS_kwJpeL3Q@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: pxa: Make two symbols static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:56 PM Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warnings:
>
> drivers/gpio/gpio-pxa.c:580:29: warning:
>  symbol 'pxa_irq_domain_ops' was not declared. Should it be static?
> drivers/gpio/gpio-pxa.c:819:20: warning:
>  symbol 'pxa_gpio_syscore_ops' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
