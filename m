Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE644C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C094B21924
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 12:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfKIMM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 07:12:28 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:33603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfKIMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 07:12:27 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MNtGq-1iIUSX1xEG-00OFPX for <linux-kernel@vger.kernel.org>; Sat, 09 Nov
 2019 13:12:25 +0100
Received: by mail-qv1-f41.google.com with SMTP id g12so3253957qvy.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 04:12:25 -0800 (PST)
X-Gm-Message-State: APjAAAXPx/AuybLb2gJmXlxJ/fqKVkxfJrtTcD3WYi6+KfAhJd3MUqfs
        bW3ivuBq2o9f5uwgmajz9gp2fwQ2ZvgRElUrmxY=
X-Google-Smtp-Source: APXvYqwrFNWF6Dpd4vh4zt7FVLqZIoiTzNk6q+TuwKkce6U0Xebk5BkpHFMk7HkcxM1TafkZVAgFj3m4JatiBrbujwQ=
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr15109594qvu.4.1573301544256;
 Sat, 09 Nov 2019 04:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20191108213257.3097633-1-arnd@arndb.de> <20191108213257.3097633-16-arnd@arndb.de>
 <3a0cfce79620152facfe31b442a735db1dcda436.camel@pengutronix.de>
In-Reply-To: <3a0cfce79620152facfe31b442a735db1dcda436.camel@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 9 Nov 2019 13:12:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a13jSRqzZ-aDETdxk-BKgfXaAhdWiSn7aW+u3MFf06fWw@mail.gmail.com>
Message-ID: <CAK8P3a13jSRqzZ-aDETdxk-BKgfXaAhdWiSn7aW+u3MFf06fWw@mail.gmail.com>
Subject: Re: [PATCH 15/16] drm/etnaviv: use ktime_t for timeouts
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HOEFJ5qxD2Bh82m6q0PDxcve+Hvh/8jUZBKyoReDNwvBGBDrz99
 2EjiksTy3mDcEmJJXn4nICaERyP7uwuaZBIGT3KeIlisL7RT6AiMMCQV3hA+dhT5qILnzat
 43b3gHzhQ24q7mOi7rDQibrplGzhYvTUd4q5dCiMXit5xuy0YDS5m7KpiMcwX87i+kmxY/y
 Gz/LZfbfrpv9tDT/QCCgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GqzViut1/R0=:bP6MC3QMhn0kWCtzDfRKnB
 lQj2ox0RcEQ42PoMxPC4eytmwT2CFX87Kg9ZSWc3CZ6lqyBhU/zVgZY6O93+QCgQxMo4kQRbv
 hru3pMIiXUT0GS0SKcV/qwWEYWWuZR6SDdqVnhwUtjZ38s7KHOWKYX5lSS6eRK1BQUKq/JDeO
 41bGET69+QaL37vBjtLKtYU59bL8wCVI8OdM0THry9SnR524pQmxQa4gBcQEnCPo1ggjhFKux
 1p1uEjIggesxT69jmOJeFF4fXxEVB116DiwD5b4SXVz4tr2dk9ZldSkbpo9UKfFtVlO3ue6LD
 IkGpV9dVbueikjobbG0RyW1Drm46pDCmAf8ivw0rcJgYNKMU7m6J0tPzAOzwyNmY3Y5LW0pOM
 uTSEGDgReoXb9+X1n7Ki8+6Ow/HA0pJJf6Amwt0pH1Kg2bS+3+sKzIDauDTzngN6lL/EBHVaT
 1A7e+8qgjFC3cRYVsS2/UExgbzOdbQn4ozHmZ2Xa2ULGvpvyHDhQap4DtvEhH+GizehCbk/yZ
 +35NfwtLadOvKiihCjb3esLIG2Fh7IcYvZGTH2s+gyRsOmDI9HKMRpMmTZWQMwBarFNCag0Ao
 WwPPXu1hP32yul9qGMdrhPncWLClmSo/XNsGwN4xYPsyvusaTRoLbAEiktbFZ5lF1k9gFtjaf
 6fHG+Ei+PFLqLU70+DYYb+JW0lPa5H8HVwyU8DgIYJ8VmBZG1XjNuYFu8oBRvZOm9+gD4j5cc
 dFrH1LS6RB/usMv2UBDJGpFfBHV+360xaPM/dJGOG/Vab4QrGOhTSpICagasz5hPG2gqZyEK8
 P/t24X9u52KL4WrutwkwvcawOWZqIOeUfCS0VoFTu6O1B/FKeKe7sCM8mRl/XtnDEDvHEwZag
 prqLWKe1lRfClZ8A0ToA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 9, 2019 at 12:03 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Freitag, den 08.11.2019, 22:32 +0100 schrieb Arnd Bergmann:
> > struct timespec is being removed from the kernel because it often leads
> > to code that is not y2038-safe.
> >
> > In the etnaviv driver, monotonic timestamps are used, which do not suffer
> > from overflow, but using ktime_t still leads to better code overall.
> >
> > The conversion is straightforward for the most part, except for
> > etnaviv_timeout_to_jiffies(), which needs to handle arguments larger
> > than MAX_JIFFY_OFFSET on 32-bit architectures.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> > @@ -368,7 +366,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
> >               return -ENXIO;
> >
> >       if (args->flags & ETNA_WAIT_NONBLOCK)
> > -             timeout = NULL;
> > +             timeout = ktime_set(0, 0);
>
> This is a change in behavior, as far as I can see. After this change
> the called internal function is not able to differentiate between a
> NONBLOCK call and a blocking call with 0 timeout. The difference being
> that on a busy object the NONBLOCK call will return -EBUSY, while a
> blocking call will return -ETIMEDOUT.

Ah, good point. I created this patch a long time ago (cherry-picked it out
of an older branch I had done), so I don't remember how I concluded this
was a safe conversion, of if I missed that difference originally.

> But then CLOCK_MONOTONIC starts at 0 and should not never wrap, right?

Yes, that is correct.

> If that's the case then we should never encounter a genuine 0 timeout
> and this change would be okay.

That's quite likely, I'd say any program passing {0,0} as a timeout without
ETNA_WAIT_NONBLOCK is already broken, but if we leave it like that,
it would be best to describe the reasoning in the changelog.

Should I change the changelog, or change the patch to restore the
current behavior instead?

I guess I could fold the change below into my patch to make it transparent
to the application again.

      Arnd

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 1250c5e06329..162cedfb7f72 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -354,6 +354,7 @@ static int etnaviv_ioctl_wait_fence(struct
drm_device *dev, void *data,
        ktime_t timeout = ktime_set(args->timeout.tv_sec,
                                    args->timeout.tv_nsec);
        struct etnaviv_gpu *gpu;
+       int ret;

        if (args->flags & ~(ETNA_WAIT_NONBLOCK))
                return -EINVAL;
@@ -365,8 +366,12 @@ static int etnaviv_ioctl_wait_fence(struct
drm_device *dev, void *data,
        if (!gpu)
                return -ENXIO;

-       if (args->flags & ETNA_WAIT_NONBLOCK)
-               timeout = ktime_set(0, 0);
+       if (args->flags & ETNA_WAIT_NONBLOCK) {
+               ret = etnaviv_gpu_wait_fence_interruptible(gpu, args->fence,
+                                                          ktime_set(0, 0));
+
+               return (ret == -ETIMEDOUT) ? -EBUSY : ret;
+       }

        return etnaviv_gpu_wait_fence_interruptible(gpu, args->fence,
                                                    timeout);
@@ -421,10 +426,13 @@ static int etnaviv_ioctl_gem_wait(struct
drm_device *dev, void *data,
        if (!obj)
                return -ENOENT;

-       if (args->flags & ETNA_WAIT_NONBLOCK)
-               timeout = ktime_set(0, 0);
-
-       ret = etnaviv_gem_wait_bo(gpu, obj, timeout);
+       if (args->flags & ETNA_WAIT_NONBLOCK) {
+               ret = etnaviv_gem_wait_bo(gpu, obj, ktime_set(0, 0));
+               if (ret == -ETIMEDOUT)
+                       ret = -EBUSY;
+       } else {
+               ret = etnaviv_gem_wait_bo(gpu, obj, timeout);
+       }

        drm_gem_object_put_unlocked(obj);

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index e42b1c4d902c..fa6986c5a5fe 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1135,6 +1135,7 @@ int etnaviv_gpu_wait_fence_interruptible(struct
etnaviv_gpu *gpu,
        u32 id, ktime_t timeout)
 {
        struct dma_fence *fence;
+       unsigned long remaining;
        int ret;

        /*
@@ -1151,12 +1152,12 @@ int
etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
        if (!fence)
                return 0;

-       if (!timeout) {
-               /* No timeout was requested: just test for completion */
-               ret = dma_fence_is_signaled(fence) ? 0 : -EBUSY;
+       if (!timeout ||
+           (remaining = etnaviv_timeout_to_jiffies(timeout)) == 0) {
+               /* No timeout was requested, or timeout is already expired,
+                * just test for completion */
+               ret = dma_fence_is_signaled(fence) ? 0 : -ETIMEDOUT;
        } else {
-               unsigned long remaining = etnaviv_timeout_to_jiffies(timeout);
-
                ret = dma_fence_wait_timeout(fence, true, remaining);
                if (ret == 0)
                        ret = -ETIMEDOUT;
@@ -1185,7 +1186,7 @@ int etnaviv_gpu_wait_obj_inactive(struct etnaviv_gpu *gpu,
        long ret;

        if (!timeout)
-               return !is_active(etnaviv_obj) ? 0 : -EBUSY;
+               return !is_active(etnaviv_obj) ? 0 : -ETIMEDOUT;

        remaining = etnaviv_timeout_to_jiffies(timeout);
