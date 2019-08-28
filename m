Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9296C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB13221883
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpkXszfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfH1JcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:32:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43081 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfH1JcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:32:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8so1736932wrn.10;
        Wed, 28 Aug 2019 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8YZMPrk4taIfd9lhqFUp5xwJn0FNidcXhT7fTedt7cc=;
        b=TpkXszfqgchu4JhwM4l26r9kQzmiJ25FKVEV4NRDkanYqou5TF2iXz2qfMLdVgKxc8
         kFUoM5rwlaLnSYpfJgYhffezbf53NAluAXWDX4pZxlGeQQCMnGgQMCbyDDVy+u49+GNi
         6A6pGixrU89g/irZKbir08mxb86Znnu0Nn3RDFHSUyKlLfdhFKYR/kalfdNWelkgmuEX
         5CdmNWfJH2GjPZvW0FOaJPoL+UZqHKLu9+dzCXGbcM5BEbU8D7PJQW+IrmNNe9nosojO
         ECD/zG+ulrxNYTEgNIAhdsAtyq6NykWgKpJfD/oRIaRbgytEOwwl8rkmpwFxDLgfxReE
         rG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8YZMPrk4taIfd9lhqFUp5xwJn0FNidcXhT7fTedt7cc=;
        b=FtHkCVE0wLha+fQh3z2K/HDFyempnIQfSYwbHcuriLYQjmY0E4AwfjymkHUZifpJYD
         Dpvy82xe83WYLGQRXokYt0w/9D3diY+Zg4cFWAfBP3Lj8ZE/xFmh+kcASfy4AL/Xldv5
         /FOhSR8OySTCAwEwT6GQWC9fneMQw1JZG2gNkTyD1RuY2sYw9TL2H3V0AHESaAPSTkd4
         c63WmYh7KYo2HsGrsACUB13GIEYkUBaxMnZD8HHSDKJK1C4rDYHTRafZYewrZGqtpK/T
         k0q7mhDqTLpYW966mJawgwZPZFkMPEG0xVHqoebWJ5zVWG/mhxtEEWE85PXcf2oAJarh
         EtPA==
X-Gm-Message-State: APjAAAUh66BkdBrX/6KCuqVGAWGfX7z4g2mOP0EOo9BY/9oBvyyKsaBF
        Et8zvuqqZLBvf2U1W6GKo371IfHc
X-Google-Smtp-Source: APXvYqzBKn5uq8Z/LSmYy1vCSMHdQAKtE9a0raqpTeuGSXHKKnSz0po7mYOh1BmKRa3SxJCjrM6vWA==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr3400811wrr.318.1566984730627;
        Wed, 28 Aug 2019 02:32:10 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id f10sm1988058wrs.22.2019.08.28.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 02:32:09 -0700 (PDT)
Date:   Wed, 28 Aug 2019 11:32:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: platform: Introduce
 platform_get_irq_optional()
Message-ID: <20190828093208.GC2917@ulmo>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
 <20190828085724.GA31055@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <20190828085724.GA31055@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 10:57:24AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 28, 2019 at 10:34:10AM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > In some cases the interrupt line of a device is optional. Introduce a
> > new platform_get_irq_optional() that works much like platform_get_irq()
> > but does not output an error on failure to find the interrupt.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/base/platform.c         | 22 ++++++++++++++++++++++
> >  include/linux/platform_device.h |  1 +
> >  2 files changed, 23 insertions(+)
> >=20
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 8ad701068c11..0dda6ade50fd 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -192,6 +192,28 @@ int platform_get_irq(struct platform_device *dev, =
unsigned int num)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_irq);
> > =20
> > +/**
> > + * platform_get_irq_optional - get an optional IRQ for a device
> > + * @dev: platform device
> > + * @num: IRQ number index
> > + *
> > + * Gets an IRQ for a platform device. Device drivers should check the =
return
> > + * value for errors so as to not pass a negative integer value to the
> > + * request_irq() APIs. This is the same as platform_get_irq(), except =
that it
> > + * does not print an error message if an IRQ can not be obtained.
>=20
> Kind of funny that the work people did to put error messages in a
> central place needs to be worked around at times :)

Indeed. I think it does make sense in this case to have the error
message in a central place, because it really does seem like the vast
majority of users really do want that IRQ. Having the _optional variant
makes it really explicit in the cases where it's fine to continue
without the IRQ.

> Anyway, I have no objection to this, but it looks like it has to go in
> through my tree.  I can take the hwmon patch as well through my tree if
> the hwmon maintainer(s) say it is ok to do so.

I suppose we could technically make this go through the driver core and
hwmon trees separately with a bit of timing, but the hwmon patch is so
trivial that it would indeed be simplest to take it through the driver
core tree as well.

Thierry

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1mShUACgkQ3SOs138+
s6FNhhAAwVNhp6Fie+ky5QepEPYXddUP7qI5ou4FIufzN/u8+VgqfHNaNuli1BT5
uJgWDNTwyOYVmPCC29QZ+bQpDEauGkkg5bXKaewkp1omnir84EsWRSZfNrR8m24C
T6W4DuGrqNWhvrFeqyZjzqVmcgksUAZ2Uqiy4c8qtSAMGZwRkZxzMwpDnWyLFShB
40OpgxqWCx/GqjJnCwBwlNNI9JqPhblu09znMo9oHXoELubago8/L0R7vfSWmMqN
KBSZ+Qak0vnRWrbVZpKDQTyHgiiNpRQ7M/pmblktEWgwwAH1OJLR9buWwPkePoOE
dJldWRKmbORp7hGkHQSQ8UkdTLfOkEr70WcH73BChPWTIdvPOJ2zkhDFehVoFLkU
SkoNwma5NSvIb4r5xvnVfRWYbKEas1ijO6LeVzMBBsEYoEsXBL04OF7w4waEH+R9
7yBBasVSqdTmDdZXpP69f9kwjS/giwNX29/hq+6FPQNbrWjv7pumKaWQp3FB9K9U
eS4ceCw32/XUyyor2gTSonZg11jHAzTc/GhvS0r6Z+RwJL3Ih90OCfLjYXe8/s+0
ydGtUJSFQv+HX0ZUNWZo5u2il6POcxQuToEQFBw5uxSFysIlK0YcdTlxHqf2aswG
mYuvMvLq7+R5yRm9nHxKZWQQhteQX6mBSIHjLBv3/FQO/NvPUo4=
=u2KZ
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
