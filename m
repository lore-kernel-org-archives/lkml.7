Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB06C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1502067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhEf2Ypd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgAIQeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:34:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46183 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgAIQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:34:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id g1so6307010qtr.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1y196/fnbEpnC9sIv+FxPS9US7j6TCqpE/hgHgeZN80=;
        b=EhEf2Ypd4dMBZL1Z4eZQUoeoV1U/sfXOUNMlTk4oE2ubSg61VXz6zmuEgcWWwsmB+J
         4J6HAPRoVsWWYJOFUxJk9ytcjgQULw+3vyUeU6CqlrluWB8XDJ6jM21AvFyzDL3tjNXH
         KfJ/hs7ieC+9nuZBKUxFfBBywnXjZksJ/xH6+nNA3q2db4/Qt4xj723DkuY5Bg9mq7PK
         yLOw9G7pSPhxDmIaBlfbb8l+eayJyYWZaWFYWj14m7ObLCal1BC92/pOB7Ygm+4xMITK
         W+o35n+tcdTqpW555uSrmszyURHyA/vInaYt/U4aw2272ihdC0Oz8XbirSqxxuXOwHnQ
         K6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1y196/fnbEpnC9sIv+FxPS9US7j6TCqpE/hgHgeZN80=;
        b=eEfroBeZ6fhBkd9lZvA2IE4Eo+8tSXcoyOzPMdOiwVerXrj8ZHcRhYGD0VKcKYU0Dk
         t03o5kaUKhg0NaQ9vx2rGQD1qJpaPy/olNdJMHgWbLrrN4blh3nTur1gRGPnCSDUxZSy
         EE+mwAevYYocp5pxG1rDNLubLOW3CXPA8krhTSzvPzbydlGcJs91lprsTd0E+An951fQ
         qZAA0pWAZb7Y/tWRcP90iVgyotuEAxfsr3sAtsuKs+Wv77Ovugz/WhqFq41iA909goRx
         iYks0PlD7PXUC3WQzw8TOlRdUU+T+aunS5FFs6w4N40ZqDI2yNjMEWVgH6CSZxMYntp7
         XpKQ==
X-Gm-Message-State: APjAAAX2dewQGJGtY8xdDOXZZDq20JD0My2r4F/khC5uybJEx0v2NcWN
        B5ZNnYqTPYVM74cmkWPf9yY7C8cTbdHXwdloayXd4lx8
X-Google-Smtp-Source: APXvYqxidMsdaPP4lby56x2DJB/wrUu01RgG4Ruw+w38dqIgvpt/xG0nzmnXjBgDvkhYqRbjZLO1BxdtoV/O6qzpccA=
X-Received: by 2002:ac8:33ab:: with SMTP id c40mr8822381qtb.250.1578587644018;
 Thu, 09 Jan 2020 08:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20191119105753.32363-1-benjamin.gaignard@st.com>
 <CA+M3ks7C+_B+4Jxy+55bFoWct7j=WseoPKxxh7KLOZ0LhEUL7Q@mail.gmail.com> <17fdbb6a-493d-d47c-9acf-3c79032359b0@st.com>
In-Reply-To: <17fdbb6a-493d-d47c-9acf-3c79032359b0@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 9 Jan 2020 17:33:53 +0100
Message-ID: <CA+M3ks5d9Vjw6kF1YsJVnx1HDOpvNiuMQUGgANfjd=XDohpjfA@mail.gmail.com>
Subject: Re: [PATCH] drm/fb-cma-helpers: Fix include issue
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 9 janv. 2020 =C3=A0 17:29, Benjamin GAIGNARD
<benjamin.gaignard@st.com> a =C3=A9crit :
>
>
> On 12/3/19 5:49 PM, Benjamin Gaignard wrote:
> > Le mer. 20 nov. 2019 =C3=A0 00:28, Benjamin Gaignard
> > <benjamin.gaignard@st.com> a =C3=A9crit :
> >> Exported functions prototypes are missing in drm_fb_cma_helper.c
> >> Include drm_fb_cma_helper to fix that issue.
> >>
> > Gentle ping to reviewers.
> > Thanks,
> > Benjamin
>
> I know that removing warnings is not a sexy task, but reviewers are welco=
me.

Applied on drm-misc-next, with Thomas ack even if dri patchwork doesn't sho=
w it.

Thanks
Benjamin

>
> Thanks,
>
> Benjamin
>
> >
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>   drivers/gpu/drm/drm_fb_cma_helper.c | 1 +
> >>   include/drm/drm_fb_cma_helper.h     | 2 ++
> >>   2 files changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm=
_fb_cma_helper.c
> >> index c0b0f603af63..9801c0333eca 100644
> >> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> >> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> >> @@ -9,6 +9,7 @@
> >>    *  Copyright (C) 2012 Red Hat
> >>    */
> >>
> >> +#include <drm/drm_fb_cma_helper.h>
> >>   #include <drm/drm_fourcc.h>
> >>   #include <drm/drm_framebuffer.h>
> >>   #include <drm/drm_gem_cma_helper.h>
> >> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_=
helper.h
> >> index 4becb09975a4..795aea1d0a25 100644
> >> --- a/include/drm/drm_fb_cma_helper.h
> >> +++ b/include/drm/drm_fb_cma_helper.h
> >> @@ -2,6 +2,8 @@
> >>   #ifndef __DRM_FB_CMA_HELPER_H__
> >>   #define __DRM_FB_CMA_HELPER_H__
> >>
> >> +#include <linux/types.h>
> >> +
> >>   struct drm_framebuffer;
> >>   struct drm_plane_state;
> >>
> >> --
> >> 2.15.0
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
