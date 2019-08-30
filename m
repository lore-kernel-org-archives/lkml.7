Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A333C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377E123427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHQpPopx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfH3RAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:00:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39002 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfH3RAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:00:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id u6so2836021edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYx/7ZZJMriDlNg4ZPsq21Bt/UqwjpyoKzwS2ezJwBE=;
        b=fHQpPopx4LSbHrCvj7rw6l1CLOopOQzBJRjlVgJMH98EnxhPls8ZkejgfrdqYvd1FP
         QKVs/gZovPqgZxUmNAqZYRUvejV71/GkggtdXplY9NATi5nWIxAixao0KrT9LRLQc5Mo
         IvL8DnaH3m9RayTSLM/UcmEzg+vEWq0AJwrFiCbeg25v+y7rVW3KxQifYZIWFriZ//7t
         eUpgC+7JASwn8HE40bUopQfVznDkB6Xd2n/maTuYzzgCysZ5aTXqLXoKWcr8HVZTP3uf
         MlRfeJDYkmw3dtaGF7Y1Z8uuBAJ4elyMrGY18gR8GsbgHzFhqJLqcXG4EKtlrgnUkh6E
         nsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYx/7ZZJMriDlNg4ZPsq21Bt/UqwjpyoKzwS2ezJwBE=;
        b=JGybVHf+883Ag5u1Iz7pkxz/wKbYMFxPaW0OJgXw3f7nWTkYWV67QGMS25rQHFlmDk
         LQJK6JHuMbXSgN6cJvrw6K8bM6XTAyYHYoOfU4KC5I3JXLTwnri5+EESRCrscpTy38aL
         ikANKooLNivkweMV3tYJBivoUCXKYymDFNhfR4NyIq7CLXeUMbKOtasIUdQwJWDirud5
         n4rR2qsPf2Rb8Zi1GUQxAyPq72E2hvHDGorHGCbvkzr4i4ZdRomSA9Rr4R8Ns5FRNhDz
         lulN1J5ieF3hXw8ulBxCvt4YxRRdj109kix2o5a3oTHdPxrrObSc0WtpE0CGs6FCgZBQ
         /liw==
X-Gm-Message-State: APjAAAV660iUOuWghRRnRCCHH7FjT+saDf8sEvdnFWQxgpKSIpK3G0f8
        ZJYNNzSSYuaktagR3CH30cja6rkk4sEWDdEoLXo=
X-Google-Smtp-Source: APXvYqyZ6FiDbZXqhP+dUzvTWSJz4+sI8AP9b1IW11QFTTBJP93LJVxAD4AX29i6NLqjKmTRVObBEHluGl4oDaY4Kf4=
X-Received: by 2002:a50:8d8b:: with SMTP id r11mr16378963edh.163.1567184444153;
 Fri, 30 Aug 2019 10:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060550.62095-1-john.stultz@linaro.org>
 <CGME20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da@epcas3p1.samsung.com>
 <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com> <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com>
In-Reply-To: <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 30 Aug 2019 10:00:32 -0700
Message-ID: <CAF6AEGtkvRpXSoddjmxer2U6LxnV_SAe+jwE2Ct8B8dDpFy2mA@mail.gmail.com>
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matt Redfearn <matt.redfearn@thinci.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 29.08.2019 19:39, Rob Clark wrote:
> > On Wed, Aug 28, 2019 at 11:06 PM John Stultz <john.stultz@linaro.org> wrote:
> >> Since commit 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI
> >> host at probe time") landed in -next the HiKey board would fail
> >> to boot, looping:
> > No, please revert 83f35bc3a852.. that is going in the *complete* wrong
> > direction.  We actually should be moving panels to not require dsi
> > host until attach time, similar to how bridges work, not the other way
> > around.
>
>
> Devices of panels and bridges controlled via DSI will not appear at all
> if DSI host is not created.
>
> So this is the only direction!!!
>

I disagree, there is really no harm in the bridge probing if there is no dsi.

Furthermore, it seems that this change broke a few other drivers.

> >
> > The problem is that, when dealing with bootloader enabled display, we
> > need to be really careful not to touch the hardware until the display
> > driver knows the bridge/panel is present.  If the bridge/panel probes
> > after the display driver, we could end up killing scanout
> > (efifb/simplefb).. if the bridge/panel is missing some dependency and
> > never probes, it is rather unpleasant to be stuck trying to debug what
> > went wrong with no display.
>
>
> It has nothing to do with touching hardware, you can always (I hope)
> postpone it till all components are present.

Unfortunately this is harder than it sounds, since we need to read hw
revision registers for display and dsi blocks to know which hw
revision we are dealing with.

(Also, we need to avoid
drm_fb_helper_remove_conflicting_framebuffers() until we know we are
ready to go.)

We could possibly put more information in dt.  But the less we depend
on dt, the easier time we'll have adding support for ACPI boot on the
windows arm laptops.

> But it is just requirement of device/driver model in Linux Kernel.

yes and no.. the way the existing bridges work with a bridge->attach()
step seems fairly pragmatic to me.

>
> >
> > Sorry I didn't notice that adv7511 patch before it landed, but the
> > right thing to do now is to revert it.
>
>
> The 1st version of the patch was posted at the end of April and final
> version was queued 1st July, so it was quite long time for discussions
> and tests.

sorry I didn't notice the patch sooner, most of my bandwidth goes to mesa.

> Reverting it now seems quite late, especially if the patch does right
> thing and there is already proper fix for one encoder (kirin), moreover
> revert will break another platforms.

kirin isn't the only other user of adv75xx.. at least it is my
understanding that this broke db410c as well.

> Of course it seems you have different opinion what is the right thing in
> this case, so if you convince us that your approach is better one can
> revert the patch.

I guess my strongest / most immediate opinion is to not break other
existing adv75xx bridge users.

Beyond that, I found doing mipi_dsi_attach() in bridge->attach() was
quite convenient to get display handover from efifb work.  And that
was (previously) the way most of the bridges worked.

But maybe there is another way.. perhaps somehow the bridges/panels
could be added as sub-components using the component framework, to
prevent the toplevel drm device from probing until they are ready?
We'd still have the problem that the dsi component wants to be able to
read hw revision before registering dsi host.. but I suppose if CCF
exported a way that we could query whether the interface clk was
already enabled, we could have the clk enable/disable cycle that would
break efifb.

BR,
-R
