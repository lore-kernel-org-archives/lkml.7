Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9966CC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C073208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LdrNHrf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfFNGd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:33:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37901 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfFNGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:33:25 -0400
Received: by mail-io1-f65.google.com with SMTP id k13so3400415iop.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 23:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BC78yzeE2YVKx79Y2+WiS4iK6WeI4kP4QaEjuFxmzkA=;
        b=LdrNHrf+3Zal1wdOC3nqZSVJTZ1ztZNykMZ180uzsuSvlISU5nSC4VNTxS8zoaOfrO
         hOY0UTpCsxGSV73FXv3vjyCicnC4lkVC/M23gJz9R9s9Nyz4Zw76EARWPGeUB9vRve/I
         SekLQ1rfJUbhW5Es0Pnp2hsgMFL6UaXyKuSso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BC78yzeE2YVKx79Y2+WiS4iK6WeI4kP4QaEjuFxmzkA=;
        b=Keqa8P8Cb/S2HvpGS3/KU3pq+vY2gFrWKkUEwtEkPyC7VIVpSfC+Bo6Ae2KnT//28H
         onfrxNemjkUuo+ZF+axeTehWV8huIP2nCmoPrdyFdu7DgbFc8+6njqB+OLLneXsUuxts
         4jOjxubtpRmKTabExY8jWE/TMDhm3fnwrMRBPKXPXLOApI/GDiDJihdsUZ9wuUoRkmT4
         KX0XrWz/n3bG294CLu9Pz8fSpVRdxMxOz/sTMG3DOYyHmPTnYEqj80bP4MYfrv4N82Hj
         MJyDSdyGhouM/y+OG8yRqK1W64F7wR+wnnhHqbzkMfygb54SdaVGopGEjvkRDu7trMTJ
         4XRw==
X-Gm-Message-State: APjAAAWlp/rSSGDke2cMwxuLrnVFU9h8sYgTeDGJKPiXL2imYriYj9X+
        NY+XJULEG7urAa7Gu/ESI2lzXVEW9E9ur/ILDpFCxw==
X-Google-Smtp-Source: APXvYqweSn0IQ8QqCH4p5EFhvJNln9sfYUgga9RCLvHtMGb5QEWowO29OmcHTwtxMf4b7gjxCBAq/GZXs5jv+MERDZo=
X-Received: by 2002:a02:3308:: with SMTP id c8mr46484238jae.103.1560494004682;
 Thu, 13 Jun 2019 23:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
 <20190520090318.27570-2-jagan@amarulasolutions.com> <20190523203407.o5obg2wtj7wwau6a@flea>
 <CAMty3ZDDYEOvSbi7kmacjJZS6f3whpaGd4xsf4OUkXmBbTE3Qg@mail.gmail.com>
 <20190529145450.qnitxpmpr2a2xemk@flea> <CAMty3ZB89cPc8AycFPuNTfPC1dot4cNgN87v+rtQVW2zQh8uZg@mail.gmail.com>
 <20190604100011.cqkhpwmmmwh3vr3y@flea> <CAMty3ZAFdg1Ow8ececmqF2L0ckitkLdqUPmME3fGBoOaP32kzA@mail.gmail.com>
 <20190613125630.2b2fvvtvrcjlx4lv@flea>
In-Reply-To: <20190613125630.2b2fvvtvrcjlx4lv@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 14 Jun 2019 12:03:13 +0530
Message-ID: <CAMty3ZCNJK+Wcdw3AXKjUQZTD=PWijq9caNsTzpz+pSEqpUy_A@mail.gmail.com>
Subject: Re: [PATCH v10 01/11] drm/sun4i: dsi: Fix TCON DRQ set bits
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bhushan Shah <bshah@mykolab.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?B?5Z2a5a6a5YmN6KGM?= <powerpan@qq.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 6:56 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Jun 05, 2019 at 01:17:11PM +0530, Jagan Teki wrote:
> > On Tue, Jun 4, 2019 at 3:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Wed, May 29, 2019 at 11:44:56PM +0530, Jagan Teki wrote:
> > > > On Wed, May 29, 2019 at 8:24 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Fri, May 24, 2019 at 03:48:51PM +0530, Jagan Teki wrote:
> > > > > > On Fri, May 24, 2019 at 2:04 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > >
> > > > > > > On Mon, May 20, 2019 at 02:33:08PM +0530, Jagan Teki wrote:
> > > > > > > > According to "DRM kernel-internal display mode structure" in
> > > > > > > > include/drm/drm_modes.h the current driver is trying to include
> > > > > > > > sync timings along with front porch value while checking and
> > > > > > > > computing drq set bits in non-burst mode.
> > > > > > > >
> > > > > > > > mode->hsync_end - mode->hdisplay => horizontal front porch + sync
> > > > > > > >
> > > > > > > > With adding additional sync timings, the dsi controller leads to
> > > > > > > > wrong drq set bits for "bananapi,s070wv20-ct16" panel which indeed
> > > > > > > > trigger panel flip_done timed out as:
> > > > > > > >
> > > > > > > >  WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
> > > > > > > >  [CRTC:46:crtc-0] vblank wait timed out
> > > > > > > >  Modules linked in:
> > > > > > > >  CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 5.1.0-next-20190514-00026-g01f0c75b902d-dirty #13
> > > > > > > >  Hardware name: Allwinner sun8i Family
> > > > > > > >  Workqueue: events deferred_probe_work_func
> > > > > > > >  [<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
> > > > > > > >  [<c010b76c>] (show_stack) from [<c0688c70>] (dump_stack+0x84/0x98)
> > > > > > > >  [<c0688c70>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
> > > > > > > >  [<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
> > > > > > > >  [<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
> > > > > > > >  [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
> > > > > > > >  [<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
> > > > > > > >  [<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
> > > > > > > >  [<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
> > > > > > > >  [<c0411b64>] (restore_fbdev_mode_atomic) from [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
> > > > > > > >  [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0415774>] (drm_fb_helper_set_par+0x30/0x54)
> > > > > > > >  [<c0415774>] (drm_fb_helper_set_par) from [<c03ad450>] (fbcon_init+0x560/0x5ac)
> > > > > > > >  [<c03ad450>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
> > > > > > > >  [<c03eb8a0>] (visual_init) from [<c03ed1b8>] (do_bind_con_driver+0x1b0/0x390)
> > > > > > > >  [<c03ed1b8>] (do_bind_con_driver) from [<c03ed780>] (do_take_over_console+0x13c/0x1c4)
> > > > > > > >  [<c03ed780>] (do_take_over_console) from [<c03ad800>] (do_fbcon_takeover+0x74/0xcc)
> > > > > > > >  [<c03ad800>] (do_fbcon_takeover) from [<c013c9c8>] (notifier_call_chain+0x44/0x84)
> > > > > > > >  [<c013c9c8>] (notifier_call_chain) from [<c013cd20>] (__blocking_notifier_call_chain+0x48/0x60)
> > > > > > > >  [<c013cd20>] (__blocking_notifier_call_chain) from [<c013cd50>] (blocking_notifier_call_chain+0x18/0x20)
> > > > > > > >  [<c013cd50>] (blocking_notifier_call_chain) from [<c03a6e44>] (register_framebuffer+0x1e0/0x2f8)
> > > > > > > >  [<c03a6e44>] (register_framebuffer) from [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock+0x2fc/0x50c)
> > > > > > > >  [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock) from [<c04158c8>] (drm_fbdev_client_hotplug+0xe8/0x1b8)
> > > > > > > >  [<c04158c8>] (drm_fbdev_client_hotplug) from [<c0415a20>] (drm_fbdev_generic_setup+0x88/0x118)
> > > > > > > >  [<c0415a20>] (drm_fbdev_generic_setup) from [<c043f060>] (sun4i_drv_bind+0x128/0x160)
> > > > > > > >  [<c043f060>] (sun4i_drv_bind) from [<c044b598>] (try_to_bring_up_master+0x164/0x1a0)
> > > > > > > >  [<c044b598>] (try_to_bring_up_master) from [<c044b668>] (__component_add+0x94/0x140)
> > > > > > > >  [<c044b668>] (__component_add) from [<c0445e1c>] (sun6i_dsi_probe+0x144/0x234)
> > > > > > > >  [<c0445e1c>] (sun6i_dsi_probe) from [<c0452ef4>] (platform_drv_probe+0x48/0x9c)
> > > > > > > >  [<c0452ef4>] (platform_drv_probe) from [<c04512cc>] (really_probe+0x1dc/0x2c8)
> > > > > > > >  [<c04512cc>] (really_probe) from [<c0451518>] (driver_probe_device+0x60/0x160)
> > > > > > > >  [<c0451518>] (driver_probe_device) from [<c044f7a4>] (bus_for_each_drv+0x74/0xb8)
> > > > > > > >  [<c044f7a4>] (bus_for_each_drv) from [<c045107c>] (__device_attach+0xd0/0x13c)
> > > > > > > >  [<c045107c>] (__device_attach) from [<c0450474>] (bus_probe_device+0x84/0x8c)
> > > > > > > >  [<c0450474>] (bus_probe_device) from [<c0450900>] (deferred_probe_work_func+0x64/0x90)
> > > > > > > >  [<c0450900>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
> > > > > > > >  [<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
> > > > > > > >  [<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
> > > > > > > >  [<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> > > > > > > >  Exception stack(0xde539fb0 to 0xde539ff8)
> > > > > > > >  9fa0:                                     00000000 00000000 00000000 00000000
> > > > > > > >  9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > > > > > >  9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > > > > > >  ---[ end trace b57eb1e5c64c6b8b ]---
> > > > > > > >  random: fast init done
> > > > > > > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:46:crtc-0] flip_done timed out
> > > > > > > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:48:DSI-1] flip_done timed out
> > > > > > > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:30:plane-0] flip_done timed out
> > > > > > > >
> > > > > > > > But according to Allwinner A33, A64 BSP code [1] [3] the TCON DRQ for
> > > > > > > > non-burst DSI mode can be computed based on "horizontal front porch"
> > > > > > > > value only (no sync timings included).
> > > > > > > >
> > > > > > > > Detailed evidence for drq set bits based on A33 BSP [1] [2]
> > > > > > > >
> > > > > > > > => panel->lcd_ht - panel->lcd_x - panel->lcd_hbp - 20
> > > > > > > > => (tt->hor_front_porch + lcdp->panel_info.lcd_hbp +
> > > > > > > > lcdp->panel_info.lcd_x) - panel->lcd_x - panel->lcd_hbp - 20
> > > > > > > > => tt->hor_front_porch - 20
> > > > > > >
> > > > > > > The thing is, while your explanation on the DRM side is sound,
> > > > > > > Allwinner has been using the hbp field of their panel description to
> > > > > > > store what DRM calls the backporch and the sync period.
> > > > > >
> > > > > > Exactly, hbp = backporch + sync
> > > > > > https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L2046
> > > > > >
> > > > > > And the above computation is rely on that as well. If you can see the
> > > > > > final out of the above computation you can get the front porch value
> > > > > > (w/o sync )
> > > > >
> > > > > As I was saying, you are explaining it well for DRM, but in order for
> > > > > your last formula (the one coming from the BSP) to make sense, you
> > > > > have to explain that the horizontal back porch for Allwinner contains
> > > > > the sync period, otherwise your expansion of lcd_ht doesn't make
> > > > > sense.
> > > >
> > > > I'm not sure why we need to take care of back porch since the formula
> > > > clearly evaluating a result as front porch, without sync timing (as
> > > > current code included this sync), I keep the hbp and trying to
> > > > substitute the lcd_ht value so the end result would cancel hbp.
> > >
> > > Because it changes how lcd_ht expands. In the DRM case, it will expand
> > > to the displayed area, the front porch, the sync period and the back
> > > porch.
> > >
> > > In your case, you expand it to the displayed area, the front porch and
> > > the back porch, precisely because in Allwinner's case, the back porch
> > > has the sync period.
> >
> > I understand the point, but technically it matter about the final
> > computation result.  May be we can even manage the same computation in
> > back porch, but I'm not sure. Since the final output doesn't involve
> > any sync length, why we can include that ie what I'm not sure.
>
> We have the following formula:
> lcd_ht - lcd_x - lcd_hbp - 20
>
> Using the concepts as they are defined in DRM, this expands to:
> x + hbp + hsync + hfp - x - hbp - 20

Here is diff between allwinner hbp vs hbp in DRM.

Say hbp in DRM can call it hbackporch, so

=> x + hbackporch + hsync + hfp - -x - hbp - 20

(and here we need to substitute hbp formula from allwinner since the
actual equation would coming from there
https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L2046)

=> x + hbackporch + hsync + hfp - x - (hbackporch + hsync) - 20
=> x + hbackporch + hsync + hfp - x - hbackporch - hsync - 20
=> hfp - 20

>
> which ends up as
> hsync + hfp - 20
>
> Now, the same formula with how Allwinner defines it:
> x + hbp + hfp - x - hbp - 20
> which ends up as
> hfp - 20

This is true, and same I have explained in commit log. and hbp here is
as per allwinner so we endedup hfp. which is satisfied by above DRM
equation.

>
> So it definitely matters, and the sync period is used in one but not
> the other.

With the above explanation there is no sync included.
