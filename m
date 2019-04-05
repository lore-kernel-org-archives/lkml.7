Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76136C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36696218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554472839;
	bh=fsh/4e2YUoJ6mxG6gKftsBN+3Zc6eKt4TFqmWvOthcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FkDTFY3JjUu0EjL7K1aN6LVYVWwgY9aoKd2BBVvQPCvXCgY1gzBQbWdqbUCvhIsJl
	 SiGH0IbPDEyGfMJnDwZJ1lM/YjDH5vRiOsQ0+G24yLXtitqsTkxDkc3i/AnmAbsmj+
	 JUbpIDhm6s9jb2IyK5pfd0uw6AU49HCCrr7LqXDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfDEOAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbfDEOAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:00:33 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB382186A;
        Fri,  5 Apr 2019 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554472833;
        bh=fsh/4e2YUoJ6mxG6gKftsBN+3Zc6eKt4TFqmWvOthcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFVGo5jsv7v2QhLvHC/FSjMhlrVL6lTv6MuFrA84ZpKo3+wGkVynXaTSXlYlmt/mL
         W45RXFcB8RZyiPPV60XkZB6SYttSYBZZEe5FIQ8sAkNw18BL8zVp7py9BafognDX58
         dQhv9UkAk6YSIR55+9g1P9goOt9XpwlLjx2NgF8M=
Received: by earth.universe (Postfix, from userid 1000)
        id 30ACF3C08D5; Fri,  5 Apr 2019 16:00:31 +0200 (CEST)
Date:   Fri, 5 Apr 2019 16:00:31 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: charger-manager: fix a potential NULL pointer
 dereference
Message-ID: <20190405140031.6u35e5jd56aqms6o@earth.universe>
References: <20190314060247.7848-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tkl3ivocftthn6sa"
Content-Disposition: inline
In-Reply-To: <20190314060247.7848-1-kjlu@umn.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tkl3ivocftthn6sa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 14, 2019 at 01:02:47AM -0500, Kangjie Lu wrote:
> In case create_freezable_workqueue fails, the fix return -ENOMEM
> to avoid a potential NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 38be91f21cc4..d29c4f338157 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1987,6 +1987,9 @@ static struct platform_driver charger_manager_drive=
r =3D {
>  static int __init charger_manager_init(void)
>  {
>  	cm_wq =3D create_freezable_workqueue("charger_manager");
> +	if (unlikely(!cm_wq))
> +		return -ENOMEM;
> +
>  	INIT_DELAYED_WORK(&cm_monitor_work, cm_monitor_poller);
> =20
>  	return platform_driver_register(&charger_manager_driver);
> --=20
> 2.17.1
>=20

--tkl3ivocftthn6sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynX34ACgkQ2O7X88g7
+pqT4w//bt8j4QXMjCoJjbStIlmi1jhU7Zq0fcOE/O0PkQyArTOnQJ5cyvnvoDGv
UfcaxNBLas4M1YXXVHZT7cp1GyZI21s/e0dPXvTNxpqd4SkipcdYGtRgkvj1s3yN
+0Olt8vuomRr48a825+5sGL55tXCXJfOe9T5M8GGxvv4urNcy+U2JaO0pidnWZi0
cmVQ0oCRXiqFh24xfwpwJ0AB0O+yIpxqcXEXwTJ6F1nOXrEe+LpgSHginyCDET3s
dvaiDBuYk6d36ZCmsN3rz80LE0jz6m9rZd0iVGi2jVACbSFgPvYlgJmJA8n3Hn+8
yBp2VcHqUrRLGFeLykLSxIRHd1Ahrtugmkn4eH4S920BhqqIdL1esVvnxRtQ7sce
feIrzAPTNpVzS3O38CDExWEQrg9BCLnv6A+6QS3T/ediYH4p1agZSKXQluKIU4gq
niS8142knFXQ2xCNBm8Np44ahjCwftjJ6pAH994fqTvF6kRQ6b5GgiUzjV16EL+i
zdkS75qeNgOcbCrJEUgMcpa76Gk3/Mys5pA+2mq4qxWvejMH9Z2daL8N3zsPZ+Kp
mqImJqaDMiLeQP6srTkuDrUHKQBAuDi+/mgrqLYUNw5HQnq/rDAHnUWvjN1puCDW
FDoMlUlyy2U9o8O/KJjUvdeZX4Ts/OKU/FZOqRQLlTy5SKXV+ks=
=u5jE
-----END PGP SIGNATURE-----

--tkl3ivocftthn6sa--
