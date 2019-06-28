Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DD2C5B578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478F2208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Qmeuxf9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfF1Dpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:45:50 -0400
Received: from ozlabs.org ([203.11.71.1]:36923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfF1Dpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:45:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZjNB1lQjz9s3l;
        Fri, 28 Jun 2019 13:45:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561693547;
        bh=8mUj2KRXvTU5FS/z0xXNOweWk6tKKmKVr7agiirZ1s4=;
        h=Date:From:To:Cc:Subject:From;
        b=Qmeuxf9MpFQq0XOVT0qU/oGC3pXppHD0PsmtG2ZoNwFJ+gVaDMO/aT1vOvlU7qv4O
         QKAzmSh1tHRTBbOXi18SAv/9pqi2NaWnGxiIVXAevBbe2h3k5UpFxDSpB1on0BCjLY
         MnaNlSt+KH/MeHF+NyuxgOL1Lc4K5JZwDe3S9FqbanZhH6KPRm/MKAtTR8CM2CUJvJ
         nvBh38+yDTd4Hoipi3cn5XdayWrZU74Y5FufDIk9EgjYTZuYBrx7pCCcBSyRi0V3/h
         aW385tQwVpw3I/ahX3bLtGroeFr2HL5SDcexS4miNyxtW+2lB79/6RgOrhwzFlYW1L
         /GnvApe2vWYQg==
Date:   Fri, 28 Jun 2019 13:45:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Nick Crews <ncrews@chromium.org>
Subject: linux-next: manual merge of the battery tree with the mfd tree
Message-ID: <20190628134545.4b9b8625@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ue4zsQO11Nz+tbA_o9EUmS="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ue4zsQO11Nz+tbA_o9EUmS=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the battery tree got conflicts in:

  drivers/power/supply/Kconfig
  drivers/power/supply/Makefile

between commit:

  f8c7f7ddd8ef ("power: supply: Initial support for ROHM BD70528 PMIC charg=
er block")

from the mfd tree and commit:

  0736343e4c56 ("power_supply: wilco_ec: Add charging config driver")

from the battery tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/power/supply/Kconfig
index 4a3cd679295b,4c01598f5ccb..000000000000
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@@ -689,13 -702,13 +703,22 @@@ config CHARGER_UCS100
  	  Say Y to enable support for Microchip UCS1002 Programmable
  	  USB Port Power Controller with Charger Emulation.
 =20
 +config CHARGER_BD70528
 +	tristate "ROHM bd70528 charger driver"
 +	depends on MFD_ROHM_BD70528
 +	default n
 +	help
 +	 Say Y here to enable support for getting battery status
 +	 information and altering charger configurations from charger
 +	 block of the ROHM BD70528 Power Management IC.
 +
+ config CHARGER_WILCO
+ 	tristate "Wilco EC based charger for ChromeOS"
+ 	depends on WILCO_EC
+ 	help
+ 	  Say Y here to enable control of the charging routines performed
+ 	  by the Embedded Controller on the Chromebook named Wilco. Further
+ 	  information can be found in
+ 	  Documentation/ABI/testing/sysfs-class-power-wilco
+=20
  endif # POWER_SUPPLY
diff --cc drivers/power/supply/Makefile
index 346a8ef5f348,d2263e1e2b6f..000000000000
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@@ -90,4 -91,4 +91,5 @@@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cro
  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
  obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
 +obj-$(CONFIG_CHARGER_BD70528)	+=3D bd70528-charger.o
+ obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o

--Sig_/ue4zsQO11Nz+tbA_o9EUmS=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0VjWkACgkQAVBC80lX
0GysYwf/Y+uE1npkXa982jebG95zEkW/vQvUUvOGav6bb/j6IvtMFgd+jz/P95hV
dHNm3D9WI36uA9T+wuxPLOUd75m2TiTGkMczUSKOirj8wcLagsKzIS8yJpCZkXPl
NnDVSIXK6e9+r7kMkemngBt8TNrRLoqeR4S9PhOfzAmxjimcnt6NZ3fN9RRUfh4+
6Vsyj2pZSrLwMWs7T4kqzdZOElf5x/TBSdgCx7A6R4slWLhXuGFabXplUFvaqCrW
oy2sUqMqWLpb9SzPaG8fqJAPZ4T7OA1LHg4Rl/h4IHioCy+UcJSOmDRaBrED6gTl
8ZcRtTLzJh6z4JMOfhmoS/GGydMFQg==
=JKFi
-----END PGP SIGNATURE-----

--Sig_/ue4zsQO11Nz+tbA_o9EUmS=--
