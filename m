Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90478C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA821741
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552938845;
	bh=S5qXjlimOmlmPK6S44dA6deTiv59CNz9XxD1naSz9Ys=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=yh5GSIiU7r7h9oyr9rcG3OOEtXtcQxK4naTLBKRrc+K5fg0suZo9zTKAQm237IbdD
	 VBUrJALzLl5KfjXPlO+32wmo7mGdSeVv0tMHBwE1G6GW/PmU9/GLmV4UF+o7OrGjzA
	 0PTioMx2spqxZToZcHcTQiAzfePrePVCdgjn2sRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfCRTyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfCRTyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:54:03 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB712173C;
        Mon, 18 Mar 2019 19:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552938843;
        bh=S5qXjlimOmlmPK6S44dA6deTiv59CNz9XxD1naSz9Ys=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=pY9hE0g6FBj3ayx2f0DIl7j+GMvQFXTEmNqc7Qwny151k0RrV4QWRRFv3Jjwb/dJ2
         c0S8LHITMTFvqDbFz3tU9Ql1vjVuzuimLn2z4Wd5SPN3QzUSFK6iNQex3TqDpBE1jA
         cLa96OoJZzVqqeqeu2/4AdIhWGMe0/U2uc5yYwVk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190318105045.26943-1-nicolas.ferre@microchip.com>
References: <20190318105045.26943-1-nicolas.ferre@microchip.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: at91: fix programmable clock for sama5d2
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, matthias.wieloch@few-bauer.de,
        stable@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-clk@vger.kernel.org
Message-ID: <155293884206.20095.9858756917267939797@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 18 Mar 2019 12:54:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Ferre (2019-03-18 03:50:45)
> From: Matthias Wieloch <matthias.wieloch@few-bauer.de>
>=20
> The prescaler formula of the programmable clock has changed for sama5d2. =
Update
> the driver accordingly.
>=20
> Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
> Cc: <stable@vger.kernel.org> # v4.20+
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [nicolas.ferre@microchip.com: adapt the prescaler range,
>                 fix clk_programmable_recalc_rate, split patch]
> Signed-off-by: Matthias Wieloch <matthias.wieloch@few-bauer.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> v2: adapt to v5.1-rc1
>     remove unneeded sentence about DT in commit message
>=20
> Stephen,
>=20
> I think it would be good to see this fix going upstream during v5.1-rc ph=
ase.

Ok. I can apply this clk-fixes. I presume that things are real bad and
it can't wait until v5.2?

> @@ -60,10 +68,18 @@ static int clk_programmable_determine_rate(struct clk=
_hw *hw,
>                         continue;
> =20
>                 parent_rate =3D clk_hw_get_rate(parent);
> -               for (shift =3D 0; shift < PROG_PRES_MASK; shift++) {
> -                       tmp_rate =3D parent_rate >> shift;
> -                       if (tmp_rate <=3D req->rate)
> -                               break;
> +               if (layout->is_pres_direct) {
> +                       for (shift =3D 0; shift <=3D layout->pres_mask; s=
hift++) {
> +                               tmp_rate =3D parent_rate / (shift + 1);
> +                               if (tmp_rate <=3D req->rate)
> +                                       break;
> +                       }
> +               } else {
> +                       for (shift =3D 0; shift < layout->pres_mask; shif=
t++) {
> +                               tmp_rate =3D parent_rate >> shift;
> +                               if (tmp_rate <=3D req->rate)
> +                                       break;
> +                       }

This looks like a lot of copy paste when the if statement could have been
pulled into the for loop instead of duplicating the loops and
surrounding if condition check for tmp_rate.

>                 }
> =20
>                 if (tmp_rate > req->rate)
