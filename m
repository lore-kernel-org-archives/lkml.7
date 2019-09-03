Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F8C22CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajc4zOao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfICQAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:00:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45556 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:00:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id f19so5050199eds.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHJE/4pvQVkwd+fiNmcb9b6f+m/QkW8sj9h1na4g5gU=;
        b=ajc4zOaoLHe8vrsbu2wpU9mZXXBmQvW1RkBlJpkIw8KqTjckfP3AJmJPUYxpOhQyOo
         XD0JpsUy+TdY47QjeX9fTVsuFshocPo9RWy/26bfPmMzHiqD7cKVbU3usL7U1dG04ixd
         NYV6rruDp2jKljwxXi1ifE15oaHYMD4A466FJrKcVLVwTarutozVzYnmPdd7yIWmasDU
         pf6dvVAW5px3KfhRaM5V+xqmyBMXR7aFBPLyutxHW12j+X1vmTgDHlCl1vU7jwlaAVhM
         yUquX/Z31xT+Melx23Ls0NdVhdBPJV6l4v89jCOq1MNvBgBzU43tdE5g00KHpxoSZk3d
         iHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHJE/4pvQVkwd+fiNmcb9b6f+m/QkW8sj9h1na4g5gU=;
        b=t8n5ZLsi2WR4XwRMavxuzMa2UGQP+6wWXawo1fFrUe4toZp6D7P8ibx17BMi+AWw1M
         gTa+Y8Ybewe4SNcX8JzTFez8Elt1aPJeQ+/tcHPCN/xHNM3HEhzUGr7hE6G5m1VcjrL0
         rbclpSgycWnYcnmWIwXsoMfN+6UnP/YVC93bEKMnsFDlvDvml8kr0miX9qFsYEaLTRba
         ahMjx8cuiua8DvZP3W5xfKJwByV/D/giC6qVdv61s31fF3rE47LJUEH6j0/ZzQl+3bzO
         LMBvFWla9w6pNGKl/N8hSP/N/HpddVG3864cmYpVEl0+J5JkyAllE2eop1kBrgH342pd
         DoLw==
X-Gm-Message-State: APjAAAV21l/ruFJj0Xq6dmeiRTAIUFlPyLpVSdQyDFR20zDADUUML3vx
        ycVZFhTVy0xzIF+dSau2TOrwh2ySwucI+Y47ASM=
X-Google-Smtp-Source: APXvYqxiV3w3ccYIkpZ2b1KvSwiBEK/tAZMVv8kGY1wJr5gPHsGRyXhIi8Hx8jdK5tKm0DJBoU9Af9r/bsjOOmiV6Zw=
X-Received: by 2002:a05:6402:17ba:: with SMTP id j26mr13473382edy.272.1567526418616;
 Tue, 03 Sep 2019 09:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060550.62095-1-john.stultz@linaro.org>
 <CGME20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da@epcas3p1.samsung.com>
 <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
 <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com> <CAF6AEGtkvRpXSoddjmxer2U6LxnV_SAe+jwE2Ct8B8dDpFy2mA@mail.gmail.com>
 <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com>
In-Reply-To: <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 3 Sep 2019 09:00:06 -0700
Message-ID: <CAF6AEGsiYd9QTh0NHLOgh2NkP7AcVbN1MbHJNH1Sk7tL1tUQ6g@mail.gmail.com>
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

On Mon, Sep 2, 2019 at 6:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 30.08.2019 19:00, Rob Clark wrote:
> > On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> On 29.08.2019 19:39, Rob Clark wrote:
> >>> On Wed, Aug 28, 2019 at 11:06 PM John Stultz <john.stultz@linaro.org> wrote:
> >>>> Since commit 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI
> >>>> host at probe time") landed in -next the HiKey board would fail
> >>>> to boot, looping:
> >>> No, please revert 83f35bc3a852.. that is going in the *complete* wrong
> >>> direction.  We actually should be moving panels to not require dsi
> >>> host until attach time, similar to how bridges work, not the other way
> >>> around.
> >>
> >> Devices of panels and bridges controlled via DSI will not appear at all
> >> if DSI host is not created.
> >>
> >> So this is the only direction!!!
> >>
> > I disagree, there is really no harm in the bridge probing if there is no dsi.
> >
> > Furthermore, it seems that this change broke a few other drivers.
>
>
> If the bridge/panel is controlled via dsi, it will not be probed at all
> if DSI host/bus is not created, so it will not work at all. Upstream
> device will wait forever for downstream drm_(panel|bridge).
>
> So IMO we just do not have choice here.
>
> If you know better alternative let us know, otherwise we should proceed
> with "drm: kirin: Fix dsi probe/attach logic" patch.
>
>
> >
> >>> The problem is that, when dealing with bootloader enabled display, we
> >>> need to be really careful not to touch the hardware until the display
> >>> driver knows the bridge/panel is present.  If the bridge/panel probes
> >>> after the display driver, we could end up killing scanout
> >>> (efifb/simplefb).. if the bridge/panel is missing some dependency and
> >>> never probes, it is rather unpleasant to be stuck trying to debug what
> >>> went wrong with no display.
> >>
> >> It has nothing to do with touching hardware, you can always (I hope)
> >> postpone it till all components are present.
> > Unfortunately this is harder than it sounds, since we need to read hw
> > revision registers for display and dsi blocks to know which hw
> > revision we are dealing with.
> >
> > (Also, we need to avoid
> > drm_fb_helper_remove_conflicting_framebuffers() until we know we are
> > ready to go.)
> >
> > We could possibly put more information in dt.  But the less we depend
> > on dt, the easier time we'll have adding support for ACPI boot on the
> > windows arm laptops.
> >
> >> But it is just requirement of device/driver model in Linux Kernel.
> > yes and no.. the way the existing bridges work with a bridge->attach()
> > step seems fairly pragmatic to me.
> >
> >>> Sorry I didn't notice that adv7511 patch before it landed, but the
> >>> right thing to do now is to revert it.
> >>
> >> The 1st version of the patch was posted at the end of April and final
> >> version was queued 1st July, so it was quite long time for discussions
> >> and tests.
> > sorry I didn't notice the patch sooner, most of my bandwidth goes to mesa.
> >
> >> Reverting it now seems quite late, especially if the patch does right
> >> thing and there is already proper fix for one encoder (kirin), moreover
> >> revert will break another platforms.
> > kirin isn't the only other user of adv75xx.. at least it is my
> > understanding that this broke db410c as well.
> >
> >> Of course it seems you have different opinion what is the right thing in
> >> this case, so if you convince us that your approach is better one can
> >> revert the patch.
> > I guess my strongest / most immediate opinion is to not break other
> > existing adv75xx bridge users.
>
>
> It is pity that breakage happened, and next time we should be more
> strict about testing other platforms, before patch acceptance.
>
> But reverting it now will break also platform which depend on it.
>
> Anyway the old order was incorrect and prevented other users from adv*
> driver usage, so it should be fixed anyway.
>
>
> > Beyond that, I found doing mipi_dsi_attach() in bridge->attach() was
> > quite convenient to get display handover from efifb work.  And that
> > was (previously) the way most of the bridges worked.
> >
> > But maybe there is another way.. perhaps somehow the bridges/panels
> > could be added as sub-components using the component framework, to
> > prevent the toplevel drm device from probing until they are ready?
>
>
> If you mean 'probe' as in initialization from component_master::bind
> callback with this patch it still works, DSI-HOST calls component_add
> after drm_bridge is found.
>
>
> > We'd still have the problem that the dsi component wants to be able to
> > read hw revision before registering dsi host.. but I suppose if CCF
> > exported a way that we could query whether the interface clk was
> > already enabled, we could have the clk enable/disable cycle that would
> > break efifb.
>
>
> I am not familiar with efifb, if you describe the issue you have in more
> detail we can try to find some solution together.
>

You don't really need to know too much about efifb.. the story would
be the same with simplefb, the only difference is that the scanout
address/size/format come from EFI GOP instead of dt.

The main thing is we really want to avoid a runpm resume/suspend cycle
until the we have all the components of the display, including
bridge/panel.  If the display is enabled by bootloader, then the
initial resume will be no-op (turning on clks and power domains that
are already on), but the following suspend will actually turn things
off.  If this happens because, for example, the bridge driver didn't
get copied to initrd, or probe-deferred because it is missing one of
it's dependencies, the result will be a black screen with no way to
debug what went wrong.

I guess if we can rely on panel/bridge being probed indirectly from
mipi_dsi_host_register() (but before it returns, so dsi host can defer
if bridge/panel is missing) maybe that works out..

BR,
-R
