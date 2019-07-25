Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C17C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D8521901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="VWLm7pb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbfGYCwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:52:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35269 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388165AbfGYCwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:52:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so35417698qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 19:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYbaU/RcXXoDnrZeMQ94CuW6JxA4bBgoJMHBj+E8c3U=;
        b=VWLm7pb1QP2B0tihwP9USNElFOTjEp6/v4Hd70rru6K+fpcBLvsEDPhud9KTe7tp1C
         gOYRrkbY5+tRQ2nBFGxx4CHJMbUfjVlQcbyTAYX2Zp31qb6KjaBAMSvULqFBUzF8Kb53
         /HA80hSPJspYIH/79t0OEPIUrlEg+sessZKds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYbaU/RcXXoDnrZeMQ94CuW6JxA4bBgoJMHBj+E8c3U=;
        b=TnejBTZYubFC8vVS7xuFj9vu1ClD+66Whurk3NJ0X+LUH6N/tAiXYOUMQFBFF+/EuX
         DwEUpeHMa4iT0dA0oKnzNXVH4Go8mg4erN4Lr7FTud9qnBEavf/4qRtwfu91u07W9Z2e
         bXmGckxvWu+9oNSJm4Sfe9f/1pLjpM4DV5pF7ZwNjBDRE4qiPCo+OkQGFDT3zNzgI9tt
         M1z9Bsckb8ojUy5SwpGWX+VZd24CaKGUUzmXVdUx7GBKeRzUzM1Ng4yspSZ4h3hDjT13
         X4CFP0T1H0+gR82sP7C1fxrNZahXxaeJ0kpSLKVGRD6XpUBcljzTqMHdOpFroezNUH9V
         SS0w==
X-Gm-Message-State: APjAAAWh/PAe1NO94H9P3cpKnt0FDhQzP/lN2aVZ/w/pOE51bkmm0F9A
        lzBZy3j4vM4eeVSpSMFkFO26Mgzi8J15hjdL64A=
X-Google-Smtp-Source: APXvYqyM3sqW/iwNxySOMbv+KfAtuOilJ1tOA6mmxNVc4AhyblxyzikTIraPFFcFyT9J6TSPJ9ksANxa4ctyvg2uzs8=
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr56474155qke.171.1564023159729;
 Wed, 24 Jul 2019 19:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562734889.git.joe@perches.com> <cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com>
 <2a0c5ef5c7e20b190156908991e4c964a501d80a.camel@perches.com>
 <4f6709f8-381f-415c-8569-798b074b66c5@www.fastmail.com> <4e5bc8d61436024a30a8fb6a1516e29e23a75ede.camel@perches.com>
In-Reply-To: <4e5bc8d61436024a30a8fb6a1516e29e23a75ede.camel@perches.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 25 Jul 2019 02:52:27 +0000
Message-ID: <CACPK8Xd3+iwkuw-Ofwf+Hy1Ez5-1pBvnk_G4xT72ZQdOVd7Sag@mail.gmail.com>
Subject: Re: [PATCH 03/12] drm: aspeed_gfx: Fix misuse of GENMASK macro
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-aspeed@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 at 01:18, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-07-25 at 10:40 +0930, Andrew Jeffery wrote:
> >
> > On Thu, 25 Jul 2019, at 02:46, Joe Perches wrote:
> > > On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> > > > Arguments are supposed to be ordered high then low.
> > > >
> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > ---
> > > >  drivers/gpu/drm/aspeed/aspeed_gfx.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > index a10358bb61ec..095ea03e5833 100644
> > > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > @@ -74,7 +74,7 @@ int aspeed_gfx_create_output(struct drm_device *drm);
> > > >  /* CTRL2 */
> > > >  #define CRT_CTRL_DAC_EN                  BIT(0)
> > > >  #define CRT_CTRL_VBLANK_LINE(x)          (((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
> > > > -#define CRT_CTRL_VBLANK_LINE_MASK        GENMASK(20, 31)
> > > > +#define CRT_CTRL_VBLANK_LINE_MASK        GENMASK(31, 20)
> >
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>
> This hardly needs a review, it needs to be applied.
> There's a nominal git tree for aspeed here:
>
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
>
> But who's going to do apply this?

This is a DRM patch, so it goes through the DRM tree. I am a
co-maintainer there and can apply it once I remember how to drive the
tools.

(FYI, this macro is not used by the current driver).

Cheers,

Joel
