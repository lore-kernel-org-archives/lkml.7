Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F131C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022FE206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZfE6hm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbfISQuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:50:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52555 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfISQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:50:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id x2so5441952wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LM0Yvzz4kDc9ho3QFMhZnWDRFXnLDKd2ypltfYClCA=;
        b=lZfE6hm9NGJZF9rboafGqjYFm2jya+goGEzsq56iSqVmtNG6NM0I644NaQXe0NQ/TI
         1BPTxrVeVUH+78BoSVtZau4sIetT3TUBmxX+eOsNepYEK0BTS7d+i8UM1TRPeSc++35S
         kYSOcqe9uPOGqywe5O9mNDvPprMazSR1ju9/XjusfrvB+V7irqmrOp88RyDaBnx+ljrT
         dYs4zdDQIGLVR2SRIJHfB+/x/9x+UlhtEir3LgRK3Fas2+a+WfFSVEs5GLBWpNjfHQGE
         W9iouVZQG5qYgMAnjrotyqNP1Qbm8eYpLaWcf4cnEPAs5qKPwnxAqCoBImCXwY9U0NOY
         tCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LM0Yvzz4kDc9ho3QFMhZnWDRFXnLDKd2ypltfYClCA=;
        b=Pqr35MWA28TNHdbuoDibVFgHBISlRmVreCY9XLfbuRx4K1+FkjQj3hgNQz163VCxO6
         +czgFg/NnG15YWmBBgprUPSwGwC7/G6wqv5Er9SbES6M4tLFHIkvKJXsKNPlrzwtcnpU
         4w11STBsqIq+siH7cOERsEQY7zvjl0LW5v55WEvlTIglb3+au3/qRs0CM9RAuBodTxcz
         iE01jS2+HDPYCqXhXJjkDDrjJ2yGYCkBPabJ1DNaiNXX6EJTXptFrNZgfyGJBuHqDcuM
         EimMKDKiMnEmp9mnhgWqagkzAH7cReM5+Q6s7FEohe6/MifTT4+Xsr/4e0TWiBtlujAr
         t0uA==
X-Gm-Message-State: APjAAAXUqRlB0Gs2g47y3Vhb5I5SpIWQ6G5+qoVoS0LiVAP+AwFFPfpt
        uUzLnZVXlsN+qEa8r9mc1wwxOSVsBHbbD9KmmX4=
X-Google-Smtp-Source: APXvYqxiQp41vQ3dSqfJVbSnzcBZafnBS4DTNbqx7SWWfGlzAFK+ND5rgYf9T8z46BGsmpbcCoXDBzpa+yKbWbaTrq0=
X-Received: by 2002:a05:600c:54a:: with SMTP id k10mr1014581wmc.127.1568911799607;
 Thu, 19 Sep 2019 09:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190918195418.2042610-1-arnd@arndb.de> <73842ec4-2767-c918-6ede-d05ff653255c@amd.com>
In-Reply-To: <73842ec4-2767-c918-6ede-d05ff653255c@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 19 Sep 2019 12:49:47 -0400
Message-ID: <CADnq5_OnhBx_cCHNNQcWkd1SosSfdF9jXYpoE-iYSuZbsVOicQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: hide an unused variable
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 9:45 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-09-18 3:53 p.m., Arnd Bergmann wrote:
> > Without CONFIG_DEBUG_FS, we get a warning for an unused
> > variable:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6020:33: error: unused variable 'source' [-Werror,-Wunused-variable]
> >
> > Hide the variable in an #ifdef like its only users.
> >
> > Fixes: 14b2584636c6 ("drm/amd/display: add functionality to grab DPRX CRC entries.")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index e1b09bb432bd..74252f57bafb 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6017,7 +6017,9 @@ static void amdgpu_dm_enable_crtc_interrupts(struct drm_device *dev,
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> >       int i;
> > +#ifdef CONFIG_DEBUG_FS
> >       enum amdgpu_dm_pipe_crc_source source;
> > +#endif
> >
> >       for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> >                                     new_crtc_state, i) {
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
