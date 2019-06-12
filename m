Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CEAC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F408215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rz+qpRkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfFLIy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:54:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36189 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437357AbfFLIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:54:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so14380411ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IKFQlxi0I3P+ssh5DIOko6Z7anWDy6UzmX3xFflNos=;
        b=Rz+qpRkAbq+hptik3GAI7okccDPVbInSsLaxqEtZTomNfsjlqRfd9PzKBT/YzBuNPE
         veYB4wGxhDLSH/ufDqUCISgInQPxltZputvSEzEcNMNOMAf9Ibxx9N5g5qc0qwH5gn8N
         Yafhk7x8bsm31SWMGMSv4Hnhrfg5fyrZggWpy7LS26LpYF/T/7M6qhr0mabXtEMvpDzh
         8CTTxM5sOHxKi26a35R7GIpCTvb4xnvsK1B2TIBF38F/LIoJ+EJa3pgDRmewKGlz4tKo
         gPg1dq7xGijhxl0IqDkiB6K/1PEXDtNrarjigDIXHs7l1kuLZ/WQCk0JN4Es9oe/Or72
         TJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IKFQlxi0I3P+ssh5DIOko6Z7anWDy6UzmX3xFflNos=;
        b=m2k/uQpy8dNGAuwT0wf7E2yoLsQH40Fxg+N4+MjSfsQT0sLhIItowxyirA4C5AsKcJ
         oNV4Ayyq2GF1uDvH3/6wR7owFApBXgH0fGWQqoATT2OA9NBYuKOKxDM8Cj1lgR1tU8fZ
         ETuYqw16/zQxPaq9kgVJkS2oz4Rp6L+QhE39KT3EpHG+q7ssRokVJZV7zgTJbSaTmyCa
         McuLfH4sWuNt41A3x+mA2yIWXcfuGunRY5QrRiPBeh2V+1imjCvzj9/SbXHp9/7VBtFb
         v8HL0oYPc6+wcmTDisWLsxhJbBWt6oIJwoOd84NnUNK8LWedtcBfj+Gu4JjULk2p5DZZ
         MPpQ==
X-Gm-Message-State: APjAAAU3BTRUFVn8eGTaa17gcGhdW2BA2br2jgZETiJKbaXdmOum/tZQ
        skeYcfXQf1/ILvGqOtSppz03mERMzXOEl84+v0OMTzmLH+M=
X-Google-Smtp-Source: APXvYqxMH6dEoA+jip3uBxOPRmjugsKb0aIbkzeQ/8izSdJ+XQ+aTevZeOi2mpb9gqe3y8jgwkgiGr950I4ymBVhnDQ=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr33803985lje.46.1560329662190;
 Wed, 12 Jun 2019 01:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-14-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-14-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:54:10 +0200
Message-ID: <CACRpkdZmnezPYiKpi+7Ka70YL4H4O=_Gv=DqXfvY9J4xv8X37Q@mail.gmail.com>
Subject: Re: [PATCH-next 13/20] gpio: gpio-omap: simplify omap_toggle_gpio_edge_triggering()
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> This function open-codes an exclusive-or bitwise operation using an
> if() statement and explicitly setting or clearing the bit. Instead,
> use an exclusive-or operation instead, and simplify the function.
>
> We can combine the preprocessor conditional using IS_ENABLED() and
> gain some additional compilation coverage.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
