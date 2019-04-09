Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8C8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D825320883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDIV0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:04 -0400
Received: from anholt.net ([50.246.234.109]:39430 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfDIVZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:25:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B21C210A32F0;
        Tue,  9 Apr 2019 14:25:55 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id uF7mVp9bDYhL; Tue,  9 Apr 2019 14:25:54 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3479E10A053F;
        Tue,  9 Apr 2019 14:25:54 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9AE172FE36FA; Tue,  9 Apr 2019 14:25:53 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v3 3/3] drm/panfrost: Add initial panfrost driver
In-Reply-To: <20190409205427.6943-4-robh@kernel.org>
References: <20190409205427.6943-1-robh@kernel.org> <20190409205427.6943-4-robh@kernel.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Apr 2019 14:25:53 -0700
Message-ID: <87v9zmdg66.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Rob Herring <robh@kernel.org> writes:

> This adds the initial driver for panfrost which supports Arm Mali
> Midgard and Bifrost family of GPUs. Currently, only the T860 and
> T760 Midgard GPUs have been tested.

> +static int panfrost_ioctl_get_bo_offset(struct drm_device *dev, void *data,
> +			    struct drm_file *file_priv)
> +{
> +	struct drm_panfrost_get_bo_offset *args = data;
> +	struct drm_gem_object *gem_obj;
> +	struct panfrost_gem_object *bo;
> +

Missing check for pad == 0.  With that fixed,

Reviewed-by: Eric Anholt <eric@anholt.net>

> +	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
> +	if (!gem_obj) {
> +		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
> +		return -ENOENT;
> +	}
> +	bo = to_panfrost_bo(gem_obj);
> +
> +	args->offset = bo->node.start << PAGE_SHIFT;
> +
> +	drm_gem_object_put_unlocked(gem_obj);
> +	return 0;
> +}


> +static void panfrost_job_timedout(struct drm_sched_job *sched_job)
> +{
> +	struct panfrost_job *job = to_panfrost_job(sched_job);
> +	struct panfrost_device *pfdev = job->pfdev;
> +	int js = panfrost_job_get_slot(job);
> +	int i;
> +
> +	/*
> +	 * If the GPU managed to complete this jobs fence, the timeout is
> +	 * spurious. Bail out.
> +	 */
> +	if (dma_fence_is_signaled(job->done_fence))
> +		return;

Note: The scheduler calls cancel_delayed_work_sync() in
s_job->finish_work, so this is just reducing the race for the job
successfully completing near the timeout but finish_work being in the
workqueue across the timeout boundary.  I dropped it from v3d.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlytDeEACgkQtdYpNtH8
nuh3JRAAtq3pl35Q1d7+I6lbFCjyLdVHXmNShOpudBRqlPvTkKycYdhWyeUHIyRj
GVDmnaFUdQURCYWr64mqcsqu6U/N/pIAyttRVqxb4qp67Z403BZOC+BlJ1EAJgNv
vzJHUZfSZtyRrF4pez1uyY44pKbAY9ERxvYORhN4QnHfnG9h973fsHaeAD0Yjcv7
nm8yGthWiH3Tn7rqIwRmMVWJf0nhs24QLpjHZSTe7Tsbpb6jcN/nnzkPEgd5XxAm
aP75lVGfMnzISrvC1fJV4hwalMlJaXQFEP2cknDdB7mLcwh7ImrDwxCaMQwh/eB3
dpMBpbr73CM5lvgbacG30PLrr3SNlVkS5XerqqmSxWbFnvQnBbeWiLUaCPzRHerw
SMAMZq2ML2nfn2eGpipQ7EIRmhZHM6lTJsViEPHIiGrdKUUeR4L+guKMlqGjaJ0F
n3Vsw+neyW62lIbD82L5vblZB0KMB50In7Mje0wrF9qncCT6qnYNvGa7NPeJcOJ9
fhLsa2rbX9EoeGK4tLHQrdzcfNVz/FzmNhhGom1ifw+fa4llhdLAxUstn2mpP6sl
PSCwgdmahlQAa1PciacTQHrVWw2lQDnPzcvn9+MApG2mbIqPZF9khCrbbRgmIXI5
8dnMFLTWue7UBLXMEVerxahEVe5Srnj3I34lk5eSa9M0ohcccvA=
=7SIf
-----END PGP SIGNATURE-----
--=-=-=--
