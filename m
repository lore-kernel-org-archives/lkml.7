Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C6020652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqyhgSpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfDXTZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:25:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42982 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDXTZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:25:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so26708765wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2LfF+54lAYEDIYuh1kcXf6iTBYgfOjqWNYwzXwMRmQ=;
        b=hqyhgSpiAgUsPyz1ZyX9vXULHY8xwUjMTz5sjXsLXWiTFjQZj8y92RAVojJzWtXWUE
         gYUSJA+0XOeJ39h+OCP2QmKRDzn1BUvETUor3WX47WOOMExHlO6l/sXIGQHkGXvN8dSE
         Vtw8/nN465q10/sQBDyTosM6c8EMMGwe0hWWrg660R1B7+vxcREKYIkC2wBUhY1yz/XI
         Uqcbgc98QyHz/EEb+SwbqXxw3MPF2nc6OUU7nZueGYiOGcxnfTjB31GFfAcXZozLqIDZ
         fZN1048AYtRiX2/uFlqrBs5kSxBGIUDslTeHxqNIuHXqtJ7jj7chPYGydgR/X5AbRTIe
         mSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2LfF+54lAYEDIYuh1kcXf6iTBYgfOjqWNYwzXwMRmQ=;
        b=gbA7qmW3uPlFVruTOCGsie0GoajGKCS56nb0Sz1NEVRZqEbdx/j5ZKTyuRW56//6Y8
         9uN8YJu7IYu0VXqpijRzcVPf5PjHYS56l7GEAwgzGHJjnnMk/ZCBz0O1qRuWPuRzcfN8
         mhGpf2kfTAhmAXSSx+C9k9Y+u7A3FQ4/rqHDsCqIEQbsG7SbmetYOl8S6OcK6iqlVbs1
         gGt3PyClk7Z874dDs1UjQiCFgiqhfOGS1MU0m48AQpx+2tvog9YfffVK96OJwCscUglD
         x5B8g3rxpGTJgc5dH7b/kDVlDfun03zktqOaaEuckpfapre8VwDUrFgb3M8fWtTHIPM7
         zbdw==
X-Gm-Message-State: APjAAAW0q77E+jT0f6T/DfuaVlVgk7TKxmR65dKDaf+OhdI0t5caWSaI
        gabZFK7furnB0Oq20YOsRqmlGEDc/si/Uhr4KKYTiQ==
X-Google-Smtp-Source: APXvYqznbn3Slfia7rEN0K5uBFs1V9XeBBnlQpsghjBILJBDXc3J38DuhwUiDRoHSzh8t7jrC+AGF8yT6O1FQ897eec=
X-Received: by 2002:adf:cd90:: with SMTP id q16mr1316301wrj.75.1556133947827;
 Wed, 24 Apr 2019 12:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-12-git-send-email-john.stultz@linaro.org> <20190424165049.GD20110@ravnborg.org>
In-Reply-To: <20190424165049.GD20110@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Apr 2019 12:25:36 -0700
Message-ID: <CALAqxLWoXT5wQeiMYV8PQAHgvf7inp11WfKgGktz-UHL0Yt0hA@mail.gmail.com>
Subject: Re: [PATCH 11/25] drm: kirin: Move kirin_crtc, kirin_plane,
 kirin_format to kirin_drm_drv.h
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Xu YiPing <xuyiping@hisilicon.com>,
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

On Wed, Apr 24, 2019 at 9:50 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Apr 23, 2019 at 04:20:42PM -0700, John Stultz wrote:
>
> This struct:
> >  /* ade-format info: */
> > -struct ade_format {
> > -     u32 pixel_format;
> > -     enum ade_fb_format ade_format;
> > -};
> > -
> > -static const struct ade_format ade_formats[] = {
> > +static const struct kirin_format ade_formats[] = {
> >       /* 16bpp RGB: */
> >       { DRM_FORMAT_RGB565, ADE_RGB_565 },
> >       { DRM_FORMAT_BGR565, ADE_BGR_565 },
...
> > +
> > +/* kirin-format translate table */
> > +struct kirin_format {
> > +     u32 pixel_format;
> > +     u32 hw_format;
> > +};
> Is renamed.
> The member hw_format is renamed and no longer uses an enum.
> (The sole user of this enum type).

So the enum values are still used, but yes, the type here shifts.

> These changes are not included in the changelog - should they be part of
> this patch?
> And also the change from enum to u32 is not understood.

So the intent is to be able to share the kirin_format structure
between both the kirin620 support and kirin960, where as the
ade_fb_format enum values are tied to the kirin620, the kirin960 has
dpe_fb_formats enum which has different values. So the u32 hw_format
value is just the generic storage for enumerated format types of
either device. So its just a map from generic pixel_format definition
-> hardware specific value for that format.

I'll try to make that change more clear in the commit message, but if
you have ideas for a simpler or cleaner way to do the same, let me
know.

thanks
-john
