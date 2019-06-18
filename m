Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A543C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D212420B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfFROp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:45:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36653 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfFROp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:45:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so22132673edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HE93dhpJxlFYudzQ5xHr1bpHKWKPEWly3PXEgXNTmE=;
        b=W0JymefgrEbgsFdwKgvyWVpLa2zIFPEoj/udtIZTi3y7MiiGoBCJyDXvrveGkFSleK
         jk9WBk/YE0n+pAffVrfFCrG5FJ74yMoQoil//x9lEfvOhNNpIs7KmgfY1Znly509fmdQ
         EIATTIN5LKvXnsZzlnbaO+SpG0y3Mh3XrD+dKevjQfTrqcHVWV9sJLWDc3vefJb8qpWg
         BhcXtEbo7s9pnGFQhYx7bWzZZxTM+Cns5ltIyaejQdaaE9a1d+DiFDw/r8w2mpsvk7to
         lqZnv/brkP435czvALAiFqsrrJf2tyvVOfLlMpuG7wMgSFcHTHux3aTT9j0kaUsl6U2z
         VVhg==
X-Gm-Message-State: APjAAAV5Jezs4sOmS82A+qegINpqGL3iGg4R2Ryoc+mBXP9UXu3hf/ih
        AB6kHl4qKSzfwvKWdbdPeCgXhgQWdIw=
X-Google-Smtp-Source: APXvYqx0I+2k0wfgDR071HyrKkiJ55KY8+L2H9+z4DpY21h6zGP/xe5IZmNgRhk+zVpsNQJ5UCGjkw==
X-Received: by 2002:a50:9822:: with SMTP id g31mr96703428edb.175.1560869153984;
        Tue, 18 Jun 2019 07:45:53 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id s4sm829903ejm.41.2019.06.18.07.45.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:45:53 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id z23so3559409wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:45:52 -0700 (PDT)
X-Received: by 2002:a7b:c051:: with SMTP id u17mr2155372wmc.25.1560869152086;
 Tue, 18 Jun 2019 07:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
 <20190520090318.27570-2-jagan@amarulasolutions.com> <20190523203407.o5obg2wtj7wwau6a@flea>
 <CAMty3ZDDYEOvSbi7kmacjJZS6f3whpaGd4xsf4OUkXmBbTE3Qg@mail.gmail.com>
 <20190529145450.qnitxpmpr2a2xemk@flea> <CAMty3ZB89cPc8AycFPuNTfPC1dot4cNgN87v+rtQVW2zQh8uZg@mail.gmail.com>
 <20190604100011.cqkhpwmmmwh3vr3y@flea> <CAMty3ZAFdg1Ow8ececmqF2L0ckitkLdqUPmME3fGBoOaP32kzA@mail.gmail.com>
 <20190613125630.2b2fvvtvrcjlx4lv@flea> <CAMty3ZCNJK+Wcdw3AXKjUQZTD=PWijq9caNsTzpz+pSEqpUy_A@mail.gmail.com>
 <20190614144526.lorg3saj4wjopgne@flea> <CAMty3ZBuKWFKckPt+C=XeXgvSLtYL6uuyy29vw2C89TSiDs15w@mail.gmail.com>
 <CAGb2v679C2PRsEJFo_Q+PbKZXvW3B72T28mUJJDe1Sqarjy36A@mail.gmail.com> <CAMty3ZANkmf=ih4snh1xCLxJaFvPoBPvzpD=aZQCiuSM004UVw@mail.gmail.com>
In-Reply-To: <CAMty3ZANkmf=ih4snh1xCLxJaFvPoBPvzpD=aZQCiuSM004UVw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 18 Jun 2019 22:45:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64gBGcgxXDB0Xd1oxE_jX4kWp4dGE0uORFSYW=PAFAEvA@mail.gmail.com>
Message-ID: <CAGb2v64gBGcgxXDB0Xd1oxE_jX4kWp4dGE0uORFSYW=PAFAEvA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v10 01/11] drm/sun4i: dsi: Fix TCON DRQ
 set bits
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

On Tue, Jun 18, 2019 at 8:11 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Tue, Jun 18, 2019 at 5:13 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Tue, Jun 18, 2019 at 6:51 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Fri, Jun 14, 2019 at 8:15 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Fri, Jun 14, 2019 at 12:03:13PM +0530, Jagan Teki wrote:
> > > > > On Thu, Jun 13, 2019 at 6:56 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 05, 2019 at 01:17:11PM +0530, Jagan Teki wrote:
> > > > > > > On Tue, Jun 4, 2019 at 3:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, May 29, 2019 at 11:44:56PM +0530, Jagan Teki wrote:
> > > > > > > > > On Wed, May 29, 2019 at 8:24 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, May 24, 2019 at 03:48:51PM +0530, Jagan Teki wrote:
> > > > > > > > > > > On Fri, May 24, 2019 at 2:04 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, May 20, 2019 at 02:33:08PM +0530, Jagan Teki wrote:
> > > > > > > > > > > > > According to "DRM kernel-internal display mode structure" in
> > > > > > > > > > > > > include/drm/drm_modes.h the current driver is trying to include
> > > > > > > > > > > > > sync timings along with front porch value while checking and
> > > > > > > > > > > > > computing drq set bits in non-burst mode.
> > > > > > > > > > > > >
> > > > > > > > > > > > > mode->hsync_end - mode->hdisplay => horizontal front porch + sync
> > > > > > > > > > > > >
> > > > > > > > > > > > > With adding additional sync timings, the dsi controller leads to
> > > > > > > > > > > > > wrong drq set bits for "bananapi,s070wv20-ct16" panel which indeed
> > > > > > > > > > > > > trigger panel flip_done timed out as:
> > > > > > > > > > > > >
> > > > > > > > > > > > >  WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
> > > > > > > > > > > > >  [CRTC:46:crtc-0] vblank wait timed out
> > > > > > > > > > > > >  Modules linked in:
> > > > > > > > > > > > >  CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 5.1.0-next-20190514-00026-g01f0c75b902d-dirty #13
> > > > > > > > > > > > >  Hardware name: Allwinner sun8i Family
> > > > > > > > > > > > >  Workqueue: events deferred_probe_work_func
> > > > > > > > > > > > >  [<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
> > > > > > > > > > > > >  [<c010b76c>] (show_stack) from [<c0688c70>] (dump_stack+0x84/0x98)
> > > > > > > > > > > > >  [<c0688c70>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
> > > > > > > > > > > > >  [<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
> > > > > > > > > > > > >  [<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
> > > > > > > > > > > > >  [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
> > > > > > > > > > > > >  [<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
> > > > > > > > > > > > >  [<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
> > > > > > > > > > > > >  [<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
> > > > > > > > > > > > >  [<c0411b64>] (restore_fbdev_mode_atomic) from [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
> > > > > > > > > > > > >  [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0415774>] (drm_fb_helper_set_par+0x30/0x54)
> > > > > > > > > > > > >  [<c0415774>] (drm_fb_helper_set_par) from [<c03ad450>] (fbcon_init+0x560/0x5ac)
> > > > > > > > > > > > >  [<c03ad450>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
> > > > > > > > > > > > >  [<c03eb8a0>] (visual_init) from [<c03ed1b8>] (do_bind_con_driver+0x1b0/0x390)
> > > > > > > > > > > > >  [<c03ed1b8>] (do_bind_con_driver) from [<c03ed780>] (do_take_over_console+0x13c/0x1c4)
> > > > > > > > > > > > >  [<c03ed780>] (do_take_over_console) from [<c03ad800>] (do_fbcon_takeover+0x74/0xcc)
> > > > > > > > > > > > >  [<c03ad800>] (do_fbcon_takeover) from [<c013c9c8>] (notifier_call_chain+0x44/0x84)
> > > > > > > > > > > > >  [<c013c9c8>] (notifier_call_chain) from [<c013cd20>] (__blocking_notifier_call_chain+0x48/0x60)
> > > > > > > > > > > > >  [<c013cd20>] (__blocking_notifier_call_chain) from [<c013cd50>] (blocking_notifier_call_chain+0x18/0x20)
> > > > > > > > > > > > >  [<c013cd50>] (blocking_notifier_call_chain) from [<c03a6e44>] (register_framebuffer+0x1e0/0x2f8)
> > > > > > > > > > > > >  [<c03a6e44>] (register_framebuffer) from [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock+0x2fc/0x50c)
> > > > > > > > > > > > >  [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock) from [<c04158c8>] (drm_fbdev_client_hotplug+0xe8/0x1b8)
> > > > > > > > > > > > >  [<c04158c8>] (drm_fbdev_client_hotplug) from [<c0415a20>] (drm_fbdev_generic_setup+0x88/0x118)
> > > > > > > > > > > > >  [<c0415a20>] (drm_fbdev_generic_setup) from [<c043f060>] (sun4i_drv_bind+0x128/0x160)
> > > > > > > > > > > > >  [<c043f060>] (sun4i_drv_bind) from [<c044b598>] (try_to_bring_up_master+0x164/0x1a0)
> > > > > > > > > > > > >  [<c044b598>] (try_to_bring_up_master) from [<c044b668>] (__component_add+0x94/0x140)
> > > > > > > > > > > > >  [<c044b668>] (__component_add) from [<c0445e1c>] (sun6i_dsi_probe+0x144/0x234)
> > > > > > > > > > > > >  [<c0445e1c>] (sun6i_dsi_probe) from [<c0452ef4>] (platform_drv_probe+0x48/0x9c)
> > > > > > > > > > > > >  [<c0452ef4>] (platform_drv_probe) from [<c04512cc>] (really_probe+0x1dc/0x2c8)
> > > > > > > > > > > > >  [<c04512cc>] (really_probe) from [<c0451518>] (driver_probe_device+0x60/0x160)
> > > > > > > > > > > > >  [<c0451518>] (driver_probe_device) from [<c044f7a4>] (bus_for_each_drv+0x74/0xb8)
> > > > > > > > > > > > >  [<c044f7a4>] (bus_for_each_drv) from [<c045107c>] (__device_attach+0xd0/0x13c)
> > > > > > > > > > > > >  [<c045107c>] (__device_attach) from [<c0450474>] (bus_probe_device+0x84/0x8c)
> > > > > > > > > > > > >  [<c0450474>] (bus_probe_device) from [<c0450900>] (deferred_probe_work_func+0x64/0x90)
> > > > > > > > > > > > >  [<c0450900>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
> > > > > > > > > > > > >  [<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
> > > > > > > > > > > > >  [<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
> > > > > > > > > > > > >  [<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> > > > > > > > > > > > >  Exception stack(0xde539fb0 to 0xde539ff8)
> > > > > > > > > > > > >  9fa0:                                     00000000 00000000 00000000 00000000
> > > > > > > > > > > > >  9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > > > > > > > > > > >  9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > > > > > > > > > > >  ---[ end trace b57eb1e5c64c6b8b ]---
> > > > > > > > > > > > >  random: fast init done
> > > > > > > > > > > > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:46:crtc-0] flip_done timed out
> > > > > > > > > > > > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:48:DSI-1] flip_done timed out
> > > > > > > > > > > > >  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:30:plane-0] flip_done timed out
> > > > > > > > > > > > >
> > > > > > > > > > > > > But according to Allwinner A33, A64 BSP code [1] [3] the TCON DRQ for
> > > > > > > > > > > > > non-burst DSI mode can be computed based on "horizontal front porch"
> > > > > > > > > > > > > value only (no sync timings included).
> > > > > > > > > > > > >
> > > > > > > > > > > > > Detailed evidence for drq set bits based on A33 BSP [1] [2]
> > > > > > > > > > > > >
> > > > > > > > > > > > > => panel->lcd_ht - panel->lcd_x - panel->lcd_hbp - 20
> > > > > > > > > > > > > => (tt->hor_front_porch + lcdp->panel_info.lcd_hbp +
> > > > > > > > > > > > > lcdp->panel_info.lcd_x) - panel->lcd_x - panel->lcd_hbp - 20
> > > > > > > > > > > > > => tt->hor_front_porch - 20
> > > > > > > > > > > >
> > > > > > > > > > > > The thing is, while your explanation on the DRM side is sound,
> > > > > > > > > > > > Allwinner has been using the hbp field of their panel description to
> > > > > > > > > > > > store what DRM calls the backporch and the sync period.
> > > > > > > > > > >
> > > > > > > > > > > Exactly, hbp = backporch + sync
> > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L2046
> > > > > > > > > > >
> > > > > > > > > > > And the above computation is rely on that as well. If you can see the
> > > > > > > > > > > final out of the above computation you can get the front porch value
> > > > > > > > > > > (w/o sync )
> > > > > > > > > >
> > > > > > > > > > As I was saying, you are explaining it well for DRM, but in order for
> > > > > > > > > > your last formula (the one coming from the BSP) to make sense, you
> > > > > > > > > > have to explain that the horizontal back porch for Allwinner contains
> > > > > > > > > > the sync period, otherwise your expansion of lcd_ht doesn't make
> > > > > > > > > > sense.
> > > > > > > > >
> > > > > > > > > I'm not sure why we need to take care of back porch since the formula
> > > > > > > > > clearly evaluating a result as front porch, without sync timing (as
> > > > > > > > > current code included this sync), I keep the hbp and trying to
> > > > > > > > > substitute the lcd_ht value so the end result would cancel hbp.
> > > > > > > >
> > > > > > > > Because it changes how lcd_ht expands. In the DRM case, it will expand
> > > > > > > > to the displayed area, the front porch, the sync period and the back
> > > > > > > > porch.
> > > > > > > >
> > > > > > > > In your case, you expand it to the displayed area, the front porch and
> > > > > > > > the back porch, precisely because in Allwinner's case, the back porch
> > > > > > > > has the sync period.
> > > > > > >
> > > > > > > I understand the point, but technically it matter about the final
> > > > > > > computation result.  May be we can even manage the same computation in
> > > > > > > back porch, but I'm not sure. Since the final output doesn't involve
> > > > > > > any sync length, why we can include that ie what I'm not sure.
> > > > > >
> > > > > > We have the following formula:
> > > > > > lcd_ht - lcd_x - lcd_hbp - 20
> > > > > >
> > > > > > Using the concepts as they are defined in DRM, this expands to:
> > > > > > x + hbp + hsync + hfp - x - hbp - 20
> > > > >
> > > > > Here is diff between allwinner hbp vs hbp in DRM.
> > > > >
> > > > > Say hbp in DRM can call it hbackporch, so
> > > > >
> > > > > => x + hbackporch + hsync + hfp - -x - hbp - 20
> > > > >
> > > > > (and here we need to substitute hbp formula from allwinner since the
> > > > > actual equation would coming from there
> > > > > https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L2046)
> > > >
> > > > And this is precisely what needs to be said, with an explanation about
> > > > where that hor_back_porch is being used later on, and what impact it
> > > > could have.
> > >
> > > Yes, it an equation and the mathematical equations can be substitute
> > > to variety kind I did agree with that, whether you can use hbackporch
> > > or not or use another-way the final resulting value is equivalent to
> > > the value of front porch. In that case we can solve based on what I
> > > explained above. If you still dought me, please run BSP and check the
> > > resulting value on this check, you can get the front porch value.
> >
> > Maxime is not doubting you. He is saying that you need to include the
> > detailed explanation in your commit log, and not just reference pieces
> > of code. This is separate from the requirement of having a correct patch.
> >
> > Providing just a mathematical formula isn't enough either, because it
> > is not clear to the average reader which term expanded into what. A
>
> Not sure whether you see my commit log on this version or not. Each
> one has it's own way of providing the details and explanation and at
> the end people in ML should understand it. I'm not proving a simple
> formula here (like I did it in initial version) instead I'm giving all
> the respective information along with the bug log, and the bsp links
> where it comes from etc. This is easier way for everyone to
> understand.

I did, and I'm telling you it's not easy to follow.

> Just a bit to explain what I've mentioned in the log.
>
> Paragraph 1:
>
> "
> According to "DRM kernel-internal display mode structure" in
> include/drm/drm_modes.h the current driver is trying to include
> sync timings along with front porch value while checking and
> computing drq set bits in non-burst mode.
>
> mode->hsync_end - mode->hdisplay => horizontal front porch + sync
> "
>
> This paragraph explains what the existing code is using according to
> DRM, which indeed help new users to understand by providing
> include/drm/drm_modes.h file.

This at the beginning makes no sense. It would be better placed with
the formula after
the bug report

> Paragraph 2:
>
> "
> With adding additional sync timings, the dsi controller leads to
> wrong drq set bits for "bananapi,s070wv20-ct16" panel which indeed
> trigger panel flip_done timed out as:
> "
>
> This paragraph explains what is the relevant issue with existing change.
>
> Paragraph 3:
>
> BUG or WARNING log

You should lead with these two. These explain "why".

> Paragraph 4:
>
> "
> But according to Allwinner A33, A64 BSP code [1] [3] the TCON DRQ for
> non-burst DSI mode can be computed based on "horizontal front porch"
> value only (no sync timings included).
> "
>
> This paragraph explains what is BSP is using compared with mainline.
>
> Paragraph 5:
>
> "
> Detailed evidence for drq set bits based on A33 BSP [1] [2]
>
> => panel->lcd_ht - panel->lcd_x - panel->lcd_hbp - 20
> => (tt->hor_front_porch + lcdp->panel_info.lcd_hbp +
> lcdp->panel_info.lcd_x) - panel->lcd_x - panel->lcd_hbp - 20
> => tt->hor_front_porch - 20
> "
>
> This paragraph explains the detailed steps of equation evaluation by
> providing BSP links.

This actually makes it harder to read. For example it takes a couple passes
to realize lcd_ht expands to the stuff in the parenthesis. All the while I
still have no idea what all these variables mean or where they came from.
As I said, please don't ask users to open links and dig through code.

You should provide a simple explanation about what went wrong. As I
mentioned, you could have simply stated that when the driver was
reimplemented, the DRQ formula (which you can provide in its original
form) was incorrectly expanded because Allwinner's definition of "hbp"
is actually "hbp + sync" in DRM terms. That is actually the root cause,
which I believe is what Maxime wants detailed in the commit log.
This immediately points out what went wrong and how it went wrong,
without jumping through hoops.

Again the diagram helps immensely. (Well, maybe not for screen readers.)
It also directly shows why you replaced hsync_end with hsync_start.

> Paragraph 6:
>
> "
> Which is mode->hsync_start - mode->hdisplay as per
> "DRM kernel-internal display mode structure" in include/drm/drm_modes.h
> "
>
> This paragraph give fix details in according to Linux DRM.

Yes, and first you need to understand the formula you gave, which I
already mentioned is a bit hard.

On the side, going through the code and understanding it actually is quite
hard as I already did it a couple times before and it was really taxing.

> So, all the explanation which I'm trying to provide here will help to
> understand, what is the issue with existing code and BUG log, how it
> handle in BSP, with justification of equations and links where it
> refers. Please note that I'm providing bug log and before that I've
> mentioned this timeout because of additional sync. why is the timeout
> with additional sync time, which I'm unaware since we don't have
> associated datasheets for this but we have working BSP's to prove
> that.
>
> Frankly, I still didn't understand what I missed here to explain the
> issue. request for help if you see any issues on this format or
> information.

The one thing you missed, and that Maxime requested, was how hbp, and
the misinterpretation of it plays into all of this. In fact the different
definitions of terms between DRM and Allwinner code / FEX files is what
led to all this. The rest is, well, somewhat hard to read. I already
shared my way of explaining everything above.

ChenYu
