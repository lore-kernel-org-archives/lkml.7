Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AABFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080932086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWvOtAdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfF1Xrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:47:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55535 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1Xrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:47:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so10580727wmj.5;
        Fri, 28 Jun 2019 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WpQcKsFD0NKZ7fPE5iTV9T6ToE9rNRS6uT4dH8oCPLc=;
        b=TWvOtAdomHPpfqXEDjnGsUAE3rCGlYqAN8dwbsRG1MOzi5mIpkI8S96tuE/Kpa2n+B
         Jo1O0Xs8KFecgA39TZq8DETewatPBOCRCN3NeiriIwStN5Ndeby3p39OFU4WVMISyxU+
         LNEovz2X/nWrrvbC8zBvcDYzWt0Tfpjup3ksupEMAN6CG92A/piwxTfEzBw7bOGKgqgD
         pP4c1YFtF1XLhmrbm3hfbQWaXuxAG2JfA6rCx2iekseDJ0RyTKZTbEUfMEgouKmJg7cZ
         WvwWbI21l39jAFtFVdXg5Cs8/+zfbca73AR0vrdT+95M4lIGJIz3+ZkJn5/2067p6gMy
         GQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WpQcKsFD0NKZ7fPE5iTV9T6ToE9rNRS6uT4dH8oCPLc=;
        b=Kp9s3E2xWUq9WjuPy6QM8CVFH50sKZNYIhqyRgIpi8OvssVA53zNnEAnMFiXl4uiJB
         rLzbSSneuKoRkEz+ygieQPLl97X04a2eJD94H2w98iFSEHHPIIru284evTFkok2WdD2G
         QYp8DSRbEte8vOcvItybJHnznXPyMRKzjCTOQ80knN4sHXl0Tn5VntvlG4PXfwERF4D3
         nR+6tsJCbiuPVqo+jjivq3pe5B563tX/gRriURBI1NJj8IcOt/AZchxxTQh/r5WP93ws
         6w5/4PJ8dFb7+sx2Fa9/tjKjMpb3y+ugS0P7KNtORZ7nwf1C2T3fOGblSet3mRvcwzog
         9g5A==
X-Gm-Message-State: APjAAAX4aTKAPaJwbhtMFi1WXGOphnCx/DTD039miILSkOpVfSHI2yte
        7SRimclU8JPFesdUFsBH7os=
X-Google-Smtp-Source: APXvYqw6ZEMnpha5XCDbIvNtiOuep0jp4imvqTJh2Woy7CGxoh5T4N0DDfQGVf/ZJoBoO90+uDIqLg==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr8328858wmj.2.1561765670272;
        Fri, 28 Jun 2019 16:47:50 -0700 (PDT)
Received: from localhost (p200300E41F2AB200021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f2a:b200:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id 18sm2622459wmg.43.2019.06.28.16.47.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 16:47:48 -0700 (PDT)
Date:   Sat, 29 Jun 2019 01:47:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric =?utf-8?B?QmFsbGV0YsOy?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v5 1/7] dt-bindings: Add panel-timing subnode to
 simple-panel
Message-ID: <20190628234747.GA1189@mithrandir>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20190401171724.215780-2-dianders@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:17:18AM -0700, Douglas Anderson wrote:
> From: Sean Paul <seanpaul@chromium.org>
>=20
> This patch adds a new subnode to simple-panel allowing us to override
> the typical timing expressed in the panel's display_timing.
>=20
> Changes in v2:
>  - Split out the binding into a new patch (Rob)
>  - display-timings is a new section (Rob)
>  - Use the full display-timings subnode instead of picking the timing
>    out (Rob/Thierry)
> Changes in v3:
>  - Go back to using the timing subnode directly, but rename to
>    panel-timing (Rob)
> Changes in v4:
>  - Simplify desc. for when override should be used (Thierry/Laurent)
>  - Removed Rob H review since it's been a year and wording changed
> Changes in v5:
>  - Removed bit about OS may ignore (Rob/Ezequiel)
>=20
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
>  .../bindings/display/panel/simple-panel.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)

Sorry for taking so long to get back to this, sounds good to me:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0Wpx0ACgkQ3SOs138+
s6FkAA//dq1vkl6yNj7/hlMzdjFe9maoEW7fwyt9MG/kUuV2+7K/iB2hj9M9DaKS
36rSIataHUoMbKAZprhPFKpa4Ux0KVuFcld+pU/GfvX1ux+omwfYZioEtkacrlFa
FVpTSbqsQm/A1a6jTK/44si7bTgnG3AiJ7Nz+7+VBEn0Fsf+Hua9GUbwMHCPz1lb
fRuJXIEGj6s9ZnCd/2YevxcrAscypxSeU5kAePyZF2i7bdeta2TR7655vYQkdqOb
nNFz+2R53UC5P4K9ekNZPue3QivyLjyN9M+OCmf+uSkdCK2RLF/lGKDtzcxtbMJF
FK4bsJRqF0icbG7bQucnIIIf5zgUFWuURWyzciqEa0TjnkqIy4Ugdw7iUY6MERlE
fn2u1wJAjWuztuyl9FSOgBs86zFvlnW79FkX7q4Db4BZSU1c7Vld08Cw0/scsuuW
fwJMzZSf/vSshfuJrXRo8wB+YsU7WgY0Y6v7IYx+5r3gvxKAGy02i/rjvPRb+e9c
0kvQKZqBYPxZDv3xkWZHLD4fZo5vkluDnxxTU/6omXTRCsqIAS26XZ8jlXE5fcHk
0hfy2HaCXhG7ckpQusum9uasjhcpQg3QKxul3oqM2iD1XvJIwcBwJq15pMvUm5w3
Qqm5DatatB3t0U+G84KTeIEzFIBNjeLY0kNjTOa0Ke9GRDyGoEU=
=lrYn
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
