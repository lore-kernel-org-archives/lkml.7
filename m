Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96673C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6400E2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="go/AeEsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfH3Czl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:55:41 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46504 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfH3Czl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:55:41 -0400
Received: by mail-ua1-f65.google.com with SMTP id y19so1834203ual.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVJP3tNQZmRfMHp/W2ZEuVlB3ztV/VuTs152oodDoRA=;
        b=go/AeEsI5vC+mODTwi/w5PsQtEjcwg1f3Pf9r94z/spWywhIHshzlHgOAz73WeypOX
         pqMIDya9cWyUswo1xPqA+BADMwbb805CpsmQht+9dYBhC6NqBViosIEVvwIli8l3sTlO
         1jIG9p8bhTKdxA20ytec9mf4cYGdg+LwRAdxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVJP3tNQZmRfMHp/W2ZEuVlB3ztV/VuTs152oodDoRA=;
        b=neJFzwIAOWvbzkaoqKpVNj+a0AzEz7hVwkjhCcs+v97A8vKjlMkRUBYL3rSdAghWs+
         eXvAYtZXTZAv0VlMBaBrDJDQF0Itd4Zo1egvk0cdXW4moZw6nIH1p7ea5rrKuX043BTu
         HEB/4ZNYw6aVwQuPOC31E0g0alQsRwT7xpWOutJyXrvtWqW/Qs5nkOV4nt76EfKWlILQ
         IB42qIbbicD//itJ4tCVZh5nrvSk+YaUjfQWcmdh+1jocnb+BjcecR6DUBI0RFyuDBFb
         DkL3MRsABccPs/jdXHK9cUI6weQNk93jM+lgg9b1SnB1m29rfi+IboZcZJVyygmpBoeC
         13rw==
X-Gm-Message-State: APjAAAW67G/OaFYJeFwNvE+OScetxsrICko3NwQsofYt9VRQFyh0X2K5
        pzah/LS12H5QDSGGzWXIC5+6gw98heKPMuCYUQqXrQ==
X-Google-Smtp-Source: APXvYqz3y2+iMq8OG/5tEVPvpxYHj7wpUTGqFySYc0DUG/K3JsZPiNj8noweU6gAsRnU3oLPZiigq/TH0naxasIEv+E=
X-Received: by 2002:ab0:7c3:: with SMTP id d3mr6638328uaf.131.1567133739477;
 Thu, 29 Aug 2019 19:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190717083327.47646-1-cychiang@chromium.org> <CA+Px+wX4gbntkd6y8NN8xwXpZLD4MH9rTeHcW9+Ndtw=3_mWBw@mail.gmail.com>
In-Reply-To: <CA+Px+wX4gbntkd6y8NN8xwXpZLD4MH9rTeHcW9+Ndtw=3_mWBw@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Fri, 30 Aug 2019 10:55:12 +0800
Message-ID: <CAFv8NwLiY+ro0L4c5vjSOGN8jA-Qr4zm2OWvVHkiuoa7_4e2Fg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add HDMI jack support on RK3288
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Douglas Anderson <dianders@chromium.org>,
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

On Wed, Jul 17, 2019 at 6:28 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Wed, Jul 17, 2019 at 4:33 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > This patch series supports HDMI jack reporting on RK3288, which uses
> > DRM dw-hdmi driver and hdmi-codec codec driver.
> >
> > The previous discussion about reporting jack status using hdmi-notifier
> > and drm_audio_component is at
> >
> > https://lore.kernel.org/patchwork/patch/1083027/
> >
> > The new approach is to use a callback mechanism that is
> > specific to hdmi-codec.
> >
> > Changes from v4 to v5:
> > - synopsys/Kconfig: Remove the incorrect dependency change in v4.
> > - rockchip/Kconfig: Add dependency of hdmi-codec when it is really need
> >   for jack support.
> >
> > Cheng-Yi Chiang (5):
> >   ASoC: hdmi-codec: Add an op to set callback function for plug event
> >   drm: bridge: dw-hdmi: Report connector status using callback
> >   drm: dw-hdmi-i2s: Use fixed id for codec device
> >   ASoC: rockchip_max98090: Add dai_link for HDMI
> >   ASoC: rockchip_max98090: Add HDMI jack support
> >
> LGTM.
>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

Hi Daniel,
Do you have further concern on this patch series related to hdmi-codec
and drm part ?
We would like to merge this patch series if possible.
They will be needed in many future chrome projects for HDMI audio jack
detection.
Thanks a lot!
