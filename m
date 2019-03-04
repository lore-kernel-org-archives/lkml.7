Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736F9206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeEYhSFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCDK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:58:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40455 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfCDK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:58:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id g20so4200782wmh.5;
        Mon, 04 Mar 2019 02:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DD+uxTgX2tD8dMSmAQ7S7KI/4Lt/205ornkA6cqPZJg=;
        b=SeEYhSFIaUyf9vwx0B3M3xJKkKyPlhdqMXOqvpqnzLSoEJREXU2nWGI3Uo5uSCfng4
         AkZsS3utG+P9mj6hJziC+gCgjy8R/P3oFh8q2hwkoI6x2/EA29ZrENUR5cmkH3Ns2SZX
         9RpS328y3g9Toz04sFhSiw9JjO6bmsGyAC912daEYYCxVudAZwskQF/uu+pehhdnatsb
         64PVbLfp7Nc8f6d1Vt5Z0JoRM8TIcw2Q0LYWvSCzx8OhzVCSKrjzVg7Gt8BGiESWr7o0
         SStL5xkQzGUdUN+pMcGuRApr3aWQ4xy5EIkmcclyo0ZRWbpFhVr4p38md6lNrdY0WcB2
         bC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DD+uxTgX2tD8dMSmAQ7S7KI/4Lt/205ornkA6cqPZJg=;
        b=KLHOj3bCVMV6cnUv8iXmCJ8NwPg5NL5S2uNQA0YuwVOMVfDWscXJbCB2LcDniwLt5S
         /Zbe4HsSauuQNfttiQafHehXYzFCvigRy4Elgp2+tIUE3zHyxDyyS5nQHf3DSVlEZtwz
         JmFOFDIj4RU8BCfcgHiTEk9b97cyxXyucODmcO9TSeimJGmn/rC2ZsHXcT2BoNQS/cmK
         oOn/JU1a1bklhOFzyEVc2TaM9E9pmAs1dmMh287/abtI1IjoXIdiN260R9WZ2O1YLht/
         FQSxpNGGON0jrV20i6hyZ6LAAs3LtCGKtCvC41dA1pizeKp4exs7bAVELAmHz3Tl0114
         jzfQ==
X-Gm-Message-State: AHQUAubnZBmWi/yGG5dW2YeY4416v6udkwqxkGQ7zAf2DmfLgCnn02w8
        bXpb6B18uMfMt3lGJ9cupLM=
X-Google-Smtp-Source: AHgI3IZ5soaY1sGRHkh0XmSxgiq4l0+T8ocm1q9SGpEBRYPFOThZdo4JxLydaO9fNSQ1+agv0RBUcg==
X-Received: by 2002:a1c:6789:: with SMTP id b131mr10638080wmc.22.1551697131477;
        Mon, 04 Mar 2019 02:58:51 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id i13sm10316348wrm.86.2019.03.04.02.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 02:58:50 -0800 (PST)
Date:   Mon, 4 Mar 2019 11:58:49 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] add support for the new SAM9X60's PWM controller
Message-ID: <20190304105849.GA5121@ulmo>
References: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 04:44:30PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> This series adds support for PWM controller of the new SAM9X60. The diffe=
rence
> b/w this one and the provious AT91SAM9X5 is the counter size (32 bits com=
pared
> with 16 bits on the previous version) thus, allowing to generate signals =
with
> bigger periods and duty cycles. This series, modifies the driver to take =
into
> account per IP counter size by embedding this information into driver's d=
ata.
>=20
> Changes in v3:
> - collect Acked-by tags
> - introduced patch 3/5 which changes the name of objects of type
>   atmel_pwm_data
> - changed a bit commit message for patches 1/5 and 2/5
> - use mchp_sam9x60_pwm_data instead of atmel_pwm_data_v3 for SAM9X60
>   compatible data
>=20
> Changes in v2:
> - add reviewed-by tag to DT inding patch
> - move PWM_MAXV2_PRD from patch 2/4 in patch 3/4
> - change commit description for patch 3/4
>=20
> Claudiu Beznea (5):
>   pwm: atmel: add struct atmel_pwm_data
>   pwm: atmel: add support for controllers with 32 bit counters
>   pwm: atmel: rename objects of type atmel_pwm_data
>   pwm: atmel: add support for SAM9X60's PWM controller
>   pwm: atmel: add PWM binding for SAM9X60
>=20
>  .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
>  drivers/pwm/pwm-atmel.c                            | 117 ++++++++++++++-=
------
>  2 files changed, 79 insertions(+), 39 deletions(-)

Applied, thanks.

Thierry

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9BOYACgkQ3SOs138+
s6FU+A//S48LmAI/PMbxIqvim0FueiPd58rs3d5awKFxYQmsJOUbOZuYE+jlTB6H
zQkvYuYm1X881bbfPJN3TqhYAE3UeZu/+IOr1UEXrbV2y0Df5FIPCv5OF/YjU3WX
071mp9UBWAPyTAr72mFP0+sh9wBQV0cvnRKthVd1PdvFKDiSJQLRoPw9s1+Wcjy7
Q5kU/4+/v0bShwM/yx0IEuwmTUCECs6LQM0y1IPV+iDBwIDCCUNO0/Yn1R+b+vcb
IaGRp5mB6Lv4Ksl1jjJcgMQO6hWZewFnXIrxXgXnzx2GOxRJs4rKvAhBAG9cICvx
UxuKlM6biK6/Hr6Sy474jn0toy7hM+Ud3pLFFMd9I/aecd2nTflOXXDy9922/ETf
1fd4RKk2zTeuOZR684nofLno6uogDKDcAWeeZaADjJowNHH6UTzCazkKCKaYr9Ha
kvuLEsjvTbttTFvfD7H9RxjMg+EIVGYEYBmJJJ3+5oQ95wcqR+JqLJ5loKN7XsM2
j01xkwe8jbfE3v5Hu7qdTilorSgEy5hJV11O+RyDEKoGW50ZRCLtFRAj22wNj/0l
mRjShtoTM42LWaX1rjZrCZnVsvEShEO36ai/Yx/h4Zz9cmd2Eq/WKBxvdHjRiMtP
/gdKsiMkofCDRgIx8X9P+Mv+qISp2hza4mn4OJxo8n5xcEQu1O0=
=5rG+
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
