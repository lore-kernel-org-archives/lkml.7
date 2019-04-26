Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67233C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEA6205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfDZPuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:50:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34424 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDZPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:50:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id n68so2173572qka.1;
        Fri, 26 Apr 2019 08:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymu21jeemjDqWGfdDWWVDciJ6KXF0S5M8rw5vvQXkyo=;
        b=CyVsmziMN6DyJghfyj9EE/6bt44Gm2rTL7Q2mkd5PO8ebHUoX6jjXTi0jaORoqYFoB
         ILO0GcnAmVKZQCM2MKUd+LqHfoP4JTsYItMk7s57W/NeMokaWVFnAgFBmjNA5PHPwfDj
         iH5FLFYpnukgRXRwMp57UDrGEEme9n8cm5VoxnK71SNuhTm87p/cNdqiTPzj35CIt1N6
         VS/9L+RcnUcBf35JsSB5vXp4hqaw0SSwvNQ4O9brd/sq2nKBcJhj00uUfzLJ5OdeArQl
         XQGppQhAE5pX3Qdh0V7/KJI+Cj/jPeVUWO7KtgMWEM+JXWXJvAcOQ1vM3BzcNiqgouVM
         +a4A==
X-Gm-Message-State: APjAAAWAd+zOivdVbJP8AI8QBApNthKDDv/jBlMfWYiY/PSAGxldtYr9
        E8fa/v3rQCNEbiJvDnQWeJGcJTqMoIvSQXSs+jHyF2wu/q8=
X-Google-Smtp-Source: APXvYqyy3E7iElaiWITvyIeh4oqmAW90omEuCc4kqJCt/TYzTHYJKlEaaN41YUxb+z0Wy5xkp9JrN+drjt5BkW0xyX0=
X-Received: by 2002:ae9:ee15:: with SMTP id i21mr33329018qkg.107.1556293838719;
 Fri, 26 Apr 2019 08:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190426145617.2342824-1-arnd@arndb.de> <20190426152033.GB19559@ulmo>
In-Reply-To: <20190426152033.GB19559@ulmo>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Apr 2019 17:50:22 +0200
Message-ID: <CAK8P3a0d7yoEhxf+-TcUfmsR5kj3KmZ_JwzfTkzcoTTcAHaJ7g@mail.gmail.com>
Subject: Re: [PATCH] amba: tegra-ahb: mark PM functions as __maybe_unused
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 5:20 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Fri, Apr 26, 2019 at 04:56:03PM +0200, Arnd Bergmann wrote:
> > clang warns about an unused variable when CONFIG_PM is disabled,
> > since it is only referenced from an #ifdef:
> >
> > drivers/amba/tegra-ahb.c:97:18: error: variable 'tegra_ahb_gizmo' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> >
> > Rather than trying to get the #ifdef right, remove it and
> > use __maybe_unused here, which is less error prone.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/amba/tegra-ahb.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Shouldn't tegra_ahb_gizmo have the same annotation, then? I do see that
> it's "used" in tegra_ahb_probe() as part of an ARRAY_SIZE() expression,
> but that technically doesn't mean that it would need to be emitted, but
> it might be enough to shut up clang?

It would be enough to annotated tegra_ahb_gizmo as __maybe_unused,
but I don't like the idea of using both __maybe_unused and #ifdef to
deal with the CONFIG_PM issue, so I was try to make this more consistent.

> Or does the __maybe_unused not get propagated?
>
> Looking at the code, I guess we could save a bit of memory if we didn't
> allocate memory for the zero-length "ctx" array for !PM since that's no
> longer needed. But then again, we've recently changed 32-bit Tegra to
> forcefully enable PM, just like we did for 64-bit Tegra, so that's moot
> anyway.

Right

> Do you want me to pick this up, or would you rather stash it into ARM
> SoC directly? If the latter:

Olof is currently doing the merges and I forgot to Cc him, so I'd prefer
if you could forward the patch to him or include it in a later pull
request.

        Arnd
