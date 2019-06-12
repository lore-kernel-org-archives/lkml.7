Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B6320874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1Zi7sy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436745AbfFLH57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:57:59 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42552 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436729AbfFLH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:57:58 -0400
Received: by mail-lj1-f174.google.com with SMTP id t28so14203511lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hu5mYy1Aik4aGPpt9uX6kLLpSvEpnab82Qz7EMOsZ3s=;
        b=W1Zi7sy9qLC8jVk3nI8TRNpGFhYFOg7/lKaQRrKAONX2MyAFj2Lxo/XZLD7w9L9J7G
         4HYzdvdsUG1/nA6PskBT2Pr7ZmrNoSE/oO7BZSxQg0QizW2L9D2Ggzgd2EO6fVqvIE1L
         zKWQOcKKgkm5x997Hyd3bJaqGq8QHPX1IVzJy9BU19gJUn4CtAijTcv4GDZm/PKjp/q+
         M0GG5oMeL0QsLX/oHElAhFI1DN1MWe+Xe7KcLbp9lLt3IgDbDZXdaZz1wuIs1rwn41Rg
         GwxUnKxkTbajCy/iDW6NUVvfR37huqzvfE4N+QRN73y1wWkSrzq4SWgd5sRV/NMwzdtE
         6pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hu5mYy1Aik4aGPpt9uX6kLLpSvEpnab82Qz7EMOsZ3s=;
        b=ISdlbtPpLmeW5Oc79EFgFx9zZ1molQOtTSq+21a2bmd2D2A4YlqxNzGdCdN8Ca5Msc
         XvcBQSX9AlEEvQ7ZaGZUQt2PDNUDgD8gpnW7EqkjsLJwdUMPEbZU7N8SrcM8ZzP4i1MS
         iMr2ilBN485DUsOBYEMzDToAwcpLGgc9lSsgPQlAnBUBKv6Vfk9g6NoAQACvFNGrwxcL
         nVKWz1E3nFKTxtZUZHY404lkcBx31/DXK2rGcs5LcGVX0Dx4nf2zCXffAZ/dGxIBAtOT
         WUsgxNHqTlJsXzYNpBuZT8xPzgHYECr+SPeuwaMwKLgD2weCGmVc8vM70M9VsoNGlfrE
         yjvg==
X-Gm-Message-State: APjAAAX8szPjAYePSCwUtPSttE+V0tJc9I22QWi364YyGxgmMgZfxpK+
        HyRmC4dFyjdY+aIiXJN/+CYvNiGC3jG9OKsJAW2t0Q==
X-Google-Smtp-Source: APXvYqxl+ZtAXPoKQZGqWkavmG+pD5XFEpR1tkG2C7EK7lnCxHlD6+0qWESpsMmznMtDhMWnyXc7r0iAy9Bqcf/Y/90=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr3842459ljj.113.1560326276665;
 Wed, 12 Jun 2019 00:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-5-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-5-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 09:57:45 +0200
Message-ID: <CACRpkdZ2o1AP4YdbNqS7BjHZzpgfpMLSM8GeXNWFPdJ8_C0shQ@mail.gmail.com>
Subject: Re: [PATCH-next 04/20] gpio: gpio-omap: clean up edge interrupt handling
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

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> The edge interrupt handling was effectively:
>
>         isr = ISR_reg & enabled;
>         if (bank->level_mask)
>                 level_mask = bank->level_mask & enabled;
>         else
>                 level_mask = 0;
>
>         edge = isr & ~level_mask;
>
> When bank->level_mask is zero, level_mask will be computed as zero
> anyway, so the if() statement is redundant.  We are then left with:
>
>         isr = ISR_reg & enabled;
>         level_mask = bank->level_mask & enabled;
>         edge = isr & ~level_mask;
>
> This can be simplified further to:
>
>         isr = ISR_reg & enabled;
>         edge = isr & ~bank->level_mask;
>
> since the second mask with 'enabled' is redundant.
>
> Improve the associated comment as well.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
