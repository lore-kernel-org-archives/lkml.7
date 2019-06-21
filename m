Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27862C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6E8208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFUIfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:35:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38809 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFUIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:35:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so8920142edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmt0kiyLRw+HeqUtPae5wb8eOqt4c0M39SkXRh/JHCk=;
        b=TvudfNZefnjNTT4KG9Plq5BqFXTflJOYcA0n32/VPlEZ8A4fHqS1TISHInUf10VFLB
         cItyClSbPURa8gCJHGPJNi8QntKT47PSrSPxZXcbsvjEG2R+1BhLrIoZz3OnkCxxmzQB
         Jtts4SYgFfQ3Mrx7GhGKcOwncNjEk0s1MsGAkVp+d1oWmOSqODXAUgiNBvJuavVcLBqY
         fTbCkuy8EBwatYm4aCgddttKRt9ivxzDjsmXZ0TBOmVH8WMuCVbQJI0n8t1oQxMl+C7G
         wGA4Ekt2vvS1eWQtVGBKlveMkz8heRcj5EXfrLG2BWg8hPQkenXUvGiJokmzEJA2vg17
         z0eA==
X-Gm-Message-State: APjAAAUpA40W6zTf7Vsae/7Tak9agQb85szD1ELzjO7k6+g9ZRtghQlD
        dgaBxXwelAyFumx/Q6Atr1gXe35NErs=
X-Google-Smtp-Source: APXvYqwI6LagF9gG99nUgbdl/iv/EnLcdekW46tfOQEiIJernJ2D0mBQBxW6cCwnO/770Xv6q6Uu5g==
X-Received: by 2002:a50:f7c1:: with SMTP id i1mr15861292edn.268.1561106125627;
        Fri, 21 Jun 2019 01:35:25 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id g16sm625392edc.76.2019.06.21.01.35.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 01:35:25 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id n9so5737737wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:35:25 -0700 (PDT)
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr28630201wrx.167.1561106124764;
 Fri, 21 Jun 2019 01:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
 <20190520090318.27570-4-jagan@amarulasolutions.com> <20190523203836.xy7nmte3ubyxwg27@flea>
 <CAMty3ZA2mZugso_rMy+anp1i1bSL5FtB2mAyN1v_gE3rds0LgA@mail.gmail.com>
In-Reply-To: <CAMty3ZA2mZugso_rMy+anp1i1bSL5FtB2mAyN1v_gE3rds0LgA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 21 Jun 2019 16:35:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v67He9t3RhHJAW5ph_1Wgrj0eqRAF7Xg1Weh8Do3tBFyeQ@mail.gmail.com>
Message-ID: <CAGb2v67He9t3RhHJAW5ph_1Wgrj0eqRAF7Xg1Weh8Do3tBFyeQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v10 03/11] drm/sun4i: dsi: Fix video
 start delay computation
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Fri, May 24, 2019 at 6:27 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, May 24, 2019 at 2:18 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, May 20, 2019 at 02:33:10PM +0530, Jagan Teki wrote:
> > > The current code is computing vertical video start delay as
> > >
> > > delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
> > >
> > > On which the second parameter
> > >
> > > mode->vsync_end - mode->vdisplay = front porch + sync timings
> > >
> > > according to "DRM kernel-internal display mode structure" in
> > > include/drm/drm_modes.h
> > >
> > > With adding additional sync timings, the desired video start delay
> > > value as 510 for "bananapi,s070wv20-ct16" panel timings which indeed
> > > trigger panel flip_done timed out as:
> > >
> > >  WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
> > >  [CRTC:46:crtc-0] vblank wait timed out
> > >  Modules linked in:
> > >  CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 5.1.0-next-20190514-00029-g09e5b0ed0a58 #18
> > >  Hardware name: Allwinner sun8i Family
> > >  Workqueue: events deferred_probe_work_func
> > >  [<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
> > >  [<c010b76c>] (show_stack) from [<c0688c70>] (dump_stack+0x84/0x98)
> > >  [<c0688c70>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
> > >  [<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
> > >  [<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
> > >  [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
> > >  [<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
> > >  [<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
> > >  [<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
> > >  [<c0411b64>] (restore_fbdev_mode_atomic) from [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
> > >  [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0415774>] (drm_fb_helper_set_par+0x30/0x54)
> > >  [<c0415774>] (drm_fb_helper_set_par) from [<c03ad450>] (fbcon_init+0x560/0x5ac)
> > >  [<c03ad450>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
> > >  [<c03eb8a0>] (visual_init) from [<c03ed1b8>] (do_bind_con_driver+0x1b0/0x390)
> > >  [<c03ed1b8>] (do_bind_con_driver) from [<c03ed780>] (do_take_over_console+0x13c/0x1c4)
> > >  [<c03ed780>] (do_take_over_console) from [<c03ad800>] (do_fbcon_takeover+0x74/0xcc)
> > >  [<c03ad800>] (do_fbcon_takeover) from [<c013c9c8>] (notifier_call_chain+0x44/0x84)
> > >  [<c013c9c8>] (notifier_call_chain) from [<c013cd20>] (__blocking_notifier_call_chain+0x48/0x60)
> > >  [<c013cd20>] (__blocking_notifier_call_chain) from [<c013cd50>] (blocking_notifier_call_chain+0x18/0x20)
> > >  [<c013cd50>] (blocking_notifier_call_chain) from [<c03a6e44>] (register_framebuffer+0x1e0/0x2f8)
> > >  [<c03a6e44>] (register_framebuffer) from [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock+0x2fc/0x50c)
> > >  [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock) from [<c04158c8>] (drm_fbdev_client_hotplug+0xe8/0x1b8)
> > >  [<c04158c8>] (drm_fbdev_client_hotplug) from [<c0415a20>] (drm_fbdev_generic_setup+0x88/0x118)
> > >  [<c0415a20>] (drm_fbdev_generic_setup) from [<c043f060>] (sun4i_drv_bind+0x128/0x160)
> > >  [<c043f060>] (sun4i_drv_bind) from [<c044b598>] (try_to_bring_up_master+0x164/0x1a0)
> > >  [<c044b598>] (try_to_bring_up_master) from [<c044b668>] (__component_add+0x94/0x140)
> > >  [<c044b668>] (__component_add) from [<c0445e1c>] (sun6i_dsi_probe+0x144/0x234)
> > >  [<c0445e1c>] (sun6i_dsi_probe) from [<c0452ef4>] (platform_drv_probe+0x48/0x9c)
> > >  [<c0452ef4>] (platform_drv_probe) from [<c04512cc>] (really_probe+0x1dc/0x2c8)
> > >  [<c04512cc>] (really_probe) from [<c0451518>] (driver_probe_device+0x60/0x160)
> > >  [<c0451518>] (driver_probe_device) from [<c044f7a4>] (bus_for_each_drv+0x74/0xb8)
> > >  [<c044f7a4>] (bus_for_each_drv) from [<c045107c>] (__device_attach+0xd0/0x13c)
> > >  [<c045107c>] (__device_attach) from [<c0450474>] (bus_probe_device+0x84/0x8c)
> > >  [<c0450474>] (bus_probe_device) from [<c0450900>] (deferred_probe_work_func+0x64/0x90)
> > >  [<c0450900>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
> > >  [<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
> > >  [<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
> > >  [<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> > >  Exception stack(0xde539fb0 to 0xde539ff8)
> > >  9fa0:                                     00000000 00000000 00000000 00000000
> > >  9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > >  9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > >  ---[ end trace 495200a78b24980e ]---
> > >  random: fast init done
> > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:46:crtc-0] flip_done timed out
> > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:48:DSI-1] flip_done timed out
> > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:30:plane-0] flip_done timed out
> > >
> > > But the expected video start delay value is 513 which states that
> > > the second parameter on the computation is "front porch" value
> > > (no sync timings included).
> > >
> > > This is clearly confirmed from the legacy [1] and new [2] bsp codes
> > > that the second parameter on the video start delay is "front porch"
> > >
> > > Here is the detailed evidence for calculating front porch as per
> > > bsp code.
> > >
> > > vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp
> > > => (panel->lcd_vt) - panel->lcd_y - panel->lcd_vbp
> > > => (tt->ver_front_porch + lcdp->panel_info.lcd_vbp
> > >     + lcdp->panel_info.lcd_y) -  panel->lcd_y - panel->lcd_vbp
> > > => tt->ver_front_porch
> >
> > The comment on patch 1 still applies on this patch
>
> Thanks, I have responded on that. Same applies here.

So this patch fixes the misinterpretation of Allwinner's back porch value,
much like patch 1, but this one is for the vertical back porch. So I think
you should follow the same advice I gave you for patch 1.

ChenYu
