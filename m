Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E995C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7340F20652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfFXQHk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:07:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43090 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFXQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:07:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so22489725edr.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pWYsiKGg/zyVesxoNDfGpttEfT3N8EUCOmxzrH5E//Q=;
        b=NcgfnVJU/rtcPBB9LtT0h/faDwzG93aspuwiCIGowNaO2aqrMfkOQS+yFS2yhDq5ta
         yB/1tpVc7tJpmpzSqSCuopG792V7x7as4BSj5bMRbSkvIbPH3Wciq6VHmxicudxOSk91
         olewnncHXoSC+APEVPgSxKp8I2/tk/ZBn2AorBZ/rGtfpb/wQqMJhRMf9ptCbVVTv7R6
         vPQuwjd5hFn5I24qInUqxnU0RRuPuAw0HwjBx3Iy4l2XAXU1tXHFofdyF1GQeSqLC3gY
         MzqMx8NyhTbGY45PaCg57Cb0e40Q3mEuVKTqPtUGsnyGc0FaPRg+LDIHL2rdl9vUy52m
         jZWA==
X-Gm-Message-State: APjAAAUNmgkpVj58A1VYMElPL58Xig4ux64jA/cAefSkbEgHQrqyUaDb
        JvSGyZZsdTNxyftVLGAbaOx8wPJpfCE=
X-Google-Smtp-Source: APXvYqztmgndhFLUHDgQ1yRzv0IUw3ri1jcdD04SfVQLpjVtDqy8ucr65iD4Ne0cEvsqDIWcZtN3jw==
X-Received: by 2002:a05:6402:1446:: with SMTP id d6mr126699677edx.37.1561392457073;
        Mon, 24 Jun 2019 09:07:37 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id l35sm842315edc.2.2019.06.24.09.07.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:07:35 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id g135so13331120wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:07:35 -0700 (PDT)
X-Received: by 2002:a7b:c051:: with SMTP id u17mr16105850wmc.25.1561392454870;
 Mon, 24 Jun 2019 09:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <3f9e51d5-8ca5-a439-943c-26de92dd52fe@samsung.com> <CAGb2v67FF3k9wZu7K+Z5yKFFeh8A_4iuEXfh+tO65UvVRfY-sA@mail.gmail.com>
 <44611965.cJa5QBey4U@jernej-laptop>
In-Reply-To: <44611965.cJa5QBey4U@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 25 Jun 2019 00:07:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v67T-nOqxkjekcc1ze9otVrzJb5KEtdJuMMk+dEGgAn1pQ@mail.gmail.com>
Message-ID: <CAGb2v67T-nOqxkjekcc1ze9otVrzJb5KEtdJuMMk+dEGgAn1pQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/sun4i: Enable DRM InfoFrame support on H6
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:03 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne ponedeljek, 24. junij 2019 ob 17:56:30 CEST je Chen-Yu Tsai napisal(a):
> > On Mon, Jun 24, 2019 at 11:49 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > > On 24.06.2019 17:05, Jernej Škrabec wrote:
> > > > Dne ponedeljek, 24. junij 2019 ob 17:03:31 CEST je Andrzej Hajda
> napisal(a):
> > > >> On 26.05.2019 23:20, Jonas Karlman wrote:
> > > >>> This patch enables Dynamic Range and Mastering InfoFrame on H6.
> > > >>>
> > > >>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > > >>> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > > >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > >>> ---
> > > >>>
> > > >>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 ++
> > > >>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
> > > >>>  2 files changed, 3 insertions(+)
> > > >>>
> > > >>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > > >>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index
> > > >>> 39d8509d96a0..b80164dd8ad8
> > > >>> 100644
> > > >>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > > >>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > > >>> @@ -189,6 +189,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
> > > >>> struct device *master,>
> > > >>>
> > > >>>     sun8i_hdmi_phy_init(hdmi->phy);
> > > >>>
> > > >>>     plat_data->mode_valid = hdmi->quirks->mode_valid;
> > > >>>
> > > >>> +   plat_data->drm_infoframe = hdmi->quirks->drm_infoframe;
> > > >>>
> > > >>>     sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
> > > >>>
> > > >>>     platform_set_drvdata(pdev, hdmi);
> > > >>>
> > > >>> @@ -255,6 +256,7 @@ static const struct sun8i_dw_hdmi_quirks
> > > >>> sun8i_a83t_quirks = {>
> > > >>>
> > > >>>  static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
> > > >>>
> > > >>>     .mode_valid = sun8i_dw_hdmi_mode_valid_h6,
> > > >>>
> > > >>> +   .drm_infoframe = true,
> > > >>>
> > > >>>  };
> > > >>>
> > > >>>  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
> > > >>>
> > > >>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > >>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index
> > > >>> 720c5aa8adc1..2a0ec08ee236
> > > >>> 100644
> > > >>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > >>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > >>> @@ -178,6 +178,7 @@ struct sun8i_dw_hdmi_quirks {
> > > >>>
> > > >>>     enum drm_mode_status (*mode_valid)(struct drm_connector
> > > >
> > > > *connector,
> > > >
> > > >>>                                        const struct
> > > >
> > > > drm_display_mode *mode);
> > > >
> > > >>>     unsigned int set_rate : 1;
> > > >>>
> > > >>> +   unsigned int drm_infoframe : 1;
> > > >>
> > > >> Again, drm_infoframe suggests it contains inforframe, but in fact it
> > > >> just informs infoframe can be used, so again my suggestion
> > > >> use_drm_infoframe.
> > > >>
> > > >> Moreover bool type seems more appropriate here.
> > > >
> > > > checkpatch will give warning if bool is used.
> > >
> > > Then I would say "fix/ignore checkpatch" :)
> > >
> > > But maybe there is a reason.
> >
> > Here's an old one from Linus: https://lkml.org/lkml/2013/9/1/154
> >
> > I'd say that bool in a struct is a waste of space compared to a 1 bit
> > bitfield, especially when there already are other bitfields in the same
> > struct.
> > > Anyway I've tested and I do not see the warning, could you elaborate it.
> >
> > Maybe checkpatch.pl --strict?
>
> It seems they removed that check:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?
> id=7967656ffbfa493f5546c0f1
>
> After reading that block of text, I'm not sure what would be prefered way for
> this case.

This:

+If a structure has many true/false values, consider consolidating them into a
+bitfield with 1 bit members, or using an appropriate fixed width type, such as
+u8.

would suggest using a bitfield, or flags within a fixed width type?

ChenYu
