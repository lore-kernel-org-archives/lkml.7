Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0B5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D486233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NXVwIT7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbfHVU26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:28:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:38123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732323AbfHVU25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566505724;
        bh=pF0dgdCpgl4enpI6SdBXTKqpcVBK5za8jnquv0x1bRU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NXVwIT7tCIb8dvVcorSB3fdlhvZNjSwBVymRUXWQJNmvJY0UStyr4uSaBRmkxcUy0
         RA0aNiai7yUhCaIOJ4heMt76W5tGP3FxdbuvBnJi+4X+1FvPbkVzgHBrZ8u6fF4poi
         p87T69qQq5a9FDQZrjA42tSZrbEZDI+srgz8VLhc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.89] ([217.61.154.89]) by web-mail.gmx.net
 (3c-app-gmx-bs43.server.lan [172.19.170.95]) (via HTTP); Thu, 22 Aug 2019
 22:28:44 +0200
MIME-Version: 1.0
Message-ID: <trinity-5d117f0d-9f34-4a2b-8a12-1cd34152c108-1566505724458@3c-app-gmx-bs43>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     "Liam Girdwood" <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?=22Ren=C3=A9_van_Dorst=22?= <opensource@vdorst.com>
Subject: Aw: Re: BUG: devm_regulator_get returns EPROBE_DEFER
 (5.3-rc5..next-20190822) for bpi-r2/mt7623/mt7530
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 22 Aug 2019 22:28:44 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190822193015.GK23391@sirena.co.uk>
References: <trinity-584a4b1c-18c9-43ae-8c1a-5057933ad905-1566501837738@3c-app-gmx-bs43>
 <20190822193015.GK23391@sirena.co.uk>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:i4Hx9cJguNAPQETNd9mSs1bTlBVLDuFWF/KISNtejmaHipYzr/LzXxBqLzzgSyyNTLhKP
 QlctORci17513NEMK4wUbVHJ5lHYkh7pbpid6BopWdU7Kk1fyFz7ffHMFtT3Ea82MTFhgBSod0vy
 2k7AuehKjyB2uCNat9OO3R1G3GW3VVbSvyXvzVzIlWKAn+kH0wbbiQrRUDIvgveJYorqPKi11B/r
 U+8XIK5rfhaAMppQlUu08EuI6MR7ezRDuFV/fOzS+Xpv1mkkZYkN4ElaTV+2PODEODp5/rl83Kji
 tk=
X-UI-Out-Filterresults: notjunk:1;V03:K0:JhRVqcGM0fU=:JCYujooCTmUMHi6+YWGqjA
 Z6O0xAeSkqTOWcW9S9Iz2rUU+047BwinHRFjCw8YLRmJ5XxcFT0PnfIq6WkEoGBirTxPpAghf
 rNXney7yNaLQGdJxWbT55pWU27JKWkkuo/RLiKZ31NofEg1oi4+HCQGP/n2aJ7FhsHXJhf8HN
 inVvctE6CVb7+ihleYC24Fka3vZtLU4qYITv26FDuEWj+FrLAW6crw0GafIOg6quOJOIpeiek
 N4Z9RhDDyAUsTgRD+6mJa5U2hPjBIY5ptOxlNy66HerwtE9kNf7HNe8oh290zMEN2Cip+0dCM
 GjjadVwkmvNEiqbPx6ljQSv3Dxe0Adl80k/xXaPfmxzctRoC9b2fiPyNdpnbcOFYNKUXlZ7/9
 BbRP5PryLEcyQ0qBprLzhj7eAO0aL3KxtYCyGKle964paeTHDL/w1LUkV0egUFQswMoF81F5+
 If2UkPdO9ISb4lPZDJ/s8kOHEsCV749Z8koManeCBArH/ADIrNCiN7pW5RTNPZTeP0P+KMqZ9
 xxznXpjSpRB5+AY83KBWBbRGcuvE7hKGEHAbD4SAM4XGvN50gOmI4O+NOH+VILx8swOkqK8W/
 9dj4kUc9HO0CFojzZaUBD4Ylc3WmZa9gpmE7PcvTRBuJm2wlEYH5hzwakk0qbfXKlfHUpXdNc
 vqVijZWwQ3GfJv9i1XjeUASDb9ZO98JHxy7uYcmPH4rEizw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfba5de9b99f drivers: Introduce device lookup variants by of_node

this looks suspicios to me since the change is in the function which fails=
:

struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 {
        struct device *dev;
=20
-       dev =3D class_find_device(&regulator_class, NULL, np, of_node_matc=
h);
+       dev =3D class_find_device_by_of_node(&regulator_class, np);


but i cannot revert this commit so i did it manually=2E=2E=2Ebut this does=
 not seem to be the cause=2E=2E=2Estill error 517, also a change in core=2E=
c is not the cause=2E=2E=2E

how can i check instantiation at runtime?

regards Frank


> Gesendet: Donnerstag, 22=2E August 2019 um 21:30 Uhr
> Von: "Mark Brown" <broonie@kernel=2Eorg>
> An: "Frank Wunderlich" <frank-w@public-files=2Ede>
> Cc: "Liam Girdwood" <lgirdwood@gmail=2Ecom>, linux-kernel@vger=2Ekernel=
=2Eorg, linux-mediatek@lists=2Einfradead=2Eorg, "Ren=C3=A9 van Dorst" <open=
source@vdorst=2Ecom>
> Betreff: Re: BUG: devm_regulator_get returns EPROBE_DEFER (5=2E3-rc5=2E=
=2Enext-20190822) for bpi-r2/mt7623/mt7530
>
> On Thu, Aug 22, 2019 at 09:23:57PM +0200, Frank Wunderlich wrote:
>=20
> > seems of_find_regulator_by_node(node); is failing here, but i see the =
dts-node (mt6323_vpa_reg: buck_vpa) in /sys/firmware/devicetree/=2E=2E=2E
>=20
> It's not looking for the node in the device tree, it's looking
> for that regulator to instantiate at runtime=2E  Is that happening?
>
