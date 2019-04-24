Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205BE206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIHOFrVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbfDXQuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:50:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46260 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbfDXQuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:50:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so26069931wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gd5ss9wUd+sHecdwwrDARY92RM22a/6uha5UkmKmo9s=;
        b=KIHOFrVEzmZxLxuk2z2O/mEoB6cfpcsGR1iF9qYXi5qYO+ul/rKNPLV/4zZiEllirW
         66E3uT96cCOHTpBla4xFr4BsPb/lBNbNS/yi46uV4tFJMF2BErzLK+r1b6XeIexb6ZfN
         bfZw3wo+CaNDFdrFTuc6Y931DFf5P9HGzTA/qpqp5yDpbpvJtWMyCMJCASQ14l8eLsQW
         aMlrzGtNSw+mQ+vgFzbRCyj4q2LDf0qZiAEpRHrxYwVF7znh5NDVdJX20cQNu59V8Ly2
         7qbx/DtOz8pN8EIC9Mf/ouK+b1JVZNTcyLhOz3OMOpWtOj+suuCC2SAIGCq9+ewSe8P4
         RFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd5ss9wUd+sHecdwwrDARY92RM22a/6uha5UkmKmo9s=;
        b=XbHnUxyD5a8SvAdnASBFQscN6IctqxR2u9rmX2acfr+s8/KIj+zEekIsnK2D1czTvy
         DPxegHBys2aNOHgm/3ioH/aAYyW32WrLH9U1YKlBxDLxWJUWN3rBu8njNH2jEn37UJJM
         BQu5XTcnuLvCYE1NyAZleZXhPtslOFtZdTGTvc730vFxlSRRmfrJbCXZOOIM4wK7faxk
         2ZXsUqmuHAtvI07wW/TfqFx06O8oiZ3rbVYK3DiKHWfiAhEl26VK+VGqpl64LAxqd0Sa
         Mfmh/Bfe94liDKMrOpVV8AnOftkbw12TcrtcTosAXG00u1wKgAQ3HlOfK9FFEOTV+dtj
         8hyw==
X-Gm-Message-State: APjAAAUWtjzQEqwMPIceYcbkR5o68mvK2G7HXegSEgeUNL0Ef0+gBsr2
        xXv7JWf0td2q/8nUKFPSEhdQrT4R5/EovD4jxjz40w==
X-Google-Smtp-Source: APXvYqwUR/KxNHWf1l1ucsn/smycF/X7bSTMDTHzRCZ4d/Ne9tjd4x3ovMdfKIne6O+13Eo29oP9dP20aWWApk5ZTI0=
X-Received: by 2002:adf:ba81:: with SMTP id p1mr21319802wrg.192.1556124601648;
 Wed, 24 Apr 2019 09:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-3-git-send-email-john.stultz@linaro.org> <20190424163908.GB20110@ravnborg.org>
In-Reply-To: <20190424163908.GB20110@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Apr 2019 09:49:49 -0700
Message-ID: <CALAqxLXeU7skJiy2J4ZYOFtym6pDUuzY3QT+e3F1D8jE4pYC0w@mail.gmail.com>
Subject: Re: [PATCH 02/25] drm: kirin: Remove HISI_KIRIN_DW_DSI config option
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:39 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi John.
>
> On Tue, Apr 23, 2019 at 04:20:33PM -0700, John Stultz wrote:
> > The CONFIG_HISI_KIRIN_DW_DSI option is only used w/ kirin
> > driver, so cut out the middleman and condense the config
> > logic down.
> >
> > Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> > Cc: Rongrong Zou <zourongrong@gmail.com>
> > Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> > Cc: Chen Feng <puck.chen@hisilicon.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  drivers/gpu/drm/hisilicon/kirin/Kconfig  | 10 +---------
> >  drivers/gpu/drm/hisilicon/kirin/Makefile |  4 ++--
> >  2 files changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> > index 499f644..6ef7906 100644
> > --- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
> > +++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> > @@ -4,16 +4,8 @@ config DRM_HISI_KIRIN
> >       select DRM_KMS_HELPER
> >       select DRM_GEM_CMA_HELPER
> >       select DRM_KMS_CMA_HELPER
> > -     select HISI_KIRIN_DW_DSI
> > +     select DRM_MIPI_DSI
> >       help
> >         Choose this option if you have a hisilicon Kirin chipsets(hi6220).
> >         If M is selected the module will be called kirin-drm.
> >
> > -config HISI_KIRIN_DW_DSI
> > -     tristate "HiSilicon Kirin specific extensions for Synopsys DW MIPI DSI"
> > -     depends on DRM_HISI_KIRIN
> > -     select DRM_MIPI_DSI
> > -     help
> > -      This selects support for HiSilicon Kirin SoC specific extensions for
> > -      the Synopsys DesignWare DSI driver. If you want to enable MIPI DSI on
> > -      hi6220 based SoC, you should selet this option.
>
> Nice simplification. We are now down to two very small Kconfig files.
> Consider to merge them into one Kconfig file in the top-level dir.
>

Part of this cleanup is so that we can add another device option in a
later commit (though not in this series), so unless folks are
generally wanting to consolidate Kconfigs into the top level, it may
be premature to do so now only to later undo it when there are more
kirin specific options. I'm fine with whichever, I just want to make
sure that's clear.

thanks
-john
