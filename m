Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0C3C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC56121726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1BV+/Sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfH3IP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:15:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33324 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3IPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:15:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so6060405wrr.0;
        Fri, 30 Aug 2019 01:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3EOOFYn612pmlMywCbGSgza1tgRqpUPGtojj8ut2Cu8=;
        b=V1BV+/SlWdPMHvYu3Fegj2KQVK/fAKI2n3SkLvKcFqUYkjiFKKWaQMqykT+TihOLvn
         F6RfwtGXGhkra7K0G8cYNIHXhtsJ2xBihFVZZtq7Avu2PQfoPlYjBpBetXrUsIxbuOn/
         wX34qBKC1pcugvZzPeEcvntW+un1kCXXMtDDPAGhL5SUChDdfBNN2lYEgHGIJ6WihLPQ
         djzrgJ4YCx4qYXBSBRUOOFpHwKYi3QChNgR9zmpjBtoLCaQos46UiXGKJwzQk3cmsQhS
         mFWojDE6Zf7zvppXSUcILOzRlN4s0R+qc+v09H1aYuX2z1Xpt7mEwMh7wMJ+e8/YJcxS
         UIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3EOOFYn612pmlMywCbGSgza1tgRqpUPGtojj8ut2Cu8=;
        b=uKeARXbZ5J7v+HCHSt79NGL6Dr2U5gAc8jTvuCvoAmx8oADUswUTotP1gCEdc7/nVR
         S6gJnrYTjYbUgyN1MAEwRcZ62g3y0+frF2WvjrLh9pBFN5an7jNE+qTL9wwuUjHgpzO/
         /aXRXY/f5BG9GVvP9IgqsXINIIohMlg28WTdPuoizAyJeAG+gZo6G+npkXIj89JgOcpX
         hIjBJEUo2pXU3KzCYrRgNst0wBoRw9YIjj6BQbxYWZOR2JiB6XNOQEOib7VsmxFkJsuE
         MHqyLULGwi63OzIK+zcffRMaWY9XOZQlGrAan2mEGuLdI1T3JYVaTCMY96aok0xYdhC2
         lDdg==
X-Gm-Message-State: APjAAAXOaVmd7d1+wVtigzwuDz9PC600b1Zpp9sIKGH3T8CD5sDhzgJ1
        pclJzGkkN4/udT75HTlP6Ks=
X-Google-Smtp-Source: APXvYqyLSIHb45lOIWQ8szFMaTfucy3ZKbqtifqqKTtcmu3xaZWMEbn3f7odUWDHcc1XgHUt6BZKtw==
X-Received: by 2002:a5d:6444:: with SMTP id d4mr10948303wrw.322.1567152952852;
        Fri, 30 Aug 2019 01:15:52 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id p190sm4925408wme.46.2019.08.30.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 01:15:51 -0700 (PDT)
Date:   Fri, 30 Aug 2019 10:15:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 0/4] regulator: add and use a helper for setting supply
 names
Message-ID: <20190830081550.GA25502@ulmo>
References: <20190830071740.4267-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20190830071740.4267-1-brgl@bgdev.pl>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 09:17:36AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> There are ~80 users of regulator bulk APIs that set the supply names
> in a for loop before using the bulk helpers.
>=20
> This series proposes to add a helper function for setting supply names
> and uses it in a couple tegra drivers. If accepted: a coccinelle script
> should be easy to develop that would address this in other drivers.
>=20
> Bartosz Golaszewski (4):
>   regulator: provide regulator_bulk_set_supply_names()
>   ahci: tegra: use regulator_bulk_set_supply_names()
>   phy: tegra: use regulator_bulk_set_supply_names()
>   usb: host: xhci-tegra: use regulator_bulk_set_supply_names()
>=20
>  drivers/ata/ahci_tegra.c           |  6 +++---
>  drivers/phy/tegra/xusb.c           |  6 +++---
>  drivers/regulator/helpers.c        | 21 +++++++++++++++++++++
>  drivers/usb/host/xhci-tegra.c      |  5 +++--
>  include/linux/regulator/consumer.h | 12 ++++++++++++
>  5 files changed, 42 insertions(+), 8 deletions(-)

The diffstat here suggests that this isn't really helpful. Even if you
subtract the regulator code that adds the new helper, you actually have
a zero diffstat (and a positive one in one case).

Instead, why don't we take this one step further and roll a bit more of
the boilerplate into the new helper, something along these lines:

	struct regulator_bulk_data *
	devm_regulator_bulk_get_from_names(struct device *dev,
					   const char * const *supply_names,
					   unsigned int num_supplies)
	{
		struct regulator_bulk_data *data;
		unsigned int i;
		int err;

		data =3D devm_kcalloc(dev, num_supplies, sizeof(*data));
		if (!data)
			return ERR_PTR(-ENOMEM);

		for (i =3D 0; i < num_supplies; i++)
			data[i].supply =3D supply_names[i];

		err =3D devm_regulator_bulk_get(dev, num_supplies, data);
		if (err < 0)
			return ERR_PTR(err);

		return data;
	}

That seems to be still a very common pattern and gets rid of a lot more
boilerplate, so your diffstat will actually start to be negative at some
point.

I suppose one could add a non-managed variant for this as well, but I'm
counting 6 uses of regulator_bulk_get() vs. ~140 uses of the managed
variant, so I'm not sure it's worth it.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1o2zQACgkQ3SOs138+
s6E4FQ//bIrTrh6mYLEypci9Lz5fy/h9qh0mbcgfmUz43e3u1ktpwr3hcfLjOZPv
9kJgsZQr7bqtL4BnAsVDfij55LZhxIkjLi2asNMZVvnjA4yZUzr/TaEJm/OX0G2T
1uTSRQtSfKAriNsIgpuvHbZYHWjeGj9I7VeQfN44PiJbpSYdm18PPIj3MpNNYTua
RW0I4rohY/LuKzZDrbAJm2fT2/QnOpawezs15J1HNOchXtXx3wP+jEis464B67ty
TH0I257uMsCaSjDaBj7mgty7bCXxsnNwdCiCSpzZszbdiKizKgYdvO3unjo6M3k6
ym85mff7D/5OWUzS9va821TOyzhAawYdZdkV0dmzizB+fi94B3/07aP3qbZ1IJNW
2qTADamv94WL/hx8UfCuXAq4Jk7Vh95q5aNH+JCuN58C0L5gl67Ne42xGL2S0spG
iTqE2Nf0Goa7wstt45oktH3Min8aHWeC/7jfVQUlvHpnaI5DawISv4T3pmqDNVOm
78ItwJ3QyHzqan2eFsqS56aRaWdI6N8YfZ4iZWFjYDQGoxTEy5gBwSjK09DZeqR8
ApOGkJHj56MkHI1Mv04dsxsswTCIHpP9N6dGf8gwi8D/GdtURtsmT0yf/c1nV7E3
I7+779qe0fvv9DMHIGIUp/OgumL70GLq+LeJ6HH3N6YHaSwWJRs=
=Cngb
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
