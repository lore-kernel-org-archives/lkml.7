Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DCEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7066C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfFXJec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:34:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43283 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:34:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so20761327edr.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVa47P92BemoaLBZOvSqv4LRSbGGjo9/5yhYubtSxi8=;
        b=CpuKjnACuBZXHJnqOifWPUNnVEfXl7t7IcrE/rhZC+12/9wVvOGb6SXZRE4OPuWk6L
         vo5HvPhRgBmw8n17YvfpyLHojfvzCKL63rmPyAw9jwcCtOE23qdgAe6gj3GAs6cyvbKB
         ZYTyK+2z3qgu0EXuGggEZt5U5Wimw6PyVrblI6guPEURGGUXWVwooUyTNuoD3N9Fx9WJ
         WEYcP5S6uR8JRXe+Si0ZmPCtSeGDhLB4Df5ijrZKz/c/RamSfUXzZCv4dhYjJjUsXrQz
         MjOXnPyy0jKLWWbvrUP9G8Wlo4loQc0p8Ou1qmSDDLnRr+WM1CyR8IMfJzUF0Ls/lzXR
         goVg==
X-Gm-Message-State: APjAAAWe4btpW5HANXwPTKZCizDSX/yYTnnVgl2NsOpQhJvgJ6it6w6k
        VT6ifX7QXjobgGgDUKA2nwFObhaT7eA=
X-Google-Smtp-Source: APXvYqxpTFFzEM7RJ+x7qqm1f52ELkWyA6MzGoI7Lezvqi/DVkdtxBcWYDl+mIIzTE8gSjR0skzyGg==
X-Received: by 2002:a50:8bcc:: with SMTP id n12mr139909694edn.6.1561368868834;
        Mon, 24 Jun 2019 02:34:28 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id x4sm3662749eda.22.2019.06.24.02.34.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:34:28 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id x17so13085033wrl.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:34:27 -0700 (PDT)
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr41793692wrx.167.1561368867466;
 Mon, 24 Jun 2019 02:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190520090318.27570-1-jagan@amarulasolutions.com> <20190520090318.27570-3-jagan@amarulasolutions.com>
In-Reply-To: <20190520090318.27570-3-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 24 Jun 2019 17:34:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v67wWUTpjNncOhv=69WzywJ2ueDdFSbiD-UAPSwkzcW5xQ@mail.gmail.com>
Message-ID: <CAGb2v67wWUTpjNncOhv=69WzywJ2ueDdFSbiD-UAPSwkzcW5xQ@mail.gmail.com>
Subject: Re: [PATCH v10 02/11] drm/sun4i: dsi: Update start value in video
 start delay
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

Hi,

On Mon, May 20, 2019 at 5:07 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> start value in video start delay computation done in below commit
> is as per the legacy bsp drivers/video/sunxi/legacy..
> "drm/sun4i: dsi: Change the start delay calculation"
> (sha1: da676c6aa6413d59ab0a80c97bbc273025e640b2)

There is a standard format for referencing commits. Please use it.
The format is:

    ... commit <leading 12 characters of commit hash> ("commit subject") ...

So your commit message should read:

    start value in video start delay was changed in commit
da676c6aa641 ("drm/sun4i:
    dsi: Change the start delay calculation") to match the legacy BSP
driver [1].

>
> This existing start delay computation gives start value of 35,
> for "bananapi,s070wv20-ct16" panel timings which indeed trigger
> panel flip_done timed out as:
>
>  WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
>  [CRTC:46:crtc-0] vblank wait timed out
>  Modules linked in:
>  CPU: 0 PID: 31 Comm: kworker/0:1 Tainted: G        W         5.1.0-next-20190514-00025-gf928bc7cc146 #15
>  Hardware name: Allwinner sun8i Family
>  Workqueue: events deferred_probe_work_func
>  [<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
>  [<c010b76c>] (show_stack) from [<c0688c90>] (dump_stack+0x84/0x98)
>  [<c0688c90>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
>  [<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
>  [<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
>  [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
>  [<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
>  [<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
>  [<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
>  [<c0411b64>] (restore_fbdev_mode_atomic) from [<c0411cb0>] (drm_fb_helper_pan_display+0xac/0x1d0)
>  [<c0411cb0>] (drm_fb_helper_pan_display) from [<c03a4e84>] (fb_pan_display+0xcc/0x134)
>  [<c03a4e84>] (fb_pan_display) from [<c03b1214>] (bit_update_start+0x14/0x30)
>  [<c03b1214>] (bit_update_start) from [<c03afe94>] (fbcon_switch+0x3d8/0x4e0)
>  [<c03afe94>] (fbcon_switch) from [<c03ec930>] (redraw_screen+0x174/0x238)
>  [<c03ec930>] (redraw_screen) from [<c03aceb4>] (fbcon_prepare_logo+0x3c4/0x400)
>  [<c03aceb4>] (fbcon_prepare_logo) from [<c03ad2b8>] (fbcon_init+0x3c8/0x5ac)
>  [<c03ad2b8>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
>  [<c03eb8a0>] (visual_init) from [<c03ed1b8>] (do_bind_con_driver+0x1b0/0x390)
>  [<c03ed1b8>] (do_bind_con_driver) from [<c03ed780>] (do_take_over_console+0x13c/0x1c4)
>  [<c03ed780>] (do_take_over_console) from [<c03ad800>] (do_fbcon_takeover+0x74/0xcc)
>  [<c03ad800>] (do_fbcon_takeover) from [<c013c9c8>] (notifier_call_chain+0x44/0x84)
>  [<c013c9c8>] (notifier_call_chain) from [<c013cd20>] (__blocking_notifier_call_chain+0x48/0x60)
>  [<c013cd20>] (__blocking_notifier_call_chain) from [<c013cd50>] (blocking_notifier_call_chain+0x18/0x20)
>  [<c013cd50>] (blocking_notifier_call_chain) from [<c03a6e44>] (register_framebuffer+0x1e0/0x2f8)
>  [<c03a6e44>] (register_framebuffer) from [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock+0x2fc/0x50c)
>  [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock) from [<c04158c8>] (drm_fbdev_client_hotplug+0xe8/0x1b8)
>  [<c04158c8>] (drm_fbdev_client_hotplug) from [<c0415a20>] (drm_fbdev_generic_setup+0x88/0x118)
>  [<c0415a20>] (drm_fbdev_generic_setup) from [<c043f060>] (sun4i_drv_bind+0x128/0x160)
>  [<c043f060>] (sun4i_drv_bind) from [<c044b5b0>] (try_to_bring_up_master+0x164/0x1a0)
>  [<c044b5b0>] (try_to_bring_up_master) from [<c044b680>] (__component_add+0x94/0x140)
>  [<c044b680>] (__component_add) from [<c0445e1c>] (sun6i_dsi_probe+0x144/0x234)
>  [<c0445e1c>] (sun6i_dsi_probe) from [<c0452f0c>] (platform_drv_probe+0x48/0x9c)
>  [<c0452f0c>] (platform_drv_probe) from [<c04512e4>] (really_probe+0x1dc/0x2c8)
>  [<c04512e4>] (really_probe) from [<c0451530>] (driver_probe_device+0x60/0x160)
>  [<c0451530>] (driver_probe_device) from [<c044f7bc>] (bus_for_each_drv+0x74/0xb8)
>  [<c044f7bc>] (bus_for_each_drv) from [<c0451094>] (__device_attach+0xd0/0x13c)
>  [<c0451094>] (__device_attach) from [<c045048c>] (bus_probe_device+0x84/0x8c)
>  [<c045048c>] (bus_probe_device) from [<c0450918>] (deferred_probe_work_func+0x64/0x90)
>  [<c0450918>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
>  [<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
>  [<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
>  [<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>  Exception stack(0xde539fb0 to 0xde539ff8)
>  9fa0:                                     00000000 00000000 00000000 00000000
>  9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>  9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  ---[ end trace 755e10f62b83f396 ]---
>  Console: switching to colour frame buffer device 100x30
>  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:46:crtc-0] flip_done timed out
>  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:48:DSI-1] flip_done timed out
>  [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:30:plane-0] flip_done timed out
>
> But the expected start delay value is 1 which is confirmed from
> new bsp [2].
>
> The important and unclear note on legacy and new bsp codes [1] [2]
> is both use similar start computation initially but it later reassign
> it to 1 in new bsp.
>
> Unfortunately we don't have any evidence or documentation for this
> reassignment to 1 in new bsp, but it is working with all supported
> panels in A33, A64.
>
> So, use the start as per new bsp code since it is working in all
> the supported panels.

It would be better to actually list the panels you tested. The list of
"supported panels" is nowhere to be found, and would change from release
to release anyways. It would be hard for anyone to realize which ones
were actually tested.

It would also help if others want to verify your fix, and/or test other
hardware.

Also I suggest following a similar pattern to the suggestions I gave for patch 1
for writing your commit logs:

  1. Describe what you observe to be not working.

     In this case, the display is not working, with the provided traceback
     and kernel logs.

  2. Describe what you think went wrong.

     This could be a git bisect result, or in this case, you are
providing evidence
     from the BSP with links and actual results from hardware running
the BSP. For
     actual running BSP, it would be better to provide the actual
hardware combinations
     you are running on, in addition to the BSP links. Last, the best
piece of concrete
     evidence might be relevant register values from functioning hardware.

  3. Explain that the fix corrects the issue for you, and list the hardware
     that it works on.

  4. Optional. Any other thoughts on the subject matter, such as suspicion of
     other broken hardware, or the fix might not be complete.

> [2] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L807
> [1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/legacy/disp/de_bsp/de/ebios/de_dsi.c#L682

Please list your references in increasing order:

    [1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/legacy/disp/de_bsp/de/ebios/de_dsi.c#L682
    [2] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L807

It is otherwise confusing. I believe Maxime might have mixed up the two.

Otherwise I believe the commit message matches the intent of the code.
I'm afraid I don't know enough about DSI in general or the hardware to
comment on why this works and if it's the right fix though.

Regards,
ChenYu

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index c5bec0096b7c..b3ca85410b2c 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -364,7 +364,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>                                            struct drm_display_mode *mode)
>  {
> -       u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> +       /**
> +        * Allwinner legacy (drivers/video/sunxi/legacy),
> +        * new (drivers/video/sunxi/disp/de/lowlevel_sun8iw5) bsp drivers
> +        * are evaluating start as:
> +        *
> +        *      vtotal - vdisplay - 10
> +        *
> +        * but the new drivers are reassigning start to 1, which seems to be
> +        * working in all supported panels as of now.
> +        */
> +       u8 start = 1;
>         u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
>
>         if (delay > mode->vtotal)
> --
> 2.18.0.321.gffc6fa0e3
>
