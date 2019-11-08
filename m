Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C422C17440
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BEE20865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfKHXDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:03:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51675 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHXDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:03:50 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iTDIA-0002Ia-C0; Sat, 09 Nov 2019 00:03:46 +0100
Message-ID: <3a0cfce79620152facfe31b442a735db1dcda436.camel@pengutronix.de>
Subject: Re: [PATCH 15/16] drm/etnaviv: use ktime_t for timeouts
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Date:   Sat, 09 Nov 2019 00:03:41 +0100
In-Reply-To: <20191108213257.3097633-16-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
         <20191108213257.3097633-16-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 08.11.2019, 22:32 +0100 schrieb Arnd Bergmann:
> struct timespec is being removed from the kernel because it often leads
> to code that is not y2038-safe.
> 
> In the etnaviv driver, monotonic timestamps are used, which do not suffer
> from overflow, but using ktime_t still leads to better code overall.
> 
> The conversion is straightforward for the most part, except for
> etnaviv_timeout_to_jiffies(), which needs to handle arguments larger
> than MAX_JIFFY_OFFSET on 32-bit architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 19 +++++++++----------
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h | 21 +++++++++------------
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c |  5 ++---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.h |  2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  4 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  4 ++--
>  6 files changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 1f9c01be40d7..1250c5e06329 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -282,16 +282,13 @@ static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
>  			args->flags, &args->handle);
>  }
>  
> -#define TS(t) ((struct timespec){ \
> -	.tv_sec = (t).tv_sec, \
> -	.tv_nsec = (t).tv_nsec \
> -})
> -
>  static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
>  		struct drm_file *file)
>  {
>  	struct drm_etnaviv_gem_cpu_prep *args = data;
>  	struct drm_gem_object *obj;
> +	ktime_t timeout = ktime_set(args->timeout.tv_sec,
> +				    args->timeout.tv_nsec);
>  	int ret;
>  
>  	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
> @@ -301,7 +298,7 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
>  	if (!obj)
>  		return -ENOENT;
>  
> -	ret = etnaviv_gem_cpu_prep(obj, args->op, &TS(args->timeout));
> +	ret = etnaviv_gem_cpu_prep(obj, args->op, timeout);
>  
>  	drm_gem_object_put_unlocked(obj);
>  
> @@ -354,7 +351,8 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
>  {
>  	struct drm_etnaviv_wait_fence *args = data;
>  	struct etnaviv_drm_private *priv = dev->dev_private;
> -	struct timespec *timeout = &TS(args->timeout);
> +	ktime_t timeout = ktime_set(args->timeout.tv_sec,
> +				    args->timeout.tv_nsec);
>  	struct etnaviv_gpu *gpu;
>  
>  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
> @@ -368,7 +366,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
>  		return -ENXIO;
>  
>  	if (args->flags & ETNA_WAIT_NONBLOCK)
> -		timeout = NULL;
> +		timeout = ktime_set(0, 0);

This is a change in behavior, as far as I can see. After this change
the called internal function is not able to differentiate between a
NONBLOCK call and a blocking call with 0 timeout. The difference being
that on a busy object the NONBLOCK call will return -EBUSY, while a
blocking call will return -ETIMEDOUT.

But then CLOCK_MONOTONIC starts at 0 and should not never wrap, right?
If that's the case then we should never encounter a genuine 0 timeout
and this change would be okay.

Regards,
Lucas
>  
>  	return etnaviv_gpu_wait_fence_interruptible(gpu, args->fence,
>  						    timeout);
> @@ -403,7 +401,8 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
>  {
>  	struct etnaviv_drm_private *priv = dev->dev_private;
>  	struct drm_etnaviv_gem_wait *args = data;
> -	struct timespec *timeout = &TS(args->timeout);
> +	ktime_t timeout = ktime_set(args->timeout.tv_sec,
> +				    args->timeout.tv_nsec);
>  	struct drm_gem_object *obj;
>  	struct etnaviv_gpu *gpu;
>  	int ret;
> @@ -423,7 +422,7 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
>  		return -ENOENT;
>  
>  	if (args->flags & ETNA_WAIT_NONBLOCK)
> -		timeout = NULL;
> +		timeout = ktime_set(0, 0);
>  
>  	ret = etnaviv_gem_wait_bo(gpu, obj, timeout);
>  
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> index 32cfa5a48d42..57a4e247bbcf 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -60,8 +60,7 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>  int etnaviv_gem_prime_pin(struct drm_gem_object *obj);
>  void etnaviv_gem_prime_unpin(struct drm_gem_object *obj);
>  void *etnaviv_gem_vmap(struct drm_gem_object *obj);
> -int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
> -		struct timespec *timeout);
> +int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op, ktime_t timeout);
>  int etnaviv_gem_cpu_fini(struct drm_gem_object *obj);
>  void etnaviv_gem_free_object(struct drm_gem_object *obj);
>  int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
> @@ -106,22 +105,20 @@ static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t base)
>   * We need to calculate the timeout in terms of number of jiffies
>   * between the specified timeout and the current CLOCK_MONOTONIC time.
>   */
> -static inline unsigned long etnaviv_timeout_to_jiffies(
> -	const struct timespec *timeout)
> +static inline unsigned long etnaviv_timeout_to_jiffies(ktime_t timeout)
>  {
> -	struct timespec64 ts, to;
> -
> -	to = timespec_to_timespec64(*timeout);
> -
> -	ktime_get_ts64(&ts);
> +	s64 remain = ktime_to_ns(ktime_sub(timeout, ktime_get()));
>  
>  	/* timeouts before "now" have already expired */
> -	if (timespec64_compare(&to, &ts) <= 0)
> +	if (remain < 0)
>  		return 0;
>  
> -	ts = timespec64_sub(to, ts);
> +#ifndef CONFIG_64BIT
> +	if (remain > ((s64)MAX_JIFFY_OFFSET * NSEC_PER_SEC / HZ))
> +		return MAX_JIFFY_OFFSET;
> +#endif
>  
> -	return timespec64_to_jiffies(&ts);
> +	return nsecs_to_jiffies(remain);
>  }
>  
>  #endif /* __ETNAVIV_DRV_H__ */
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index cb1faaac380a..febe5196788e 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -372,8 +372,7 @@ static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
>  		return DMA_BIDIRECTIONAL;
>  }
>  
> -int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
> -		struct timespec *timeout)
> +int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op, ktime_t timeout)
>  {
>  	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>  	struct drm_device *dev = obj->dev;
> @@ -431,7 +430,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
>  }
>  
>  int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, struct drm_gem_object *obj,
> -	struct timespec *timeout)
> +			ktime_t timeout)
>  {
>  	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>  
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> index d6270acce619..a3461a554a6c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> @@ -112,7 +112,7 @@ struct etnaviv_gem_submit {
>  void etnaviv_submit_put(struct etnaviv_gem_submit * submit);
>  
>  int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, struct drm_gem_object *obj,
> -	struct timespec *timeout);
> +	ktime_t timeout);
>  int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
>  	const struct etnaviv_gem_ops *ops, struct etnaviv_gem_object **res);
>  void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index d47d1a8e0219..e42b1c4d902c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1132,7 +1132,7 @@ static void event_free(struct etnaviv_gpu *gpu, unsigned int event)
>   * Cmdstream submission/retirement:
>   */
>  int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
> -	u32 id, struct timespec *timeout)
> +	u32 id, ktime_t timeout)
>  {
>  	struct dma_fence *fence;
>  	int ret;
> @@ -1179,7 +1179,7 @@ int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
>   * that lock in this function while waiting.
>   */
>  int etnaviv_gpu_wait_obj_inactive(struct etnaviv_gpu *gpu,
> -	struct etnaviv_gem_object *etnaviv_obj, struct timespec *timeout)
> +	struct etnaviv_gem_object *etnaviv_obj, ktime_t timeout)
>  {
>  	unsigned long remaining;
>  	long ret;
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> index 8f9bd4edc96a..6d352a435427 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -169,9 +169,9 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m);
>  void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu);
>  void etnaviv_gpu_retire(struct etnaviv_gpu *gpu);
>  int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
> -	u32 fence, struct timespec *timeout);
> +	u32 fence, ktime_t timeout);
>  int etnaviv_gpu_wait_obj_inactive(struct etnaviv_gpu *gpu,
> -	struct etnaviv_gem_object *etnaviv_obj, struct timespec *timeout);
> +	struct etnaviv_gem_object *etnaviv_obj, ktime_t timeout);
>  struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit);
>  int etnaviv_gpu_pm_get_sync(struct etnaviv_gpu *gpu);
>  void etnaviv_gpu_pm_put(struct etnaviv_gpu *gpu);

