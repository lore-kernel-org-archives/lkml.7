Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E40C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0900207FC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gVLsd+T0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfIHNvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:51:31 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44774 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfIHNva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:51:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id z8so3446512uaq.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OjUEd4QSp7PdF6VW4aQrBE3Z+/uVpO6ArZ5TFedKOc=;
        b=gVLsd+T0GXYo4KXD8R+kiCVmUyc3iXlvJ5SL3N90TjeV223lfZq0lpVImmm1TQPLvr
         biVG3B/n3OMziPN/L+IVvhgX7Ge1Bk7hcW/JG/CkZ9zrfy4+DonIP5+MTrsf/9lW9zj+
         GDyNN76Ur/2fW2BBK/M7SqE9yXZfqSEsSHkh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OjUEd4QSp7PdF6VW4aQrBE3Z+/uVpO6ArZ5TFedKOc=;
        b=p4uIUfBB1nkAbLkOmiApCFc8jKarxk7RngsOgfTQ3kaaqd8fETDIAd9Of1siBxpcoB
         9aMgP8R6wcZyR5E78OVKuTqIOHM2S+nGsSZUn7zO+tOaAAi2FNtgiGKKlj5q6Hai9oB2
         QgexKMkU+dDvFTq59CTwl3jGLhhdIY4IiiLA1lmJyHXyGbY/sEq9cgCiiXXAvB7rOAni
         aRA9XLoMxSUuj2eSiRLmOkEUtnSbRpa5esUhwoe9CYWMEEL1ghpmMSawjtKnCtv2zZYc
         2cxsxSKie2vOQUdAXyMC1QttlcSrbdumfKdfIr3phCZ7ZsEqIuwvIe6W5gZevrkwvtKQ
         r3Ww==
X-Gm-Message-State: APjAAAW2Rh3sht/Phi+1IAwiCHWbzsfPB8RlxgXNCBeZxr4a1xKbpZyK
        Enx0NggGgSUX7v2Q6uotKWESFoP/w9+7cK5LvVuMRQ==
X-Google-Smtp-Source: APXvYqz0WcmHMeiK6IT+v7kmZTAGTgr1Hd/fvxS4YbL4elq2hJMpg584VDsJiFFWnsbRAAo6uqeDZQp5p3+XGhBLzrU=
X-Received: by 2002:ab0:7c3:: with SMTP id d3mr8981573uaf.131.1567950687342;
 Sun, 08 Sep 2019 06:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190717083327.47646-1-cychiang@chromium.org> <CA+Px+wX4gbntkd6y8NN8xwXpZLD4MH9rTeHcW9+Ndtw=3_mWBw@mail.gmail.com>
 <CAFv8NwLiY+ro0L4c5vjSOGN8jA-Qr4zm2OWvVHkiuoa7_4e2Fg@mail.gmail.com>
In-Reply-To: <CAFv8NwLiY+ro0L4c5vjSOGN8jA-Qr4zm2OWvVHkiuoa7_4e2Fg@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Sun, 8 Sep 2019 21:51:01 +0800
Message-ID: <CAFv8NwJjG4mwfnYO=M3O9nZN48D6aY72nQuqEFpZL68dh5727w@mail.gmail.com>
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
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:55 AM Cheng-yi Chiang <cychiang@chromium.org> wrote:
>
> On Wed, Jul 17, 2019 at 6:28 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > On Wed, Jul 17, 2019 at 4:33 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> > >
> > > This patch series supports HDMI jack reporting on RK3288, which uses
> > > DRM dw-hdmi driver and hdmi-codec codec driver.
> > >
> > > The previous discussion about reporting jack status using hdmi-notifier
> > > and drm_audio_component is at
> > >
> > > https://lore.kernel.org/patchwork/patch/1083027/
> > >
> > > The new approach is to use a callback mechanism that is
> > > specific to hdmi-codec.
> > >
> > > Changes from v4 to v5:
> > > - synopsys/Kconfig: Remove the incorrect dependency change in v4.
> > > - rockchip/Kconfig: Add dependency of hdmi-codec when it is really need
> > >   for jack support.
> > >
> > > Cheng-Yi Chiang (5):
> > >   ASoC: hdmi-codec: Add an op to set callback function for plug event
> > >   drm: bridge: dw-hdmi: Report connector status using callback
> > >   drm: dw-hdmi-i2s: Use fixed id for codec device
> > >   ASoC: rockchip_max98090: Add dai_link for HDMI
> > >   ASoC: rockchip_max98090: Add HDMI jack support
> > >
> > LGTM.
> >
> > Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
>
> Hi Daniel,
> Do you have further concern on this patch series related to hdmi-codec
> and drm part ?
> We would like to merge this patch series if possible.
> They will be needed in many future chrome projects for HDMI audio jack
> detection.
> Thanks a lot!

Hi Neil,
I am not sure if this patch series is under your radar.
Would you mind taking a look ?
This patch series has been following great suggestions from various
reviewers, so I hope it is fine now.

Audio jack reporting for HDMI might not be needed for other OS, but it
is a must on ChromeOS.
We have many previous projects using different local patch sets to
achieve HDMI jack reporting.
I hope that we can achieve a proper way and really get the patches
merged to mainline.
Thanks a lot!
