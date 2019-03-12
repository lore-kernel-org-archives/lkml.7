Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B0720883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1s/dHop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCLLi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:38:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38579 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfCLLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:38:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so2315278wrm.5;
        Tue, 12 Mar 2019 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YtzcH7BB7x2UbQWl7ghp8eoh+CUFyncOaY4nExE5rCY=;
        b=P1s/dHop7dxa+o7uw79keBd07arsAjqCMQkTB2ii1WjLHPNERl56NFrwqbMRdSzeWd
         +18K84A4RuS2K9Kqg+IQAkAR6aqsRO4z1xH9/4yuytJBsKj8Cu7A9TVNB2lYig98K3Lw
         8N9jVJ1JC+UwbPGTE685XhFvFK3okltxzTaBcPydPeM+aM6lVMI9oiZxJY4d3ECxQJU7
         BnkcSAj5bXr6Am+CGAuZz5YrFeU+rQkBIyrdx2btcduXlkn14mTafmL7b6P8DGs60EgY
         JCkDzBEXgEpZG5oUgvECdqDSHRIYbu0steSb37C4He57ZtmucDDlMuZgxwnVmnPZ7whQ
         Vy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtzcH7BB7x2UbQWl7ghp8eoh+CUFyncOaY4nExE5rCY=;
        b=P9UZWi16J37S5K+kIeVsDnLMVpaKcF736R+1R2yA6Ph0UcNAjGAPjfKi9rfg3dJuii
         GKwv+WVDvuVu1D9diqJ8h6rFxtxnBSbuZBuU3MtPRglGJ+bK/bTCs05/kJJ+hBx8gRnZ
         jGCXZaOqaJxjmQlcSV7xs2pXhbVf8i/KQjB46OJ/cWoClmSZXCMpSp2hogfYsLuCNN/k
         4B61YzFv4hIxnoPGmwHcXcoddCnVinxd5TxMRA0zGDOiD3I81w1XWOSd01jTD71G57n+
         iH/0vqSApBzdSd2rJHozmgwPm79h+JPSJzFZdne4xi5ywGkyErZYZj4nImFE40BKW6mK
         gdaw==
X-Gm-Message-State: APjAAAVz4ZlrqAdqlDMVhVo9aJUmW9rabUxyb/fg4BHAeYnpctiNmeFa
        ktLCZ1POQC2BkleSSKf2d7I=
X-Google-Smtp-Source: APXvYqz6HrlvUPrupIkeOnNR4u2JiO5HAO6+4u8i6Uy+pDBKsc4EckR0AXk5jX6hXLXHqhODeDCaUg==
X-Received: by 2002:adf:f80e:: with SMTP id s14mr24186744wrp.327.1552390734584;
        Tue, 12 Mar 2019 04:38:54 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id v6sm3226026wme.24.2019.03.12.04.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:38:53 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:38:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        hoan@os.amperecomputing.com, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        robert.jarzmik@free.fr, yamada.masahiro@socionext.com,
        jun.nie@linaro.org, shawnguo@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 42/42] drivers: gpio: use devm_platform_ioremap_resource()
Message-ID: <20190312113852.GH31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-42-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <1552330521-4276-42-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:55:21PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-zynq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Subject prefix doesn't seem to match for this driver.

Thierry

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHmkwACgkQ3SOs138+
s6Gx6xAAv1mQgIEYsiEOG3auFjK4NyqWTcTVKmRK/0r5f71zWRytjqe4lKn75wI+
5PytZXa7xc67Qx6cVyqtLsdTBQ0kyShxwlRX4weQpR98ogYazQeEa+uzpDI8ywLa
xrNmbePWN8RvJPtnksoHn36mNLIRHx5GB7ZdpnM5SpXufT0EH0+jZ5qJcZLmFrVr
ctvRo3YzlLFsnaETSUOzP3uEEUZoa1cP18ul+36Xl+YBDUGpiXBVgyYvVGj8ZICw
iq+/HA/MvPMTytFk81aEDMIH+K8mSP5uIXHsLFc/9hB8kb1vT3M70pt3yTdUdIJ6
cuPcmSNtuLEe6lQm2UnBS7zUNblU5WVR7jz5bqAXDD2hI78PgXP9mZeT4jJyIV+e
JS4juLof2V2V717jwL1iaJjgsrgetKAzfWV9EovIHiMVTCBQlALrl9hwi3rA/LL4
0h5Zre1NaZ5OHFy/lM48NCcamK83rfFtfrzT8E1znKgN/AUvOyDbPKuA8gRrt+et
NQrxijZW3aHPwtnFy4NYRtltYyI7XYNt7rIOSPFtFT40T6CcQRdJlETsFXYutVU/
FLEyWQYPGSt+KzlPXWb1julgTWuA8n6/n6AgldDEL/wdV8f2SoBLmUtGjJ7NQ547
B796Pe8juq+0bpjOWveScK46skLniGOrAyjltkR8PTotXq77kzo=
=GdEd
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
