Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3CC3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719E623429
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567411247;
	bh=L83zCSB1qiwTYwMO95Zsb92WohQS4er/qeMOyrCaEvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xhALK+1TtM11cMG+3sfmtMcpgwhaGdcYSAHrqeSpO11cUhuG5LCfXefEm631hnS3G
	 6+A0aa+xRVxaGMUgwmm8MYjKSCN/F/WRthxe6vfUtBm6jp867CjP0mnHMZ9OF/EsdY
	 7GxJ0WnXsrk2bntfbQSA10C3SwRXGKhftK97VDA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfIBIAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfIBIAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:00:46 -0400
Received: from earth.universe (dyndsl-091-096-044-124.ewe-ip-backbone.de [91.96.44.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DA122CF7;
        Mon,  2 Sep 2019 08:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567411245;
        bh=L83zCSB1qiwTYwMO95Zsb92WohQS4er/qeMOyrCaEvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npha/fxKlCxSrpKAu0q7t6vulPXDDZwH1O7a/jwXEwqLgNwoQUD+DyNsFTsCY8NJj
         DL2Ek58sfD2J6glEz8zMNVmSC3sjqLzn6y2gajXHNtH4IB1ngez5w3DiAiL+fheqQZ
         32EuL94JEk+H7L9mArHt/EQxmqgd/sWEeRXlyep4=
Received: by earth.universe (Postfix, from userid 1000)
        id 4216C3C0B7F; Mon,  2 Sep 2019 10:00:43 +0200 (CEST)
Date:   Mon, 2 Sep 2019 10:00:43 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] power: supply: Init device wakeup after device_add()
Message-ID: <20190902080043.nx7rqf32fv7w6eoy@earth.universe>
References: <20190801213330.81079-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fcu4abygg3rqtqkb"
Content-Disposition: inline
In-Reply-To: <20190801213330.81079-1-swboyd@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fcu4abygg3rqtqkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 01, 2019 at 02:33:30PM -0700, Stephen Boyd wrote:
> We may want to use the device pointer in device_init_wakeup() with
> functions that expect the device to already be added with device_add().
> For example, if we were to link the device initializing wakeup to
> something in sysfs such as a class for wakeups we'll run into an error.
> It looks like this code was written with the assumption that the device
> would be added before initializing wakeup due to the order of operations
> in power_supply_unregister().
>=20
> Let's change the order of operations so we don't run into problems here.
>=20
> Fixes: 948dcf966228 ("power_supply: Prevent suspend until power supply ev=
ents are processed")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>                      =
                                                                           =
                    =20
> Cc: Tri Vo <trong@android.com>                                           =
                                                                           =
                      =20
> Cc: Kalesh Singh <kaleshsingh@google.com>     =20
> Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Thanks, queued.

-- Sebastian

>=20
> See this thread[1] for more information on how this will be necessary.
>=20
> [1] https://lkml.kernel.org/r/20190731215514.212215-1-trong@android.com
>=20
>=20
>  drivers/power/supply/power_supply_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 82e84801264c..5c36c430ce8b 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1051,14 +1051,14 @@ __power_supply_register(struct device *parent,
>  	}
> =20
>  	spin_lock_init(&psy->changed_lock);
> -	rc =3D device_init_wakeup(dev, ws);
> -	if (rc)
> -		goto wakeup_init_failed;
> -
>  	rc =3D device_add(dev);
>  	if (rc)
>  		goto device_add_failed;
> =20
> +	rc =3D device_init_wakeup(dev, ws);
> +	if (rc)
> +		goto wakeup_init_failed;
> +
>  	rc =3D psy_register_thermal(psy);
>  	if (rc)
>  		goto register_thermal_failed;
> @@ -1101,8 +1101,8 @@ __power_supply_register(struct device *parent,
>  	psy_unregister_thermal(psy);
>  register_thermal_failed:
>  	device_del(dev);
> -device_add_failed:
>  wakeup_init_failed:
> +device_add_failed:
>  check_supplies_failed:
>  dev_set_name_failed:
>  	put_device(dev);
> --=20
> Sent by a computer through tubes
>=20

--fcu4abygg3rqtqkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1szCsACgkQ2O7X88g7
+poKTg/+PPMWnxzv7N42HIkbJcOljQK+Bkv98IuSroLz7Sg3wsA07untO69B+e+A
xZLwbmJo7hPCpBFyCIlN+LRSrvFPwpdbUKJiSpfkuUWMe/9hUhBSupZWftJbrz8H
5BSBBxeXdNwULTZ/8Dg2j3I/0udexWUFxpUVSPTjzJrGXgNqY0P49957G6E5N4VE
ul7HdgnkAqzo/cfrLn03WOOZbEstgni41hpj6cvtgC2CiZwDjaZK6+oNboIBYHZl
HlvJMezAV2YaAnPwteNm2B4wDlQ83AjcUpPH0EkmuqlQr2Iq9zEuXO9/NjZeMKUK
S7YHGj170r2IQRUjG1J1hGAbrWF5Xc1KgQMvdXM95eQP9aGrYzP/AzoRrOUpD1A4
OOyG6PPHIfQ72jM5UiTDrWPhygLasvWPW6lPTu3xFQbwZ4lPUg63d0F6QicvBjl+
a43tZJUeIjs/7mR8KM7A88FqOTu+NcR6JbDeJvnPiogBF3V+rrJ2AJL+hdHwSBn1
xcMYoxz4p9Su/vdSV4baOpx0zEFDThXl7iIKiqH8xpIe8vqlYQRg8XsD4dRJYHZ4
49QwK0l7ykeoM/jB7V9tj3pZ/OC2KA6NxBI76z3kgsuPSe5CqNexQfeKU6zT+VCe
3o46oe3ZBCI9/Ehipnk28FE1y6KuZf+z9akmtbyWiVCA0ntdUWY=
=XWqr
-----END PGP SIGNATURE-----

--fcu4abygg3rqtqkb--
