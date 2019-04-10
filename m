Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358232082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="a+fx2L/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbfDJMfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:35:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41020 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731961AbfDJMfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:35:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id w30so2554609qta.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rNPAM2/g8CqWDOvOfGJ4cG8h10c+7F246j/Q9RmvZYo=;
        b=a+fx2L/8aXX+/kSlXuzsZ83HrbNoXOtqOiGKydrXbdaVyfmzdEze+olOOO7rZQEV+7
         PSdwq5sRlRSS1oHrXhzyMK668uIZw6I7bXhyJA7emurgTzg7kSAwc7N3TV9epkYrqeWv
         NPec7Kf6sDU0Frnyc6PYZ45A+W9arTp5TnHaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rNPAM2/g8CqWDOvOfGJ4cG8h10c+7F246j/Q9RmvZYo=;
        b=gFZPCoHcZcqiDtDc4usEVo5Z1jMJG5Xnb5cZwkkLX15w9BsCWdJ1pBbzJnl24lhjPi
         RMpvAN1oQJ/SwuGr2ulwu/nkOcDE88nkkYO6CKJRh5D/YGAiN0Jn8WM4co29RUwlABlH
         VqofKY5y2339oq71nr4s5tdfzKCNKfxpzn/yAdC6zIN7waFvupbjMWLsO4eJIwggX2oi
         6hmP24rgEYmq2eW4uEIaN/z6AX79xC/sV6WRdvs9KSmSK8y7+svseBel+fVQZC8XWkvN
         o726av2fQ5ZTE8fTVVYUL8Y2yV2Y8g8nwRG10XNmFdn9NDY6dbkKVBxCBdK0A1WciPvR
         wdYQ==
X-Gm-Message-State: APjAAAU9aNWaAIPW8jHZjP5WZo4TRSMOgNHiSq5GxVOfIedc1wV1bUm+
        BecPcIF1IhQmTyW7+TZZ3iyv0LrNPXwmV23nzl8NT2iwxk896g==
X-Google-Smtp-Source: APXvYqyWXmxQowxXohlALbCLFAD3sPtJSkBf0JjKT6EKmxER6E5oS7B2iPBC3ufYj0y8mw3zR8AJOaxZLNNB2xtPmxM=
X-Received: by 2002:ac8:2f85:: with SMTP id l5mr36329015qta.269.1554899706475;
 Wed, 10 Apr 2019 05:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190405052830.27899-1-joel@jms.id.au> <aae72ebf-2c9c-8cc4-4598-e8bb896b9a24@tronnes.org>
In-Reply-To: <aae72ebf-2c9c-8cc4-4598-e8bb896b9a24@tronnes.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 10 Apr 2019 12:34:54 +0000
Message-ID: <CACPK8XfosTwskxTDgv1ONdfB5yAtN9QukH=1TFu06RorrZS8cQ@mail.gmail.com>
Subject: Re: [PATCH] drm: aspeed: Select CMA only if available
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2019 at 11:20, Noralf Tr=C3=B8nnes <noralf@tronnes.org> wrote=
:
>
>
>
> Den 05.04.2019 07.28, skrev Joel Stanley:
> > When building this driver for architectures where CMA is not available.
> >
> > Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > This fixes the build break.
> >
> > Another question is if we need to select this at all, as we have a
> > reserved memory region to allocate from. I am not familiar with this
> > area, so advice is welcome.
> >
> >  drivers/gpu/drm/aspeed/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kc=
onfig
> > index 42b74d18a41b..1775fb85ec74 100644
> > --- a/drivers/gpu/drm/aspeed/Kconfig
> > +++ b/drivers/gpu/drm/aspeed/Kconfig
> > @@ -4,8 +4,8 @@ config DRM_ASPEED_GFX
> >       select DRM_KMS_HELPER
> >       select DRM_KMS_CMA_HELPER
> >       select DRM_PANEL
> > -     select DMA_CMA
> > -     select CMA
> > +     select DMA_CMA if HAVE_DMA_CONTIGUOUS
> > +     select CMA if HAVE_DMA_CONTIGUOUS
>
> I'm no expert on this, but the rule is that you should not select
> options that are user visible which both of these are. The user should
> select them. So I believe that you should remove them.
>
> Docs: Documentation/kbuild/kconfig-language.txt

I agree with your point, I was following what etnaviv did in this case.

As it's written the driver requires CMA to be enabled, or else it
fails to probe:

 [    3.398247] aspeed_gfx 1e6e6000.display: failed to initialize
reserved mem: -22
 [    3.410471] aspeed_gfx: probe of 1e6e6000.display failed with error -22

It was suggested by Michael that 'imply' might be appropriate here.
However, in my testing 'imply' does not set CMA=3Dy . If I start from
both CMA and ASPEED_GFX disabled, and then use menuconfig to enable
ASPEED_GFX, I expected CMA to be enabled. It does not.

In v2[1] of this patch I make the driver depend on ARCH_ASPEED, which
being ARM means it has CMA available. The other case is when enabling
COMPILE_TEST, where the test for HAVE_DMA_CONTIGUOUS will stop the
build break.

CMA only depends on MMU, so we should be safe to select it. I'm open
to other suggstions though.

Cheers,

Joel

[1] https://lore.kernel.org/linux-arm-kernel/20190405081117.27339-1-joel@jm=
s.id.au/
