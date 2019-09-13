Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308CEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA35B206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfIMRnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:43:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58494 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfIMRnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:43:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id AB4A828DF6E
Date:   Fri, 13 Sep 2019 13:43:43 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panfrost: Simplify devfreq utilisation tracking
Message-ID: <20190913174343.GB5387@kevin>
References: <20190912112804.10104-1-steven.price@arm.com>
 <20190912112804.10104-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20190912112804.10104-3-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch 1 is:

	Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Patch 2 is:

	Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Good stuff as always!

On Thu, Sep 12, 2019 at 12:28:04PM +0100, Steven Price wrote:
> Instead of tracking per-slot utilisation track a single value for the
> entire GPU. Ultimately it doesn't matter if the GPU is busy with only
> vertex or a combination of vertex and fragment processing - if it's busy
> then it's busy and devfreq should be scaling appropriately.
>=20
> This also makes way for being able to submit multiple jobs per slot
> which requires more values than the original boolean per slot.
>=20
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 64 ++++++++-------------
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h |  3 +-
>  drivers/gpu/drm/panfrost/panfrost_device.h  | 12 ++--
>  drivers/gpu/drm/panfrost/panfrost_job.c     | 14 ++---
>  4 files changed, 38 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index 7ded282a5ca8..4c4e8a30a1ac 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -13,7 +13,7 @@
>  #include "panfrost_gpu.h"
>  #include "panfrost_regs.h"
> =20
> -static void panfrost_devfreq_update_utilization(struct panfrost_device *=
pfdev, int slot);
> +static void panfrost_devfreq_update_utilization(struct panfrost_device *=
pfdev);
> =20
>  static int panfrost_devfreq_target(struct device *dev, unsigned long *fr=
eq,
>  				   u32 flags)
> @@ -32,37 +32,23 @@ static int panfrost_devfreq_target(struct device *dev=
, unsigned long *freq,
> =20
>  static void panfrost_devfreq_reset(struct panfrost_device *pfdev)
>  {
> -	ktime_t now =3D ktime_get();
> -	int i;
> -
> -	for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
> -		pfdev->devfreq.slot[i].busy_time =3D 0;
> -		pfdev->devfreq.slot[i].idle_time =3D 0;
> -		pfdev->devfreq.slot[i].time_last_update =3D now;
> -	}
> +	pfdev->devfreq.busy_time =3D 0;
> +	pfdev->devfreq.idle_time =3D 0;
> +	pfdev->devfreq.time_last_update =3D ktime_get();
>  }
> =20
>  static int panfrost_devfreq_get_dev_status(struct device *dev,
>  					   struct devfreq_dev_status *status)
>  {
>  	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> -	int i;
> =20
> -	for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
> -		panfrost_devfreq_update_utilization(pfdev, i);
> -	}
> +	panfrost_devfreq_update_utilization(pfdev);
> =20
>  	status->current_frequency =3D clk_get_rate(pfdev->clock);
> -	status->total_time =3D ktime_to_ns(ktime_add(pfdev->devfreq.slot[0].bus=
y_time,
> -						   pfdev->devfreq.slot[0].idle_time));
> -
> -	status->busy_time =3D 0;
> -	for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
> -		status->busy_time +=3D ktime_to_ns(pfdev->devfreq.slot[i].busy_time);
> -	}
> +	status->total_time =3D ktime_to_ns(ktime_add(pfdev->devfreq.busy_time,
> +						   pfdev->devfreq.idle_time));
> =20
> -	/* We're scheduling only to one core atm, so don't divide for now */
> -	/* status->busy_time /=3D NUM_JOB_SLOTS; */
> +	status->busy_time =3D ktime_to_ns(pfdev->devfreq.busy_time);
> =20
>  	panfrost_devfreq_reset(pfdev);
> =20
> @@ -134,14 +120,10 @@ void panfrost_devfreq_fini(struct panfrost_device *=
pfdev)
> =20
>  void panfrost_devfreq_resume(struct panfrost_device *pfdev)
>  {
> -	int i;
> -
>  	if (!pfdev->devfreq.devfreq)
>  		return;
> =20
>  	panfrost_devfreq_reset(pfdev);
> -	for (i =3D 0; i < NUM_JOB_SLOTS; i++)
> -		pfdev->devfreq.slot[i].busy =3D false;
> =20
>  	devfreq_resume_device(pfdev->devfreq.devfreq);
>  }
> @@ -154,9 +136,8 @@ void panfrost_devfreq_suspend(struct panfrost_device =
*pfdev)
>  	devfreq_suspend_device(pfdev->devfreq.devfreq);
>  }
> =20
> -static void panfrost_devfreq_update_utilization(struct panfrost_device *=
pfdev, int slot)
> +static void panfrost_devfreq_update_utilization(struct panfrost_device *=
pfdev)
>  {
> -	struct panfrost_devfreq_slot *devfreq_slot =3D &pfdev->devfreq.slot[slo=
t];
>  	ktime_t now;
>  	ktime_t last;
> =20
> @@ -164,22 +145,27 @@ static void panfrost_devfreq_update_utilization(str=
uct panfrost_device *pfdev, i
>  		return;
> =20
>  	now =3D ktime_get();
> -	last =3D pfdev->devfreq.slot[slot].time_last_update;
> +	last =3D pfdev->devfreq.time_last_update;
> =20
> -	/* If we last recorded a transition to busy, we have been idle since */
> -	if (devfreq_slot->busy)
> -		pfdev->devfreq.slot[slot].busy_time +=3D ktime_sub(now, last);
> +	if (atomic_read(&pfdev->devfreq.busy_count) > 0)
> +		pfdev->devfreq.busy_time +=3D ktime_sub(now, last);
>  	else
> -		pfdev->devfreq.slot[slot].idle_time +=3D ktime_sub(now, last);
> +		pfdev->devfreq.idle_time +=3D ktime_sub(now, last);
> +
> +	pfdev->devfreq.time_last_update =3D now;
> +}
> =20
> -	pfdev->devfreq.slot[slot].time_last_update =3D now;
> +void panfrost_devfreq_record_busy(struct panfrost_device *pfdev)
> +{
> +	panfrost_devfreq_update_utilization(pfdev);
> +	atomic_inc(&pfdev->devfreq.busy_count);
>  }
> =20
> -/* The job scheduler is expected to call this at every transition busy <=
-> idle */
> -void panfrost_devfreq_record_transition(struct panfrost_device *pfdev, i=
nt slot)
> +void panfrost_devfreq_record_idle(struct panfrost_device *pfdev)
>  {
> -	struct panfrost_devfreq_slot *devfreq_slot =3D &pfdev->devfreq.slot[slo=
t];
> +	int count;
> =20
> -	panfrost_devfreq_update_utilization(pfdev, slot);
> -	devfreq_slot->busy =3D !devfreq_slot->busy;
> +	panfrost_devfreq_update_utilization(pfdev);
> +	count =3D atomic_dec_if_positive(&pfdev->devfreq.busy_count);
> +	WARN_ON(count < 0);
>  }
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.h
> index e3bc63e82843..0611beffc8d0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -10,6 +10,7 @@ void panfrost_devfreq_fini(struct panfrost_device *pfde=
v);
>  void panfrost_devfreq_resume(struct panfrost_device *pfdev);
>  void panfrost_devfreq_suspend(struct panfrost_device *pfdev);
> =20
> -void panfrost_devfreq_record_transition(struct panfrost_device *pfdev, i=
nt slot);
> +void panfrost_devfreq_record_busy(struct panfrost_device *pfdev);
> +void panfrost_devfreq_record_idle(struct panfrost_device *pfdev);
> =20
>  #endif /* __PANFROST_DEVFREQ_H__ */
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index 4c2b3c84baac..233957f88d77 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -51,13 +51,6 @@ struct panfrost_features {
>  	unsigned long hw_issues[64 / BITS_PER_LONG];
>  };
> =20
> -struct panfrost_devfreq_slot {
> -	ktime_t busy_time;
> -	ktime_t idle_time;
> -	ktime_t time_last_update;
> -	bool busy;
> -};
> -
>  struct panfrost_device {
>  	struct device *dev;
>  	struct drm_device *ddev;
> @@ -95,7 +88,10 @@ struct panfrost_device {
>  	struct {
>  		struct devfreq *devfreq;
>  		struct thermal_cooling_device *cooling;
> -		struct panfrost_devfreq_slot slot[NUM_JOB_SLOTS];
> +		ktime_t busy_time;
> +		ktime_t idle_time;
> +		ktime_t time_last_update;
> +		atomic_t busy_count;
>  	} devfreq;
>  };
> =20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 05c85f45a0de..47aeadb4f161 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -155,7 +155,7 @@ static void panfrost_job_hw_submit(struct panfrost_jo=
b *job, int js)
> =20
>  	cfg =3D panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
> =20
> -	panfrost_devfreq_record_transition(pfdev, js);
> +	panfrost_devfreq_record_busy(pfdev);
>  	spin_lock_irqsave(&pfdev->hwaccess_lock, flags);
> =20
>  	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
> @@ -396,7 +396,7 @@ static void panfrost_job_timedout(struct drm_sched_jo=
b *sched_job)
> =20
>  	/* panfrost_core_dump(pfdev); */
> =20
> -	panfrost_devfreq_record_transition(pfdev, js);
> +	panfrost_devfreq_record_idle(pfdev);
>  	panfrost_device_reset(pfdev);
> =20
>  	for (i =3D 0; i < NUM_JOB_SLOTS; i++)
> @@ -454,7 +454,7 @@ static irqreturn_t panfrost_job_irq_handler(int irq, =
void *data)
> =20
>  			pfdev->jobs[j] =3D NULL;
>  			panfrost_mmu_as_put(pfdev, &job->file_priv->mmu);
> -			panfrost_devfreq_record_transition(pfdev, j);
> +			panfrost_devfreq_record_idle(pfdev);
>  			dma_fence_signal(job->done_fence);
>  		}
> =20
> @@ -551,14 +551,14 @@ int panfrost_job_is_idle(struct panfrost_device *pf=
dev)
>  	struct panfrost_job_slot *js =3D pfdev->js;
>  	int i;
> =20
> +	/* Check whether the hardware is idle */
> +	if (atomic_read(&pfdev->devfreq.busy_count))
> +		return false;
> +
>  	for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
>  		/* If there are any jobs in the HW queue, we're not idle */
>  		if (atomic_read(&js->queue[i].sched.hw_rq_count))
>  			return false;
> -
> -		/* Check whether the hardware is idle */
> -		if (pfdev->devfreq.slot[i].busy)
> -			return false;
>  	}
> =20
>  	return true;
> --=20
> 2.20.1
>=20

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl171UAACgkQ/v5QWgr1
WA1NMg/+JqnCFFTfRWYDqBeEnJpQBFerABGn9oWjVjkQJ+uJQeuK1BdZ/f2Q7WWi
lK9Py3X8DCAgUFlacJbqLemR+WRgfIMto+V1xTjorcQFry4EqC7k4MUfEsmZpfIE
saKl6sUDd0VGLy1feX05co7gM54rHQV0X67z6P0xbcxymnOQwqJ1B2biTeH1QYGr
JGcbrWrdkAemRpFquZuSe8FrjwVJ9z5DAJG1GqNVDaYm3mtKZHEpuhsfqKRHKTmM
hMaokGdkaX+62x5zpxv/Y81MLToIpXxvp2O7ruyt8gk3XQx/5Sf+K5wnrJD3+Kqq
16kM1KLRbeSOV7TUyO/moflEzmKEAVw1g7jGRiXUV0RlXycHnxz/se/4HELrkIaP
bwZvX9lZ8OYrUm6+bI5WZaJyj88nilK0HShiZukJ+94I+rWgY+LjlPdQ1oZTagMb
LqkvXFTsshmyJ7s0AeRVWo9hwciG+Ew5H+dDcdvC2dZjowRp0AKSV2r5wfQRaXlP
c1MMeRzKXg0qZREd75/Wh3U9A00hS3eczTEgrb6xj1oUzoPZrFsd7QOEUDoACmVe
sCp9aI4k0tbMqwxgIsTd28GYablQQ/GKEThtWiytraHnXIEhwql30alx+hesHjc+
YjP+QeCWiAEl3qvj97525G9OHrET5Ddv0ryA3AauxHG6xF7WHLI=
=qjqB
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
