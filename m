Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A5BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777F12133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ngQbGJwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfJCPQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:16:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39605 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfJCPQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:16:45 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so6408353ioc.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hA2LtxmdLIDTNytgEaB7reCfgrHgEKb4xoiREE/0K7Q=;
        b=ngQbGJwiby9Ke44nsAO/tlZUe9hbTCbksGis/YVtTxDj+EC1MtxBGvRkmqd0JLO845
         p7e2ovtJjAB5LueL0Y5aQf5J1HQ/lKdMuIPvH9lVJpzJiPC2gNldIggTM1iJrlmY8m33
         IpRwZ92PJPi/rxe1pcdqhVrJdkMQIW6Iw6Toc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hA2LtxmdLIDTNytgEaB7reCfgrHgEKb4xoiREE/0K7Q=;
        b=SyPtUcY4cz5w6ovWqbEPVrGl0LxmUq7tR43orCov/41W2TNpyRR/l7nbDLtv+TiEiy
         nv345L0NGWlHrODozuA1hjxCsCzj82osdgOSkUy1yFuZvwpREwXDuX6a4N4Ta+zYU1Xr
         BnyFJjKZ5L3Si3O3Yc68lDe/jskyhh8/N8uM0qy7bACY6tRk1oiohmAMuZsPVpQuk4a9
         25rXtlNAjD9GqwumxCXfhTJkwKZBckmBjylYzCzz4+P1h8nkDfwU3OY5KP+DNzjJm8nU
         OaqgDR/0IkGZPTwp1qHQGHrS25YisZna56PJB7AC3/+bvv7w4BGIzom+t8c5GdUp4gdy
         QyKA==
X-Gm-Message-State: APjAAAVYzx8kLpjzIZB85DQXro8ZNrn65kM34nIghyc4vLCiUNnCxjTn
        JqNo8d8UWGwDvMtAENjC17HbCb+t6mHYPZOB3w78IA==
X-Google-Smtp-Source: APXvYqzlTS7XsY5btr8rMMngqjvVqVkZJIrk+i/7OsB/hdVMXH4Zvn/MgTgexACnaezUOhbxLyWLbSVqyy23WYGVkQQ=
X-Received: by 2002:a92:17c4:: with SMTP id 65mr10501991ilx.28.1570115803953;
 Thu, 03 Oct 2019 08:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
 <20191003064527.15128-2-jagan@amarulasolutions.com> <20191003131737.bvpf5quds66qtsmy@gilmour>
In-Reply-To: <20191003131737.bvpf5quds66qtsmy@gilmour>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Oct 2019 20:46:31 +0530
Message-ID: <CAMty3ZA9tV-2nNa6qCBLUwoJpqEfQVZGk1E9-_wobfx5JDjvgw@mail.gmail.com>
Subject: Re: [PATCH v11 1/7] drm/sun4i: dsi: Fix TCON DRQ set bits
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 6:47 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Oct 03, 2019 at 12:15:21PM +0530, Jagan Teki wrote:
> > The LCD timing definitions between Linux DRM vs Allwinner are different,
> > below diagram shows this clear differences.
> >
> >            Active                 Front           Sync           Back
> >            Region                 Porch                          Porch
> > <-----------------------><----------------><--------------><-------------->
> >   //////////////////////|
> >  ////////////////////// |
> > //////////////////////  |..................                ................
> >                                            ________________
> > <----- [hv]display ----->
> > <------------- [hv]sync_start ------------>
> > <--------------------- [hv]sync_end ---------------------->
> > <-------------------------------- [hv]total ------------------------------>
> >
> > <----- lcd_[xy] -------->               <- lcd_[hv]spw ->
> >                                         <---------- lcd_[hv]bp --------->
> > <-------------------------------- lcd_[hv]t ------------------------------>
> >
> > The DSI driver misinterpreted the hbp term from the BSP code to refer
> > only to the backporch, when in fact it was backporch + sync. Thus the
> > driver incorrectly used the horizontal front porch plus sync in its
> > calculation of the DRQ set bit value, when it should not have included
> > the sync timing.
> >
> > Including additional sync timings leads to flip_done timed out as:
> >
> > WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
> > [CRTC:46:crtc-0] vblank wait timed out
> > Modules linked in:
> > CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 5.1.0-next-20190514-00026-g01f0c75b902d-dirty #13
> > Hardware name: Allwinner sun8i Family
> > Workqueue: events deferred_probe_work_func
> > [<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
> > [<c010b76c>] (show_stack) from [<c0688c70>] (dump_stack+0x84/0x98)
> > [<c0688c70>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
> > [<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
> > [<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
> > [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
> > [<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
> > [<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
> > [<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
> > [<c0411b64>] (restore_fbdev_mode_atomic) from [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
> > [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0415774>] (drm_fb_helper_set_par+0x30/0x54)
> > [<c0415774>] (drm_fb_helper_set_par) from [<c03ad450>] (fbcon_init+0x560/0x5ac)
> > [<c03ad450>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
> > [<c03eb8a0>] (visual_init) from [<c03ed1b8>] (do_bind_con_driver+0x1b0/0x390)
> > [<c03ed1b8>] (do_bind_con_driver) from [<c03ed780>] (do_take_over_console+0x13c/0x1c4)
> > [<c03ed780>] (do_take_over_console) from [<c03ad800>] (do_fbcon_takeover+0x74/0xcc)
> > [<c03ad800>] (do_fbcon_takeover) from [<c013c9c8>] (notifier_call_chain+0x44/0x84)
> > [<c013c9c8>] (notifier_call_chain) from [<c013cd20>] (__blocking_notifier_call_chain+0x48/0x60)
> > [<c013cd20>] (__blocking_notifier_call_chain) from [<c013cd50>] (blocking_notifier_call_chain+0x18/0x20)
> > [<c013cd50>] (blocking_notifier_call_chain) from [<c03a6e44>] (register_framebuffer+0x1e0/0x2f8)
> > [<c03a6e44>] (register_framebuffer) from [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock+0x2fc/0x50c)
> > [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock) from [<c04158c8>] (drm_fbdev_client_hotplug+0xe8/0x1b8)
> > [<c04158c8>] (drm_fbdev_client_hotplug) from [<c0415a20>] (drm_fbdev_generic_setup+0x88/0x118)
> > [<c0415a20>] (drm_fbdev_generic_setup) from [<c043f060>] (sun4i_drv_bind+0x128/0x160)
> > [<c043f060>] (sun4i_drv_bind) from [<c044b598>] (try_to_bring_up_master+0x164/0x1a0)
> > [<c044b598>] (try_to_bring_up_master) from [<c044b668>] (__component_add+0x94/0x140)
> > [<c044b668>] (__component_add) from [<c0445e1c>] (sun6i_dsi_probe+0x144/0x234)
> > [<c0445e1c>] (sun6i_dsi_probe) from [<c0452ef4>] (platform_drv_probe+0x48/0x9c)
> > [<c0452ef4>] (platform_drv_probe) from [<c04512cc>] (really_probe+0x1dc/0x2c8)
> > [<c04512cc>] (really_probe) from [<c0451518>] (driver_probe_device+0x60/0x160)
> > [<c0451518>] (driver_probe_device) from [<c044f7a4>] (bus_for_each_drv+0x74/0xb8)
> > [<c044f7a4>] (bus_for_each_drv) from [<c045107c>] (__device_attach+0xd0/0x13c)
> > [<c045107c>] (__device_attach) from [<c0450474>] (bus_probe_device+0x84/0x8c)
> > [<c0450474>] (bus_probe_device) from [<c0450900>] (deferred_probe_work_func+0x64/0x90)
> > [<c0450900>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
> > [<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
> > [<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
> > [<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> > Exception stack(0xde539fb0 to 0xde539ff8)
> > 9fa0:                                     00000000 00000000 00000000 00000000
> > 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > ---[ end trace b57eb1e5c64c6b8b ]---
> > random: fast init done
> > [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:46:crtc-0] flip_done timed out
> > [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:48:DSI-1] flip_done timed out
> > [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:30:plane-0] flip_done timed out
> >
> > With the terms(as described in above diagram) fixed, the panel
> > displays correctly without any timeouts.
> >
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Applied, thanks

Thanks, would you apply the similar change in 3/7?
