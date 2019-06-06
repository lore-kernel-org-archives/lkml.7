Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF25C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38C02089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SQ6VQ7xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfFFW6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:58:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37001 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFFW6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:58:37 -0400
Received: by mail-it1-f193.google.com with SMTP id x22so2590293itl.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZyg+4+QNKbKPq0WwkGA+iMce1tFBIQolx/rr5mhJFU=;
        b=SQ6VQ7xXspnotBNh7TJpasqfkB9SD+WXfZFDbmWBNN4+1xeq/tt2vj7xg9kOfp8Jn+
         2tqwB/HzqlKfvSfg7a25R8OwV1bJh1loaTbudTWz8QmBkGkLMkmobmKogKb/+FnTOa1g
         /sie1KrlCOWdVZiWWJLXrlxPkf/E1T1lI1Wqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZyg+4+QNKbKPq0WwkGA+iMce1tFBIQolx/rr5mhJFU=;
        b=qoM84g2eNTa8QS/cZkhWxzk6ug8bzcIHeEtTeq5me937zkSZE2SUxBBzuGiCe/IAeJ
         km/B8VblCyKZ/PzxdA34vstNa01XVMI+nOtWwXDl/gJSaTw9j9RzTHHq3xpEQYVlHCBj
         g/WA+8PAPM55CaM9FoygBZ4e68EgfmYsdK7t70G9azZeNeC9101JyY3tTemRjVzaxOBT
         p4HU97RBz/wCSZuxtquG/WkdtTeiIvxmyXTjFZLSt6g3bh/s4o/qcUtkgKUjD8gs7X31
         Syl8l5Q4YfoscieuDN+JtJQ+opSuANUTq9IrEeMwx7CkDCbgWaT1uO58HAtEA6xTqGoz
         4+Fw==
X-Gm-Message-State: APjAAAUrw3SXV65xd6hsg2NzhSVaIQsvvNHiB3NVG4SSGyViXXXd9uZ6
        pl+//FRDyjolrbb3j+XSqOTbTjhj+VA=
X-Google-Smtp-Source: APXvYqzlftWAFR/b6lef99pTtL2/J5GevxkAYS27rZ3f7C21XzYPPYoI8pQm1H0/w7D3uOs+bimT6w==
X-Received: by 2002:a02:950a:: with SMTP id y10mr34436993jah.26.1559861916313;
        Thu, 06 Jun 2019 15:58:36 -0700 (PDT)
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id b14sm96924iod.33.2019.06.06.15.58.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 15:58:33 -0700 (PDT)
Received: by mail-it1-f175.google.com with SMTP id m3so2695244itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 15:58:33 -0700 (PDT)
X-Received: by 2002:a02:9143:: with SMTP id b3mr9564655jag.12.1559861912576;
 Thu, 06 Jun 2019 15:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190604204207.168085-1-dianders@chromium.org>
 <20190604204207.168085-2-dianders@chromium.org> <20190606164221.GI17077@art_vandelay>
In-Reply-To: <20190606164221.GI17077@art_vandelay>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jun 2019 15:58:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xt6Oad9yQHZz+nwANV1MCvGc6XCgOf8HawimVQtwWsEg@mail.gmail.com>
Message-ID: <CAD=FV=Xt6Oad9yQHZz+nwANV1MCvGc6XCgOf8HawimVQtwWsEg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/rockchip: dw_hdmi: Handle suspend/resume
To:     Sean Paul <sean@poorly.run>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 6, 2019 at 9:42 AM Sean Paul <sean@poorly.run> wrote:
>
> On Tue, Jun 04, 2019 at 01:42:07PM -0700, Douglas Anderson wrote:
> > On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> > cycle:
> >
> > 1. You lose the ability to detect an HDMI device being plugged in.
> >
> > 2. If you're using the i2c bus built in to dw_hdmi then it stops
> > working.
> >
> > Let's call the core dw-hdmi's suspend/resume functions to restore
> > things.
> >
> > NOTE: in downstream Chrome OS (based on kernel 3.14) we used the
> > "late/early" versions of suspend/resume because we found that the VOP
> > was sometimes resuming before dw_hdmi and then calling into us before
> > we were fully resumed.  For now I have gone back to the normal
> > suspend/resume because I can't reproduce the problems.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v3:
> > - dw_hdmi_resume() is now a void function (Laurent)
> >
> > Changes in v2:
> > - Add forgotten static (Laurent)
> > - No empty stub for suspend (Laurent)
> >
> >  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > index 4cdc9f86c2e5..7bb0f922b303 100644
> > --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > @@ -542,11 +542,25 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > +static int __maybe_unused dw_hdmi_rockchip_resume(struct device *dev)
> > +{
> > +     struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
> > +
> > +     dw_hdmi_resume(hdmi->hdmi);
>
> The rockchip driver is already using the atomic suspend/resume helpers (via the
> modeset helpers). Would you be able to accomplish the same thing by just moving
> this call into the encoder enable callback?
>
> .enable is called on resume via the atomic commit framework, so everything is
> ordered properly. Of course, this would reset the dw_hdmi bridge on each enable,
> but I don't think that would be a problem?

I tried and it sorta kinda half worked, but...

1. One of the problems solved by this patch is making "hot plug
detect" work after suspend / resume.  AKA: if you have nothing plugged
in to the HDMI port and then suspend/resume you need to be able to
detect when something is plugged in.  When nothing is plugged in then
the ".enable" isn't called at resume time.

2. I'm not so convinced about the whole ordering being correct.
Unfortunately on my system (Chrome OS running the chromeos-4.19
kernel) we end up getting an i2c transfer before the ".enable" is
called.  I put a dump_stack() in the i2c transfer:

[   42.212516] CPU: 0 PID: 1479 Comm: DrmThread Tainted: G         C
     4.19.47 #60
[   42.221182] Hardware name: Rockchip (Device Tree)
[   42.226449] [<c0211a64>] (unwind_backtrace) from [<c020cf0c>]
(show_stack+0x20/0x24)
[   42.235114] [<c020cf0c>] (show_stack) from [<c0a1b8d4>]
(dump_stack+0x84/0xa4)
[   42.243195] [<c0a1b8d4>] (dump_stack) from [<c067d7c4>]
(dw_hdmi_i2c_wait+0x6c/0xa8)
[   42.251858] [<c067d7c4>] (dw_hdmi_i2c_wait) from [<c067d9a8>]
(dw_hdmi_i2c_xfer+0x1a8/0x30c)
[   42.261298] [<c067d9a8>] (dw_hdmi_i2c_xfer) from [<c0798704>]
(__i2c_transfer+0x3a8/0x5d8)
[   42.270543] [<c0798704>] (__i2c_transfer) from [<c07989c8>]
(i2c_transfer+0x94/0xc4)
[   42.279204] [<c07989c8>] (i2c_transfer) from [<c064e6b0>]
(drm_do_probe_ddc_edid+0xbc/0x11c)
[   42.288642] [<c064e6b0>] (drm_do_probe_ddc_edid) from [<c064e744>]
(drm_probe_ddc+0x34/0x5c)
[   42.298081] [<c064e744>] (drm_probe_ddc) from [<c0651b98>]
(drm_get_edid+0x60/0x2e0)
[   42.306743] [<c0651b98>] (drm_get_edid) from [<c067d710>]
(dw_hdmi_connector_get_modes+0x30/0x78)
[   42.316669] [<c067d710>] (dw_hdmi_connector_get_modes) from
[<c0634f38>] (drm_helper_probe_single_connector_modes+0x218/0x5c0)
[   42.329413] [<c0634f38>] (drm_helper_probe_single_connector_modes)
from [<c065b38c>] (drm_mode_getconnector+0x144/0x418)
[   42.341573] [<c065b38c>] (drm_mode_getconnector) from [<c0646844>]
(drm_ioctl_kernel+0xa0/0xf0)
[   42.351303] [<c0646844>] (drm_ioctl_kernel) from [<c0646d34>]
(drm_ioctl+0x32c/0x3c0)
[   42.360063] [<c0646d34>] (drm_ioctl) from [<c03ed0cc>] (vfs_ioctl+0x28/0x44)
[   42.367946] [<c03ed0cc>] (vfs_ioctl) from [<c03edee8>]
(do_vfs_ioctl+0x718/0x8b0)
[   42.376315] [<c03edee8>] (do_vfs_ioctl) from [<c03ee0dc>]
(ksys_ioctl+0x5c/0x84)
[   42.384587] [<c03ee0dc>] (ksys_ioctl) from [<c03ee11c>] (sys_ioctl+0x18/0x1c)
[   42.392570] [<c03ee11c>] (sys_ioctl) from [<c02011d4>]
(__sys_trace_return+0x0/0x10)

...I see several transfers fail and then finally a few seconds later
finally see the .enable call:

[   44.021501] DOUG: dw_hdmi_rockchip_encoder_enable start
[   44.027792] DOUG: dw_hdmi_rockchip_encoder_enable end

I can gather more info if it's useful.

===

...any chance we can keep the patch as-is, or do you have ideas of how
to solve the above problems?


Thanks!

-Doug
