Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C0C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4C42175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lvVH5C8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbfEXKHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:07:50 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38985 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfEXKHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:07:49 -0400
Received: by mail-it1-f196.google.com with SMTP id 9so12982967itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2UKxBj/16PFnPT0opJ+Wxp3U9KN6SIstIRPi4CR6Dg=;
        b=lvVH5C8fcVBxVLdFKCCU7ZqdcvQC84ZTeT1hnQfp2l+m4+WAl8xKSkJ62hp4jGjoRP
         pZZCtvosTk3b1cuR8ZH2y5aeRTZiaMcez8/hglgDIG8f+BgvYF1xQa8Q16acwfmqNtsP
         EAORiPyjxlLePwEQdO4Ju5Xmo5mFeB9cGNrWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2UKxBj/16PFnPT0opJ+Wxp3U9KN6SIstIRPi4CR6Dg=;
        b=WPvvRAfoRp3SeORuDvrCSNmhWIqB+MPD/vCP0883a5ecIoKSJZg1E7BtXO3CZ6OyKT
         6Xe7Mxx48aTZdOu90ESSQVrdTeCvSq22aZ2URt82BC9lZW7ET6yu84vgpc4roLJXP/9k
         UX6O4LsCkQ8M4y3TCHYwwzJSGX2SF7zwMTfIewNRNzhetB6q89Au3VupNf+03xaGtoL5
         vbfw7XIjQJsR2iE85zdIydffBu1u2TdAyk8HzPBS+t4Z45nxjmQl9WevnUvT5eJr759Q
         /2YYWv3C2TSsPpg2Re+P+1wq3lY6HJm1MRa1gMxE+g0iNdGS64tAo4uiVsh4elFpbmkk
         ffuw==
X-Gm-Message-State: APjAAAV59wSgD3F9VD5dL2rQwYiYJZYuf1MVA8iCglwfQa8rGePIaJU+
        C7cLg1mqrw0i5K3QMU/WbV6AF7zSEoU3cHge4+4AYQ==
X-Google-Smtp-Source: APXvYqzZYv+7JHLFo0KwfeFhhGoWLlvdvku8Io/xT0x0+uSdJAzpclvRy5FUulBPbGFLltElswI7+88s+Lg69y+sBgc=
X-Received: by 2002:a24:a004:: with SMTP id o4mr16634448ite.167.1558692468219;
 Fri, 24 May 2019 03:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
 <20190520090318.27570-5-jagan@amarulasolutions.com> <20190523204823.mx7l4ozklzdh7npn@flea>
In-Reply-To: <20190523204823.mx7l4ozklzdh7npn@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 24 May 2019 15:37:36 +0530
Message-ID: <CAMty3ZA0S=+8NBrQZvP6sFdzSYWqhNZL_KjkJAQ0jTc2RVivrw@mail.gmail.com>
Subject: Re: [PATCH v10 04/11] drm/sun4i: tcon: Compute DCLK dividers based on
 format, lanes
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

On Fri, May 24, 2019 at 2:18 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, May 20, 2019 at 02:33:11PM +0530, Jagan Teki wrote:
> > pll-video => pll-mipi => tcon0 => tcon0-pixel-clock is the typical
> > MIPI clock topology in Allwinner DSI controller.
> >
> > TCON dotclock driver is computing the desired DCLK divider based on
> > panel pixel clock along with input DCLK min, max divider values from
> > tcon driver and that would eventually set the pll-mipi clock rate.
> >
> > The current code is passing dsi min and max divider value as 4 via
> > tcon driver which would ended-up triggering below vblank wait timed out
> > warning on "bananapi,s070wv20-ct16" panel.
> >
> >  WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
> >  [CRTC:46:crtc-0] vblank wait timed out
> >  Modules linked in:
> >  CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 5.1.0-next-20190514-00025-g5186cdf10757-dirty #6
> >  Hardware name: Allwinner sun8i Family
> >  Workqueue: events deferred_probe_work_func
> >  [<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
> >  [<c010b76c>] (show_stack) from [<c0688c70>] (dump_stack+0x84/0x98)
> >  [<c0688c70>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
> >  [<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
> >  [<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
> >  [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
> >  [<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
> >  [<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
> >  [<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
> >  [<c0411b64>] (restore_fbdev_mode_atomic) from [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
> >  [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0415774>] (drm_fb_helper_set_par+0x30/0x54)
> >  [<c0415774>] (drm_fb_helper_set_par) from [<c03ad450>] (fbcon_init+0x560/0x5ac)
> >  [<c03ad450>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
> >  [<c03eb8a0>] (visual_init) from [<c03ed1b8>] (do_bind_con_driver+0x1b0/0x390)
> >  [<c03ed1b8>] (do_bind_con_driver) from [<c03ed780>] (do_take_over_console+0x13c/0x1c4)
> >  [<c03ed780>] (do_take_over_console) from [<c03ad800>] (do_fbcon_takeover+0x74/0xcc)
> >  [<c03ad800>] (do_fbcon_takeover) from [<c013c9c8>] (notifier_call_chain+0x44/0x84)
> >  [<c013c9c8>] (notifier_call_chain) from [<c013cd20>] (__blocking_notifier_call_chain+0x48/0x60)
> >  [<c013cd20>] (__blocking_notifier_call_chain) from [<c013cd50>] (blocking_notifier_call_chain+0x18/0x20)
> >  [<c013cd50>] (blocking_notifier_call_chain) from [<c03a6e44>] (register_framebuffer+0x1e0/0x2f8)
> >  [<c03a6e44>] (register_framebuffer) from [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock+0x2fc/0x50c)
> >  [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock) from [<c04158c8>] (drm_fbdev_client_hotplug+0xe8/0x1b8)
> >  [<c04158c8>] (drm_fbdev_client_hotplug) from [<c0415a20>] (drm_fbdev_generic_setup+0x88/0x118)
> >  [<c0415a20>] (drm_fbdev_generic_setup) from [<c043f060>] (sun4i_drv_bind+0x128/0x160)
> >  [<c043f060>] (sun4i_drv_bind) from [<c044b588>] (try_to_bring_up_master+0x164/0x1a0)
> >  [<c044b588>] (try_to_bring_up_master) from [<c044b658>] (__component_add+0x94/0x140)
> >  [<c044b658>] (__component_add) from [<c0445e0c>] (sun6i_dsi_probe+0x144/0x234)
> >  [<c0445e0c>] (sun6i_dsi_probe) from [<c0452ee4>] (platform_drv_probe+0x48/0x9c)
> >  [<c0452ee4>] (platform_drv_probe) from [<c04512bc>] (really_probe+0x1dc/0x2c8)
> >  [<c04512bc>] (really_probe) from [<c0451508>] (driver_probe_device+0x60/0x160)
> >  [<c0451508>] (driver_probe_device) from [<c044f794>] (bus_for_each_drv+0x74/0xb8)
> >  [<c044f794>] (bus_for_each_drv) from [<c045106c>] (__device_attach+0xd0/0x13c)
> >  [<c045106c>] (__device_attach) from [<c0450464>] (bus_probe_device+0x84/0x8c)
> >  [<c0450464>] (bus_probe_device) from [<c04508f0>] (deferred_probe_work_func+0x64/0x90)
> >  [<c04508f0>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
> >  [<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
> >  [<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
> >  [<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> >  Exception stack(0xde539fb0 to 0xde539ff8)
> >  9fa0:                                     00000000 00000000 00000000 00000000
> >  9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >  9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >  ---[ end trace 4017fea4906ab391 ]---
> >
> > But accordingly to Allwinner A33, A64 BSP codes [1] [2] this divider
> > is clearly using 'format/lanes' for dsi divider value, dsi_clk.clk_div
> >
> > Which would compute the pll_freq and set a clock rate for it in
> > [3] and [4] respectively.
> >
> > The same issue has reproduced in A33, A64 with 4-lane and 2-lane devices
> > and got fixed with this computation logic 'format/lanes', so this patch
> > using dclk min and max dividers as per BSP.
> >
> > [1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L1106
> > [2] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L213
> > [3] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L1127
> > [4] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L1161
>
> In that mail, I've pointed out that clk_div isn't used for the TCON dclk divider:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/629596.html
>
> The only reply you've sent is that you indeed see that the divider is
> set to 4 in the BSP, but you're now saying that the BSP can change
> it. If so, then please point exactly the flaw in the explanation in
> that mail.

Frankly, I have explained these details in commit message and previous
version patch[1] with print messages on the code.

BSP has tcon_div and dsi_div. dsi_div is dynamic which depends on
bpp/lanes and it indeed depends on PLL computation (not tcon_div),
anyway I have explained again on this initial link you mentioned.
Please have a look and get back.

[1] https://patchwork.freedesktop.org/patch/291525/
