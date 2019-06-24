Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30232C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6EF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfFXP4q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:56:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34898 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFXP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:56:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id w20so14876775edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mMUgs4HoLKDmtg/T/uzM5Qeyyd0kP1F7cWc1uMkgeRs=;
        b=f6MpH70T/k12GzVORXWXsIR5heiROU0PHkVp7O3nLmesMTRtGRU2q4qux4S17fPm8e
         bjpIce4BQxwKkLtPH17KSvdkicwRqwwo5rSZhITaF4FrjoWa3zM+BHGP30yYAS/AnxFS
         OaXm0mFmQTwkf0xkdNfNcs1qdcKpfzwWEW2eTIqdtbErrsv3ThAQfP9EOQFXzQHKJVP6
         CP7iEi/ZHJ92LxFnYZhPeAqXcymKo72+w6qNMZul4f8hEr9nL12h3mW7PgzPjxQko5fH
         c7S3ATWSkYvaYeBgkSeTACm2k3zB/ZDwT6diszCKJXmg9pP1Xj6NDWX+H8+mFOrxo8+u
         YEZg==
X-Gm-Message-State: APjAAAUYVcKldjQBAClNtCOo1epXa20vQPisPgjHHvZpT4Wxn+MDdDjd
        PPjf8oOQKH6tSmxEBE+1UGM165qiXaE=
X-Google-Smtp-Source: APXvYqzZQUQotwQYrqZNCYZXQ+x2MO1sWW0bFtMWPMBHT7pd0Hr3s1ChG62EqI7GxXj2lQdpXiLUjA==
X-Received: by 2002:a50:aa7c:: with SMTP id p57mr116794659edc.179.1561391803332;
        Mon, 24 Jun 2019 08:56:43 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id me3sm1942965ejb.21.2019.06.24.08.56.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:56:42 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id v19so13898197wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:56:42 -0700 (PDT)
X-Received: by 2002:a1c:f512:: with SMTP id t18mr16201190wmh.47.1561391801973;
 Mon, 24 Jun 2019 08:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <VI1PR03MB4206740285A775280063E303AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <baf95e6b-bfcf-27e7-1a00-ca877ae6f82d@samsung.com> <CGME20190624150546epcas1p1da19043e13dd3604a546f7983fc089b9@epcas1p1.samsung.com>
 <6819050.kFKQ8T6p8H@jernej-laptop> <3f9e51d5-8ca5-a439-943c-26de92dd52fe@samsung.com>
In-Reply-To: <3f9e51d5-8ca5-a439-943c-26de92dd52fe@samsung.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 24 Jun 2019 23:56:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v67FF3k9wZu7K+Z5yKFFeh8A_4iuEXfh+tO65UvVRfY-sA@mail.gmail.com>
Message-ID: <CAGb2v67FF3k9wZu7K+Z5yKFFeh8A_4iuEXfh+tO65UvVRfY-sA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/sun4i: Enable DRM InfoFrame support on H6
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
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

On Mon, Jun 24, 2019 at 11:49 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 24.06.2019 17:05, Jernej Škrabec wrote:
> > Dne ponedeljek, 24. junij 2019 ob 17:03:31 CEST je Andrzej Hajda napisal(a):
> >> On 26.05.2019 23:20, Jonas Karlman wrote:
> >>> This patch enables Dynamic Range and Mastering InfoFrame on H6.
> >>>
> >>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> >>> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>> ---
> >>>
> >>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 ++
> >>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
> >>>  2 files changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> >>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index 39d8509d96a0..b80164dd8ad8
> >>> 100644
> >>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> >>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> >>> @@ -189,6 +189,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
> >>> struct device *master,>
> >>>     sun8i_hdmi_phy_init(hdmi->phy);
> >>>
> >>>     plat_data->mode_valid = hdmi->quirks->mode_valid;
> >>>
> >>> +   plat_data->drm_infoframe = hdmi->quirks->drm_infoframe;
> >>>
> >>>     sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
> >>>
> >>>     platform_set_drvdata(pdev, hdmi);
> >>>
> >>> @@ -255,6 +256,7 @@ static const struct sun8i_dw_hdmi_quirks
> >>> sun8i_a83t_quirks = {>
> >>>  static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
> >>>
> >>>     .mode_valid = sun8i_dw_hdmi_mode_valid_h6,
> >>>
> >>> +   .drm_infoframe = true,
> >>>
> >>>  };
> >>>
> >>>  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
> >>>
> >>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> >>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index 720c5aa8adc1..2a0ec08ee236
> >>> 100644
> >>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> >>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> >>> @@ -178,6 +178,7 @@ struct sun8i_dw_hdmi_quirks {
> >>>
> >>>     enum drm_mode_status (*mode_valid)(struct drm_connector
> > *connector,
> >>>
> >>>                                        const struct
> > drm_display_mode *mode);
> >>>
> >>>     unsigned int set_rate : 1;
> >>>
> >>> +   unsigned int drm_infoframe : 1;
> >> Again, drm_infoframe suggests it contains inforframe, but in fact it
> >> just informs infoframe can be used, so again my suggestion
> >> use_drm_infoframe.
> >>
> >> Moreover bool type seems more appropriate here.
> > checkpatch will give warning if bool is used.
>
>
> Then I would say "fix/ignore checkpatch" :)
>
> But maybe there is a reason.

Here's an old one from Linus: https://lkml.org/lkml/2013/9/1/154

I'd say that bool in a struct is a waste of space compared to a 1 bit bitfield,
especially when there already are other bitfields in the same struct.

> Anyway I've tested and I do not see the warning, could you elaborate it.

Maybe checkpatch.pl --strict?

ChenYu
