Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9348ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB2D2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xht2cWoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbfJAOfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:35:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52340 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfJAOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:35:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so3682280wmh.2;
        Tue, 01 Oct 2019 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k26dovb4oQGdd7w6o3TR40KUEyF5ft7G3GUL+iaF6Bo=;
        b=Xht2cWoQheQyGHryEWbV0cak41WzdwV/ZmRMZE1qYxv6U3rsu5aHFE+QCHhbMoja46
         r7Y3MFuOBMAd2q2lMPVAvSRbyBsIKotpshJQyJUlI7le14yErMDZwwyGYKqy90RQoBpY
         0ymknZVXklXxg0xCAgK3pNVt+mFPKjIXmrmyVkoUsnoNxGiz/brKm3Psd2/nRa+s5tBa
         n0hFY2822Wh2kmVwpEJP+2YeSnzSFUFq69vG2Nr0btpEhhPYAK2bL3js4PEQemRWxBJ4
         ZsYNCJ62Zkptt0SsGjdlNOHp3ClFECcQDepibbIyjHx0Z71MUIgtSIlGJFZYrXkvhjMK
         D/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k26dovb4oQGdd7w6o3TR40KUEyF5ft7G3GUL+iaF6Bo=;
        b=qFvXcZ7WK3wh2bcFM9lAvf3kT22u4OqT2A+de0DbH4g8h+ajxpUJoCxSZMi72PhfGY
         NUGBzmKaVuihpis00kQMeIiepKQ9h1BKdvbHM9rF+cH3OWANZ9tRSPQSK4n4a4OffTBV
         5I/ioLnHGlmdEpB/Z8+RXJJ/puobBoS3poPcs1ckSYdylfMH00bh5L79qY+eeOM+84Qt
         ez3NKnpfmJWo6HIXyJmZc6nYjCYvOHrpCnky8GOFwXECdRV1HZpOo5Ia2OJbIlBrfGuT
         Wfe3NfdA9OWwGXuFGXxmjYhEltEagS8dQg5KAjCMxnas9pDxgBHoXob1smN83OFO2hyX
         ET4A==
X-Gm-Message-State: APjAAAXS/naZMOXFtmE3ubRH2lrze61Ej1wEMJE9fSgij8xq0dMhAyp9
        XKY6JyvZPMdEibeZRaFgArU=
X-Google-Smtp-Source: APXvYqz/9a3rVokHHZK1hmvWkgmQibfuWhrwgHdIFniAPzbQ3ku5JC22LcJ5ZHhm6QKuDHoTk7AYug==
X-Received: by 2002:a05:600c:295d:: with SMTP id n29mr3873471wmd.36.1569940503859;
        Tue, 01 Oct 2019 07:35:03 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id c18sm18622360wrn.45.2019.10.01.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 07:35:02 -0700 (PDT)
Date:   Tue, 1 Oct 2019 16:35:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Message-ID: <20191001143501.GA3566931@ulmo>
References: <20190814105318.21902-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20190814105318.21902-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 10:53:38AM +0000, Philippe Schenker wrote:
> Add the stmpe-adc DT node as found on Toradex T30 modules
>=20
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>=20
> ---
>=20
>  arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-apalis.dtsi      | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-colibri.dtsi     | 22 ++++++++++++++--------
>  3 files changed, 42 insertions(+), 24 deletions(-)

Applied to for-5.5/arm/dt , thanks.

Thierry

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2TZBIACgkQ3SOs138+
s6Hftw/9GSzpANShuy2Bl8XDU0wfm4ImQZHn+gvloV9ychIEQKAJuFYroWjvf1kc
x/NskhwR081Ap9AfiDk9KWEg2Xe4fnfQmI+zFAPDSEee+OMmvMaTEfY0xYQOAe7l
OrhXiNadMZKXohIKA2L7lKEGiUsbojTVOh7RSfxTzjCirS+3FWnHnozRVL0Cwwwx
8lkBdHnUSvJMLrjB7JmE5hFJHIdxmwtkp5YmnQCp+708xMmdy1c3G3kffiyiyrAM
//qYyzPtduSVEbrBcmQX/22+dOHi9HKPSgzmStqn40j4gioBp06TmRmLe+wdOu90
G8ZO8tdyFU7TpWwCU8BAZXkpb5C64vZNxjyKDZeLZ4hk2pgu+dQ9hTiJQywyM/oa
/1Hn/AX43COH++K5KBcVWhu5LvzYMRL7GZzlkiOOGuR9k3F/ig7Qx6DMrnjFPlqI
m7t4nqqZTlDEzDa53yoVVVdXXiDsKwi8nEOfeIiuEBlU6w6nPf+nui3DBWA3Zkn2
2XS2Lq2G1qttg5xv1naf5geG5a7Vop+3goArJKpCLNzac/2Vzrkm9kKNyVBre5pz
dobkYxt5O3x/y7+DIqnpmCV37Gx/9juYh2EH+C3lWCsWiGqzMZxELLU0E1qX9FqR
O0lbuoWfYfzEuoLEILEfjo1lxpziqUOw1condM59Se6u9R5A+uo=
=/g0r
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
