Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8246DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE36218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfDWVVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:21:24 -0400
Received: from sauhun.de ([88.99.104.3]:56356 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWVVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:21:22 -0400
Received: from localhost (p5486CDD9.dip0.t-ipconnect.de [84.134.205.217])
        by pokefinder.org (Postfix) with ESMTPSA id C048F2C7BF4;
        Tue, 23 Apr 2019 23:21:19 +0200 (CEST)
Date:   Tue, 23 Apr 2019 23:21:19 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "eha@deif.com" <eha@deif.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Message-ID: <20190423212119.GC5659@kunai>
References: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 01:59:34AM +0000, Anson Huang wrote:
> The way of getting private imx_i2c_struct in i2c_imx_clk_notifier_call()
> is incorrect, should use clk_change_nb element to get correct address
> and avoid below kernel dump during POST_RATE_CHANGE notify by clk
> framework:
>=20
> Unable to handle kernel paging request at virtual address 03ef1488
> pgd =3D (ptrval)
> [03ef1488] *pgd=3D00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Workqueue: events reduce_bus_freq_handler
> PC is at i2c_imx_set_clk+0x10/0xb8
> LR is at i2c_imx_clk_notifier_call+0x20/0x28
> pc : [<806a893c>]    lr : [<806a8a04>]    psr: a0080013
> sp : bf399dd8  ip : bf3432ac  fp : bf7c1dc0
> r10: 00000002  r9 : 00000000  r8 : 00000000
> r7 : 03ef1480  r6 : bf399e50  r5 : ffffffff  r4 : 00000000
> r3 : bf025300  r2 : bf399e50  r1 : 00b71b00  r0 : bf399be8
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4e03004a  DAC: 00000051
> Process kworker/2:1 (pid: 38, stack limit =3D 0x(ptrval))
> Stack: (0xbf399dd8 to 0xbf39a000)
> 9dc0:                                                       806a89e4 0000=
0000
> 9de0: ffffffff bf399e50 00000002 806a8a04 806a89e4 80142900 ffffffff 0000=
0000
> 9e00: bf34ef18 bf34ef04 00000000 ffffffff bf399e50 80142d84 00000000 bf39=
9e6c
> 9e20: bf34ef00 80f214c4 bf025300 00000002 80f08d08 bf017480 00000000 8014=
2df0
> 9e40: 00000000 80166ed8 80c27638 8045de58 bf352340 03ef1480 00b71b00 0f82=
e242
> 9e60: bf025300 00000002 03ef1480 80f60e5c 00000001 8045edf0 00000002 8045=
eb08
> 9e80: bf025300 00000002 03ef1480 8045ee10 03ef1480 8045eb08 bf01be40 0000=
0002
> 9ea0: 03ef1480 8045ee10 07de2900 8045eb08 bf01b780 00000002 07de2900 8045=
ee10
> 9ec0: 80c27898 bf399ee4 bf020a80 00000002 1f78a400 8045ee10 80f60e5c 8046=
0514
> 9ee0: 80f60e5c bf01b600 bf01b480 80460460 0f82e242 bf383a80 bf383a00 80f6=
0e5c
> 9f00: 00000000 bf7c1dc0 80f60e70 80460564 80f60df0 80f60d24 80f60df0 8011=
e72c
> 9f20: 00000000 80f60df0 80f60e6c bf7c4f00 00000000 8011e7ac bf274000 8013=
bd84
> 9f40: bf7c1dd8 80f03d00 bf274000 bf7c1dc0 bf274014 bf7c1dd8 80f03d00 bf39=
8000
> 9f60: 00000008 8013bfb4 00000000 bf25d100 bf25d0c0 00000000 bf274000 8013=
bf88
> 9f80: bf25d11c bf0cfebc 00000000 8014140c bf25d0c0 801412ec 00000000 0000=
0000
> 9fa0: 00000000 00000000 00000000 801010e8 00000000 00000000 00000000 0000=
0000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 0000=
0000
> [<806a893c>] (i2c_imx_set_clk) from [<806a8a04>] (i2c_imx_clk_notifier_ca=
ll+0x20/0x28)
> [<806a8a04>] (i2c_imx_clk_notifier_call) from [<80142900>] (notifier_call=
_chain+0x44/0x84)
> [<80142900>] (notifier_call_chain) from [<80142d84>] (__srcu_notifier_cal=
l_chain+0x44/0x98)
> [<80142d84>] (__srcu_notifier_call_chain) from [<80142df0>] (srcu_notifie=
r_call_chain+0x18/0x20)
> [<80142df0>] (srcu_notifier_call_chain) from [<8045de58>] (__clk_notify+0=
x78/0xa4)
> [<8045de58>] (__clk_notify) from [<8045edf0>] (__clk_recalc_rates+0x60/0x=
b4)
> [<8045edf0>] (__clk_recalc_rates) from [<8045ee10>] (__clk_recalc_rates+0=
x80/0xb4)
> Code: e92d40f8 e5903298 e59072a0 e1530001 (e5975008)

Applied to for-current, thanks!


--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly/gc8ACgkQFA3kzBSg
KbZQmA//VzFXXDx1h0hfIXG/pWzN7iClOx96u2ejLojvfDlNStXvfqfSGD1QOLQH
9keQyxOgbgEw+ypdpPJp/GIEaQjYJIPhwW51FPF+MvyYun7lpEjyZA1cSHqOGwqQ
DwYRI2+bs2mB5Ga3cApXVqM1Oh1dQBl61jq02J3Kq2paJQS29RwHXTx3igMQ0Iqo
KDqwU9pQ9xBHUWQ59YGhIbys9tuiLXfmBtT5soF+G+6M0y3Et2cTZhpY36PYEADo
2kAj05ckPObpK72Buc5YPXAg3MjJG/uUQVGXb3MlUUy674X7ImzluoHoWlVbfRMU
OQ/jnNLXY9xEg5WqHEEG/7xwrrgVa1p/TEoylmLQHNF0MUoRXZ5iL3weCi11iO4n
UhQOpycQno0EG5hWgfjFJf3Qs8Jry6OkNp1tDHYu4Nqj4I7Ri+Yl2MR1kH5vWbxV
U/nwIpJfiBRN8+dXjKkWAly769WSirEkJik529EGYw46mIt5KpORVAkmgVWNoyOv
+V+B0vQJnPshnBTOBN+dFfmNi2Muyy3W8PhCRvWUG+HXrfNEB7Gy4tz7zl/8lbhH
h6Iwpz4V4iEC/Pku1qAO/s4lO69uiVvxiOisS2ogme6awX/JpHfCcGnMD7Q9hY9T
QtRO0wtCQCFxlJcrFXxbdy7Vtdn70Xa8nXuwYq8ORtY+jpafWWw=
=dF1a
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
