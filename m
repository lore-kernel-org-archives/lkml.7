Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E73CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393F8217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9ChqQ+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbfJ2NC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:02:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50206 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:02:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so2508394wmk.0;
        Tue, 29 Oct 2019 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSZ29qPy9/FInL47JLj2nFrRE+ZbLKgI3ciLkri+AgU=;
        b=n9ChqQ+peMYMIs1zHPamOQMIEEGUE2OYBnNREJKqLmJbBwpVVt74QagiVoQEf+LhT4
         yEx5epph6xu/DntWAI7QxyfiRlmv2uehBxKdYvXbres5RuX+pAEP77jJt0qCu1XvYZ/a
         OJPUcYCEBib4Ayc7MTgGQWs/89F4OSdD8+UoU05dNz8YDzd3TLfppfLVSxinfukOgnot
         0x4F6Wvwj9TF5mrJ2G9YGjcdiG3wHl5XYGrZtBGBHwtXcrl0dOPosMD/wCETdCB+4M07
         +oQgRG19V52o41pbm9spoUJKzThvSvWIBsjPnN13cmHCl9UnlGXkY/9nu1FH5dY6lyXG
         oDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSZ29qPy9/FInL47JLj2nFrRE+ZbLKgI3ciLkri+AgU=;
        b=TtckWOUI72ob0IvV6HdBAz4p9T329vcUuugc1etLmCd5Gq9MTsBJm7PDmecH0gm9GQ
         wkmS4FyP1sXfByvbl5q0sGWoULZUfTZ+zAYszxf2R2rPAoCvR0klowWBjX9xVicqBwWN
         FppZV6s6vlO2dZ9y0mHzac8hzhX/PIqaRo+Q06EWfBT1023tbu9ULlhR8+5A4YXU7Kfu
         WjyNGKzG+vvEe6An+oOKL3L1AeS2CupPBhxzJ9YhYuvAjbkdMMwvGea23ZvJm7baQkpD
         MyP46L5IP9OqfH+FeNgnJhSHR8hzC34EX7w6wfx4BWMG/zRgCjAOGTt1Am/BIWltutYm
         Mz2g==
X-Gm-Message-State: APjAAAU/MmQu3lZ2mnhoeB856DFTWjIx+fqUAyRhb5/e5v9/wuI8ecyP
        u1WnIyHDoN+jbDQVZkl7hyAQNMh7
X-Google-Smtp-Source: APXvYqy8XyQuID1iVThumXHAcfcDfb8IpLnVVC4oC9y9sgQjSAOLWr4VFYd+cQY1Ox/Cda8CTWcgSQ==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr3940805wmh.158.1572354145536;
        Tue, 29 Oct 2019 06:02:25 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id u1sm20356221wru.90.2019.10.29.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:02:24 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:02:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Support regulators coupling on NVIDIA Tegra20/30
Message-ID: <20191029130222.GA508460@ulmo>
References: <20190725151832.9802-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20190725151832.9802-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 06:18:29PM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> The voltage regulators need to be coupled on NVIDIA Tegra20 and Tegra30
> SoCs in order to provide voltage scaling functionality in a generic way.
> All necessary regulator-core patches that added support for the regulators
> coupling are already have been merge into mainline kernel. This series
> adds customized voltage couplers for Tegra20/30 SoCs, paving the way for
> a refined CPUFreq driver that will utilize voltage scaling and other neat
> features. This is a resend of a leftover patches from a previous series
> [1] that was partially applied by Mark Brown. Please review, thanks in
> advance!
>=20
> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D115626
>=20
> Changelog:
>=20
> v2: - Some days ago OPP framework got a change that makes CPU regulator
>       to be enabled at the time of CPUFreq's driver initializing OPPs.
>       In a result the CPU's voltage is dropped to a minimum value on
>       CPUFreq's setting up because there are no consumers at the time
>       of regulator's enabling, thus CPU is getting into a big trouble.
>       This problem is now resolved in the couplers code by assuming
>       that min_uV=3Dcurrent_uV for CPU's regulator if it doesn't have
>       any active consumers.
>=20
> Dmitry Osipenko (3):
>   dt-bindings: regulator: Document regulators coupling of NVIDIA
>     Tegra20/30 SoCs
>   soc/tegra: regulators: Add regulators coupler for Tegra20
>   soc/tegra: regulators: Add regulators coupler for Tegra30

All three patches applied, thanks.

Thierry

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl24OFwACgkQ3SOs138+
s6EL6hAAmsRFT55RAhQ6AhkSpGk/FCoDTu+zuHf3m3lS91LuGmYCkvxyKiCgkTBf
ZzEgbaqOlM7FdaW++Au+vGooywMUwgsDyBw6rzSPTiz54Vt3YxEcs1HukLf9almB
IvmO9AoRf6ifH6wZLNbYLrzsdpOxjgKJMxmOn2XZh6hyPS03Olp/T+m3DhXNUAz6
B7LUK2DheI14aQ1OPs9RP6SnN+g/tXdO9k5tGuqqI/OXkUdTqNN1l/uIWcKhYoYK
0Wi3wdp50qsuAOxAWuqX7miWV/eewLO2XM+uB7Xe0ooqspCbK5iiQC+pp+EF08u0
7IuF5kb7arW5yeAbnMfvCiOWFY5bqk5VrRgeUWjOGfkh6ZcqzOT3PLaC/jlCMCvB
u47/l/XN2YQFjHooZT8GngezSDwBkTHBSbJr2xz8gxGnMWnIaKo2sVR+Xps0TT1W
UXFQLorJd608gPu4+5unZDJKf9EhgSDr4umndO6YgNQd2WH5A+I+OQPHdDbpYdML
baZC33pLnN/rjm9alKzOird/NUlLJ6boFc4p2nscQs4barX9geQqOol2i02PfETv
NxQvf+simgk5WazA7aogM9oKFckaYlXIQ8VRS2a7YyL0lW7bdAZEbD4Bdz982gDb
nGtTq+SYRfsFhZFxN504UGy8lbYcU+szGcys81vBHXpDYgDcYf8=
=F8yu
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
