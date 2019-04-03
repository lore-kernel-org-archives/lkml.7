Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2532C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976EE206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF7UAwlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCQPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:15:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37971 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:15:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so22212567wro.5;
        Wed, 03 Apr 2019 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mibXejhkTt3HczjfIawcvoFcD+Z22ProgZ/81SwqvDw=;
        b=eF7UAwlPbC4rhMnc+PT2kD6K5ltbjbw0IVURvRDdXyNNRFfozaJEZF7rBjySd1CO3v
         XUFCPPQ016wKJIqm6Cql/IDFKGkB9vTiRygDb/cjPJPbAGPMrB8yXUp8C9dkQ8dZbSRU
         MMmGstZIQ4IJ3SGHmf+uFc7HhR+EcQGLSLWy4lyBvqkmQ9d+C0le3uGNoJ4FckEdzGXH
         7+4fhQQdkBL/YaKH1IWHDrfv9xgUFAAHPlR6W1d7JJptpA2GPF/PwZB1tgmUC0juhyKK
         rKeIeDTRWBdid6fXOTBdItyjsRDjIgRTS9pHLwisurgWmooI4oxzgyRWyerNiUre8kb/
         +60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mibXejhkTt3HczjfIawcvoFcD+Z22ProgZ/81SwqvDw=;
        b=l42u3xYFwLmnMfCkMvciJw+iwgpc1V+DPSpuslo2+DhxVSEYeGiHMH/oQ0/61OZdLs
         FTAL76EhKlPI5hhoSxvj+DT4Grre3Hj1i5QfzjulhY/AddZh3QcTCuU0RjA4oWiqsE33
         YFpqqy6AIftKsTzvP/yCidqWgI9kh0C0fKppRMjJTP67zagEZfgGDqXNEC93SWDrK7hk
         ha0mZnau6ZJARPeQylLCI3VMls5srGuCkpQoYQolk3J+aXPgxLdUjzfiUQpWCZQJoR4w
         NLLejzFM3YVo8ZDCglo8CKDa3ULRTK/aRfPfoSDkqu6I6eEmWZZNRIcK+JwbS1P8/Rdf
         tl6Q==
X-Gm-Message-State: APjAAAWk7FkjdYMETYARIKIs0NE8SiUv+DlWTpQ6Y9yyYhrKfgbbttPz
        902ffigOA+WRePuP0a2X/bo=
X-Google-Smtp-Source: APXvYqzF3q9yfL8z7Kl9fMKeQ/ZjTBkQwwTHW0ld9TqnGlqaUsS6/1CsGLZHjUcRf7c0Eypjnz3rgA==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr299213wro.276.1554308119230;
        Wed, 03 Apr 2019 09:15:19 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id r16sm11575764wrx.37.2019.04.03.09.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:15:18 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:15:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] dt-bindings: display/panel: Add missing unit names
Message-ID: <20190403161517.GM5238@ulmo>
References: <901e836ea06889a9d91a799102b2a6b836d93dcd.1553529797.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DXTueXWT3Da08pik"
Content-Disposition: inline
In-Reply-To: <901e836ea06889a9d91a799102b2a6b836d93dcd.1553529797.git.agx@sigxcpu.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DXTueXWT3Da08pik
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 05:08:10PM +0100, Guido G=C3=BCnther wrote:
> Some examples were missing the unit names triggering
>=20
>  Warning (unit_address_vs_reg): .../panel: node has a reg or ranges prope=
rty, but no unit name
>=20
> warnings when used verbatim in DTs and running dtc with W=3D1.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
>  .../devicetree/bindings/display/panel/innolux,p079zca.txt       | 2 +-
>  .../devicetree/bindings/display/panel/innolux,p097pfg.txt       | 2 +-
>  .../devicetree/bindings/display/panel/kingdisplay,kd097d04.txt  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--DXTueXWT3Da08pik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyk3BUACgkQ3SOs138+
s6EUSBAAg+iye7nrVWW3qKP9BoY9lnhQAewxgvMoVktvxT+7+GOMKSOeGyjJGhxw
GluTb2Nqv3wGBq6EPv7qm6Fw+3Dlt4x7fkXw6AgEYn/9Aee+VmaXEq6TtqBy36r1
zNWa7LSyHjNT2mMfwE8qltlOPaESocjActvzziGRHlLLS6X0kZB9irDlOBbCSlP+
NXqAipfD7wnHRt0Kl5qnhn27vtsVBEpSiAW8gmqkvJANDlLeW2p4r6aK31Z1B+jR
Lc1+6V5Jb9nQgEhDbW+JD5cJdvesvXv3K5c0Hk2e+4XkR5+2HfLdNvQIF2Kijfcp
mAv7x8JblSIn5c4scD3RBVZaSfI6nJl3BmtdFkCAIU8QT6Jdr3mKPkudh8Ip9WsO
I3xPtLbnJ78bwnLvVx5ZFaM9LJkrocHBc1GioVk6VmfsvEz75HtdUPKc9Hsnq9tD
3WxHrEZzBoKxrBq7JO1BqvJdz0RhTs9WYBHUazDO5wdGqCN6Utr2k8JJL8R+VvZz
+DsBD44EJFkEfKBcL/SBbwlzJCo11qw2midN9jXJYxZoExY+7J2RWxLtPpEMZLH4
rFmDUTlU9wNwPqtWsLdBsANyRTnWwvF4NMvMpwWAfO5MD6IUXvs98F/lnqeTVM7i
Pp/wnFKMPxU36SUXI5KA0CBpks3dBoVGUjqy3MkG0Xy0DHZupYM=
=SpyK
-----END PGP SIGNATURE-----

--DXTueXWT3Da08pik--
