Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C24C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C020B21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uepVfLVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfJBM0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:26:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44791 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:26:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so6300394wrl.11;
        Wed, 02 Oct 2019 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zcCfEs3KfOKzCbyLEWqayRRUzXnw9D3ddQV5gJK1ZO0=;
        b=uepVfLVm8rY+dPdz/rllu5OOvyDpdWYbUVdKmYXZi5OVbbLuxF6i0fnA3WXcyvWw50
         s+7m7zpRsYez7Ua+uzvIPueJRwv9MPEOlAtGeqmOMBta1CpCHJWw0dqcnLFbbNrmLykE
         cRpaRnWkxrnkewrij4RJdlUFM4B2uXZghuwBptHB3MOEecJW9w2jtoQ2CY0Na1SK9EFU
         H2HJ0f3G/D9kFaxPRZEOivva2VNJbx5S8lVh4NikI/NZUO+ZuNvoxmrsuBafQL3kQdUK
         OJEj7kKL1/Crs8eVTO5Lkt85OM17LMZt04HoSTU3Wqe8Z/5ZNxuFT0etcUtpxzlvdIGZ
         x3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcCfEs3KfOKzCbyLEWqayRRUzXnw9D3ddQV5gJK1ZO0=;
        b=KfUSc3g6Y3chGi+pb+hy1OWmOo/vUwE1x78h+X/WeENpo89qrhUnzu26sNu4TeuXnm
         AMGP4L54E4lC8KFfritNISWyu2rEGHmTVhnPbHZLDbw6ngo/qdo1hgoIDbQ792g4JyUQ
         gIY+1k2cS4/zKJUqvNdpBDc1BZYyGiKfAB2Lcxk0TnAx+5Qgr2kZOYYFARaK9D69F/h0
         w8KqtYRDOOXDwk8jDj40YkMJyhe+9P0Jbe5oBapwcoyVlPqIM5ngvJX2/UXk+mhQowma
         5RFrJsEBp5AAYi9Gg5gHh73grKTN8YaEpPijRifsLRBf8yuLnYdEyX4XK/8HPfvIqz+A
         3oyQ==
X-Gm-Message-State: APjAAAXD30lyTCE6dYhvMA4yzMWqFnlZ3ZRe2n+DZ5nK8yrME/j7cbfL
        dcKQmQLRy6vR7IhDDKN4+Bs=
X-Google-Smtp-Source: APXvYqxoybC6gRPh4GDDplN1z+zsSxPdzEXbKLb/SJ5x93pwy7LiuM71IUPziFfqROC5f5SXCOA3Kg==
X-Received: by 2002:adf:e387:: with SMTP id e7mr2568520wrm.306.1570019200785;
        Wed, 02 Oct 2019 05:26:40 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id f186sm6769589wmg.21.2019.10.02.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:26:39 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:26:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 2/3] phy: tegra: use regulator_bulk_set_supply_names()
Message-ID: <20191002122638.GB3908655@ulmo>
References: <20191001132333.20146-1-brgl@bgdev.pl>
 <20191001132333.20146-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20191001132333.20146-3-brgl@bgdev.pl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 03:23:32PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Use the new regulator helper instead of a for loop.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/phy/tegra/xusb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2Ul30ACgkQ3SOs138+
s6EF5A//Xcp1n7NvMOoJLxPyJaAbj2+9yDBPk8P8XjrOlNnnJKLR/Pi/ZJ3XHx5F
GUdipz/eE9JwZqsUSbqdBv+77ZeUeSz0SU5B7TNwajOLcInHbbmLqTxbXh+yydC8
COM6x1+GzPZ/V8c2k1NqQUyKx1xfWe4cEWKIa/Nyssw9YoJfRI4RMZ20NQ2tyYcV
fEO97xTcG+1ikivOJiqNdJYgSY4GdM5/6gJdHzLk0lBZEDq6EadVvdu/thMloF8i
mlankGeD5uHIZLZLxw5tnX7TGVJ7kEoIbf8aFdQaFtXVweao8QUGlYaVbFnlPJXT
/z1n+kLrBI8X6jdbUqzWYrcWI6LzrHSh3xRNdqxqjgW8EppuP1qhcVcdS34Q7/SJ
dbSivgaTeeGf88Z5RFMXLPxVYpKGsZ3xIi2QSuz6PZG2pJQmWvRlgSZR+ReH/9xg
YnpBaRCKiAGLpxXTn/ZQNlhca1ZXH90SgPsHEaPSgFB+EencKjbLgvVd3Sq3lNEW
E2xVPeO+0zwkmwm9alfPI1RP2dUvR37cgEaapu4i+htkcQxb3mctjQrkisixMYYH
eozSjWqaoKvSzvahgnEpwgd4e+H0qjQSyJ3yK8fWeO1PBmuPH8sOKUtAMnOtoeXN
Ne0xB7w7DvGhA3+KokaDTdgu4PslLrmmKTQSIKA6BnGhqED6S2k=
=k7Zf
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
