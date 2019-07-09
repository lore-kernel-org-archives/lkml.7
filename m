Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF00C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD2E21670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b6eUu3HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGIL7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:59:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37598 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfGIL7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:59:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id v6so10448697vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiTv9D9r+HWewv08+uDjzds8jJ160NpsMW3nG+2KdoY=;
        b=b6eUu3HOZ32VMVxihS1TEiZDDJGMWpTKkUmCzgDy0Wn1UIqQ2Hg/sRGYSq7RTss8Dt
         EUsDIbda6QYf9S42qsjMSo76RaQmk/AXAegCp/GvMR+GeNmoH1GewBpHbDxaucdsY43j
         Ic831T+DuHkmI1k4SYW5LLWcFpi0VyYWE6dxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiTv9D9r+HWewv08+uDjzds8jJ160NpsMW3nG+2KdoY=;
        b=GQ8V/GnNsuh7MwpCdYBGS+SBHOx+ni7/DLPBGxfqi74SLTgRzaMnamrwPKvv3yeej3
         kyuOZSvsavl7XWcPdoQ2eCy46IZTeCHEdDwRVMgeZAed7UuBXNVCooNpFFZ46Yqd+2pU
         rQHVRbvQimbyD4gjvVn2rhtO6VyY4IcpTevCOYQUVjeCP4tlTWWVP148WvxoDnP4VVFI
         ivG+oY20P8YsH9ZrO0xwGQ9xI2NBttTUtkloyzZkKxv6J9SnhfBriv76A1sH5cq9UfnZ
         0R8QqP33Lt2gr++QVDFm/x2PCj9QXRgKYvwkExyk5j/UKZdYnCgOU0Fpcy3pwaxSedy5
         0lRA==
X-Gm-Message-State: APjAAAUB3KSRZI/HK2VjaRZBogmTpNbiRn9RQBcp6dQXAH9vzluWNzQl
        OhXfa9V8qF4Gi4Zh7EfHkd6z4zsa6yyFPTtfX3qLpQ==
X-Google-Smtp-Source: APXvYqyNbkbPQt5s+GfBLT3QI7iGlZiQWtRzOE3HxXG0lIDjqNAi3SYslwEYCGrQlbUmVYhU38as6OOl9n5yJb/dYW4=
X-Received: by 2002:a67:d386:: with SMTP id b6mr14020005vsj.170.1562673563188;
 Tue, 09 Jul 2019 04:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org> <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
 <20190705121240.GA20625@sirena.org.uk> <CAFv8NwLP-hUBW8FZW5kooaggeNRG7LAEd2pd_-70YBrVMY-+CQ@mail.gmail.com>
In-Reply-To: <CAFv8NwLP-hUBW8FZW5kooaggeNRG7LAEd2pd_-70YBrVMY-+CQ@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 9 Jul 2019 19:58:56 +0800
Message-ID: <CAFv8NwJHpY+ptc+WbeRhsKB8wGnt08r38GG7WUYTrt=wZaGqqA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function
 for plug event
To:     Mark Brown <broonie@kernel.org>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
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
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 1:03 PM Cheng-yi Chiang <cychiang@chromium.org> wrote:
>
> On Fri, Jul 5, 2019 at 8:12 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Jul 05, 2019 at 03:08:37PM +0800, Tzung-Bi Shih wrote:
> > > On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > > > +typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
> > > > +                                     bool plugged);
> > > > +
> >
> > > The callback prototype is "weird" by struct platform_device.  Is it
> > > possible to having snd_soc_component instead of platform_device?
> >
> > Or if it's got to be a device why not just a generic device so
> > we're not tied to a particular bus here?
>
> My intention was to invoke the call in dw-hdmi.c like this:
>
>     hdmi->plugged_cb(hdmi->audio,
>                                    result == connector_status_connected);
>
> Here hdmi->audio is a platform_device.
> I think dw-hdmi can not get  snd_soc_component easily.
> I can use a generic device here so the ops is more general.
> The calling will be like
>     hdmi->plugged_cb(&hdmi->audio->dev,
>                                    result == connector_status_connected);
> I will update this in v2.
> Thanks!

I have thought about this a bit more. And I think the more proper
interface is to pass in a generic struct device* for codec.
This way, the user of hdmi-codec driver on the DRM side is not limited
to the relation chain of
audio platform device -> codec platform device, which is just a
special case in dw-hdmi driver.
As long as DRM side can get hdmi-codec device pointer through
drv_data, it can use this callback.
Hope this makes the interface more generic.
