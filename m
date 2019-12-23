Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B5C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF6C20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JChcZAmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfLWJOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:14:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36765 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfLWJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:14:53 -0500
Received: by mail-qv1-f67.google.com with SMTP id m14so6134083qvl.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 01:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gu/ztFiRQ3wq9XQZk4WFXx+978qv3TNkjDk+Rg1DcEQ=;
        b=JChcZAmP16y+mbW1Asq7N8aJZsXBv8p86qgVulBr2n85kEF6ZYqrML12yiQ0Jliii0
         Knr104cQRfUO4BGBfzSyzaSqSTy7iNiXrG2Pax060fVdsPFaMX5BYTNmR6Bk3WqDIm35
         0/RGy6FmY5hwcu3+ywUuX0yVkdqKLZKYFXpqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gu/ztFiRQ3wq9XQZk4WFXx+978qv3TNkjDk+Rg1DcEQ=;
        b=CJ4GD/OrJhPgaL8zLK54gtS1GXdkaSMMDMffdYN7AxdWMVX1l29Ufuv0p+V6tfzGww
         xoiBHFyjBNDHdSL3p9TmPUvUyGqfjAIhO6PKH3z8cE1FdkLEA5G0Q8l0BZZsEBHOhYAc
         FQzYRXiZ+9O/ebe5hrdLglqZR2/iFLCyOz6dhuzNCt6+IPKvlaVvlgWuyIhJotkuwKgv
         aQHupaYUnQaTEZknm8yRjRjlJvykjFWFWZpzQuDahpW7/+2Hwrmq4IgRucDC0p42epTn
         wQY3rP7kzoLd2MyhNFX0VjJI+h1nzBM0/T/EtltoyE2r5nYVZgJCMNXG1Gc40luyMAru
         wSDg==
X-Gm-Message-State: APjAAAXJMzfU8gyxYthj5N278yg+6sqPgL4puhDNcYoZ1ZlSPRtCjhDE
        ndbBVvcThUoj3U/8ZuaQuFNkpOoB2CDg2TimJ5B0AA==
X-Google-Smtp-Source: APXvYqxSGh8tEsYM4HGrQMAIpi4RkLM4nlV0RIDeW/C6zkKppoWb1uEylH2teSbPYDtcvEwo1nKoLSIXM3xw4c24zSA=
X-Received: by 2002:ad4:4182:: with SMTP id e2mr23692671qvp.187.1577092492136;
 Mon, 23 Dec 2019 01:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20191220081738.1895-1-enric.balletbo@collabora.com>
 <20191220081738.1895-3-enric.balletbo@collabora.com> <CANMq1KBHsc8oqcjWnjLPCpRToyOm16X6EcQqmqPjZf=D7wA2-Q@mail.gmail.com>
 <05db638b-02a6-0e3a-43ed-44a0a1458d87@collabora.com>
In-Reply-To: <05db638b-02a6-0e3a-43ed-44a0a1458d87@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 23 Dec 2019 17:14:41 +0800
Message-ID: <CANMq1KA4mp648p1LicOzAyra6tdgN2qdDY=N0XyDYhgt6BP26w@mail.gmail.com>
Subject: Re: [PATCH v22 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Ulrich Hecht <uli@fpond.eu>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 3:10 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Nicolas,
>
> Many thanks for you review. Just preparing a new version with your comments
> addressed.
>
> On 20/12/19 9:44, Nicolas Boichat wrote:
> > On Fri, Dec 20, 2019 at 4:17 PM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> From: Jitao Shi <jitao.shi@mediatek.com>
> >>
> >> This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
> >>
> >> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> >> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> >> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> [uli: followed API changes, removed FW update feature]
> >> Signed-off-by: Ulrich Hecht <uli@fpond.eu>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> [snip]
> >> +       ret = i2c_smbus_write_byte_data(client, PAGE2_MCS_EN,
> >> +                                       status & ~MCS_EN);
> >> +       if (ret < 0) {
> >> +               DRM_ERROR("failed write PAGE2_MCS_EN: %d\n", ret);
> >> +               goto err_regulators_disable;
> >> +       }
> >> +
> >> +       ret = ps8640_bridge_unmute(ps_bridge);
> >> +       if (ret)
> >> +               DRM_ERROR("failed to enable unmutevideo: %d\n", ret);
> >
> > failed to unmute? Or failed to enable?
> >
>
> failed to unmute sound more clear to me.

I may be wrong, but I have the feeling that the functions
"mute/unmute" video/display, actually... And that the function naming
is strange...

You could just try to remove the calls, as there is no audio on the
board you have (elm), so if video still works, maybe this is actually
audio ,-)

Thanks,
