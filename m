Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2A721907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fego5LxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfIRLxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:53:08 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45949 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfIRLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:53:08 -0400
Received: by mail-vs1-f65.google.com with SMTP id d204so4219055vsc.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KlX045+but4kZYDkxl79NCCq10iOcslEdRaiYLes50=;
        b=fego5LxIL6sB7nuVbbaJVJB9N7WNC8aIjmYR0y5szXrjm/cLvc2AEl4CT76peU8LyO
         ovgIJAkEcVdo/HQkTbgy73bCOznMQ54xCR6vuEpJF43zd/anX3d2aaBum9pZVtNEW2/S
         KaQ6549ctO0oKG1CzL2x+C+6Ci98YSp8YZRfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KlX045+but4kZYDkxl79NCCq10iOcslEdRaiYLes50=;
        b=mxdTigv1bxolK8yZtSXfqjRN4sdoKIzaSTlHSneaIeuYC0d6GkzfgCWgXGMiJmV99D
         WjE6r4kteAsQrwfEiJ4qhEY+CH5H0IKrsfPuvwN/VDGycn2mwUwE6+RrIXltmIgao4k2
         NXwQWmS8ZzuUImFeEXh4L34janDZoUFBGrU1BbZZVaL1P242rfa9ZjrS1jMUvRlmZyeX
         AL55ksCbSC9Zfr+RJVC6ZSymml0PEw1SO8HGkBXtBileVkHcBVHiB0Guvj09IF1PnVFv
         3zjGViNLa2aKO3Vg195d7jZpysdO9RbXcR20R3oAiLqobfywZaKSkGNsLNl5vwgvfBc0
         OqRw==
X-Gm-Message-State: APjAAAUH7zpgoh5BNCSXqcjlpM+e5JbAAxFqAv/b3vYli4qEaq9COhBK
        VfEr5BYonwWMaW55gXf2OixUSZ3rf1mUdi71qZCBl/ysvN6PLw==
X-Google-Smtp-Source: APXvYqyhL40Vy4UIINlY/uIQouC/knlNQeJfWaG2W2HqYygbGI5RQ+ggz1DPkhARkI89YhNy/gvof3y7jgV5PmDT70U=
X-Received: by 2002:a67:db8d:: with SMTP id f13mr1855977vsk.163.1568807586619;
 Wed, 18 Sep 2019 04:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190918082500.209281-1-cychiang@chromium.org>
 <20190918082500.209281-3-cychiang@chromium.org> <1j7e663sfu.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j7e663sfu.fsf@starbuckisacylon.baylibre.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 18 Sep 2019 19:52:39 +0800
Message-ID: <CAFv8Nw+JssR+qJYWaQAjDRbHuNidHXQBPLsbOM7kNs4MN-Nkkw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] drm: dw-hdmi-i2s: Use fixed id for codec device
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 4:43 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Wed 18 Sep 2019 at 10:24, Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> > The problem of using auto ID is that the device name will be like
> > hdmi-audio-codec.<id number>.auto.
> >
> > The number might be changed when there are other platform devices being
> > created before hdmi-audio-codec device.
> > Use a fixed name so machine driver can set codec name on the DAI link.
> >
> > Using the fixed name should be fine because there will only be one
> > hdmi-audio-codec device.
>
> While this is true all platforms we know of (I suppose), It might not be
> the case later on. I wonder if making such assumption is really
> desirable in a code which is used by quite a few different platforms.
>
> Instead of trying to predict what the device name will be, can't you just
> query it in your machine driver ? Using a device tree phandle maybe ?
>
> It is quite usual to set the dai links this way, "simple-card" is a good
> example of this.
>

Hi Jerome,
Thanks for the quick reply!
And thanks for pointing this out.
I found that
soc_component_to_node searches upward for one layer so it can find the
node which creates hdmi-audio-codec in runtime. This works even that
hdmi-audio-codec does not have its own node in dts.
I will change accordingly in v7.
Thanks!



> >
> > Fix the codec name in rockchip rk3288_hdmi_analog machine driver.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 2 +-
> >  sound/soc/rockchip/rk3288_hdmi_analog.c             | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > index d7e65c869415..86bd482b9f94 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > @@ -193,7 +193,7 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
> >
> >       memset(&pdevinfo, 0, sizeof(pdevinfo));
> >       pdevinfo.parent         = pdev->dev.parent;
> > -     pdevinfo.id             = PLATFORM_DEVID_AUTO;
> > +     pdevinfo.id             = PLATFORM_DEVID_NONE;
> >       pdevinfo.name           = HDMI_CODEC_DRV_NAME;
> >       pdevinfo.data           = &pdata;
> >       pdevinfo.size_data      = sizeof(pdata);
> > diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
> > index 767700c34ee2..8286025a8747 100644
> > --- a/sound/soc/rockchip/rk3288_hdmi_analog.c
> > +++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/gpio.h>
> >  #include <linux/of_gpio.h>
> >  #include <sound/core.h>
> > +#include <sound/hdmi-codec.h>
> >  #include <sound/jack.h>
> >  #include <sound/pcm.h>
> >  #include <sound/pcm_params.h>
> > @@ -142,7 +143,7 @@ static const struct snd_soc_ops rk_ops = {
> >  SND_SOC_DAILINK_DEFS(audio,
> >       DAILINK_COMP_ARRAY(COMP_EMPTY()),
> >       DAILINK_COMP_ARRAY(COMP_CODEC(NULL, NULL),
> > -                        COMP_CODEC("hdmi-audio-codec.2.auto", "i2s-hifi")),
> > +                        COMP_CODEC(HDMI_CODEC_DRV_NAME, "i2s-hifi")),
> >       DAILINK_COMP_ARRAY(COMP_EMPTY()));
> >
> >  static struct snd_soc_dai_link rk_dailink = {
>
