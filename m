Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32B12064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/iE0ACw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfHOISN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:18:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45614 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHOISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:18:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id t3so1498764ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7xfr16BH5ZJjmVp0865t1tdCv0TJfQQ8MOvl0IA0RI=;
        b=h/iE0ACwRL8YZpox9tiry6Y6F9AtQ6fulXq/U4nRshmUS5LIgMjgsMcGGCCmgSfY0J
         nglNTBQxeLzOt23t5VWv3b16qAW7RU72nYgfDHIc6rn/87aL9AlP5VRxR1gOtdNN2rzJ
         CE8Oaxl6PzFKEDehEhvT9xMnQ2BuRQKgGSacBPydzgzfPTcdrYIriDbFD0KYhisx/fYQ
         TfxHkfwUUu+WzgWKIvWBuJerhIihKrkXphGv+H3J2ktph4Au4Vf7P8one0DBq1AYscNq
         Ya5pxqW6o6aiYu+tmytDC5UQsm+gOAXmFAltlAlJRfVa6YAKIB8IWmHbMqFum5Xh0C62
         Y8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7xfr16BH5ZJjmVp0865t1tdCv0TJfQQ8MOvl0IA0RI=;
        b=bJuoZ3FdipB4AFL3G/StniNJMWRT10YlYC9H3BxCnSB/A2kAXmfJETO40XFLd141y0
         G0lgOhuTHwf3jOKJQteGtpedFcx2abQZJSL48kohEIP3a+scL8UaJTpZq1RgmgHGlJNe
         /vVajoJ0+utPC6qyuZjhw/IrcldEFVTalQZQMnyksu7oKZaX1Ij8ruKRo8beS3uycwJe
         slxHSEfSBwRDWqzrDtFpmJ64vUOVvgH0QkO9Ef1Po5vMmv2ur1HYTs3bLoC2JNO2cRls
         +5lgh/FlKcfg0Z38wpDhEC7q4D9ErqqdN8VpAzbrpYr5qR8Higx+dy1vQRzR4j+bERkY
         0XwQ==
X-Gm-Message-State: APjAAAUsaj5ag7njtMsVquaZ3xJN4t+9j0NwjnkMpIERp88U4L7vYMUM
        lq/Tl26JsKBkspDpcZ0aHCs1776YYLPz4Xe99c+xyA==
X-Google-Smtp-Source: APXvYqwlNuGYnM4syJ7wAaplZofwwfNvfLAdOC0xu1V73tUg0jS10SDexNQ4wMU3AxJ+Dtlu9zFGYve/VAiy/marM2E=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr2044788ljo.69.1565857090860;
 Thu, 15 Aug 2019 01:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190815004854.19860-1-masneyb@onstation.org> <20190815004854.19860-3-masneyb@onstation.org>
In-Reply-To: <20190815004854.19860-3-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 10:17:59 +0200
Message-ID: <CACRpkdaDHoJvoH93Amzv2gSDGbgAsF-iNLiEFA3Fuov3D4uh5Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/bridge: analogix-anx78xx: add new variants
To:     Brian Masney <masneyb@onstation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:49 AM Brian Masney <masneyb@onstation.org> wrote:

> Add support for the 7808 variant. While we're here, the of match table
> was missing support for the 7812 and 7818 variants, so add them as well.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
