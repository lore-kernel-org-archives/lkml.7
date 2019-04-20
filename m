Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B3DC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276C32087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="WwxZc8O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfDTMXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:23:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37068 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfDTMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:23:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so3804537pgc.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lZrcXnZdn7xjrXsqmqiror62OxRMVPaG0x3r/D/8YBQ=;
        b=WwxZc8O19Qlub3zgWlpi5OUaGAH38MjbtmfB6pV1Bnvn2bopmJ+gO44s0krCgU1BS+
         /xZHFCfsl1+Ij4/0qjBZgK593iIOnYegGprcFFka5b/G/mJKnzonSHgDoMNt1J2rXmcx
         2lTT8fu0DPy4zc18zbuawNtfNEecgRpZQTWXl9Gah0/CQ1Tq3gjfZmRfBDvmranTV+cf
         MS4PLIGDVM2daVOiBy77m+B4c5v9yPyySMn1a1HAlCMbGaDdcncjxA6fdQEqwnY5C5u2
         kXbw/zwG+VEU17iLriowDr5gcb+ZCReSJ09FttusDgF0gqga5gsvAN5HZWpdvbbEIUhz
         73Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lZrcXnZdn7xjrXsqmqiror62OxRMVPaG0x3r/D/8YBQ=;
        b=BlzCUeNXZY6ZdJV9pPKhuFhRTFTHQzDlj5rJ31jyGsWNIQ8dI8Lo29spIpSUL44xbL
         poBDwvtgJwv7ArK+EedKyaahKF/e1FKeQ5AA0DnikwmboGxSSxbHAt9qDDyyZSnTddmN
         JJ5bqgnWcNGu2DwRouM81y3ta2aD6enjHkd87viqC+WUpJUKdH8pG27BjaM5kvebYlbA
         xerkbJG1+3/pmZFjKcaAUhJQxd2rQYU7g3vGJtWMO0CvjqDVsCKkOvV514aYSzfNof5O
         kSn0PjQhL3Tg6hd0Pz8pGcCJDfAcnmSvrfa3SQeKauhZvqBc/oIg+x2jPJzTpTyN7Ngt
         03zg==
X-Gm-Message-State: APjAAAU528MXy1bqXdw4S4d7KILuwRRp6wNflX6M/R2flTkeHmTr/kAx
        4bHmjZ9vdVYEjOXQ1sfltWJfce3X8x2Tp7Kk3ivfjg==
X-Google-Smtp-Source: APXvYqxZurU01XjM49DVH6vAb1H86e2zcwQh60AcdJrwpdWhXXMd7YSkgR8LgTFEMNjx3u++0DydVdVaiPPW7zlHm/4=
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr9325689pfv.10.1555763004733;
 Sat, 20 Apr 2019 05:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190414200824.28348-1-paul@crapouillou.net> <20190414200824.28348-2-paul@crapouillou.net>
 <CAL_JsqKkYkRQ4jDM9NR_eP4BLaAw=M5f5f5iDYBv4sZGGDzzgA@mail.gmail.com>
In-Reply-To: <CAL_JsqKkYkRQ4jDM9NR_eP4BLaAw=M5f5f5iDYBv4sZGGDzzgA@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 20 Apr 2019 09:23:13 -0300
Message-ID: <CAAEAJfBZPvoUd6dT2C6QDO4wsPzpwMpcT-XFwo+Xr4NO+4+jtA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: Add header for the ingenic-drm driver bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 at 10:48, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Sun, Apr 14, 2019 at 3:08 PM Paul Cercueil <paul@crapouillou.net> wrot=
e:
> >
> > Add macros that can be used with the ingenic,lcd-mode property in the
> > devicetree node that corresponds to the ingenic-drm driver.
>
> DRM is a Linuxism.
>
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Tested-by: Artur Rojek <contact@artur-rojek.eu>
> > ---
> >
> > Notes:
> >     v2: No change
> >
> >     v3: s/_DRM//
> >
> >  include/dt-bindings/display/ingenic,drm.h | 28 +++++++++++++++++++++++=
+++++
>
> DRM is a Linuxism...
>
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 include/dt-bindings/display/ingenic,drm.h
> >
> > diff --git a/include/dt-bindings/display/ingenic,drm.h b/include/dt-bin=
dings/display/ingenic,drm.h
> > new file mode 100644
> > index 000000000000..c749b8c346fc
> > --- /dev/null
> > +++ b/include/dt-bindings/display/ingenic,drm.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + *  Ingenic JZ47xx KMS driver
>
> Pretty sure this file is not a KMS driver.
>
> > + *
> > + *  Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
> > + */
> > +#ifndef __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__
> > +#define __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__
> > +
> > +#define JZ_LCD_GENERIC_16BIT                   0
> > +#define JZ_LCD_GENERIC_18BIT                   16
>
> We have some generic properties for defining the bus width already.
> Plus, in many cases this can be implied by the panel compatible. The
> exceptions are cases such as when both the ctrlr and panel support
> multiple modes.
>

In the same direction as Rob's comment, I'd like to see these decoupled
from the register value.

Ideally, we'd like to reuse this driver and its bindings for JZ4780,
and these values are already different.

Thanks!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
