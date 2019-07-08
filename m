Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28FDC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966F120659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kr9xgzIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfGHFEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 01:04:23 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40369 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfGHFEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 01:04:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id a186so7363633vsd.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 22:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Div9/ExPBXeNPwe6gkanRSA20V8261vIipkTc2adVjM=;
        b=Kr9xgzIgvJODL4j4Tar0NRNKMTIXggQEPJlw7ZTjjNYm575FxLii/NRilTRRlb5wa9
         BWu/yi/4QHA/SF4dJDPdiho9Fx9QFL7y+FAMY/c8IVi1NMs8YVjKbGVOIrjJYJzX4EsW
         nPrzbFSUsGbfcqx1g1C4zlpLeDlnrse6Nv5Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Div9/ExPBXeNPwe6gkanRSA20V8261vIipkTc2adVjM=;
        b=k3iV2kATf6HpxDPw7nugM04z6UD7UYXWdf7FsmB9ouPFa1+PJu4kbJY1oNxx8EUbNV
         yQmJeLUj5nHubX2AEwaPwINsk4cuT4AtSq3d7rcRoTLzuG0W0ZtN1S0Yd96bKJUYa5do
         6cLGpqF9ETn2t7v0iuO+8b4CSP+t096EJAQJqiIpIgYaER4I1wP4eIQkMb3c25vhZ1/B
         I/Gs4uTTMf3RPGnk3WvWoA7Qdig+6Qwidw65nuUcSfhqJMpdcuOMHhHY7YDA1r1i1rDc
         ktA/Lj6BqaTnHa0xvoFDu1rgYV/rjKjjZU7iz2DHy9Fty8LLNneJgFkKfIXyUVywH3Bh
         GOew==
X-Gm-Message-State: APjAAAVZpPum932C2dKWOBxwr4ZJOyyEUJI0FQ4OQNgwAFSww7Fy3PEt
        wXdhGjCfIVBvNDkgjIJa7Z+GyJpm2BmefXa1Xqd/2Z8m6dxXXA==
X-Google-Smtp-Source: APXvYqzKI5qNNsiRKRIHZBN2EiiQYggki+EnjIVPY+3PoX163CFHFiFOgVyx1S9hteBUIbxFauiJMzT56Q8PxxERB2o=
X-Received: by 2002:a67:f7cd:: with SMTP id a13mr6748465vsp.163.1562562261162;
 Sun, 07 Jul 2019 22:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org> <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
 <20190705121240.GA20625@sirena.org.uk>
In-Reply-To: <20190705121240.GA20625@sirena.org.uk>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 8 Jul 2019 13:03:53 +0800
Message-ID: <CAFv8NwLP-hUBW8FZW5kooaggeNRG7LAEd2pd_-70YBrVMY-+CQ@mail.gmail.com>
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

On Fri, Jul 5, 2019 at 8:12 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 05, 2019 at 03:08:37PM +0800, Tzung-Bi Shih wrote:
> > On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> > > +typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
> > > +                                     bool plugged);
> > > +
>
> > The callback prototype is "weird" by struct platform_device.  Is it
> > possible to having snd_soc_component instead of platform_device?
>
> Or if it's got to be a device why not just a generic device so
> we're not tied to a particular bus here?

My intention was to invoke the call in dw-hdmi.c like this:

    hdmi->plugged_cb(hdmi->audio,
                                   result == connector_status_connected);

Here hdmi->audio is a platform_device.
I think dw-hdmi can not get  snd_soc_component easily.
I can use a generic device here so the ops is more general.
The calling will be like
    hdmi->plugged_cb(&hdmi->audio->dev,
                                   result == connector_status_connected);
I will update this in v2.
Thanks!
