Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B52C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CCA20659
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nUiqNxzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfGQCRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:17:54 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36060 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfGQCRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:17:53 -0400
Received: by mail-vs1-f67.google.com with SMTP id y16so15360423vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 19:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yeo9/78yIZ/9VC2V6OzC4jD48Q2tlshLhO2xlpzyNJY=;
        b=nUiqNxzKLCH4uh7Rdk28OYJeCqZg+QKn/Ua3o40RM8WpdDaG3iflhnr8M/qkqbKcgw
         MB6O6mEn6WPNEgokSircT8LHVL2pkHwIAhiObF6mtO0l5foVBQDuDCYQgfQ/yKy2vod1
         EiRO1lNXlRxUc2xtXifWRV0NCnbRPoBSHfW0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yeo9/78yIZ/9VC2V6OzC4jD48Q2tlshLhO2xlpzyNJY=;
        b=qg4GCmxEoypBuNnZKEq3r8EJ5ohkpPe83IGykjvDGHA269NH8kzW/b7lkHef0EItRZ
         qcb26krgPU98ZqnOP1hqSlcdSAGT8MVwCQXL/GxzCWpGmA3LPNyOss6yTlejJORuIZ/w
         O4CpeVRf09SFKDZ6dRk0e8tub/gyj12cI013HF21UXq2twkd8ILibXVbzOMTNpgCuMcR
         JcK+NqPGnvGHhKrQE5kLjPhSRuMxUpo+3aHjF6n7/FR+l1zCyjQBV/2/I5MU+J9cyTn3
         XxR3NAI7qG/nerZOt/TPuGpUH4MAgh480nKWgWmBeEal/BENCQgabI5Q2zI0OGITpT5b
         JhbA==
X-Gm-Message-State: APjAAAWkkaGnaJBlh/vDzfJjkRLbvmQowQjohUJOUtswLAk8GNviKIPB
        hFmJucqJoQjtrxNM+LSuhyXRgzFYvRULHbE0ApuNXA==
X-Google-Smtp-Source: APXvYqxWnVBbK8jRKVsd6t2y7gQJuZMs4DlVLf7zXq9OOaLMsZSZoBF8H9LF78AxDMSny/dXL5TfEDzdnilbzMthY7M=
X-Received: by 2002:a67:ebcb:: with SMTP id y11mr13049180vso.138.1563329872293;
 Tue, 16 Jul 2019 19:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-3-cychiang@chromium.org>
 <CA+Px+wWuCBvWra8+=szQOrvr3iv2YPMeoHHVtJ1vmaZWEEQ44A@mail.gmail.com>
In-Reply-To: <CA+Px+wWuCBvWra8+=szQOrvr3iv2YPMeoHHVtJ1vmaZWEEQ44A@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 17 Jul 2019 10:17:25 +0800
Message-ID: <CAFv8NwKVEpnUi=+Hvi1_2vdYqWFd49zu8eoQbMwnjg6i_PGhcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] drm: bridge: dw-hdmi: Report connector status
 using callback
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

On Tue, Jul 16, 2019 at 10:13 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Tue, Jul 16, 2019 at 7:57 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > Change the Kconfig of DRM_DW_HDMI so it selects SND_SOC_HDMI_CODEC.
> > This is for the typedef of hdmi_codec_plugged_cb to be used in dw-hdmi.c.
> Not sure why you select SND_SOC_HDMI_CODEC in this patch.  To have
> definition of hdmi_codec_plugged_cb, include hdmi-codec.h should be
> sufficient.
>
Thank you for the review!
I misunderstood when to change Kconfig.
Will fix in v5.
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
> > index 21a1be3ced0f..309da052db97 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/Kconfig
> > +++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
> > @@ -4,6 +4,7 @@ config DRM_DW_HDMI
> >         select DRM_KMS_HELPER
> >         select REGMAP_MMIO
> >         select CEC_CORE if CEC_NOTIFIER
> > +       select SND_SOC_HDMI_CODEC
> So that it is weird to select this option.
>
Will be removed in v5.
Thanks!
> >
> >  config DRM_DW_HDMI_AHB_AUDIO
> >         tristate "Synopsys Designware AHB Audio interface"
> > @@ -20,7 +21,6 @@ config DRM_DW_HDMI_I2S_AUDIO
> >         tristate "Synopsys Designware I2S Audio interface"
> >         depends on SND_SOC
> >         depends on DRM_DW_HDMI
> > -       select SND_SOC_HDMI_CODEC
> Also strange for deselecting the option.  Should be in another commit
> for another reason?
Will be removed in v5.
Thanks!
