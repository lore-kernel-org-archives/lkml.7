Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C2DC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF9221582
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH/djuKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAEWIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:08:13 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33245 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:08:13 -0500
Received: by mail-ua1-f66.google.com with SMTP id a12so16481113uan.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gN32nj0fCJV1JTpdvkxbljfmBSVYN/OI2ByyfTw0WlA=;
        b=DH/djuKMsWL5Ji9Mluc7+DUJAPlPGwfTWrEJA06R1Gl4RMN200Cvg4hxzeiLl27fJ6
         7+V6vdsKgEeisXdUU4plTEPrbTYyy5/KrVeSfrjXWra9+2Hm8T4rxOJHrVRpFFBC/iG5
         uw6b6pflkhHdnMX/7hPUT9c/YEY0mm4JSf1w/vZ4vTT9tT+i63PeQf6CEXMtEp582ybR
         VbVZEVzvCvmFSjI7XzsFa0rSFL04ZbjmefKfEjGDaGNA8ZRxnKRofPlIs4M+Pi2OMSjC
         n/VAaw/3DOvNeKbDPHGZ8IASRk/F3s4Hs/YRKWmZ6dtc6NkYxpZsphMuvupJHSQ5R0r5
         C9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gN32nj0fCJV1JTpdvkxbljfmBSVYN/OI2ByyfTw0WlA=;
        b=f9D/fC6aa4nfaaytww5IoUbyTu49bHio++3q+TIsIom4AeoSo0ztAMUtcX/I2ljgls
         KP8wSeo4GInf5cjp+mjAo4oiBqe5nG4uiRpaae+f8qtRErqzBHyDM4luhTP7ooTUm44N
         VXOp8GUw4WX0pHFOtsOsV23yuz1HXS1DVxJshQgScC47/RstUkwU5spocJ+0YmRZHbzV
         yR836vbtjIBpx8/QwU/m/ndiDDKmbv/Sw7YD5d4cdtOWRZGsgkordEgBaa/7vPithLwK
         cfq5Cksh7wOaFqPebBwNZHMdxQBo4ACfRt6D6qVOMz0yPPua0SU5d6HIoiP6mLOORdxS
         xHpA==
X-Gm-Message-State: APjAAAWtNdwGyLrnX3ryX2B843NhNudFc1oEz+XMZNDal+ilwY156+OE
        GoolwiZIykgHBLnVKgPoNdO5h2hqwb8EcEeQ0LE=
X-Google-Smtp-Source: APXvYqwVhdsTLtyEOlLYzgTMx5J4xh1D/3v3AigHUqzVPMqquC3uNYmIjP2M9M2z3U81JKr4ewrVpFI1uOHTkV7btNM=
X-Received: by 2002:ab0:72d0:: with SMTP id g16mr55270503uap.11.1578262092346;
 Sun, 05 Jan 2020 14:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20191231205734.1452-1-wambui.karugax@gmail.com> <20200101185147.GB3856@dvetter-linux.ger.corp.intel.com>
In-Reply-To: <20200101185147.GB3856@dvetter-linux.ger.corp.intel.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 6 Jan 2020 08:08:01 +1000
Message-ID: <CACAvsv5SF18v7t8kbo0LPQi3L8U3xGGf70_UEfOnKdHu89yo9A@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: use NULL for pointer assignment.
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 at 04:51, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Dec 31, 2019 at 11:57:34PM +0300, Wambui Karuga wrote:
> > Replace the use of 0 in the pointer assignment with NULL to address the
> > following sparse warning:
> > drivers/gpu/drm/nouveau/nouveau_hwmon.c:744:29: warning: Using plain integer as NULL pointer
> >
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> I'll check with Ben next week or so whether he wants to pick these up or
> whether I should stuff them into drm-misc-next.
I'll grab them.

Ben.

> -Daniel
>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_hwmon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > index d445c6f3fece..1c3104d20571 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > @@ -741,7 +741,7 @@ nouveau_hwmon_init(struct drm_device *dev)
> >                       special_groups[i++] = &pwm_fan_sensor_group;
> >       }
> >
> > -     special_groups[i] = 0;
> > +     special_groups[i] = NULL;
> >       hwmon_dev = hwmon_device_register_with_info(dev->dev, "nouveau", dev,
> >                                                       &nouveau_chip_info,
> >                                                       special_groups);
> > --
> > 2.17.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
