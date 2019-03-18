Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CD820811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj4warRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCRJMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:12:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCRJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:12:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id 33so16118577wrb.13;
        Mon, 18 Mar 2019 02:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4bjTcs1DU4GC9V5+oGpeC8b/mQVxsMiUscnUocYbN1I=;
        b=Nj4warRUVNwnnijKED5iQ18GMPUF5RraX1AXQE7bV7hPJyxUyTzRjp5fwWt00naYie
         pIdfHE7xZRDKyEuRLN8goxTh1bWEZ2qE7SJ3TM+JVtocnvu5y3FsroGpUqkc0HxPeDFK
         6jE4+ak7YUTuCSAupdZNZtaBPo8wbmNyIC49Ie03wHsptyPiyiIQ+ChZdqe2xsTJCLka
         tBWuzARLjTutntE+8+gSIXlPFocB8YOyCzYyM3KMIOdniTP656TRB7QeYqGh2muSlGVT
         RMKvy37T7sJAz2ZEphhQffaNi/1glv9jr4YRONnAK/AjAbEnHVog8H2MCOxmdBXllhSH
         /6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4bjTcs1DU4GC9V5+oGpeC8b/mQVxsMiUscnUocYbN1I=;
        b=BeT6F1p9P7zL1aES922o7JFcz+f60B/A6guK8otgYiDzAHALB6TJeXZ0opCdy39BcG
         ii/PH/ofBws+CsHXbDkyM7X29IQqgUyktGLZRjAQDxUgaOWWkfuVAuBC7914d2UaUgT0
         0cOvlTzCFkf7IaTECe0CwwcjR6GlyJq3wHe/CN99gVee9PxdkjtJM3Q+/sQ1Ml9+4Uq+
         BuEbq01QLF+A7fZchS1bVQHN6rjop7kcKOkRM09WGVWV/9VySBvKIVAucGIrLL7jG2V9
         f15daJc3X8djp5qh7mkjODuLWO339eeAaA6XTCRQemsqSmadN6ByvjgKpze1PthtRkRQ
         Ekjw==
X-Gm-Message-State: APjAAAUXWslYIipI3994nB1R2NlQBTMJ7SncQ6kklEV9b/t6nbM4l+/m
        Ztff03hIHxPvb/q7OjbExu8=
X-Google-Smtp-Source: APXvYqwoghnPTMe3SNOx8H6HOj8XTIsZS8i9v8A46KA3AbYSIIFfgDJ6wesD4l+FIPxqb+X9MjoXyg==
X-Received: by 2002:adf:e3d1:: with SMTP id k17mr11110075wrm.143.1552900338496;
        Mon, 18 Mar 2019 02:12:18 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id l3sm8816627wrt.62.2019.03.18.02.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 02:12:17 -0700 (PDT)
Date:   Mon, 18 Mar 2019 10:12:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] reset: add acquired/released state for exclusive
 reset controls
Message-ID: <20190318091216.GB14465@ulmo>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
 <20190221152858.GA8652@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20190221152858.GA8652@ulmo>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 04:28:58PM +0100, Thierry Reding wrote:
> On Thu, Feb 21, 2019 at 04:25:53PM +0100, Thierry Reding wrote:
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> >=20
> > There are cases where a driver needs explicit control over a reset line
> > that is exclusively conneted to its device, but this control has to be
> > temporarily handed over to the power domain controller to handle reset
> > requirements during power transitions.
> > Allow multiple exclusive reset controls to be requested in 'released'
> > state for the same physical reset line, only one of which can be
> > acquired at the same time.
> >=20
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/reset/core.c  | 139 ++++++++++++++++++++++++++++++++++++++----
> >  include/linux/reset.h |  93 ++++++++++++++++++++++------
> >  2 files changed, 200 insertions(+), 32 deletions(-)
>=20
> Hi Philipp,
>=20
> the bulk of this is unchanged relative to what you had posted
> originally. I squashed in the few things that we had already discussed
> earlier (EINVAL -> EPERM) and a couple of minor fixes for issues that I
> found while working with this.
>=20
> Attached is my fixup patch which contains all the changes I made on top
> of your version and that I squashed into this.
>=20
> Thierry

Hi Philipp,

do you have any further comments on this series?

Thierry

> --- >8 ---
> commit aa618d0b63eec676d9ea8db91a4c5fdc9330fc6b
> Author: Thierry Reding <treding@nvidia.com>
> Date:   Mon Feb 18 11:32:46 2019 +0100
>=20
>     fixup! reset: add acquired/released state for exclusive reset controls
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index c6a7a4474142..1e8a42b16f23 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -65,6 +65,17 @@ struct reset_control_array {
>  	struct reset_control *rstc[];
>  };
> =20
> +static const char *rcdev_name(struct reset_controller_dev *rcdev)
> +{
> +	if (rcdev->dev)
> +		return dev_name(rcdev->dev);
> +
> +	if (rcdev->of_node)
> +		return rcdev->of_node->full_name;
> +
> +	return NULL;
> +}
> +
>  /**
>   * of_reset_simple_xlate - translate reset_spec to the reset line number
>   * @rcdev: a pointer to the reset controller device
> @@ -276,7 +287,7 @@ int reset_control_reset(struct reset_control *rstc)
>  			return 0;
>  	} else {
>  		if (!rstc->acquired)
> -			return -EINVAL;
> +			return -EPERM;
>  	}
> =20
>  	ret =3D rstc->rcdev->ops->reset(rstc->rcdev, rstc->id);
> @@ -340,8 +351,11 @@ int reset_control_assert(struct reset_control *rstc)
>  		if (!rstc->rcdev->ops->assert)
>  			return -ENOTSUPP;
> =20
> -		if (!rstc->acquired)
> -			return -EINVAL;
> +		if (!rstc->acquired) {
> +			WARN(1, "reset %s (ID: %u) is not acquired\n",
> +			     rcdev_name(rstc->rcdev), rstc->id);
> +			return -EPERM;
> +		}
>  	}
> =20
>  	return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
> @@ -378,8 +392,11 @@ int reset_control_deassert(struct reset_control *rst=
c)
>  		if (atomic_inc_return(&rstc->deassert_count) !=3D 1)
>  			return 0;
>  	} else {
> -		if (!rstc->acquired)
> -			return -EINVAL;
> +		if (!rstc->acquired) {
> +			WARN(1, "reset %s (ID: %u) is not acquired\n",
> +			     rcdev_name(rstc->rcdev), rstc->id);
> +			return -EPERM;
> +		}
>  	}
> =20
>  	/*
> @@ -417,15 +434,43 @@ int reset_control_status(struct reset_control *rstc)
>  }
>  EXPORT_SYMBOL_GPL(reset_control_status);
> =20
> +/**
> + * reset_control_acquire() - acquires a reset control for exclusive use
> + * @rstc: reset control
> + *
> + * This is used to explicitly acquire a reset control for exclusive use.=
 Note
> + * that exclusive resets are requested as acquired by default. In order =
for a
> + * second consumer to be able to control the reset, the first consumer h=
as to
> + * release it first. Typically the easiest way to achieve this is to cal=
l the
> + * reset_control_get_exclusive_released() to obtain an instance of the r=
eset
> + * control. Such reset controls are not acquired by default.
> + *
> + * Consumers implementing shared access to an exclusive reset need to fo=
llow
> + * a specific protocol in order to work together. Before consumers can c=
hange
> + * a reset they must acquire exclusive access using reset_control_acquir=
e().
> + * After they are done operating the reset, they must release exclusive =
access
> + * with a call to reset_control_release(). Consumers are not granted exc=
lusive
> + * access to the reset as long as another consumer hasn't released a res=
et.
> + *
> + * See also: reset_control_release()
> + */
>  int reset_control_acquire(struct reset_control *rstc)
>  {
>  	struct reset_control *rc;
> =20
> -	if (!rstc || rstc->acquired)
> +	if (!rstc)
>  		return 0;
> =20
> +	if (WARN_ON(IS_ERR(rstc)))
> +		return -EINVAL;
> +
>  	mutex_lock(&reset_list_mutex);
> =20
> +	if (rstc->acquired) {
> +		mutex_unlock(&reset_list_mutex);
> +		return 0;
> +	}
> +
>  	list_for_each_entry(rc, &rstc->rcdev->reset_control_head, list) {
>  		if (rstc !=3D rc && rstc->id =3D=3D rc->id) {
>  			if (rc->acquired) {
> @@ -435,13 +480,28 @@ int reset_control_acquire(struct reset_control *rst=
c)
>  		}
>  	}
> =20
> +	rstc->acquired =3D true;
> +
>  	mutex_unlock(&reset_list_mutex);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(reset_control_acquire);
> =20
> +/**
> + * reset_control_release() - releases exclusive access to a reset control
> + * @rstc: reset control
> + *
> + * Releases exclusive access right to a reset control previously obtaine=
d by a
> + * call to reset_control_acquire(). Until a consumer calls this function=
, no
> + * other consumers will be granted exclusive access.
> + *
> + * See also: reset_control_acquire()
> + */
>  void reset_control_release(struct reset_control *rstc)
>  {
> +	if (!rstc || WARN_ON(IS_ERR(rstc)))
> +		return;
> +
>  	rstc->acquired =3D false;
>  }
>  EXPORT_SYMBOL_GPL(reset_control_release);



--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyPYO0ACgkQ3SOs138+
s6HHDg//YneTNkf+xXw6KFibhXVNaYKQd2HSjH9Y4UUlFQhA775m1F9Icicfb5IJ
eXgHHqVeCPKTL3K/bDI2fWSwlFZ6wseSxij7W1HQGyjekDX0gEX1HnsF9HOmeP9B
u/UqrAzrpoLnOa8tUpbIDZ6S7WyI5mn7Yd8LZxkpeNvcPwtBD2B34nU0SYcyp7bk
DKJiM38a40Jo5g+URyyGP9eZFwFeT6tajJRN2Rk14mE0vJs3BLSIy373GVsV2jss
jPa73igCcJ7Q6UDwNlDCmTIaZsTJ6cF7hMuM6QN9eB9owzESNeBjWy/xDyGDsbLQ
pWJ8inQmADGEVfoUowCqew4pogR7vsxcdGfPF8ssFUA4DGGkgtW3WzvzeBoxpqVv
KydytFT57r2WpcS9nod01rMcNbXPZNNxOuwGbv8Ynzr7jhyNnGq5Rs7hYp4XjWDk
fhKsa8IsP8+twW7linsBeoK7Ws21CCi9eLai4s8dRCvhzLoShvsxOgsQkOtzGGy4
I59GIR45Bw/iVyoraKM3f8CxqVBwOKoYXIH9j9+eluWtjnJOFdyzR5rakFKmooQT
mpeRPTgrdc2Hjktj3hrcDSZkRMK5+rwVe5qzaAq3uMATkbT1IKrm9c/FATUxTQeg
M2wMYzEogVWJELNzm9ox28N6sGE1cvFPWoJndX9LleRL1fIzj78=
=cGMw
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
