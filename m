Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DFBC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFF7206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uo1cGikn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfFRTuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:50:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37306 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfFRTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:50:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id n65so3790480pga.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wjifz5uHPldc8PDdCIO5f85gTwG04S/iIKsvaQyfdkE=;
        b=uo1cGiknudQ1DmCFoJu+xmQeQ2RwtsorW/AgOgRgz5ePe8JksVTzzAQCMOiHqsKF5t
         Gi/DoHlCUw0++GW308UhmYRN/rpi3H/RUiquyEAEmyQdKMt5CSxJaqip8s9vdwfuxbnQ
         1+sQlO+q9ECK0U9ayKPWpBg3Bo4QHSVQUtqUbKZyLpX88dwGBKkSkDN4V2pmterJYqeK
         AsGKz+aYxJtU79kA0yg6Z+mTzDUoUjFTNUAGbSwY4Jjivr3Ss5J2wLg5au7JTnMXSUbp
         Ri+v4EQF5tDhRLg3lCpDi9Q87Q+vtSKa1tcCioQkh3Sp/MnpwqPYY9HJ6YdqYGgTI4Af
         l3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjifz5uHPldc8PDdCIO5f85gTwG04S/iIKsvaQyfdkE=;
        b=VCxUp2uAIpcWLINO5ULYuK4qUzAEzK1TOuNKbMUN3cb4smSjTbM3WKIm40OpSg01jW
         Cs70NFegWdQ6+z5LvNvzLhLkpYQML2Mhh/G3vKFT/AH4qSRMFvPViKTabxeJ9H4kIE7p
         E/CSBw8KkYvLjaHYAVw178QCFgrjiC8ata7Ne6BCEKvpxSsKS1NtRk6TUwxmVLcPTeUc
         lNE/IC6CTKvA0sZI7UFLNPbssBtU2d7J1eZW1k+Vq3e96T6AyIBhTFqxot6mfScyqLGI
         U3m8BNCQQ31UfgJRb2GUGgfSaq4sbS/CWJ/kLsvN/GaRZhh+AoUs1Yz4bev1LF6p2JRI
         ScEA==
X-Gm-Message-State: APjAAAWaBNQvI98iDm/OAYRJVb2xnKSEWqbdYOgZFDtYEIxhiH3Ghy8O
        Fpr640Dk4jOEx2+2qApQBtEGSw==
X-Google-Smtp-Source: APXvYqwPnu8RBmlL3E+Q7vpolsbVlPjST5zSI2vPiZwMCGYSPhgpa6ysjJMPAePvkMGJydTgegwmKw==
X-Received: by 2002:a17:90a:35e5:: with SMTP id r92mr7097863pjb.34.1560887416690;
        Tue, 18 Jun 2019 12:50:16 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id g17sm19819854pfb.56.2019.06.18.12.50.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 12:50:15 -0700 (PDT)
Date:   Tue, 18 Jun 2019 12:50:11 -0700
From:   Benson Leung <bleung@google.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: wilco_ec: fix null pointer
 dereference on failed kzalloc
Message-ID: <20190618195011.GB209269@google.com>
References: <20190618153924.19491-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20190618153924.19491-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Colin,

On Tue, Jun 18, 2019 at 04:39:24PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> If the kzalloc of the entries queue q fails a null pointer dereference
> occurs when accessing q->capacity and q->lock.  Add a kzalloc failure
> check and handle the null return case in the calling function
> event_device_add.
>=20
> Addresses-Coverity: ("Dereference null return")
> Fixes: 75589e37d1dc ("platform/chrome: wilco_ec: Add circular buffer as e=
vent queue")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied. Thanks.

Benson

> ---
>  drivers/platform/chrome/wilco_ec/event.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/=
chrome/wilco_ec/event.c
> index c975b76e6255..e251a989b152 100644
> --- a/drivers/platform/chrome/wilco_ec/event.c
> +++ b/drivers/platform/chrome/wilco_ec/event.c
> @@ -112,8 +112,11 @@ module_param(queue_size, int, 0644);
>  static struct ec_event_queue *event_queue_new(int capacity)
>  {
>  	size_t entries_size =3D sizeof(struct ec_event *) * capacity;
> -	struct ec_event_queue *q =3D kzalloc(sizeof(*q) + entries_size,
> -					   GFP_KERNEL);
> +	struct ec_event_queue *q;
> +
> +	q =3D kzalloc(sizeof(*q) + entries_size, GFP_KERNEL);
> +	if (!q)
> +		return NULL;
> =20
>  	q->capacity =3D capacity;
>  	spin_lock_init(&q->lock);
> @@ -474,6 +477,11 @@ static int event_device_add(struct acpi_device *adev)
>  	/* Initialize the device data. */
>  	adev->driver_data =3D dev_data;
>  	dev_data->events =3D event_queue_new(queue_size);
> +	if (!dev_data->events) {
> +		kfree(dev_data);
> +		error =3D -ENOMEM;
> +		goto free_minor;
> +	}
>  	init_waitqueue_head(&dev_data->wq);
>  	dev_data->exist =3D true;
>  	atomic_set(&dev_data->available, 1);
> --=20
> 2.20.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXQlAcwAKCRBzbaomhzOw
wr+OAQDkPiwWk7AV6oZD5PfPYh/XkD9jN7eDN/xgit4T9H45EAEA7vDa2nw7IoFX
InIF4BYsfI/ilZ9ZuBM8hpW43YKKswg=
=s73v
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
