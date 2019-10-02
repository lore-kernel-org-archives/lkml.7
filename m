Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E624ECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C7D21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRtNZRaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfJBM02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:26:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43649 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:26:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so19429484wrx.10;
        Wed, 02 Oct 2019 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nJJWJKWZ6ot8MB4WrieEngenboHBJCatY61zRdQspzo=;
        b=rRtNZRaHtyB52yI7QHrLWz3o4Yp8l3xcgAbpJbUpbz5LBwTwLwSSU/JBMljRxmoIUG
         mYOhl6+8084nVywzjqUUXsI1lDtB1TycUeBZrxvmjnpOsYq0Ce3s0PF/bNcPQOq4KUES
         J4t9YfB1cj3+dHCUqOYy/SNqEoiYlqNuAeHqjzomytp0MKaEY3Rrq7EgaUuDyfwZ77VI
         /7y0aIm+Dc6iKQyjCypItjZWu6x+QF64Z/Q9uswF3kXDCJ/accQb8hlBEuPGGpDktcxO
         EL6+UOSXVqJ5r+WtLEWK0SaoxOx1syq0Waxej2vgt1BxPJ2VBu5XL3FX9soNx6C+/wlU
         iUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJJWJKWZ6ot8MB4WrieEngenboHBJCatY61zRdQspzo=;
        b=O4mD5gGNJfhuIVNJ3/2zThVBaMU/kBJkejgPy1jmrInuBGGt5VTpBsL+3KY0AObi9M
         kIMjj5scchORNGUemY7o7ABhbu5c25dandS5+Rjw/OIpzYf5yDTB5mziqaqKTB2zPbWB
         UdICNDEHd2jVEfWWKElIpKqX0UOeeqX3z0/7AOQ1VknwAsB5luMuAIY+nl+tUkx4nTC+
         mLRmNhR1cXG5Dx3Fu6j63Hq9aTlgm03ouIKrkjLyEKWCA6MmkFL+9o1lRtEWrzgECRQT
         9yrNfsfVOwR+qKVTt6jiBBhxssdz0v0zafxC/HbwpVJTRrR89h9lV7uNlpujPihAzSAO
         VTZQ==
X-Gm-Message-State: APjAAAXx4wNLfEaNZ2nqYvmdFZjgr14navoz5rjYp4wJI3bMGMt05ez3
        AtOwEmz53CsEWRCfIUrcW1Y=
X-Google-Smtp-Source: APXvYqxzTU3I1+6Oxb2cnM6V4fD0XqMMbR0uuWfM5VqGuTXmaGdHk133qBPnxpkiR/Eu881Gb1Rrfg==
X-Received: by 2002:adf:ea10:: with SMTP id q16mr2625159wrm.356.1570019185839;
        Wed, 02 Oct 2019 05:26:25 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r18sm7990520wme.48.2019.10.02.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:26:24 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:26:23 +0200
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
Subject: Re: [PATCH 1/3] ahci: tegra: use regulator_bulk_set_supply_names()
Message-ID: <20191002122623.GA3908655@ulmo>
References: <20191001132333.20146-1-brgl@bgdev.pl>
 <20191001132333.20146-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20191001132333.20146-2-brgl@bgdev.pl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 03:23:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Use the new regulator helper instead of a for loop.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/ata/ahci_tegra.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2Ul2sACgkQ3SOs138+
s6Ga/w//Yimb8W0dHb5bPycndMDPTCHs3rLOFV/Yl1KXFujPKpcNR8l6VEDs3EQ4
S9SIZ2ZtKarqXztozASGg1i34FRAZ9k9uvnMKDhSGVmHIE+GJ/2yvG19SrdXAhqk
ysfZOdiuO9yX+sBXI2wTuzkhInxByhy9Dmi1bk/4mXL4RT4uaafV5GDhV8VcFRUm
g04drAnwoCkGKk5YfdgLGHgj06EkzdBbh98XrOgRn18juizCSB/cH+yXPUGYDsIA
NQ5YjX8kPigHc0SSblGKCpq6T+sATD1OrveMF0T8Ug5p9BuimxVNoSlSlen+0B06
gbcozBapTVJ0obQkuverozJD+UvTO889JxCHwP5IQK7besM/pN4ZlkYFWRHDXk3n
ezce5wh0VrZ4Z99VkjPimYZRDwJQbN+pQrE6jHlDhSugAhyM+s0f/rW2a9E53ZYf
f3nh2OQtrhMnZtIliNLuI1EDNWRHB2wt2JOSOmn/F7W11nXtjEZTffdQ1hipbpJV
FDho9pflIt5d/zBqzidGsyg7asSYVy2Floc7Dlnd+nLDbH/E+EDKTrVa+W+fdmM0
yuisyQp9Z1lVlSVFn31qS97UYUZkqRHWz/nMHiI4X6J/dMdpwM5kckL98Zft1vEY
HW+sUz4zelVQaZyhjsrRKiidYqcjy69dkO2Gach7iQv7+9ngHHI=
=XBi7
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
