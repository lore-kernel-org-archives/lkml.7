Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96033C73CC0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDF721537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hif8gvZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfGILz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:55:58 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40062 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGILz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:55:57 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so10432322vsd.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVsg21whGsT0nCQujzZPC48g95cuUgQWLBZNQAx+pZc=;
        b=Hif8gvZ34qKJMh958dAAJSHO70lREX96FjBgtOfqYNFJyuQpBMR0C1BjfHgf8lDQ92
         sADjoOm6BOziZ8iFV4rfX/D+8PH0/e3yQd9VX01BYzeP27ufOcJLZvyArqht8aRbI3eJ
         IS7yqBpL3VKcMJ1o6/XM6Re5YNCRXm029XCfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVsg21whGsT0nCQujzZPC48g95cuUgQWLBZNQAx+pZc=;
        b=suUYScn9FkzQqGiImvse7u6gq6SgXdncWM8mz0BYv4Ht+L0xd4gJI8hWRcvWx11KWw
         E0/YPTuRSK3xE04VlvNsR3VCI5KF1Xv3hn9Gxdh8clxj3y4XqWzwgpZPkOef+LZ8hFBA
         yPU+CeXWCu4XiihAKSr5Ak4BhAQxFzDxynA2FhDUS9tFPbY2v/GmASIfyYIrLeqOTiXs
         tejUSc3tgRkSsV2syZt5w+f7MuEdfrIx4xvAGWQYfONcXl+YUGk/6tvFY4jnKbaQZVnt
         qSYP1JM/RL9LD4pQOiQ0Q50gue6W/wNk9kFt1NNiblLGpOLe5PDrd47tlWBU76bdOjYN
         E+LA==
X-Gm-Message-State: APjAAAUyLlWGs7dDy8v3CTZinpUQnTUhDsE9MsOrPUHaNU2N0oPmmUqm
        3hhiseoXKI1801x5ytuM4rHMtfGFhpKfktKWXANV/bWu9tVVtg==
X-Google-Smtp-Source: APXvYqzIvsL1PEG4x0OPfoI+B4eR1OeQ7eQJVZ/D8bs1VUH/IGuRilDy9DOu2h4I32heosv7RyuyXtXOhjY3Ym1TCUo=
X-Received: by 2002:a67:ebcb:: with SMTP id y11mr13483911vso.138.1562673356146;
 Tue, 09 Jul 2019 04:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org> <3d5755cf-34e9-44f7-3b03-6bdfca84ff95@intel.com>
In-Reply-To: <3d5755cf-34e9-44f7-3b03-6bdfca84ff95@intel.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 9 Jul 2019 19:55:29 +0800
Message-ID: <CAFv8NwLos-XcB9K8315vmmfKn+z0XaBph3QxSwrmqhfYqoju2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function
 for plug event
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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

On Tue, Jul 9, 2019 at 7:47 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2019-07-05 06:26, Cheng-Yi Chiang wrote:
> > +static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
> > +                                unsigned int jack_status)
> > +{
> > +     if (!hcp->jack)
> > +             return;
> > +
> > +     if (jack_status != hcp->jack_status) {
> > +             snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
> > +             hcp->jack_status = jack_status;
> > +     }
> > +}
>
> Single "if" statement instead? The first "if" does not even cover all
> cases - if the secondary check fails, you'll "return;" too.
>
ACK.
I will fix in v2.
> > +/**
> > + * hdmi_codec_set_jack_detect - register HDMI plugged callback
> > + * @component: the hdmi-codec instance
> > + * @jack: ASoC jack to report (dis)connection events on
> > + */
> > +int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
> > +                            struct snd_soc_jack *jack)
> > +{
> > +     struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
> > +     int ret;
> > +
> > +     if (hcp->hcd.ops->hook_plugged_cb) {
> > +             hcp->jack = jack;
> > +             ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
> > +                                                 hcp->hcd.data,
> > +                                                 plugged_cb);
> > +             if (ret) {
> > +                     hcp->jack = NULL;
> > +                     return ret;
> > +             }
> > +             return 0;
> > +     }
> > +     return -EOPNOTSUPP;
> > +}
> > +EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);
>
> int ret = -EOPNOTSUPP;
> (...)
>
> return ret;
>
> In consequence, you can reduce the number of "return(s)" and also remove
> the redundant parenthesis for the if-statement used to set jack to NULL.
>
> Czarek
ACK
will fix in v2.

Thanks a lot for the review!
