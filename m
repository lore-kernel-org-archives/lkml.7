Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE433CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823BE20650
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IysszB7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfJ1Ccz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:32:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41911 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfJ1Ccz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:32:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so8204020wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 19:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7WLAChacz4cdQUuGvSzDH2SDjigryRCbt+WDbtW90s=;
        b=IysszB7/4YwlqN2hIxbjmBzRqB+jb5hB3Tg+ljjzuq3A+FEhC3OFZFMovTbRT0LJfK
         H4qNyEspy1rpsUjibdaW/gAWpBeFZqCkQNS/a6m2giKGzWFHNCZXv+UikEp3b05qqUYQ
         XL2aGPYxYupmlhSDoZ4ce3ZDLKnBEnisKO4aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7WLAChacz4cdQUuGvSzDH2SDjigryRCbt+WDbtW90s=;
        b=CUKbjv34ANCLDSYIDRw9ENif7yKFb1Wz7VEBSd5frU4ahQRmeXXiH9USGcHZpwo63G
         KJlw9LBxunqUPE6srOEC1gAYyR4oJEqev4WC9rtqJvnEOZiinL9/1pR80oqQBMcIuUcI
         cLteyE177WlqzYpJDnCcXc+40/Jgpo08I+yd4P/sBchZYGANYnLfWWlHfrqtiv5qxbrV
         MSq/go93iAaqgcWcJppgzf5LexLUWlTzYJdFdS2eiJAeYIGcU+Uu7x6dDvLYbpRS+pjy
         cSUBTHoDr/WKFG7Uwa0ZRHGivroEkDImiCga0jb3Nxh5npz/vneRWbEbYG4WGCDCJMuY
         uQVg==
X-Gm-Message-State: APjAAAV9/6n75Pe2PVs2enwTA9aQ650ZCs/ewxNznmdbHzaQUcDfAR/s
        dUzMAh1NdLURqFNJ4kF8qKOlgTaLfgqsjvaL0u1DGQ==
X-Google-Smtp-Source: APXvYqzK0YBdyQgsMLm2ci9Dx4kOzJFycGTSzYpVPVfKV8gCZkiX6U1k76C9C14EYAVMDUxQGFHxdvyM+PTOBO8Lys4=
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr12904765wra.201.1572229970951;
 Sun, 27 Oct 2019 19:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191025133007.11190-1-cychiang@chromium.org> <20191025133007.11190-3-cychiang@chromium.org>
 <20191025162232.GA23022@bogus>
In-Reply-To: <20191025162232.GA23022@bogus>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 28 Oct 2019 10:32:24 +0800
Message-ID: <CAFv8NwKhe=CEuMCgeP1G0-Az4GEdMGPMMhvM3oY2=KmZNGrcRw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] ASoC: rockchip-max98090: Support usage with and
 without HDMI
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 12:22 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 25, 2019 at 09:30:03PM +0800, Cheng-Yi Chiang wrote:
> > There will be multiple boards sharing this machine driver.
> > Use compatible string to specify the use case.
> >
> > "rockchip,rockchip-audio-max98090" for max98090-only.
> > "rockchip,rockchip-audio-hdmi" for HDMI-only
> > "rockchip,rockchip-audio-max98090-hdmi" for max98090 plus
> >
> > Move these properties to optional because they are not needed for
> > HDMI-only use case.
> > "rockchip,audio-codec": The phandle of the MAX98090 audio codec
> > "rockchip,headset-codec": The phandle of Ext chip for jack detection
> >
> > The machine driver change will add support for HDMI codec in
> > rockchip-max98090.
> > Add one optional property "rockchip,hdmi-codec" to let user specify HDMI
> > device node in DTS so machine driver can find hdmi-codec device node for
> > codec DAI.
>
> Why not just use the presence of rockchip,hdmi-codec to enable HDMI or
> not. Maybe you still add rockchip,rockchip-audio-hdmi for HDMI only.
>
> Really, the same should have been done for which codec is used too, but
> I guess someone wanted 2 machine drivers.

Hi Rob,
Thanks for the quick reply.
I can make change in machine driver so that
- The presence of rockchip,audio-codec enable max98090
- The presence of rockchip,hdmi-codec enable HDMI.

With that, we don't need the three properties added in this patch:
"rockchip,rockchip-audio-max98090" for max98090-only.
"rockchip,rockchip-audio-hdmi" for HDMI-only
"rockchip,rockchip-audio-max98090-hdmi" for max98090 plus HDMI.

I will post an update soon. Thanks!

>
>
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  .../bindings/sound/rockchip-max98090.txt      | 38 +++++++++++++++++--
> >  1 file changed, 35 insertions(+), 3 deletions(-)
