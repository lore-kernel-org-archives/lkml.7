Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF35C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1002921537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgUpFjpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfFUN7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:59:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34141 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:59:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so6085190ljg.1;
        Fri, 21 Jun 2019 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+WQ5L7jyykHtcS1CaXqa3gfb+mYN5tnXeopjV9M8CY=;
        b=vgUpFjpv5ZZqrSFc78/TAZwdLTsExKEeFmU93mFN3yiJ8vozEvyCLfce/BIT0sk3ZX
         fb4W7rysGrty4ceatf35AHHNPaGDJFsZ+s83f2WToV9Gko+fe3U/fFpD74uHYCMF5r1p
         U+PfUIRAfCvp/0fY+a3BaBCvBdc+PHZkf9tAE4CCg6Cu96fcJsnwYsDZZoBpm2fxNRAW
         wIfA5hq/bmruwJ9X1f21bZr8wmLeT30ZRXo5VIficsOnI9KiLr8CQTH/co8nhFGLLZZH
         131Fl6emwOwazlwG66O/kw9N+SRT7zxvRT6nHm8ltg2by4h8KD6j2/uX14T3jGjNwop4
         b+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+WQ5L7jyykHtcS1CaXqa3gfb+mYN5tnXeopjV9M8CY=;
        b=mjNiIFTmCvVonzI5/Dbc2g3z55mD0/1LPo+A37LzQWi0eDeXOsVIxrx/T0lFsHJf+n
         S5sBSMS8jsQFNgie1ilB2lJ9ODmeZmdaDHdXRpe2rgeGlx/TGQcySpMnqWFataHfohOi
         jb/X3R6LKbRjeZTKbdH32U6KHgnpyNcH7niJ6Z3y3NA/DF7tjoPBUW/22vRk49rv5lXT
         aqjCRASItxXESejOpPemrzuqKc9hIRTmfc1FgjisNf62CnEEhUD8KVH8ZTJQP3iKtwke
         d6u7Xu9jvL3AVBzHd8Enb167FELcJ0fddZhK2ix0DbuHY6mvwK7NBJSho5yBqU28XD3R
         HKJQ==
X-Gm-Message-State: APjAAAX+reoo9KnMyEbXTCT+13Yr+lLArf6H/dzvsU4k6S3bH9xbXt2d
        plTCgVrSDyXP43NgP/DC+2b+vGjZ3wa+QygfcAo=
X-Google-Smtp-Source: APXvYqyt8yBta8bXLwF3TPCIh4vXPw+1C+YH2PaA7n6MW+n+xOcCd+FZKm8ynnqW0f6tzdYQjTVqYzRna3Q4v+GilBY=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr24502679ljj.178.1561125542140;
 Fri, 21 Jun 2019 06:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <1561037428-13855-1-git-send-email-robert.chiras@nxp.com> <1561037428-13855-3-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1561037428-13855-3-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 21 Jun 2019 10:59:19 -0300
Message-ID: <CAOMZO5DS2v15h9E=qKg2vKuFkBSQQwdBHA5Th5mZ+ca6DWgQsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: Add support for Raydium RM67191 panel driver
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Thu, Jun 20, 2019 at 10:31 AM Robert Chiras <robert.chiras@nxp.com> wrote:

> +fail:
> +       if (rad->reset)
> +               gpiod_set_value_cansleep(rad->reset, 1);

gpiod_set_value_cansleep() can handle NULL, so no need for the if() check.

> +static const struct display_timing rad_default_timing = {
> +       .pixelclock = { 132000000, 132000000, 132000000 },

Having the same information listed three times does not seem useful.

You could use a drm_display_mode structure with a single entry instead.

> +       videomode_from_timing(&rad_default_timing, &panel->vm);
> +
> +       of_property_read_u32(np, "width-mm", &panel->width_mm);
> +       of_property_read_u32(np, "height-mm", &panel->height_mm);
> +
> +       panel->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

Since this is optional it would be better to use
devm_gpiod_get_optional() instead.


> +
> +       if (IS_ERR(panel->reset))
> +               panel->reset = NULL;
> +       else
> +               gpiod_set_value_cansleep(panel->reset, 1);

This is not handling defer probing, so it would be better to do like this:

panel->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
if (IS_ERR(panel->reset))
      return  PTR_ERR(panel->reset);

> +       memset(&bl_props, 0, sizeof(bl_props));
> +       bl_props.type = BACKLIGHT_RAW;
> +       bl_props.brightness = 255;
> +       bl_props.max_brightness = 255;
> +
> +       panel->backlight = devm_backlight_device_register(dev, dev_name(dev),
> +                                                         dev, dsi,
> +                                                         &rad_bl_ops,
> +                                                         &bl_props);

Could you put more parameters into the same line?

Using 4 lines seems excessive.

> +       if (IS_ERR(panel->backlight)) {
> +               ret = PTR_ERR(panel->backlight);
> +               dev_err(dev, "Failed to register backlight (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       drm_panel_init(&panel->panel);
> +       panel->panel.funcs = &rad_panel_funcs;
> +       panel->panel.dev = dev;
> +       dev_set_drvdata(dev, panel);
> +
> +       ret = drm_panel_add(&panel->panel);
> +

Unneeded blank line

> +       if (ret < 0)
> +               return ret;
> +
> +       ret = mipi_dsi_attach(dsi);
> +       if (ret < 0)
> +               drm_panel_remove(&panel->panel);
> +
> +       return ret;

You did not handle the "power" regulator.

> +static int __maybe_unused rad_panel_suspend(struct device *dev)
> +{
> +       struct rad_panel *rad = dev_get_drvdata(dev);
> +
> +       if (!rad->reset)
> +               return 0;
> +
> +       devm_gpiod_put(dev, rad->reset);
> +       rad->reset = NULL;
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused rad_panel_resume(struct device *dev)
> +{
> +       struct rad_panel *rad = dev_get_drvdata(dev);
> +
> +       if (rad->reset)
> +               return 0;
> +
> +       rad->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

Why do you call devm_gpiod_get() once again?

I am having a hard time to understand the need for this suspend/resume hooks.

Can't you simply remove them?
