Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B51C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08AC2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNe/IM6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfFRK6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:58:02 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44613 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfFRK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:58:01 -0400
Received: by mail-wr1-f42.google.com with SMTP id r16so13421727wrl.11;
        Tue, 18 Jun 2019 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQvVKHxeSgcqLnyzzTyNxjA3usGAS6zCVGXO0R/QfL0=;
        b=TNe/IM6EQ6FqbHKU2iUx8oEi1YKRTXlW1c+mTu0csxW+y5kmr92lTKKS1Y0ki6zois
         GF5j0p6hCICQcxKHwYiiu3LHJYrIHv4SSDyA8LUH3O0cX3bP4LFgpJeGC9WllYCmirzI
         C2nETkBD//rAzimUughJuku57cu2Xj5QGS6BnVSxaRtyf2qMfg/Csrm3Rjnp/vzZO9Js
         r6o4GPYBjQcKpiO5tQQPaPqiCZYBd8wCrraxmz6cSqd62LQSM5qNDCZ66fUsAxnQ7IJB
         O+RBhjUoRtAAruAps5HPBAG2hRJCB0bgkXflCwXOAiWTfzWd3y5pbQ8y6BnsR9rJnZ6t
         pPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQvVKHxeSgcqLnyzzTyNxjA3usGAS6zCVGXO0R/QfL0=;
        b=J+DcPhNGIHBeOEFOylkIgN3n/+B1uhLPLyXmHjL9+R/HCZ00q0YBKQapovk1gOxnyq
         J3V8T5wS6VzdIwe9Ch0sC32Yeox7Vx4zymsex5/s3vC0TQj9iU56Geqb3Dwqak74xGld
         ZtAMa9FbAZuRD6D7X8lICKZclgpaXi3/JPEWMpKtXQESNvxMQZRFjWknDLofmi95P2kO
         +WFcqR4g/HJLvLQbG7LWyk0gQVCHCJ8Jhafi8/Z7UMI+5i6cEyrfXm3UTO+NtKjYw0iM
         6NNvhyA2AU+fYAI/h7CDLyY/RWBjwO++FV/zDbGs6Bvg+4Z2ZfoGw32sB2OkbPe4+f5f
         HBOQ==
X-Gm-Message-State: APjAAAXP1npaEwabtWbPpbKebx762Ewm2t81mblDOLX2MVXzLJHHX9Nx
        HfbBmuUKu66lJgzdAg7C8nQ=
X-Google-Smtp-Source: APXvYqw9hI/mxhmRW42S1eiDNlGbtjcBgBwMHiE+PtZr+RNSXVRedsfSoM3aW+bG9o7NCoR64LBtVQ==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr28758585wrs.152.1560855478819;
        Tue, 18 Jun 2019 03:57:58 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id j7sm14584049wru.54.2019.06.18.03.57.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 03:57:57 -0700 (PDT)
Date:   Tue, 18 Jun 2019 12:57:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: Add INA3221 channel info for Jetson TX2
Message-ID: <20190618105756.GC28892@ulmo>
References: <20190617221659.25366-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <20190617221659.25366-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:16:59PM -0700, Nicolin Chen wrote:
> There are four INA3221 chips on the Jetson TX2 (p3310 + p2771).
> And each INA3221 chip has three input channels to monitor power.
>=20
> So this patch adds these 12 channels to the DT of Jetson TX2, by
> following the DT binding of INA3221 and official documents from
> https://developer.nvidia.com/embedded/downloads
>=20
> tegra186-p3310:
> https://developer.nvidia.com/embedded/dlc/jetson-tx2-series-modules-oem-p=
roduct-design-guide
>=20
> tegra186-p2771-0000:
> http://developer.nvidia.com/embedded/dlc/jetson-tx1-tx2-developer-kit-car=
rier-board-spec-20180618
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  .../boot/dts/nvidia/tegra186-p2771-0000.dts   | 40 +++++++++++++++++++
>  .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 40 +++++++++++++++++++
>  2 files changed, 80 insertions(+)

Applied, thanks.

Thierry

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0Iw7QACgkQ3SOs138+
s6EXmQ/9GZLFKQR0NGbOGAN7fcKrt2ibZoOvzKBBoHjDUnPERTfkFJFPZpr1QiI1
s2lG+C4nzxfhh2VMLBjAB/T4S7icF66zo7azRRhOeWZYYt7yfjv61wn48TOEV0vo
BKWR9NF9f4CUc4bAbMwkD9rGc3FLkvrh63rxPzPCqboY0k0tjz/rss3+DoSYaSY3
C6yu4gej37N/Bj9jFx6l0RKIsiLVErLrnHupqzgKsqNjbaZOIwQgJPvVQFxt7QnA
9ckz2JTV2AEYjsD2EG2rUw3Sy/CeyD7OgpLhWaQ0yaw5XQyyVpuZJvGTYrjgxn1b
lAW+MlmxGBxhrYmOzRhh11FAZwTAtObaLdjGk1jaR25hnw5DYk1ESL8mlTaxUTWA
3ISZU9ADj5x7BHF0M5f/YH0FRg8BdBS0BgDGGiMJNcNk+HNrhODhrEY66vLcTjDZ
Tg7TL9sPnAgeRumKc/xnV4sa1CJ3HLR6GdxxUMgD64OzRH0xKEeSBhzadGenCzyp
x6EYsHAETEc0CER1WzDDgsGEsqxHPegpe8e+eI299Qf7yhBzLA4D43eI7GeCRgQo
Z3yMBrxH8GW6co9v2VTHbDiFuBLjPtiwOSvWw4jHr1HpguVA/6S/wzYAD2tgjPk7
9838K6HJj7rOiC0Ojzn6fGi7XS0nnDWIGnjMpaTuXjKWi++mc/g=
=sXFk
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
