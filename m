Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F8C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5131A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfOwrr8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfLLXj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:39:29 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34220 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfLLXj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:39:28 -0500
Received: by mail-vk1-f196.google.com with SMTP id w67so260664vkf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc2RGJ3UClAMsvSW+fKzHU87UiE/9k4bA3dodgjrviE=;
        b=DfOwrr8xJ+MjAGBD5DPRK3CtrM98mBYbvY82OB7HXgLa1lSvy6Oh7roTWvGfy1vYmQ
         fkK8JvcONlBAl2dde0NnSED13jqqTXZ5ZuN8OUUdY4yirTMTd5eJfgCr0ry8TQ36uANH
         xdfhYjply1N4IvUEZb0K59zMzDOfBiJNVnbB2r0AW6CyGDbUwwgflvz5Zav1jhZHa2Hc
         w0YBOCUEr+bBToZQVHj23JGp9HlqIIDmA6NqcJtZxtvD0hBOtbXhVDnIgAt8g0/f/u6n
         HDWRnEdGP2SDVIYDxscK1eX/jRB4GSAjMlsJGzZvlc9NiCMDtNGeOxgcp0JjR8txI43q
         ZXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc2RGJ3UClAMsvSW+fKzHU87UiE/9k4bA3dodgjrviE=;
        b=b7BpbJgf0hFUHs1T3Oa9wiE5ap4fCjWSciOHr+2Y9swB4UiwgPliUm0XmXPB70yS7a
         U0ExYn/gQSSG5wOU5JVspFdeaLEfRmlWsOQAYDGN6td51KC1UtGIUSxK2s4NkBH3ap7x
         icObLVHcVBHb55x+FBlH/6yT1KG5jC0rDqevwWV/Dtr7Rh01UiKv/91h2IYdIlL0cL9n
         FrIpHwlpZWFBld3jy/xYUxCe7uod5izexA0A+GXCi+CxxdZFVlqerHN/VDY7AOSBeEPJ
         gbFa3S2bXyXuRxPYRdncE1l22QrDQ/NfYf6rl2VviQRc5UbKlK8FHwgQlT2F2FXumHVr
         5exQ==
X-Gm-Message-State: APjAAAUQtOZ21nv87Vd453jUMrSRMfDsnzzt0E1IFIFewkz7EeHxeAf4
        PRVC6Wc+4gQHJxX3sNo9NUk8siHhj3+jl4/LALrI74Rl
X-Google-Smtp-Source: APXvYqxiVybcStEMqYeEIGEnJ+HtMBPGQkv8Kki+YBh0DS0X1ru0NT7WrnTsK5Rvcxhr0Gt1sTo4rGQEHf7vCJ/BUvQ=
X-Received: by 2002:a05:6122:2b6:: with SMTP id 22mr11219224vkq.49.1576193967753;
 Thu, 12 Dec 2019 15:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20191206075321.18239-1-hslester96@gmail.com> <8736dq2c66.fsf@intel.com>
In-Reply-To: <8736dq2c66.fsf@intel.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Fri, 13 Dec 2019 09:39:16 +1000
Message-ID: <CACAvsv4He=bKpa2VxJr-cYUoy66sw8mGgFcnpMM0qDb1qXYSrg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: add missed nv50_outp_release in nv50_msto_disable
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 at 18:14, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Fri, 06 Dec 2019, Chuhong Yuan <hslester96@gmail.com> wrote:
> > nv50_msto_disable() does not call nv50_outp_release() to match
> > nv50_outp_acquire() like other disable().
> > Add the missed call to fix it.
This is intentional, and it's called at a later time
(nv50_mstm_prepare()) to avoid confusing HW.

Ben.

>
> The subject prefix "drm/dp_mst" implies drm core change, but this is
> about nouveau. Please fix.
>
> BR,
> Jani.
>
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > index 549486f1d937..84e1417355cc 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -862,8 +862,10 @@ nv50_msto_disable(struct drm_encoder *encoder)
> >
> >       mstm->outp->update(mstm->outp, msto->head->base.index, NULL, 0, 0);
> >       mstm->modified = true;
> > -     if (!--mstm->links)
> > +     if (!--mstm->links) {
> >               mstm->disabled = true;
> > +             nv50_outp_release(mstm->outp);
> > +     }
> >       msto->disabled = true;
> >  }
>
> --
> Jani Nikula, Intel Open Source Graphics Center
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
