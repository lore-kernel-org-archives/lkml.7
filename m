Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3086BC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35F620856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKKJzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:55:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54067 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfKKJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:55:47 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iU6QA-0005W7-NO; Mon, 11 Nov 2019 10:55:42 +0100
Message-ID: <7379bfe6c530132caab4cd930cd94f0e28c935ff.camel@pengutronix.de>
Subject: Re: [PATCH 15/16] drm/etnaviv: use ktime_t for timeouts
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Date:   Mon, 11 Nov 2019 10:55:40 +0100
In-Reply-To: <CAK8P3a13jSRqzZ-aDETdxk-BKgfXaAhdWiSn7aW+u3MFf06fWw@mail.gmail.com>
References: <20191108213257.3097633-1-arnd@arndb.de>
         <20191108213257.3097633-16-arnd@arndb.de>
         <3a0cfce79620152facfe31b442a735db1dcda436.camel@pengutronix.de>
         <CAK8P3a13jSRqzZ-aDETdxk-BKgfXaAhdWiSn7aW+u3MFf06fWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sa, 2019-11-09 at 13:12 +0100, Arnd Bergmann wrote:
> On Sat, Nov 9, 2019 at 12:03 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Freitag, den 08.11.2019, 22:32 +0100 schrieb Arnd Bergmann:
> > > struct timespec is being removed from the kernel because it often leads
> > > to code that is not y2038-safe.
> > > 
> > > In the etnaviv driver, monotonic timestamps are used, which do not suffer
> > > from overflow, but using ktime_t still leads to better code overall.
> > > 
> > > The conversion is straightforward for the most part, except for
> > > etnaviv_timeout_to_jiffies(), which needs to handle arguments larger
> > > than MAX_JIFFY_OFFSET on 32-bit architectures.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > @@ -368,7 +366,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
> > >               return -ENXIO;
> > > 
> > >       if (args->flags & ETNA_WAIT_NONBLOCK)
> > > -             timeout = NULL;
> > > +             timeout = ktime_set(0, 0);
> > 
> > This is a change in behavior, as far as I can see. After this change
> > the called internal function is not able to differentiate between a
> > NONBLOCK call and a blocking call with 0 timeout. The difference being
> > that on a busy object the NONBLOCK call will return -EBUSY, while a
> > blocking call will return -ETIMEDOUT.
> 
> Ah, good point. I created this patch a long time ago (cherry-picked it out
> of an older branch I had done), so I don't remember how I concluded this
> was a safe conversion, of if I missed that difference originally.
> 
> > But then CLOCK_MONOTONIC starts at 0 and should not never wrap, right?
> 
> Yes, that is correct.
> 
> > If that's the case then we should never encounter a genuine 0 timeout
> > and this change would be okay.
> 
> That's quite likely, I'd say any program passing {0,0} as a timeout without
> ETNA_WAIT_NONBLOCK is already broken, but if we leave it like that,
> it would be best to describe the reasoning in the changelog.
> 
> Should I change the changelog, or change the patch to restore the
> current behavior instead?
> 
> I guess I could fold the change below into my patch to make it transparent
> to the application again.

If we assume 0 to never be a valid timeout, due to monotonic clock
starting at 0 and never wrapping then I think we shouldn't introduce
any additional code complexity to fix up the return value for this
specific case. I'm not aware of any etnaviv userspace being broken in
this way to rely on the return value for an invalid timeout input.

Please just amend the commit message to mention the change in behavior
and why we think it is safe to do.

Regards,
Lucas

>       Arnd
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 1250c5e06329..162cedfb7f72 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -354,6 +354,7 @@ static int etnaviv_ioctl_wait_fence(struct
> drm_device *dev, void *data,
>         ktime_t timeout = ktime_set(args->timeout.tv_sec,
>                                     args->timeout.tv_nsec);
>         struct etnaviv_gpu *gpu;
> +       int ret;
> 
>         if (args->flags & ~(ETNA_WAIT_NONBLOCK))
>                 return -EINVAL;
> @@ -365,8 +366,12 @@ static int etnaviv_ioctl_wait_fence(struct
> drm_device *dev, void *data,
>         if (!gpu)
>                 return -ENXIO;
> 
> -       if (args->flags & ETNA_WAIT_NONBLOCK)
> -               timeout = ktime_set(0, 0);
> +       if (args->flags & ETNA_WAIT_NONBLOCK) {
> +               ret = etnaviv_gpu_wait_fence_interruptible(gpu, args->fence,
> +                                                          ktime_set(0, 0));
> +
> +               return (ret == -ETIMEDOUT) ? -EBUSY : ret;
> +       }
> 
>         return etnaviv_gpu_wait_fence_interruptible(gpu, args->fence,
>                                                     timeout);
> @@ -421,10 +426,13 @@ static int etnaviv_ioctl_gem_wait(struct
> drm_device *dev, void *data,
>         if (!obj)
>                 return -ENOENT;
> 
> -       if (args->flags & ETNA_WAIT_NONBLOCK)
> -               timeout = ktime_set(0, 0);
> -
> -       ret = etnaviv_gem_wait_bo(gpu, obj, timeout);
> +       if (args->flags & ETNA_WAIT_NONBLOCK) {
> +               ret = etnaviv_gem_wait_bo(gpu, obj, ktime_set(0, 0));
> +               if (ret == -ETIMEDOUT)
> +                       ret = -EBUSY;
> +       } else {
> +               ret = etnaviv_gem_wait_bo(gpu, obj, timeout);
> +       }
> 
>         drm_gem_object_put_unlocked(obj);
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index e42b1c4d902c..fa6986c5a5fe 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1135,6 +1135,7 @@ int etnaviv_gpu_wait_fence_interruptible(struct
> etnaviv_gpu *gpu,
>         u32 id, ktime_t timeout)
>  {
>         struct dma_fence *fence;
> +       unsigned long remaining;
>         int ret;
> 
>         /*
> @@ -1151,12 +1152,12 @@ int
> etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
>         if (!fence)
>                 return 0;
> 
> -       if (!timeout) {
> -               /* No timeout was requested: just test for completion */
> -               ret = dma_fence_is_signaled(fence) ? 0 : -EBUSY;
> +       if (!timeout ||
> +           (remaining = etnaviv_timeout_to_jiffies(timeout)) == 0) {
> +               /* No timeout was requested, or timeout is already expired,
> +                * just test for completion */
> +               ret = dma_fence_is_signaled(fence) ? 0 : -ETIMEDOUT;
>         } else {
> -               unsigned long remaining = etnaviv_timeout_to_jiffies(timeout);
> -
>                 ret = dma_fence_wait_timeout(fence, true, remaining);
>                 if (ret == 0)
>                         ret = -ETIMEDOUT;
> @@ -1185,7 +1186,7 @@ int etnaviv_gpu_wait_obj_inactive(struct etnaviv_gpu *gpu,
>         long ret;
> 
>         if (!timeout)
> -               return !is_active(etnaviv_obj) ? 0 : -EBUSY;
> +               return !is_active(etnaviv_obj) ? 0 : -ETIMEDOUT;
> 
>         remaining = etnaviv_timeout_to_jiffies(timeout);

