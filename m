Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CC7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883E22084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlwYctZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbfHOIW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:22:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41599 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbfHOIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:22:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id m24so1529012ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNifjZHy9qpEjr0GVjpJDJGNo3i2//VHyToq2Gi1I5o=;
        b=OlwYctZRlIMTjnglbFz8m9UPeYHKRsw+HS0cqHa/AZrP3rCVWXzJ5gTfiLfl40hRWX
         cX599NGltZt5oVIqpRPPhMuFrdyeOZm97dwPU+CAxT5l2Fmeh/ZSbFOCb/7nY3jY2z0d
         CIjrlvHSyzJD4VsaZOWNL8WGygu6Rqv8F2u1V5+5Vq2p/D6QfBUPCY82EgeyCZmGRItF
         sjGHEgbToBdt25gqu0ZmUeiwWbzQ33NvDXBHQd6ysLH7sZmeFJ9duV5eFYsKV7RiV72h
         eNWFtqLstPI4m/mvgNB4pqyITfo+BGeWUfVdKBuxzmRIaxr6JBuXwM1U7lK/HLoL9KU5
         xc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNifjZHy9qpEjr0GVjpJDJGNo3i2//VHyToq2Gi1I5o=;
        b=T1Ey7DHiLV8FDaEerhpNRiDxVzoLHZ8PQ8A+w4TDfoqKttpJoDkWfIL0FvuMUQ5bJe
         db2HIporhWcUhySdcTpNw7SjKi34r2kLnLjGbbxigxlE6eeyGRPGvBq3rz/yFCPWw0el
         S/XJsF5Run0UAsmaKL4dFfftHbXvgUviaLGx+AAwOq8F7B4DjAzkIvYNbeYgxPIkmZ5K
         gqXaglMDAQWewqSL0dWR4e1lnwQbnWpgPUIpEzf+j9E5CjhbhrwYbCuzUkWBTjTdPPBr
         ABw9f1RRkgoBdwmEAtjpPX9YhVeRe3yqYQTYpZxvGysP+/06kHS9yGMj/ALK8Zfz6aW5
         swoA==
X-Gm-Message-State: APjAAAViZvothvmrKFbvFHdrn/HFH0FrFjp7TrVqCZBEjhbXkZK43TVv
        drEQNgrVI3CkkDwXtz7fAbiaBboMyVGK1ML2bcbeWA==
X-Google-Smtp-Source: APXvYqzSKpPdJ2jsFgd1uIci3/V28JBr33UJghFYLTf8pCPXob33LzLWLieV3eJDVU3sY3EnTwoxgKPof5pySOFlK/A=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr2027257ljc.28.1565857377246;
 Thu, 15 Aug 2019 01:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190815004854.19860-1-masneyb@onstation.org> <20190815004854.19860-7-masneyb@onstation.org>
In-Reply-To: <20190815004854.19860-7-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 10:22:45 +0200
Message-ID: <CACRpkdYdQa+FVfpSjLi0SsBMDT4QC667z1P1dnapz7PXgRoB5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 06/11] drm/bridge: analogix-anx78xx: add support for
 avdd33 regulator
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

> Add support for the avdd33 regulator to the analogix-anx78xx driver.
> Note that the regulator is currently enabled during driver probe and
> disabled when the driver is removed. This is currently how the
> downstream MSM kernel sources do this.
>
> Let's not merge this upstream for the mean time until I get the external
> display fully working on the Nexus 5 and then I can submit proper
> support then that powers down this regulator in the power off function.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

> +static void anx78xx_disable_regulator_action(void *_data)
> +{
> +       struct anx78xx_platform_data *pdata = _data;
> +
> +       regulator_disable(pdata->avdd33);
> +}
(...)
> +       err = devm_add_action(dev, anx78xx_disable_regulator_action,
> +                             pdata);

Clever idea. Good for initial support, probably later on it would
need to be reworked using runtime PM so it's not constantly
powered up.

See for example how I try to push down power dissipation
of sensors in 3d838118c6aa.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
