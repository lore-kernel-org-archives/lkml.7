Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CCEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F502175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHYy0EHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfCTLb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:31:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51924 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:31:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id n19so20115784wmi.1;
        Wed, 20 Mar 2019 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XeuWolKB0WDDCVgOUgqrVlhXiTn4A8ltWQqwZwJjvRo=;
        b=vHYy0EHbCNnyH+lhtOxJ96Oa37W5zgSUDfClNMWvRporikNeBCiG2eWvlA7858diGO
         7Het6xTRVffe6LSs30d3GobLX7uEcndm2hQiT5u0Bzj+DpYmmezNsnp0kJCNtX25jOJr
         cXhz8vMoMnxHyt1yRqMaKHyXDCqga4u143grdqh792FCPh4etDdWdwMA3trEe71u1rpq
         j64kP0sU69S/WYnC/wdvLT6Ft7IXcG74QhM3TitvKTMQTCgvLKCqtyH7GNwFwMj3f++z
         7nrqQacFCid0PSDfzgvr9iaRmNKI6XYt+OeC0Hzz3yVXRE4l8ylnvYYyPH9bR7XQmZP7
         S6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XeuWolKB0WDDCVgOUgqrVlhXiTn4A8ltWQqwZwJjvRo=;
        b=gNjI6Q2kOd+WXjYY0KAp3rSiJwu4aPjgulOWC0xk5FRJtmDCPfphjzOVUV/1hvaQDy
         e1yJh6APulvvk9mzJeUUVPJEFGLsBlvTAtpUDRta+sha9HQo5oOZw412tmDnuS8Aj56C
         a3TDoU1ghH298qxaj7LhWsn97e+o717gKmSdRQjIaqa9WWAI5F5BXlI22ehpObhaL9az
         yHk1s5BQyOiLmXrnMrv+hWs5IFDSuaR4RG6g3j6yGTeE9a9NCtQx8vkzM4Xh4ai0SwF1
         UUEFgVGox3pp7L4pYZuLm8ElyAZ09NxhH/3l78YzSzg4wFEzKI5YpKLqcef6BjfG/PS3
         OINQ==
X-Gm-Message-State: APjAAAU7iVrAWCPhZUnapkifahFU1HBYF1lhJE9i0nYE1Xb6NLrK1x7a
        CDoh4n9dqPwUGsILTHFTZ0U=
X-Google-Smtp-Source: APXvYqxxsyWVq6iplaSux14blg+wkrqNwnfx8/LNqGHIs5wgfVV05aK6c49LE90H02U50epl12B5KQ==
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr8381053wmj.80.1553081484188;
        Wed, 20 Mar 2019 04:31:24 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id r12sm2827536wrr.71.2019.03.20.04.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 04:31:23 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:31:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Christoph =?utf-8?Q?Vogtl=C3=A4nder?= 
        <c.vogtlaender@sigma-surface-science.com>
Subject: Re: [PATCH] pwm: tiehrpwm: Update shadow register for disabling PWMs
Message-ID: <20190320113122.GC23838@ulmo>
References: <20190312090846.29519-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20190312090846.29519-1-vigneshr@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 02:38:46PM +0530, Vignesh Raghavendra wrote:
> From: Christoph Vogtl=C3=A4nder <c.vogtlaender@sigma-surface-science.com>
>=20
> It must be made sure that immediate mode is not already set, when
> modifying shadow register value in ehrpwm_pwm_disable(). Otherwise
> modifications to the action-qualifier continuous S/W force
> register(AQSFRC) will be done in the active register.
> This may happen when both channels are being disabled. In this case,
> only the first channel state will be recorded as disabled in the shadow
> register. Later, when enabling the first channel again, the second
> channel would be enabled as well. Setting RLDCSF to zero, first, ensures
> that the shadow register is updated as desired.
>=20
> Fixes: 38dabd91ff0b ("pwm: tiehrpwm: Fix disabling of output of PWMs")
> Signed-off-by: Christoph Vogtl=C3=A4nder <c.vogtlaender@sigma-surface-sci=
ence.com>
> [vigneshr@ti.com: Improve commit message]
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlySJIoACgkQ3SOs138+
s6GH9RAAlwIpQi4Gp8VyqL0xxWDtcvhjF+5T/vNJWUudy+Th2MB7bP8ou2KvZ/yZ
rvhJQXfkwdR61jaa6j2ZH68gbJAILEnbOlDLKgkfsQ16nTLYxJvI4VRy+OxvowKO
/yx08iYXiHdXpGEhnKWaLMYoBbimE0WE04PoHGhXTBWDsFfP1og/Tgvgps26BQ3j
Wpz7LrHcSuxTFSCIwDuLGFxv58zYb6wKgAv7DoeptJ3VUlDi6V/i7viHg9MWiq+U
psPPdHwW+0zhY6y5LxpUozQ9rGaCyRVbMYp1y5SfJUZaHYJcgO8JHO8YTMGqNViX
vp5wL2K4jE70TlMF8GGQnQYzF+RdDJr0XPXskz7hLzndjx5vre1w5ECilWbvpha6
aRLnMQpbI9enzX9SdeLH+/5qUrTC7gUO5HO9zaiu606w5SO6PGD/bknbRPO6zH3R
ilXolsxeLRX5PngnwPbtM1CEG5RAREKYZZHgYog8sEhLDdf2j3M9qRShBOk/3mlJ
Y3Tmj1Zu1ailuDeICwhKgDIG2DVZ26RquROq3TBnw6h/wVqd8KKLRf4zAzVG+gzx
0MTakHxT6Y+m2IWawQhpcC7pqLF+uEJwsHnSfr2uLc2ke+idnpXLxklFR8sD9vDM
cqpkaisS0F+ciKx8QnuPwVPxTAbvSb8R3AA1q/bvEyDllbKQjLs=
=VRBA
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
