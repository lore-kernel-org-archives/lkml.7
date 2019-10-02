Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A8C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EE9218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570048314;
	bh=2WYhvLcVLSMEzXpg5qlewn+Ca793Z6CYPcHmcJoAuKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pqWdGRnzRIqlqggBp19oy90HxuZ8KrFiqxdJOAgttmK/ctSgaJtxTi+8w2PBME7NG
	 uZbVeikEafWU/YcsjFHe2kYNaUJkFbwvN/7+O3G5ogddu3i3XViq/YfAwWIWwKFOZo
	 U/UhdiY8LxYEwOUOL5+zLo6GJClSftaOnAout2tE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfJBUbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfJBUbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:31:53 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9720B21783;
        Wed,  2 Oct 2019 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570048311;
        bh=2WYhvLcVLSMEzXpg5qlewn+Ca793Z6CYPcHmcJoAuKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6lmZ1WgebksVHOrIid4jjR2hrh/DJsATwataRLEwP3tQR66WUfsjG66hsuQZh1Sv
         YFbwIz6byESts5cHB4ZASC+iR57uiiV+t87DgIF/aY4EpCUtLYgIFddeZxT9THgIsR
         HLFTgRuNhJ3fH6UljH5vn0v7wSoco1kJkuLo1V64=
Received: by earth.universe (Postfix, from userid 1000)
        id 11C943C0CA1; Wed,  2 Oct 2019 22:31:49 +0200 (CEST)
Date:   Wed, 2 Oct 2019 22:31:49 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        adam.ford@logicpd.com
Subject: Re: [PATCH] Revert "Bluetooth: hci_ll: set operational frequency
 earlier"
Message-ID: <20191002203149.g22igmfndbve7m3n@earth.universe>
References: <20191002114626.12407-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oce6v5i3llqwjvjc"
Content-Disposition: inline
In-Reply-To: <20191002114626.12407-1-aford173@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oce6v5i3llqwjvjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 02, 2019 at 06:46:26AM -0500, Adam Ford wrote:
> As nice as it would be to update firmware faster, that patch broke
> at least two different boards, an OMAP4+WL1285 based Motorola Droid
> 4, as reported by Sebasian Reichel and the Logic PD i.MX6Q +
> WL1837MOD.
>=20
> This reverts commit a2e02f38eff84f199c8e32359eb213f81f270047.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

This should be backported stable

-- Sebastian

> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 285706618f8a..d9a4c6c691e0 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -621,13 +621,6 @@ static int ll_setup(struct hci_uart *hu)
> =20
>  	serdev_device_set_flow_control(serdev, true);
> =20
> -	if (hu->oper_speed)
> -		speed =3D hu->oper_speed;
> -	else if (hu->proto->oper_speed)
> -		speed =3D hu->proto->oper_speed;
> -	else
> -		speed =3D 0;
> -
>  	do {
>  		/* Reset the Bluetooth device */
>  		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
> @@ -639,20 +632,6 @@ static int ll_setup(struct hci_uart *hu)
>  			return err;
>  		}
> =20
> -		if (speed) {
> -			__le32 speed_le =3D cpu_to_le32(speed);
> -			struct sk_buff *skb;
> -
> -			skb =3D __hci_cmd_sync(hu->hdev,
> -					     HCI_VS_UPDATE_UART_HCI_BAUDRATE,
> -					     sizeof(speed_le), &speed_le,
> -					     HCI_INIT_TIMEOUT);
> -			if (!IS_ERR(skb)) {
> -				kfree_skb(skb);
> -				serdev_device_set_baudrate(serdev, speed);
> -			}
> -		}
> -
>  		err =3D download_firmware(lldev);
>  		if (!err)
>  			break;
> @@ -677,7 +656,25 @@ static int ll_setup(struct hci_uart *hu)
>  	}
> =20
>  	/* Operational speed if any */
> +	if (hu->oper_speed)
> +		speed =3D hu->oper_speed;
> +	else if (hu->proto->oper_speed)
> +		speed =3D hu->proto->oper_speed;
> +	else
> +		speed =3D 0;
> +
> +	if (speed) {
> +		__le32 speed_le =3D cpu_to_le32(speed);
> +		struct sk_buff *skb;
> =20
> +		skb =3D __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
> +				     sizeof(speed_le), &speed_le,
> +				     HCI_INIT_TIMEOUT);
> +		if (!IS_ERR(skb)) {
> +			kfree_skb(skb);
> +			serdev_device_set_baudrate(serdev, speed);
> +		}
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.17.1
>=20

--oce6v5i3llqwjvjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2VCSkACgkQ2O7X88g7
+priwg//WmOF0VYpnbAnBIyU0dH6K9I3h+5P5hx3bKGWzJo5y943l8m5CDt0Egq1
qvsw7K4b9SinxoG7Em1DVbhIEiuExf3bHqeX6tv+VlpFI1tmAPkrkuUPiItV4pRl
mAk142dQaiLNMlQNevvw9bx0lC0T1P2vWrjELRK9IWZWe4HshRhHc2jULBZNuQrP
SpZjEgZ6t6jr3U3NrFIgfHef9A6QClzsDsf8ekPBABsVm3FwJpf/UENsANi0oEE9
QseUbGmu65ROKtP7rRRB3tnlZfklQm71CHVHh6yChqeGLvgLmdvNpzV26v3vb0LH
vpU4Z4wvHUSlN9as1tJGQffzqyoH0E3E/3OrQjYZWIZbQCvU5+CjHiXsbj/Bw48U
cgXSWnXAMtE+1g04Tus2lGrNEAJQiOZcyGvpjaGKVaCbWEFjwQ5k4jUXFSIaVbh+
8rsoeeDkQxDPmWjf5XtVj4mQtDyEZcc4WZ+NoU4gMot4R733Yj29vd/V7AE6YTuT
qP/a1MygeuJ5YmLSpmPmcJ4dUNbVlCUQjBQUPkWeDPIMUdZsEUZmI5fv+f0ltZmJ
OsNccPHJLsfFJ2+s2TRk+XO4RnuQtpTNC+mrQkAQE72y4c3za6Jyhl10InmJ2fvM
Q7iV9O3i5Ovuk77ekTp9c4O6SOARLVEECtJNSglNirRpxhhP69k=
=gWno
-----END PGP SIGNATURE-----

--oce6v5i3llqwjvjc--
