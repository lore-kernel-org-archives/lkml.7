Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6717C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38B722CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNwrYHMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfH2HoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:44:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37636 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2HoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:44:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so2351631wrt.4;
        Thu, 29 Aug 2019 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FxMZVBtYGnfVGlhM9QLt+9596i7ieWLb8OER0jk2Ipw=;
        b=HNwrYHMPoYIdG+g7d39xvzQYiLAE/nt8sMfzbAHgVzYA7OWIMHnBB8Um6znmXwpyFF
         i74i0+oSH9etNExu7GZxttszVFc1xFOH/I/fAA8qkhMgX0ow5v8HfAhPLB6XBDOhvWlG
         dzJ64yodlfUFXSrCh5LKMZauL4Ou+mihzZpgzrcJttGLfm3L+W7Blfle7Ew0svT70UNL
         9SHvCJzb/g77Un/p5xPifb3l1JHE0IuUpq4lXtz3kAHd/QM3z+8bEYUjitZ3CeU5RF8R
         rNrWAIfZ+72Tkci/DHXTMNbEr1zsNBLFTCaxQlY9XoEwk/ga7TEn1clmtfU8Q0q/oZUH
         1lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FxMZVBtYGnfVGlhM9QLt+9596i7ieWLb8OER0jk2Ipw=;
        b=plkDNR4CHfMGOeKBFSkziQAcuKCPMiC/8oO7a/+3bJHvKdGNFid+cphrfaVbKavWUv
         Hg9crOvoqhNk5t0apZg4KqE4JM64wQra9p1I8PpSScxjMnyfTxcFGij9+ezJ7QauPUo0
         UNtSGz2QvUYJISyLT1ysTbGWGgKtvZivczks/H1hXAkbfMdqTGv7b5emO+Wi89AOSTX4
         bvEA5UOP3QxHfqPwGW7hcNyTqFwAoYA8D5dxe9fS3p8yJImC3pR7327CrWAWZJclOqXg
         ojeb1zFDgR4mCSIOhx1F0XsyrJ2WCS/RaEwtjm8ZzcghRwJ/r/1wg2Wfn0wHNSKZ/4w5
         Kf9Q==
X-Gm-Message-State: APjAAAVAQxqmICjE9ntifT8709PMXZeM6bN4HB3j2mPP9oIfTs3gV1Fv
        TkoBlTSR/A/uVi5Z/U+efrE=
X-Google-Smtp-Source: APXvYqwUVVXc03pYRsk6RuBUUg7oF+TPDARWunZZGWodZF4up1Bs/2UETd7qHQKSWwkI0Iu0NdzhiA==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr10197361wrx.50.1567064650942;
        Thu, 29 Aug 2019 00:44:10 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id t22sm1421459wmi.11.2019.08.29.00.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 00:44:09 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:44:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: platform: Introduce
 platform_get_irq_optional()
Message-ID: <20190829074408.GA17754@ulmo>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <20190828083411.2496-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 10:34:10AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> In some cases the interrupt line of a device is optional. Introduce a
> new platform_get_irq_optional() that works much like platform_get_irq()
> but does not output an error on failure to find the interrupt.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/base/platform.c         | 22 ++++++++++++++++++++++
>  include/linux/platform_device.h |  1 +
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8ad701068c11..0dda6ade50fd 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -192,6 +192,28 @@ int platform_get_irq(struct platform_device *dev, un=
signed int num)
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> =20
> +/**
> + * platform_get_irq_optional - get an optional IRQ for a device
> + * @dev: platform device
> + * @num: IRQ number index
> + *
> + * Gets an IRQ for a platform device. Device drivers should check the re=
turn
> + * value for errors so as to not pass a negative integer value to the
> + * request_irq() APIs. This is the same as platform_get_irq(), except th=
at it
> + * does not print an error message if an IRQ can not be obtained.
> + *
> + * Example:
> + *		int irq =3D platform_get_irq_optional(pdev, 0);
> + *		if (irq < 0)
> + *			return irq;
> + *
> + * Return: IRQ number on success, negative error number on failure.
> + */
> +int platform_get_irq_optional(struct platform_device *dev, unsigned int =
num)
> +{
> +	return __platform_get_irq(dev, num);
> +}

Oh my... this is embarrassing, but the kbuild test robot reported that
the second patch here fails to build because I forgot to export this
symbol. I've attached a patch that fixes it.

Thierry

> +
>  /**
>   * platform_irq_count - Count the number of IRQs a platform device uses
>   * @dev: platform device
> diff --git a/include/linux/platform_device.h b/include/linux/platform_dev=
ice.h
> index 37e15a935a42..35bc4355a9df 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -58,6 +58,7 @@ extern void __iomem *
>  devm_platform_ioremap_resource(struct platform_device *pdev,
>  			       unsigned int index);
>  extern int platform_get_irq(struct platform_device *, unsigned int);
> +extern int platform_get_irq_optional(struct platform_device *, unsigned =
int);
>  extern int platform_irq_count(struct platform_device *);
>  extern struct resource *platform_get_resource_byname(struct platform_dev=
ice *,
>  						     unsigned int,
> --=20
> 2.22.0
>=20

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline;
	filename="0001-driver-core-platform-Export-platform_get_irq_optiona.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 0f7695c4d3f30b2946c97160b717de03c3deb73f Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Thu, 29 Aug 2019 09:29:32 +0200
Subject: [PATCH] driver core: platform: Export platform_get_irq_optional()

This function can be used by modules, so it needs to be exported.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 014dc07b0056..b6c6c7d97d5b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -194,6 +194,7 @@ int platform_get_irq_optional(struct platform_device *d=
ev, unsigned int num)
 {
 	return __platform_get_irq(dev, num);
 }
+EXPORT_SYMBOL_GPL(platform_get_irq_optional);
=20
 /**
  * platform_irq_count - Count the number of IRQs a platform device uses
--=20
2.22.0


--MGYHOYXEY6WxJCY8--

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ngkUACgkQ3SOs138+
s6FDcBAAv/ED0K5uDmDTXC6R6UUt5I2AwLY3sIuy1Zl6pYWoJw7pjk0071hlLcSm
iPPJraLkVdNR5NQVrRAVTVIdyaGnmMsQzjOmCSiyi4hVrlgo94cSeff8/XWozCDQ
FHmAyz6dKJ7XPdrrzmo0pMJ2MW6uvIy7jtKUQf5tLaAeGyNbec5SGqojbgktBz3f
8DGixdHIKuyf5zNbtCE3hfws0Q9TND+bQj6BW1cpXPzvzqc8RgUCWG2B3pdP5g8g
+matb4hndmPOow8EQEBRDWcjTxxEwck8l7XeFCaeT3Ext916QZQsWTGDX6VtrkWy
gJ1QfNWOX0W8B9KlAF0WJm2NC8rLjCv6DWElfbTAkifYu/lTkE1SrkpuQIwr4CtN
HNXIUIHj4dkwPAiipXQnokac+jJtdhCXczBCshxGn3p0O+4QGiGZkQ+v+i/YnCIF
xmdVVVVYdNmpSvqex4fRO25GkVADS81O1INhFf1mrll4mZLiHY2Y2nvWW2iXjFBT
EiddQoT8hI2ldJjfEuqCMzoIGj+YniSSZ8gBHQfeWhMOJwkxrYjPw7qvONrNc+er
N/VBcuQQmExQSuRF8PD/DAhl3QZDSxN+tXJDBSgDgV3gXADvFNVfjfssomkHGKuN
kKPAGitlE9wZGSOYpdcHwCEdrQk6of87ChXhQDeg2ku8De/UYA0=
=fB2o
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
