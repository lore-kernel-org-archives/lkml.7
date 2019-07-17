Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317D3217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PGAFc+Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfGQINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:13:16 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46878 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQINQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:13:16 -0400
Received: by mail-ua1-f67.google.com with SMTP id o19so9293440uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPZj9UlJHzFlKhJn6/fmruVkm+j5FSEf7iBCwWIUVP4=;
        b=PGAFc+PfE3kR9fcYCHC8OBC1+IoRoDTjks9fGGEtJhXcGwvydqTrmOTUlJG5NcIoi+
         DhgCrVbGujMZ7kdW7pd2LxhnmzfkWVhrSGU6+vUrDINKdXOnsMlhOmTpRSBNgMGfmh6M
         2FzdJiKfwVdXZUmZgAS729lwaeb3EbIcBDD8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPZj9UlJHzFlKhJn6/fmruVkm+j5FSEf7iBCwWIUVP4=;
        b=DIPae15fLUX6gC+GVAXN0xYw52gff8Np5agZ7PrzON+fmRCcEMdDTEjgGVn6O27hrj
         UWcPYL1pSJ8J8qh3YCyEzDNb8JU0V9YmrLkDPh/W9UMOEsZEDNCsjNKC5sxGHGMI4ojC
         yA3P0zDCeIG+25+NbuauUkSg9UxZZMR/KNGYZgkKnKy0Gmet0WNAG4WUe75WFq2eM69P
         J/zo49XQROSrX2kINi+mJQwcUFNjfJgX/4a84POGEUj3v55QPtdljfGB8t4lwDwYsSEY
         3vKDqVuU82baxH5GLTjCtXZaoe5vlc3j0bPyoXcHq9RejVP3bu6b1X9zyJLPolaW2e6i
         U6JA==
X-Gm-Message-State: APjAAAUemxgZgFtSDed3DtHRwCYOUqlGvM8nxoy1QFea8Ddit9pxAqkw
        iqwKdLIzj/7orxRmIhpcdPe/ksMoqMAhWj4y2uM6Ug==
X-Google-Smtp-Source: APXvYqw12VFX7Lv6Sh5rKLzmIJDafMfD4+5vdQs5GbevDPTLgen0n5WPlVHqD/WI9vXfnk5kxptgrH3h3fBuUjYs/4Q=
X-Received: by 2002:ab0:7c3:: with SMTP id d3mr6146624uaf.131.1563351195035;
 Wed, 17 Jul 2019 01:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-5-cychiang@chromium.org>
 <CA+Px+wV6RSfv4GL8+EJzXGq2nqzKtH9p23VTo2s30h0To2rQtg@mail.gmail.com>
In-Reply-To: <CA+Px+wV6RSfv4GL8+EJzXGq2nqzKtH9p23VTo2s30h0To2rQtg@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 17 Jul 2019 16:12:48 +0800
Message-ID: <CAFv8NwJu14XEDLE3Y+GTU2foFH3b5iBQ-q=tehjBYQ51m2LiCQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] ASoC: rockchip_max98090: Add dai_link for HDMI
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

On Tue, Jul 16, 2019 at 10:14 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Tue, Jul 16, 2019 at 7:58 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
> > index b43657e6e655..d610b553ea3b 100644
> > --- a/sound/soc/rockchip/Kconfig
> > +++ b/sound/soc/rockchip/Kconfig
> > @@ -40,9 +40,10 @@ config SND_SOC_ROCKCHIP_MAX98090
> >         select SND_SOC_ROCKCHIP_I2S
> >         select SND_SOC_MAX98090
> >         select SND_SOC_TS3A227E
> > +       select SND_SOC_HDMI_CODEC
> >         help
> >           Say Y or M here if you want to add support for SoC audio on Rockchip
> > -         boards using the MAX98090 codec, such as Veyron.
> > +         boards using the MAX98090 codec and HDMI codec, such as Veyron.
> You should not need to select the option in this patch (but in next
> patch), because this patch does not depend on anything from
> hdmi-codec.c.
Thanks for the explanation.
I'll fix in v5.
