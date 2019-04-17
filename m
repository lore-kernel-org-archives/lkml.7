Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C014C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE80E21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbfDRCf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:35:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57996 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbfDRCfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 22:35:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7E46C260AA7
Received: by earth.universe (Postfix, from userid 1000)
        id 266B63C0985; Wed, 17 Apr 2019 23:56:49 +0200 (CEST)
Date:   Wed, 17 Apr 2019 23:56:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Han Nandor <nandor.han@vaisala.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] power: reset: nvmem-reboot-mode: use NVMEM as
 reboot mode write interface
Message-ID: <20190417215649.ejrvd6zekfmvjtn5@earth.universe>
References: <20190411055341.9263-1-nandor.han@vaisala.com>
 <20190411055341.9263-2-nandor.han@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fcbbndneer5y2eeg"
Content-Disposition: inline
In-Reply-To: <20190411055341.9263-2-nandor.han@vaisala.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fcbbndneer5y2eeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 05:54:09AM +0000, Han Nandor wrote:
> Add a new reboot mode write interface that is using an NVMEM cell
> to store the reboot mode magic.
>=20
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
>  drivers/power/reset/Kconfig             |  9 +++
>  drivers/power/reset/Makefile            |  1 +
>  drivers/power/reset/nvmem-reboot-mode.c | 76 +++++++++++++++++++++++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 drivers/power/reset/nvmem-reboot-mode.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 6533aa560aa1..bb4a4e854f96 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -245,5 +245,14 @@ config POWER_RESET_SC27XX
>  	  PMICs includes the SC2720, SC2721, SC2723, SC2730
>  	  and SC2731 chips.
> =20
> +config NVMEM_REBOOT_MODE
> +	tristate "Generic NVMEM reboot mode driver"
> +	select REBOOT_MODE
> +	help
> +	  Say y here will enable reboot mode driver. This will
> +	  get reboot mode arguments and store it in a NVMEM cell,
> +	  then the bootloader can read it and take different
> +	  action according to the mode.
> +
>  endif
> =20
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 0aebee954ac1..85da3198e4e0 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_POWER_RESET_ZX) +=3D zx-reboot.o
>  obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
> +obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/rese=
t/nvmem-reboot-mode.c
> new file mode 100644
> index 000000000000..816cfdab16a7
> --- /dev/null
> +++ b/drivers/power/reset/nvmem-reboot-mode.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) Vaisala Oyj. All rights reserved.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot-mode.h>
> +
> +struct nvmem_reboot_mode {
> +	struct reboot_mode_driver reboot;
> +	struct nvmem_cell *cell;
> +};
> +
> +static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
> +				    unsigned int magic)
> +{
> +	int ret;
> +	struct nvmem_reboot_mode *nvmem_rbm;
> +
> +	nvmem_rbm =3D container_of(reboot, struct nvmem_reboot_mode, reboot);
> +
> +	ret =3D nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
> +	if (ret < 0)
> +		dev_err(reboot->dev, "update reboot mode bits failed\n");
> +
> +	return ret;
> +}
> +
> +static int nvmem_reboot_mode_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct nvmem_reboot_mode *nvmem_rbm;
> +
> +	nvmem_rbm =3D devm_kzalloc(&pdev->dev, sizeof(*nvmem_rbm), GFP_KERNEL);
> +	if (!nvmem_rbm)
> +		return -ENOMEM;
> +
> +	nvmem_rbm->reboot.dev =3D &pdev->dev;
> +	nvmem_rbm->reboot.write =3D nvmem_reboot_mode_write;
> +
> +	nvmem_rbm->cell =3D devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
> +	if (IS_ERR(nvmem_rbm->cell)) {
> +		dev_err(&pdev->dev, "failed to get the nvmem cell reboot-mode\n");
> +		return PTR_ERR(nvmem_rbm->cell);
> +	}
> +
> +	ret =3D devm_reboot_mode_register(&pdev->dev, &nvmem_rbm->reboot);
> +	if (ret)
> +		dev_err(&pdev->dev, "can't register reboot mode\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id nvmem_reboot_mode_of_match[] =3D {
> +	{ .compatible =3D "nvmem-reboot-mode" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, nvmem_reboot_mode_of_match);
> +
> +static struct platform_driver nvmem_reboot_mode_driver =3D {
> +	.probe =3D nvmem_reboot_mode_probe,
> +	.driver =3D {
> +		.name =3D "nvmem-reboot-mode",
> +		.of_match_table =3D nvmem_reboot_mode_of_match,
> +	},
> +};
> +module_platform_driver(nvmem_reboot_mode_driver);
> +
> +MODULE_AUTHOR("Nandor Han <nandor.han@vaisala.com>");
> +MODULE_DESCRIPTION("NVMEM reboot mode driver");
> +MODULE_LICENSE("GPL v2");

I suppose as of bf7fbeeae6db "GPL v2" is deprecated, before it was
often read as GPL v2 only. In both cases it makes sense to just
use "GPL". Otherwise the driver looks fine to me, but I'm waiting
for Rob's review of the DT bindings before merging this.

-- Sebastian

--fcbbndneer5y2eeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly3oR0ACgkQ2O7X88g7
+pqQqA//TtgCVsWgzSVRHdGqQGgMQVbza8ej172YepxnzqwpQpzEYGQ6nuX69F2l
wC2i4Spxj+0in0ckEm/oPbQO8yIjwQRKs07Frj2NCPzvsv9p6Y9SQYbu4HLWcF8A
FFjQYllOdFR6T0ORRC0iVKADzVwKIoPXItEeVK7QVZxBF+Z7WhJj2L+LHtNcEyaQ
jUV5WKcCbbLOh83t9+SkrD2K8iR6qq2AVLsPHT4Jnmjez0lGOe07jVRDVAv0PMq3
ChRIs60bYb2wdRy82CtEiBDUymS4pXX6BQVpLLKf3tnf4vE2QhAC59zDhVa/58h7
/bFnrV/bsf0iVaeGIIngrHt4byRfAyx8nRVf6Wl/2hn8V4mtRdPdmy5G7EfvNkBq
HawK4jGh/2Krnp3T+NuJEgmvZ7gx+ZhLlok8Pwrh62FO/2F6fluVXcpcmaD49xkE
y3EC8U+7+YV/kUk9YCiTIliGWetsO0pUFsn23Qj8NwJD0vg83p4AlKGlO/NCYZzj
k25OO9IWRCIyRJKMwMqQziTTdKoLs6ja2g9dNeiw0kdfU3pE0Y1jg1H4R1KpNMuQ
G6XYq7ibBPm7F7Qd+47e1qKQXyaROze/eckokN/E3tYnZoKIERJjkA8R91nlIRl8
C1pU2CuO2QU65NIz9RcUHED558LpjfWnHwsOylowHZc3eD/PvN0=
=tI3H
-----END PGP SIGNATURE-----

--fcbbndneer5y2eeg--
