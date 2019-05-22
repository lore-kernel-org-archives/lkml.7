Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144E1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D406021841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjFCBLs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfEVNYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:24:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfEVNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:24:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so2302007wrv.2;
        Wed, 22 May 2019 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a4JBStCcSZC4v0Q51f4UGvVDbTYVZbXrg5o7Yfs72tw=;
        b=tjFCBLs4VCFoQspPTBklAZxOg1zTMohdRF6b3Ybz4R0OIlg7ieqtmqU6PKhUw2NFdw
         pQzj6SAMk77H5DpPmyPSDAq1rLtZIujN8ErBDIgJl9UxI9D+3TtCTLKLIdASjdHLxHKx
         dHullA3i68cDPI4o+IATreD8JCoUs2eAfwrRdm4DtQ5Y5szlGpU3KXBhvRyLdmyk1mBi
         ZspFom/vebb7Q+1UMW1ZPHzJHGsGq/SD1P8gMk7RW/xjG5zogVMSW0UtJyaXym57JIFX
         RrxP+p9g60VMHTzgiLmPe92B+8TVK5ebGIYwTwvxorZXw4H1AD1OAv915w1mD+I5JsWs
         QwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4JBStCcSZC4v0Q51f4UGvVDbTYVZbXrg5o7Yfs72tw=;
        b=REWTXGI4w0FYFzakhFmDp8haVcNpqysj8O88T/D8ceD7Y1TsTGs61ssKmAVNT2lAc1
         cz7a4aFnpyBT2NPIn7qRAlWU5KkNFoSAjWVJvWhyV3CU2j1B7jjnUmwv/xPHjNyhugPg
         0SEfdHPKilQd17/iNGj+LTT3S6lbhZerp9YOWGXyftJEuqAqw3J3xBeHc9OS0DQnLx+g
         2K7sLEE9TXJJtgjm2eirti4qjFjP7+U+Cn+zfCFlUEvftlrfH2yZu2Vb6VM2J4txeQBW
         +I//G+r7bQBjECPiRBACwa4rQ+v33Sex6iNcSTH05NiJ/lMNiz8M7T/v4DFLI8y09eKe
         AQyQ==
X-Gm-Message-State: APjAAAW2fUKsBVnCCjP+i7tBRrlOWXTCQOzpWF2Sq1YOCTydpIHsXR58
        aPcSn6oCsZ+p/ZDbY1aYnkA=
X-Google-Smtp-Source: APXvYqzUeF0lFDRFrXPXN9JFJusI6NdigE6jSBgERTEp8G1tIf5DsJl8uPkylwnXzmKUvgdDMK3vbw==
X-Received: by 2002:adf:ce89:: with SMTP id r9mr6362559wrn.300.1558531455728;
        Wed, 22 May 2019 06:24:15 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id i125sm11765781wmi.2.2019.05.22.06.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:24:14 -0700 (PDT)
Date:   Wed, 22 May 2019 15:24:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 10/12] gpio: tegra: implement wake event support for
 Tegra210 and prior GPIO
Message-ID: <20190522132413.GL30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-11-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yaPAUYI/0vT2YKpA"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-11-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yaPAUYI/0vT2YKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:21PM -0700, Sowjanya Komatineni wrote:
> The GPIO controller doesn't have any controls to enable the system to
> wake up from low power states based on activity on GPIO pins. An extra
> hardware block that is part of the power management controller (PMC)
> contains these controls. In order for the GPIO controller to be able
> to cooperate with the PMC, obtain a reference to the PMC's IRQ domain
> and make it a parent to the GPIO controller's IRQ domain. This way the
> PMC gets an opportunity to program the additional registers required
> to enable wakeup sources on suspend.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra.c | 109 ++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 103 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index 6d9b6906b9d0..d57e33050d0c 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -32,6 +32,8 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pm.h>
> =20
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
>  #define GPIO_BANK(x)		((x) >> 5)
>  #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
>  #define GPIO_BIT(x)		((x) & 0x7)
> @@ -275,8 +277,22 @@ static int tegra_gpio_set_config(struct gpio_chip *c=
hip, unsigned int offset,
>  static int tegra_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct tegra_gpio_info *tgi =3D gpiochip_get_data(chip);
> +	struct irq_domain *domain =3D tgi->irq_domain;
> +
> +	if (!gpiochip_irqchip_irq_valid(chip, offset))
> +		return -ENXIO;
> +
> +	if (irq_domain_is_hierarchy(domain)) {
> +		struct irq_fwspec spec;
> +
> +		spec.fwnode =3D domain->fwnode;
> +		spec.param_count =3D 2;
> +		spec.param[0] =3D offset;
> +		spec.param[1] =3D IRQ_TYPE_NONE;
> +		return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec);
> +	}
> =20
> -	return irq_find_mapping(tgi->irq_domain, offset);
> +	return irq_find_mapping(domain, offset);
>  }
> =20
>  static void tegra_gpio_irq_ack(struct irq_data *d)
> @@ -365,7 +381,10 @@ static int tegra_gpio_irq_set_type(struct irq_data *=
d, unsigned int type)
>  	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>  		irq_set_handler_locked(d, handle_edge_irq);
> =20
> -	return 0;
> +	if (d->parent_data)
> +		return irq_chip_set_type_parent(d, type);
> +	else
> +		return 0;

Why is this needed?

>  }
> =20
>  static void tegra_gpio_irq_shutdown(struct irq_data *d)
> @@ -566,10 +585,79 @@ static const struct dev_pm_ops tegra_gpio_pm_ops =
=3D {
>  	SET_SYSTEM_SLEEP_PM_OPS(tegra_gpio_suspend, tegra_gpio_resume)
>  };
> =20
> +static int tegra_gpio_irq_domain_translate(struct irq_domain *domain,
> +					   struct irq_fwspec *fwspec,
> +					   unsigned long *hwirq,
> +					   unsigned int *type)
> +{
> +	if (WARN_ON(fwspec->param_count < 2))
> +		return -EINVAL;
> +
> +	*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> +	*hwirq =3D fwspec->param[0];
> +
> +	return 0;
> +}
> +
> +static int tegra_gpio_irq_domain_alloc(struct irq_domain *domain,
> +				       unsigned int virq,
> +				       unsigned int num_irqs, void *data)
> +{
> +	struct tegra_gpio_info *tgi =3D gpiochip_get_data(domain->host_data);
> +	struct irq_fwspec *fwspec =3D data;
> +	struct irq_fwspec spec;

You can put the above two lines onto a single line.

> +	struct tegra_gpio_bank *bank;
> +	unsigned long hwirq;
> +	unsigned int type;
> +	int err =3D 0;
> +
> +	if (WARN_ON(fwspec->param_count < 2))
> +		return -EINVAL;
> +
> +	if (!irq_domain_get_of_node(domain->parent))
> +		return -EINVAL;

Can this ever fail?

> +
> +	err =3D tegra_gpio_irq_domain_translate(domain, fwspec, &hwirq, &type);
> +	if (err)
> +		return err;
> +
> +	bank =3D &tgi->bank_info[GPIO_BANK(hwirq)];
> +	err =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> +					    &tgi->ic, bank);
> +
> +	if (err < 0)
> +		return err;
> +
> +	spec.fwnode =3D domain->parent->fwnode;
> +	spec.param_count =3D 3;
> +	spec.param[0] =3D GIC_SPI;
> +	spec.param[1] =3D fwspec->param[0];
> +	spec.param[2] =3D fwspec->param[1];
> +
> +	return irq_domain_alloc_irqs_parent(domain, virq, 1, &spec);

What if num_irqs is different from 1? I'm not exactly sure what to pass
as &spec, but likely we'd have to create an array of struct irq_fwspec
and pass that along. It seems like some drivers catch that case and
refuse to work rather than pass potentially rubbish information along.
See for example drivers/irqchip/irq-meson-gpio.c.

> +}
> +
> +static const struct irq_domain_ops tegra_gpio_irq_domain_ops =3D {
> +	.translate =3D tegra_gpio_irq_domain_translate,
> +	.alloc =3D tegra_gpio_irq_domain_alloc,
> +};
> +
> +static const struct of_device_id tegra_pmc_of_match[] =3D {
> +	{ .compatible =3D "nvidia,tegra210-pmc" },
> +	{ .compatible =3D "nvidia,tegra132-pmc" },
> +	{ .compatible =3D "nvidia,tegra124-pmc" },
> +	{ .compatible =3D "nvidia,tegra114-pmc" },
> +	{ .compatible =3D "nvidia,tegra30-pmc" },
> +	{ .compatible =3D "nvidia,tegra20-pmc" },
> +	{ }
> +};
> +
>  static int tegra_gpio_probe(struct platform_device *pdev)
>  {
>  	struct tegra_gpio_info *tgi;
>  	struct tegra_gpio_bank *bank;
> +	struct device_node *np;
> +	struct irq_domain *parent_domain =3D NULL;
>  	unsigned int gpio, i, j;
>  	int ret;
> =20
> @@ -612,8 +700,15 @@ static int tegra_gpio_probe(struct platform_device *=
pdev)
>  	tgi->ic.irq_set_type		=3D tegra_gpio_irq_set_type;
>  	tgi->ic.irq_shutdown		=3D tegra_gpio_irq_shutdown;
>  #ifdef CONFIG_PM_SLEEP
> -	tgi->ic.irq_set_wake		=3D tegra_gpio_irq_set_wake;
> +	tgi->ic.irq_set_wake		=3D irq_chip_set_wake_parent;

This doesn't seem right. What about tegra_gpio_irq_set_wake()? If it's
no longer needed, just remove it. But then, what about the extra logic
in that function that causes the interrupts to be enabled during
suspend? Is that no longer necessary? Maybe that's no longer needed on
Tegra210, but what about other Tegra generations?

Thierry

>  #endif
> +	np =3D of_find_matching_node(NULL, tegra_pmc_of_match);
> +	if (np) {
> +		parent_domain =3D irq_find_host(np);
> +		of_node_put(np);
> +		if (!parent_domain)
> +			return -EPROBE_DEFER;
> +	}
> =20
>  	platform_set_drvdata(pdev, tgi);
> =20
> @@ -625,9 +720,11 @@ static int tegra_gpio_probe(struct platform_device *=
pdev)
>  	if (!tgi->bank_info)
>  		return -ENOMEM;
> =20
> -	tgi->irq_domain =3D irq_domain_add_linear(pdev->dev.of_node,
> -						tgi->gc.ngpio,
> -						&irq_domain_simple_ops, NULL);
> +	tgi->irq_domain =3D irq_domain_add_hierarchy(parent_domain, 0,
> +						   tgi->gc.ngpio,
> +						   pdev->dev.of_node,
> +						   &tegra_gpio_irq_domain_ops,
> +						   &tgi->gc);
>  	if (!tgi->irq_domain)
>  		return -ENODEV;
> =20
> --=20
> 2.7.4
>=20

--yaPAUYI/0vT2YKpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlTXoACgkQ3SOs138+
s6HrchAArpxYmrjI7qy7yEaDqPo0KASXMR+eUjyS0BudrNh7swJNlIhBTGLSRaaI
r4i9RQl7Tt8nTKKam9NrA3WmtJg/dZO/tOS/zL8HvywdZBCVspzMbox0TZVb/gE2
C5RrncjWL3gjEsS+AkF/VH1a8BuFkrW41pPhhPE1HhU8brZSP4u8Y4mbNwQ+PUXO
KTBeUqQ3WdJ8c9RRxPxzHCNjrWDP5l5WLfLA956XKya2+yxAa4DAiB/vaxBPl2H8
cE57QSECDghHr6uxyXHKqs0BYJvr5Xib6AV+3FrCAU9uQoui3HRjAPuoZP9jTtPU
738yKruQNwqCa+sFV0cGHF4rSdOs0JraEvu1SX4jtowshyQZR94iu3bGiXKRP5ta
SBiQXPjgDufMuNhEKJPhhJTcIPfIDcVNsu4ZhDTehHxzJBYluhHvAEa4guNDNUn/
OWpr7MDoHNpgPzG8DCTcwEZJA7CMXsTSWZYOukPeAHJbGRLy4GFlOGZb+5uAzkQH
CvReaKQjY6Wp0KFWdvpxFVJp48i0giF7xcylw7nIJnLx8UdZE7XANakEVtj1DhT1
mdr/dY9MAi+E/W/qNU1+CKN8TaJN1kGZ9rF6iDeUVqS3rYFRU1XSLlWbBB4CPKUQ
qmJ9c0RxlTcT61L0rrJPKxcVqdXMXh9rAtyY3+AT1zUdSlBgAqM=
=HHsq
-----END PGP SIGNATURE-----

--yaPAUYI/0vT2YKpA--
