Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FDBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC792082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INaVkyoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfC1QeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:34:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37822 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1QeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:34:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so4818329wmf.2;
        Thu, 28 Mar 2019 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T+iO7ohGXHp+0kpXpbw3kD77dcAQPkX6pAr+iFKatJQ=;
        b=INaVkyoSh31TCdsn2NmmeXjfHBYnxHcFSplcBYhojI4TcHPIjUKqT87XCJIkTJqwCy
         jgDaNx2xdI8GJdoUdcGlLMwvzG3TNy7rT5r7HER40Z1ZAXrSnaPLKN4flDZV2oGOAad9
         73hNDSWbsnxavVqLIBqNM9Zjs3vsImlKZV0ikqYlV8ipTkugy7o7ilUiG7gCd/+pMcrU
         InSqqgr6f4VOhjJ9i2Ad4EFdx4Ww2UWJ5r3rgssr/22kvnB+ScdORx3N0aY3jkxhRlJH
         LuIGHzjbihfAc1ZI9UGeVndWwlnTXhjqubOX23yEZxOn8FM4T0WaoO4RpOi3XfA+YfT+
         fSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+iO7ohGXHp+0kpXpbw3kD77dcAQPkX6pAr+iFKatJQ=;
        b=A9r3Z5bRF/PtZMjXSJPkUrS07RxWegTY9HKiWmKn2lT3zwdjKM0qo8JqxTV3qeWRrQ
         wIbVvkPcNF2Kz5tpDYO2hvf60jTHvFVBg3w1oQeYu97Wc4sUVCgH8/barU1a9171dxRr
         BSwnBeMdePEgfEixjBc3hjKMVfrEVEixqFIy0qd8IfFwJZ0GLKogcWdliCbRH5P2F8O7
         yg1Lwxz4dUVPAWxz5/tgcSN2wFgXCfYZ99DBURfPw1+h75Bd2OSD+K/aulfx3uIC7LJ3
         Hp+EvbkJgG3l+r6WNOQPQFcZZZsnkZMjIHfmOKQNMMHR/1aqxXp1d71q/v8ennqiNUN4
         xobA==
X-Gm-Message-State: APjAAAWHqgELz7q/+ozoHdBA/yj0x9tLhOT1DM5w4NcU3bp+WlwMHod9
        pnNCGJ9GG3A90JGjcnbQ6X0=
X-Google-Smtp-Source: APXvYqyU3t72sp/G7BJXvw8BPMmpw+MQa2xn9jxud6ONtiQi7Bl/N18hicjggZC+yjTIuBY4DR02XA==
X-Received: by 2002:a1c:16:: with SMTP id 22mr535813wma.91.1553790858329;
        Thu, 28 Mar 2019 09:34:18 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id t15sm23781474wrx.22.2019.03.28.09.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:34:17 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:34:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Randolph =?utf-8?Q?Maa=C3=9Fen?= <gaireg@gaireg.de>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: change chip select action order
Message-ID: <20190328163416.GA31762@ulmo>
References: <20190326143050.26232-1-gaireg@gaireg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20190326143050.26232-1-gaireg@gaireg.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 03:30:50PM +0100, Randolph Maa=C3=9Fen wrote:
> To transfer via SPI the tegra20-slink driver first sets the command
> register, which contains the chip select value, and after that the
> command2 register, which contains the chip select line. This leads to a
> small spike in the chip selct 0 line between the set of the value and
> the selection of the chip select line.
>=20
> This commit changes the order of the register writes so that first the
> chip select line is chosen and then the value is set, removing the
> spike.
>=20
> Signed-off-by: Randolph Maa=C3=9Fen <gaireg@gaireg.de>
> ---
>  drivers/spi/spi-tegra20-slink.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

With the typofix that Sowjanya pointed out, this patch is:

Acked-by: Thierry Reding <treding@nvidia.com>

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyc94gACgkQ3SOs138+
s6HshA//eM/HQvj5Ayl7EEKWD9wFOAT0N4ETiqkZHwoTO/ZNMSht7QdKprY9KLHp
ey3Dm6iLdiBTz8HZnArG37J4dh7gEsbEAy3sd2cDn72+ogHgf2+35G1wVNpsBzM6
zV2EpgRlzIVGHYv5nIZnlEAeIQ4l+5/UxuHZr15yRJkdJnPhrbTRLAnOEvqM92G/
hw0xr3EuMmddR3UCaX7BCrcZ/XNluEHzGCPxr0qnr9vB7EPztbgGMYysdbcMe88J
s5KCjPq8pJV35hKP5+3JG/1UGDA4tqzsw+4lqwvr+VBSqDn0kD4qw40ToYKh3bWK
aGcxSkHIkLzMbJWtvQ+9JPlZjg8Xrfz/FAuGbptlwCYSFK+tM8dP9s4b8ir7fJo8
L0B6hHpLucdmnPOmSiT8zQkhjRfeCmUuVJacdwAafYfqvW4OVXCcnrqsOaBiX/2E
OoXMLmFaloaQqTmsO2a4XtHv2JYoLQ9SgKUl4R01yU+CPq/CT3r1deEwkCIKOdme
Th+zXTJiaksmbPZv+XDHt8o+X18NBtH/us8Z+3gB4iD9s7eBQadlrQQ+cpSXVIpx
ZvamTQPeBmADB7r1UhhI3YBxXS5tyjImouqP94KkngdWjoq+O8Dbqqe1PSTRUaEH
vCbw2MNNHgPPkxiAyRIggzcgv2ZAmaimp//GeGWm6MgBx5l49F4=
=554g
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
