Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E52EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399E4206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCteiibq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbfDXQvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:51:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40684 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbfDXQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:51:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so6055362wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oh99ck7JeivqaoB89lkbjLrVp+cVPSIaWSDTZ/0s21U=;
        b=xCteiibq/l+yr7Fh3oUqUgVNpuvkJha8d6VmlD2IiblqNavZFvvhCnNT1S77GN2GX3
         CpsUDpglK63mtd4aaAaIoh/pnvSPWQ2POPdFB2h85Vnf6jDK+79yHf4UueNWkkwzeBve
         yRME2seKr4xy2rXl7ON9Yh3Qeo89Ub5LFEkanG3HBMXcJ8rXk+ySaSN87YiFSk0702Mj
         292X7xANWOewZp4HZsNemYuAkJGS45pwo4z120PVcQoIM1HlKR7qNjUN+aKnuARsLYXa
         MEgl43SbpZJkSi0l6l6BAT7u07XxPh+OTrW9+vXwFiE7v3ZH8h8JEB1q7x/I6u0pS4/i
         8SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oh99ck7JeivqaoB89lkbjLrVp+cVPSIaWSDTZ/0s21U=;
        b=AAgvB50Pf2qBRydXC6cyoyjJzekyxV6DzhxOZY5CIZCc5Nq5ARQ+qG7acewxTLdxzt
         YIF9tHa3IeUID/BPtSiu4Eik9Et1RG39TMb7JbsANTw+5gdGmnQK0atuVAOkkNbJh7vC
         apeBCjZ+yKL9AEMTE8xMYoZF1jExZTJaCTTtKxgQe30/T82UgyGnxORlkZD3pa7aTXN/
         n4SgQDF/+CY24T9v0eCDeCwteqeH5QwPzwj9H8zaRBslYgx0blNrfFNPMOQutCHKhHVG
         +CZsJV0tuxI/cr6UrSql6jnrMGSFbIIgXILE5q+IausnsiueNUqePXWUQ2XLUKji5igx
         agyA==
X-Gm-Message-State: APjAAAU2HI+5qQcTc4QVtogKmuvlrGFB/ZfWzQgq/0znTCzRTjaVC3pu
        SqEVowMrcRmxz0JcVCWivhrTUWIquarDL+pZWVLx4HlW
X-Google-Smtp-Source: APXvYqyOmVWYjuj13WzXXoXWHYSDdQVhlG8JVBm8jGT2ktXhCz8xb1V+fclvTtQQbMGcXO6UgsrXY7XcSSzgT9Ov5dM=
X-Received: by 2002:a1c:9691:: with SMTP id y139mr31415wmd.64.1556124711686;
 Wed, 24 Apr 2019 09:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-11-git-send-email-john.stultz@linaro.org> <20190424164645.GC20110@ravnborg.org>
In-Reply-To: <20190424164645.GC20110@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Apr 2019 09:51:40 -0700
Message-ID: <CALAqxLVzExB-XCXDgPZO0Aa=8Mfk-1J22_rbvmreqrxsKs5wGg@mail.gmail.com>
Subject: Re: [PATCH 10/25] drm: kirin: Move workqueue to ade_hw_ctx structure
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

On Wed, Apr 24, 2019 at 9:46 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi John.
>
> On Tue, Apr 23, 2019 at 04:20:41PM -0700, John Stultz wrote:
> > The workqueue used to reset the display when we hit an LDI
> > underflow error is ADE specific, so since this patch series
> > works to make the kirin_crtc structure more generic, move the
> > workqueue to the ade_hw_ctx structure instead.
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
> >  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > index 94dcad0..f54cf99 100644
> > --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > @@ -52,6 +52,7 @@ struct ade_hw_ctx {
> >       struct clk *media_noc_clk;
> >       struct clk *ade_pix_clk;
> >       struct reset_control *reset;
> > +     struct work_struct drm_device_wq;
>
> The comment probarly belongs to 01/25...
> The name drm_device_wq is not at all descriptive.
> Consider something like: display_reset_wq

I agree, that sounds like a nice improvement! I'll tweak it in patch 1/25.

thanks for the review and feedback!
-john
