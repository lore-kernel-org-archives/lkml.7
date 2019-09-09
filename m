Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FCCC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC152067B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404588AbfIIMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:00:53 -0400
Received: from orion.archlinux.org ([88.198.91.70]:59340 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404562AbfIIMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:00:53 -0400
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id D3433153D5647D;
        Mon,  9 Sep 2019 12:00:50 +0000 (UTC)
Received: from saetre (unknown [154.53.1.40])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Mon,  9 Sep 2019 12:00:50 +0000 (UTC)
Message-ID: <80785df1c804796a01bbfbae4b2aeda66f30d7c5.camel@archlinux.org>
Subject: Re: [PATCH v5] hid-logitech-hidpp: read battery voltage from newer
 devices
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     Pedro Vanzella <pedro@pedrovanzella.com>,
        linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190831175659.7404-1-pedro@pedrovanzella.com>
References: <20190831175659.7404-1-pedro@pedrovanzella.com>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-j/3msCg/E48w4jA/Rc1b"
Date:   Mon, 09 Sep 2019 13:00:49 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.32.4 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j/3msCg/E48w4jA/Rc1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-08-31 at 13:56 -0400, Pedro Vanzella wrote:
> +static int hidpp20_battery_map_status_voltage(u8 data[3], int
> *voltage)
> +{
> +	int status;
> +
> +	switch (data[2]) {
> +	case 0x00: /* discharging */
> +		status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	case 0x10: /* wireless charging */
> +	case 0x80: /* charging */
> +		status =3D POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case 0x81: /* fully charged */
> +		status =3D POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	default:
> +		status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	}
> +
> +	*voltage =3D get_unaligned_be16(data);
> +
> +	return status;
> +}

Here's the missing specification:

+--------+-----------------------------------------------------------------=
--------+
|  byte  |                                    2                            =
        |
+--------+--------------+------------+------------+----------+----------+--=
--------+
|   bit  |     0..2     |      3     |      4     |     5    |     6    |  =
   7    |
+--------+--------------+------------+------------+----------+----------+--=
--------+
| buffer | chargeStatus | fastCharge | slowCharge | critical | (unused) | e=
xtPower |
+--------+--------------+------------+------------+----------+----------+--=
--------+
Table 1 - battery voltage (0x1001), getBatteryInfo() (ASE 0), 3rd byte

+-------+--------------------------------------+
| value |                meaning               |
+-------+--------------------------------------+
|   0   | Charging                             |
+-------+--------------------------------------+
|   1   | End of charge (100% charged)         |
+-------+--------------------------------------+
|   2   | Charge stopped (any "normal" reason) |
+-------+--------------------------------------+
|   7   | Hardware error                       |
+-------+--------------------------------------+
Table 2 - chargeStatus value

I know this is already on the 5th revision but could you please change
hidpp20_battery_map_status_voltage() to properly handle the 3rd byte?
Also, if you could make sure those values are properly exported via
sysfs it would be great! We will need them for proper upower support.

Sorry for not saying this in my first review. Since then I have done
some testing and I discovered that if we want to get accurate upower
support we will need the values exposed by the 3rd byte to be
exported properly.

I am not sure about the endianness of chargeStatus but you can find
that easily.=20

Thank you!
Filipe La=C3=ADns

--=-j/3msCg/E48w4jA/Rc1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl12PukACgkQ+JPGdIFq
qV1jwg/9EttPOy1N0SJoxbvOgCYvj1PjcdoeWtCWBQJFM9Ng3pCg4yIn3yrwktYL
XD5/VkorQzmbigfGmsL1u0E/CMnvWgJHHyX2b3iwIXUFrBgTWjLE5JJv3ZWjYduV
xR6TzdRiePQiFEWPWqWp8OZ/DN/wG1b3jO91y50yxfsJzfkziSoUCYwlrB9Km+YU
eCh+7PZFZRm4Vrp3fkhDK/lhNaUHRpwR9c/UPzsdBHjf+WmE8uxggRE5wRhmKFnA
So85IpNKmBiTshIC9f0kJuFjck2QExVf45oSaxTPIOcd1khKbsIpLcvCVY8MpLK8
iShsuPae+rHYVF+XUZzQS/SgeSYQzkWEzFzYm+l5IVFRoQCju7UcoOWGKApMyldV
dS6CHEWviOFI83CttNr4fUYpoTNTnQS3ysYfTBXYd6cFB7Kbp4T0EK30fv/f3meC
JYBXmIEafzjk9wm3pqBBufNtKHr/ONEuTPphgeWZK9SCOlwDzcMi3t1U3xCcNQsr
tjTiG2nqsVduf7S5TW798gfamZ/yipmZuFgNBrpJd9oVB9dXPY4WB6uKJMzbYU54
ipkM8IuiHmEFv3nSIFEGY9ZXjOJREk0fxx8IdTI6gjYMF0Sq+SfrtzGzdW1wx3NB
bx+6ZoB8ySnwVVep8nWbCO6ocrIGRw6tu0LynPifCDGL/EE6VPQ=
=EIku
-----END PGP SIGNATURE-----

--=-j/3msCg/E48w4jA/Rc1b--
