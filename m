Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CD52087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfCKTP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:15:58 -0400
Received: from sauhun.de ([88.99.104.3]:59988 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfCKTP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:15:57 -0400
Received: from localhost (p54B3359D.dip0.t-ipconnect.de [84.179.53.157])
        by pokefinder.org (Postfix) with ESMTPSA id E1C5F2C08C3;
        Mon, 11 Mar 2019 20:15:55 +0100 (CET)
Date:   Mon, 11 Mar 2019 20:15:55 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: intel-lpss: Add "linux,use-dynamic-adapter-nr"
 device-prop to i2c-devices
Message-ID: <20190311191555.4dc2wbwqesqmn2kq@ninjato>
References: <20190311112216.31391-1-hdegoede@redhat.com>
 <20190311112216.31391-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="65wlv6bh3hk7fgyp"
Content-Disposition: inline
In-Reply-To: <20190311112216.31391-3-hdegoede@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--65wlv6bh3hk7fgyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 12:22:16PM +0100, Hans de Goede wrote:
> The i2c-designware-platdrv assumes that if the pdev has an apci-companion
> it should use a dynamic adapter-nr and otherwise it will use pdev->id as
> adapter-nr.
>=20
> On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
> some of the LPSS i2c-adapters are enumerated through PCI and do not have
> an ACPI fwnode. These devices are handled as mfd devices so they end up
> using the i2c-designware-platdrv driver.
>=20
> This results in the i2c-adapter being registered with the mfd generated
> pdev->id as adapter-nr, which conflicts with existing adapters, triggering
> a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
> adapter registration to fail.
>=20
> To fix this the i2c-designware-platdrv now also supports a
> "linux,use-dynamic-adapter-nr" device-property, which tells it to use a
> dynamic adapter nr even if there is no ACPI fwnode for the device.
>=20
> This commit adds this device-property to the properties list for PCI
> enumerated LPSS i2c-adapters.
>=20
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1687065
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

You need to CC the devicetree ML on such patches. However, I am afraid I
can pretty much NACK this one already. This is a Linux configuration
item and DT is only for describing HW.

Maybe the designware maintainers have a better idea how to achieve what
you need.


--65wlv6bh3hk7fgyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyGs+sACgkQFA3kzBSg
Kbb7MA//dTFm2uJgtmWTwBlX6sv2c8KRgO7GDWntvUTY28kOHNx/Ow6noezZBgds
UXsUVjHXsdFiqClRrTewJVqzSLTAg4H8dtN1PTmjLfcPTLj/GJr4hAgpc7Ue6nbk
DrzxwTY1OsSQUkJf5q85ReIUyE2vDmadokxeIf08hwE6HZ/FHlrbCFx6ooGkKoL7
R8y59uyo7npXa4uEPniSB0lRue6EbnHkNvni0HoJwzWXJcEsH8yyOBjJOz9ufugw
/ih25THatp/7q7Z7GO10Dh+v4vJ/ezY++DfLMslUsjWxep/6+fc2I+YtmJz0a2zu
6u2K1Emewd7Rp0RnETHzUjxUippHdCgx8nkKS95DZCME3IdfhRBTcYolC8t726BH
kt043d3+j14KBKXPpqKhlIS0tYdlbZsYhJYAWi9tnggeWT6ZfBsG7HcEypEPNyik
+OFf2eobzLua+BR+dkI0jylCSVOTjvoOzdbhifiI9GxcaSf7ke/gv2GLqwvDqMT0
UKaVwfKQIoZuoPQjf1d3eqOszHmUZOlkYNkQkyJLhEIG18HitrkViIatyUG7HWQv
eh3Vv84gDvAacBiQcyIp98T458MDLbbf3XfSAT3+v6czBD912vTz1D+vNBoX1dAD
Y2wfvW5QGF4PhZ9kDQeZCcqn90M+kw0rQxMkm75e9hV8odqRjJI=
=cXel
-----END PGP SIGNATURE-----

--65wlv6bh3hk7fgyp--
