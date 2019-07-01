Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2386720B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GtunnfKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfGATA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:00:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35667 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfGATA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:00:27 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so31300569ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 12:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+f5WCOBjqPd+mXSelV53JnH0oa33fcfgISGQjk/o+98=;
        b=GtunnfKPZkOzEInOloFGVQzAruinV1O3Ru6XEUnKvluOKdqXNXm9o5Off751DaeDAy
         UXKZND2fBEjFTfj3NRrxARYumPYVA9+BCBKr6Qdysj5fiNCksoM7z8cSEd/o3V5qOuF9
         DEUrEj7CwrILvF5/BWXYdLq2tWCyHdYkpga9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+f5WCOBjqPd+mXSelV53JnH0oa33fcfgISGQjk/o+98=;
        b=jS8cyKMCuyXGUjozqfCzV6Gx78A5DpgEVgoHxGnpsPKpKzqf76CqVdGa1k0g3afVL1
         BC6XV0lZ0KMZpE1LAqESjWQdYbmzlmcCipjjXhiFOXZyqDoqwt+2vBh8QcAhVDuvJrhV
         6F28sqURA4cLzUyyldhq2IK2x6lOXrZDfa2j5AUT75H3j7wox6klS/CWtaHv5+9UtNGB
         sZTx9Nx4+C2dhNkgwRiWkk0InmxU/3qRdY+dZxnLo8u20UIkbVKBp1flgrQ3S4kJh6b+
         uQa1fQUcUg3t30wU8apJXPv3Qtqo+nEbvJpQMA0B56vs/uSPgXM8q6KLdhBjuIXZUVLL
         EQcw==
X-Gm-Message-State: APjAAAUcccBCjEMBshuqEGW2mR8Vq7bUTeU2Iy4BgvwbZtV6lmFLy5Eb
        xNmZygZ2ipCLdyhbBIoC06gax+0FkoXDynDV1vz+NQ==
X-Google-Smtp-Source: APXvYqzlff56fV607aJrbZ+PhwePJXkwWoh4PIJ4Lt3BpMrSA97jegtE3JU7TZfOYSvAE6wdvv/6g86fFlR3Sp4wxAY=
X-Received: by 2002:a6b:6b14:: with SMTP id g20mr2643215ioc.28.1562007625979;
 Mon, 01 Jul 2019 12:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
 <20190520090318.27570-5-jagan@amarulasolutions.com> <20190523204823.mx7l4ozklzdh7npn@flea>
 <CAMty3ZA0S=+8NBrQZvP6sFdzSYWqhNZL_KjkJAQ0jTc2RVivrw@mail.gmail.com>
 <20190604143016.fcx3ezmga244xakp@flea> <CAMty3ZAAK4RoE6g_LAZ-Q38On_1s_TTOz65YG7PVd88mwp-+4Q@mail.gmail.com>
 <20190613131626.7zbwvrvd4e7eafrc@flea> <CAMty3ZBDkMJkZm8FudNB1wQ+L-q3XVKa3zR2M0wZ5Uncdy_Ayg@mail.gmail.com>
 <20190624130442.ww4l3zctykr4i2e2@flea> <CAMty3ZB+eZUh5mr-LMZuEd_wrwLCN0mbf7arcRQHj8=uUNNq=Q@mail.gmail.com>
 <20190625143747.3czd7sit4waz75b6@flea>
In-Reply-To: <20190625143747.3czd7sit4waz75b6@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 2 Jul 2019 00:30:14 +0530
Message-ID: <CAMty3ZCh+C9+zgcL633tTw6aPW_WOLnYN7FzJHX+3zu8=8Unpg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v10 04/11] drm/sun4i: tcon: Compute DCLK
 dividers based on format, lanes
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

On Tue, Jun 25, 2019 at 8:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Jun 24, 2019 at 09:32:11PM +0530, Jagan Teki wrote:
> > On Mon, Jun 24, 2019 at 6:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, Jun 14, 2019 at 05:33:23PM +0530, Jagan Teki wrote:
> > > > On Thu, Jun 13, 2019 at 7:28 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Wed, Jun 05, 2019 at 01:11:44PM +0530, Jagan Teki wrote:
> > > > > > On Tue, Jun 4, 2019 at 8:00 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 24, 2019 at 03:37:36PM +0530, Jagan Teki wrote:
> > > > > > > > On Fri, May 24, 2019 at 2:18 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, May 20, 2019 at 02:33:11PM +0530, Jagan Teki wrote:
> > > > > > > > > > pll-video => pll-mipi => tcon0 => tcon0-pixel-clock is the typical
> > > > > > > > > > MIPI clock topology in Allwinner DSI controller.
> > > > > > > > > >
> > > > > > > > > > TCON dotclock driver is computing the desired DCLK divider based on
> > > > > > > > > > panel pixel clock along with input DCLK min, max divider values from
> > > > > > > > > > tcon driver and that would eventually set the pll-mipi clock rate.
> > > > > > > > > >
> > > > > > > > > > The current code is passing dsi min and max divider value as 4 via
> > > > > > > > > > tcon driver which would ended-up triggering below vblank wait timed out
> > > > > > > > > > warning on "bananapi,s070wv20-ct16" panel.
> > > > > > > > > >
> > > > > > > > > >  WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
> > > > > > > > > >  [CRTC:46:crtc-0] vblank wait timed out
> > > > > > > > > >  Modules linked in:
> > > > > > > > > >  CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 5.1.0-next-20190514-00025-g5186cdf10757-dirty #6
> > > > > > > > > >  Hardware name: Allwinner sun8i Family
> > > > > > > > > >  Workqueue: events deferred_probe_work_func
> > > > > > > > > >  [<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
> > > > > > > > > >  [<c010b76c>] (show_stack) from [<c0688c70>] (dump_stack+0x84/0x98)
> > > > > > > > > >  [<c0688c70>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
> > > > > > > > > >  [<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
> > > > > > > > > >  [<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
> > > > > > > > > >  [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
> > > > > > > > > >  [<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
> > > > > > > > > >  [<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
> > > > > > > > > >  [<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
> > > > > > > > > >  [<c0411b64>] (restore_fbdev_mode_atomic) from [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
> > > > > > > > > >  [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0415774>] (drm_fb_helper_set_par+0x30/0x54)
> > > > > > > > > >  [<c0415774>] (drm_fb_helper_set_par) from [<c03ad450>] (fbcon_init+0x560/0x5ac)
> > > > > > > > > >  [<c03ad450>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
> > > > > > > > > >  [<c03eb8a0>] (visual_init) from [<c03ed1b8>] (do_bind_con_driver+0x1b0/0x390)
> > > > > > > > > >  [<c03ed1b8>] (do_bind_con_driver) from [<c03ed780>] (do_take_over_console+0x13c/0x1c4)
> > > > > > > > > >  [<c03ed780>] (do_take_over_console) from [<c03ad800>] (do_fbcon_takeover+0x74/0xcc)
> > > > > > > > > >  [<c03ad800>] (do_fbcon_takeover) from [<c013c9c8>] (notifier_call_chain+0x44/0x84)
> > > > > > > > > >  [<c013c9c8>] (notifier_call_chain) from [<c013cd20>] (__blocking_notifier_call_chain+0x48/0x60)
> > > > > > > > > >  [<c013cd20>] (__blocking_notifier_call_chain) from [<c013cd50>] (blocking_notifier_call_chain+0x18/0x20)
> > > > > > > > > >  [<c013cd50>] (blocking_notifier_call_chain) from [<c03a6e44>] (register_framebuffer+0x1e0/0x2f8)
> > > > > > > > > >  [<c03a6e44>] (register_framebuffer) from [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock+0x2fc/0x50c)
> > > > > > > > > >  [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock) from [<c04158c8>] (drm_fbdev_client_hotplug+0xe8/0x1b8)
> > > > > > > > > >  [<c04158c8>] (drm_fbdev_client_hotplug) from [<c0415a20>] (drm_fbdev_generic_setup+0x88/0x118)
> > > > > > > > > >  [<c0415a20>] (drm_fbdev_generic_setup) from [<c043f060>] (sun4i_drv_bind+0x128/0x160)
> > > > > > > > > >  [<c043f060>] (sun4i_drv_bind) from [<c044b588>] (try_to_bring_up_master+0x164/0x1a0)
> > > > > > > > > >  [<c044b588>] (try_to_bring_up_master) from [<c044b658>] (__component_add+0x94/0x140)
> > > > > > > > > >  [<c044b658>] (__component_add) from [<c0445e0c>] (sun6i_dsi_probe+0x144/0x234)
> > > > > > > > > >  [<c0445e0c>] (sun6i_dsi_probe) from [<c0452ee4>] (platform_drv_probe+0x48/0x9c)
> > > > > > > > > >  [<c0452ee4>] (platform_drv_probe) from [<c04512bc>] (really_probe+0x1dc/0x2c8)
> > > > > > > > > >  [<c04512bc>] (really_probe) from [<c0451508>] (driver_probe_device+0x60/0x160)
> > > > > > > > > >  [<c0451508>] (driver_probe_device) from [<c044f794>] (bus_for_each_drv+0x74/0xb8)
> > > > > > > > > >  [<c044f794>] (bus_for_each_drv) from [<c045106c>] (__device_attach+0xd0/0x13c)
> > > > > > > > > >  [<c045106c>] (__device_attach) from [<c0450464>] (bus_probe_device+0x84/0x8c)
> > > > > > > > > >  [<c0450464>] (bus_probe_device) from [<c04508f0>] (deferred_probe_work_func+0x64/0x90)
> > > > > > > > > >  [<c04508f0>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
> > > > > > > > > >  [<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
> > > > > > > > > >  [<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
> > > > > > > > > >  [<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> > > > > > > > > >  Exception stack(0xde539fb0 to 0xde539ff8)
> > > > > > > > > >  9fa0:                                     00000000 00000000 00000000 00000000
> > > > > > > > > >  9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > > > > > > > >  9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > > > > > > > >  ---[ end trace 4017fea4906ab391 ]---
> > > > > > > > > >
> > > > > > > > > > But accordingly to Allwinner A33, A64 BSP codes [1] [2] this divider
> > > > > > > > > > is clearly using 'format/lanes' for dsi divider value, dsi_clk.clk_div
> > > > > > > > > >
> > > > > > > > > > Which would compute the pll_freq and set a clock rate for it in
> > > > > > > > > > [3] and [4] respectively.
> > > > > > > > > >
> > > > > > > > > > The same issue has reproduced in A33, A64 with 4-lane and 2-lane devices
> > > > > > > > > > and got fixed with this computation logic 'format/lanes', so this patch
> > > > > > > > > > using dclk min and max dividers as per BSP.
> > > > > > > > > >
> > > > > > > > > > [1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L1106
> > > > > > > > > > [2] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L213
> > > > > > > > > > [3] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L1127
> > > > > > > > > > [4] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L1161
> > > > > > > > >
> > > > > > > > > In that mail, I've pointed out that clk_div isn't used for the TCON dclk divider:
> > > > > > > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/629596.html
> > > > > > > > >
> > > > > > > > > The only reply you've sent is that you indeed see that the divider is
> > > > > > > > > set to 4 in the BSP, but you're now saying that the BSP can change
> > > > > > > > > it. If so, then please point exactly the flaw in the explanation in
> > > > > > > > > that mail.
> > > > > > > >
> > > > > > > > Frankly, I have explained these details in commit message and previous
> > > > > > > > version patch[1] with print messages on the code.
> > > > > > > >
> > > > > > > > BSP has tcon_div and dsi_div. dsi_div is dynamic which depends on
> > > > > > > > bpp/lanes and it indeed depends on PLL computation (not tcon_div),
> > > > > > > > anyway I have explained again on this initial link you mentioned.
> > > > > > > > Please have a look and get back.
> > > > > > >
> > > > > > > I'll have a look, thanks.
> > > > > > >
> > > > > > > I've given your patches a try on my setup though, and this patch
> > > > > > > breaks it with vblank timeouts and some horizontal lines that looks
> > > > > > > like what should be displayed, but blinking and on the right of the
> > > > > > > display. The previous ones are fine though.
> > > > > >
> > > > > > Would you please send me the link of panel driver.
> > > > >
> > > > > It's drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> > > >
> > > > Look like this panel work even w/o any vendor sequence. it's similar
> > > > to the 4-lane panel I have with RGB888, so the dclk div is 6, is it
> > > > working with this divider?
> > >
> > > It works with 4, it doesn't work with 6.
> >
> > Can be the pixel clock with associated timings can make this diff.
> > Would you send me the pixel clock, pll_rate and timings this panel
> > used it from BSP?
>
> This board never had an Allwinner BSP

Running on BSP would help to understand some clue, anyway would you
send me the the value PLL_MIPI register (devme 0x1c20040) on this
board. I'm trying to understand how it value in your case.
