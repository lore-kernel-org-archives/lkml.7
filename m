Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76279C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C07A20675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1y16wd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCDM7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:59:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34857 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfCDM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:59:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so4613384wma.0;
        Mon, 04 Mar 2019 04:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r80neqkwjaZoL+ISAB0y1sQ0ZvVe0xDjxZfWvqYDf74=;
        b=e1y16wd9xyDAPlbfPWCGFvxYTsp84jesM551457UPyC54AVGTOC7lOTcRK0oJJcOvm
         VCMC74aCnDA79pw7xkCwKK1y09cKEsxXVgJF6neOVTfbgZSOIf3Y4UPTDwaGrFRPkm7R
         T5ckPPQZH0aqUGz5lQfdUdv+lZiZjgtucIS0ogt8f4RgjhQ9b8MK7v4y8tUWp1BR7Ilv
         61/U070LbzJiojM9q+bWEqvugembOJ2uKBnnF0TbMzFbnWnCrdNi+tNc77C+h+eloAu1
         Ey5Y51fjSPe2n/6I8SwJ79xjNrz5aXhhHonlboGgd4yCSJ3QzzJCpqqALPKp2WXHEEuh
         vGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r80neqkwjaZoL+ISAB0y1sQ0ZvVe0xDjxZfWvqYDf74=;
        b=fEYqkv4PcTHtwx6o+tajtwW3QxZwjrg7WU7UfME3AQ5dZjPwFd7Kkq7ppRbp4CT/t7
         zVZxU0Z7kSjm82dx446AGNbFLuPxJ8qFJ5FXZowG44yuNL6jqS+xwkLWSkcIC9VZg0kC
         v5juafwvi2XTOEd6susfO9LADXf9E1akySn1OfetkEaWarEQdAdu66QLTBDPio/hiTQQ
         0mw5GwjTMJAH/Hc7vR0auwTCyXuzJFxOLvYlVQKhjIyb3CaKvQ2BdPl6QP27X0OYytzR
         Gvd4pDuzUBMp0jj6n9/519iPyRpj/WY/dpOZygBkYnzg/PPpLaS4iIpzcIKOlFF62s6y
         XY8w==
X-Gm-Message-State: AHQUAua1ZJqrYA7B9aDw1OuvIlPtOGBOJfD0DT/D2gNI8WmlT7Q5O35X
        exP1Z9hHsVr0oc48N0D5AXXY19Cf
X-Google-Smtp-Source: APXvYqye7N6TFJA8kmxaRsV6v/kwkK8p+iWwxYPc9X3Bb5Q2T2TARqU6rUO+zAKur0Dy+Cu38bpsTA==
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr11826122wmb.5.1551704348179;
        Mon, 04 Mar 2019 04:59:08 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id o12sm24836363wre.0.2019.03.04.04.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 04:59:07 -0800 (PST)
Date:   Mon, 4 Mar 2019 13:59:06 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 6/7] i2c: tegra-bpmp: convert to use new atomic
 callbacks
Message-ID: <20190304125906.GH9040@ulmo>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 02:47:34PM +0100, Wolfram Sang wrote:
> The driver did handle this internally, convert it to use the new
> callbacks.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-tegra-bpmp.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9IRcACgkQ3SOs138+
s6E+Vw//d+WlRyraorEvpmkVgh3EUTwvY1rnjUuWH1rrNvveKGzdXYpDWjpKeCo0
OObme4tLuXOMLneWMmemPmOFTNY/dgrwUG0HuGxn9SYq9SrY2WZEMjIEmwW4d+iQ
+h5KvMBz9r/lV17lBQgIeQImpIE2o4/AhDskidyTImBDqtIdIwojSkashTq3TH2w
HDhbowCJKoXZzfhU2Xo1i7obJFXljsbCE2GsOzUq/U4uZcXMuoCMtLvHrWX2sxX1
4BiVxNjm3CAQ55nC1hJzMUBvhiXRm10WdA/WIfBc7r+JXsG2oylDRrYRiTBJ08op
RCcDwJcU8bb6xvFFuuE+m7kcNXEnR0JY0zx7dXUhJI1Jfk1zln2Rfjfbt/akhYPq
gBUw9YcmrPWxo9708UzaakUyCvm6zzjOXaLDA2sYW643CxrIzDmCIFkG1JdNxON+
IjnmJLyNWB77LffG/H7j6hP8DhzBrzbddJPP5pKigASC+Lwmzr/6d9h9muvaXT5w
SpsZyonXJht8vALeZHUEw0DtSFJuB41TFVuVFvUi+VRKuWQ/DReWZa2iV+HzK1Oz
P6C/9p6n6CCBWiXpfYMqrD7sSQGqd+OuRZdevGozd5KEtWaCTr3jR76/xY0j/Iwn
7Hj1G4m4ycWw25ZClqsVG0REm/o0aneAL8a/PIT4FRmpWoZvL94=
=Ldlv
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
