Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AFEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE1D2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555508892;
	bh=l/GdADIsohWoodOyg2eGlKnyBtQwpQIyht2FExzKQ9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1fBHeqsa+2aZqpikM3SWGeIPIOFA7EyiPaVtt8EeTcPJqrd3Z69iSTZRi7Pi7T9ay
	 IwnLQNk8EvtkaotWGaYM5B28syycdLLgfnyn13dnX5KZn62lVXdSkAJopTSZydq48E
	 fhKJv0fV5RC/2OZb0rEIKB5X7b8BR2keTbfWI0Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbfDQNsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbfDQNsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:48:10 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB7F2183E;
        Wed, 17 Apr 2019 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555508889;
        bh=l/GdADIsohWoodOyg2eGlKnyBtQwpQIyht2FExzKQ9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WBy2aOzJLOO6EBHSqrFCEaW8JbEsVkgIniv8oDaJvmyiVJWI0D4bGRJyt+2Y6iQpq
         TRNJxONy19pHKIUHlFnA9eOvUuJRu5wHGDP0RNS+e/ib7ydo1eZt4rXsTVb7sd78c2
         x3dqZhNfaK2tI3bm8InUT/n2bTdOihDQ4hnRepIk=
Received: by mail-qt1-f180.google.com with SMTP id t28so27384907qte.6;
        Wed, 17 Apr 2019 06:48:09 -0700 (PDT)
X-Gm-Message-State: APjAAAUkjSYS9tw7LotxWPtLFlwUJKoeEYHr+KPP7NDIF/DS0sw1V+kp
        vUjjERP19Nfj4Xo+hVKjqLgYW+ywzpyhk/1skQ==
X-Google-Smtp-Source: APXvYqxYbY5mEK9C4Nsc/zfhRburuVjyZpGhYqMqvmh/J6qxMVx/wQhUEqLUWUJzsfS/DSMMEEXSA17/D2nA/Aj9dJo=
X-Received: by 2002:ac8:2cef:: with SMTP id 44mr55785852qtx.178.1555508888871;
 Wed, 17 Apr 2019 06:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190414200824.28348-1-paul@crapouillou.net> <20190414200824.28348-2-paul@crapouillou.net>
In-Reply-To: <20190414200824.28348-2-paul@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 17 Apr 2019 08:47:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKkYkRQ4jDM9NR_eP4BLaAw=M5f5f5iDYBv4sZGGDzzgA@mail.gmail.com>
Message-ID: <CAL_JsqKkYkRQ4jDM9NR_eP4BLaAw=M5f5f5iDYBv4sZGGDzzgA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: Add header for the ingenic-drm driver bindings
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 3:08 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add macros that can be used with the ingenic,lcd-mode property in the
> devicetree node that corresponds to the ingenic-drm driver.

DRM is a Linuxism.

>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>
> Notes:
>     v2: No change
>
>     v3: s/_DRM//
>
>  include/dt-bindings/display/ingenic,drm.h | 28 ++++++++++++++++++++++++++++

DRM is a Linuxism...

>  1 file changed, 28 insertions(+)
>  create mode 100644 include/dt-bindings/display/ingenic,drm.h
>
> diff --git a/include/dt-bindings/display/ingenic,drm.h b/include/dt-bindings/display/ingenic,drm.h
> new file mode 100644
> index 000000000000..c749b8c346fc
> --- /dev/null
> +++ b/include/dt-bindings/display/ingenic,drm.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Ingenic JZ47xx KMS driver

Pretty sure this file is not a KMS driver.

> + *
> + *  Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
> + */
> +#ifndef __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__
> +#define __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__
> +
> +#define JZ_LCD_GENERIC_16BIT                   0
> +#define JZ_LCD_GENERIC_18BIT                   16

We have some generic properties for defining the bus width already.
Plus, in many cases this can be implied by the panel compatible. The
exceptions are cases such as when both the ctrlr and panel support
multiple modes.

> +
> +#define JZ_LCD_SPECIAL_TFT_1                   1
> +#define JZ_LCD_SPECIAL_TFT_2                   2
> +#define JZ_LCD_SPECIAL_TFT_3                   3
> +
> +#define JZ_LCD_NON_INTERLACED_TV_OUT           4
> +#define JZ_LCD_INTERLACED_TV_OUT               6

Wouldn't this be determined by the type of connector (composite vs.
s-video/component)

> +
> +#define JZ_LCD_SINGLE_COLOR_STN                        8
> +#define JZ_LCD_SINGLE_MONOCHROME_STN           9
> +#define JZ_LCD_DUAL_COLOR_STN                  10
> +#define JZ_LCD_DUAL_MONOCHROME_STN             11
> +
> +#define JZ_LCD_8BIT_SERIAL                     12
> +#define JZ_LCD_LCM                             13
> +
> +#endif /* __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__ */
> --
> 2.11.0
>
