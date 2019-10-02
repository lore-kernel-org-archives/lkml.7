Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A1C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF51C218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br7f7aRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfJBJj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:39:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38055 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJBJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:39:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so18831555wro.5;
        Wed, 02 Oct 2019 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hraA8b1qBqpZHnOd5yn8HO/MRf75psj1fsbKICu/qto=;
        b=Br7f7aRjotBomYBHxyfEyC2YFTKCobpkcIoFcpCi2SAFZlV5qBcj9P3ISaou6q74xE
         k8Vjo14JoUVn68Eryk1x/q0q/A9BJ7hjjBVcSDA96AMhRStBccIiQ+of6LzzD2FVEWqC
         Pi1P5yJvLqIL2C7/cCCG3OQgbmSJ+2FBLaBP07Vlj57wyXF3dA/0hlefdh8n2kI6wubP
         Zyqs8zvShH/9iAnu3ybvRZX/PrzAdxfBEH26Yz/jPPyNXKqNro++kRlrnirdEnR66F8n
         GFDVAaVu2hvqOBfAPq5dfmISEh3vDW/yMyE88ulpQ/7w6/kaWbyn+X1Pb3Bp8JlWhYCP
         adFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hraA8b1qBqpZHnOd5yn8HO/MRf75psj1fsbKICu/qto=;
        b=N1etcA2NBmXqaMUzJOTlze1cEY1ZJyYAPhv9cxR1yr7ND6BKSzF7rMM9otYhTf3SMI
         gg9sErfRytz0S5jhNIrMkJ5fhhFqxfqv8cr6lWMbpFZjkKMFCNA2lO6KRuj4JV4VyKWD
         xnbGtiC8zj/OhAhMLatgwcMpb3HIuGk1sr8u3kNfF7Hjsuf/n40r71ur19s8eu6D9uC2
         ffNozGeb2DR9KNMQMscQjmuUZf+mtmiHCDlL7HZbbOCq31FMb+WbPWlKSlb6ZJK3cG/H
         hzOunb/mlIDUa+7pErtGIc/9vzs60x2LLIuObLNnYJgoS8uQm/GaVpDwX4WRRNufiQ3y
         U2Cw==
X-Gm-Message-State: APjAAAUv/Z615yp0kN9eUkG8Y7TXd/7vNbLjazLsE44TziYFHjArJuY3
        Jo9yqOaK98a5Vg+mRsoGgP4=
X-Google-Smtp-Source: APXvYqwd7WSUQ5zWRLHLMWJXNP195SFhVpd8PQfrm58rOVm4+4e22s1GVrVvmifGAQz02d2VbJhz7w==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr1915132wru.63.1570009194755;
        Wed, 02 Oct 2019 02:39:54 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id o19sm9574626wmh.27.2019.10.02.02.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:39:52 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:39:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH 1/6] xhci: tegra: Parameterize mailbox register addresses
Message-ID: <20191002093951.GB3716706@ulmo>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-2-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20191002080051.11142-2-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 04:00:46PM +0800, JC Kuo wrote:
> Tegra194 XUSB host controller has rearranged mailbox registers. This
> commit makes mailbox registers address a part of "soc" data so that
> xhci-tegra driver can be used for Tegra194.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 58 +++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 16 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2UcGcACgkQ3SOs138+
s6HZXxAAj/2ccE7HkLhaxNMza6KLkAIu71w1a/63g7IUbRc7yLn7g4PwViahNPI0
cyT0wfdMIZlquxbf+g7w7kqHXcMdylo34cNFKApdVTmMy6axKnom/jVJ7SUY4RXe
N5YGVUXEGIhtlsuherZNx0MCgVh59KZSegokKL0sUbn5FaN7n+al0hYB0jJBEg2Y
MuUJHhKbF+JKDL1G+TKGjhC7HQZP4GZubc0NWZAII+KwLmQAcPUK5UuPbFXyCK3S
exxBrULnhWidd9g8A+FJNCcJgQAlPDfdo5XHIgEi1ZHJLoOqBVgUiwX6aZw4TIRM
8J10QdlK0EYGM6e5Rj396FJgjREYY78n+oUNqx+L5GTVgDNYLjZ7xTmLTUxq8Gng
vPeSxlruwzzbcnfI5YvWS5Spj7ydMEG5jfBaW9el1MCCuuIVuIXA2nbfZmVaPpvG
6FYxav5UUVzrNiIwK0F5+0+RaB0U5/IlNSjlBFi1n0d5E4vLLrpwMGtu2cFsFzkq
ZiGkchUm2V41JOuXmU+CFNGfOWKhzDBYNEnCJ+We5qNwYx+OG6/iP/nEEPCkIr5p
jFMStpz0JBi6MDG5Vas7WexdPsk9N/1lOszGzkLAMYAJSTF014uylLyyK0+Y6NQe
6FOuL//KfM5QGrdCFU5RnwM/Zz8YlS39wUahPYgkmd6w5j3wR9Y=
=+5KZ
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
