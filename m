Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1D32084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8xYolbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDIOmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:42:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36363 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:42:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so3658571wml.1;
        Tue, 09 Apr 2019 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ozWL5jZpG526a1uxyVk1Zoqvf7S42RjaByqQY1oWS/w=;
        b=R8xYolbKWi7+8xqHQtKuqMMhMWAUfGGLdMj6JytTXY1nxnTkBIi6s54l1c5QSdVjqB
         4pyaf6iqk4yoO37K45f1xSlGyqZ1xnyTAZMSP8uh8QUhPVnx+XRR7lPu6UOebFZXnLXC
         rK079cZ/znTc7ZXg0cLhP8ZyHoZ8p7UCVVBuEzoO3wZfK3PjZxZ9FkApcVN3LJo8wn7S
         LJ/HFdrGC9FyikhP8hLJu1MQ9DdcJ7J5Ot+bqT1xVD6cGkr7IjzT5w0aDlEkk42YPA1n
         FG82za3SZiycCd84KcnZQEac9XFOOfcyXOr8VdUvL+X2DlJd26bdeCEKNkmvHXPo/N+1
         i7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ozWL5jZpG526a1uxyVk1Zoqvf7S42RjaByqQY1oWS/w=;
        b=PIbHxdTOS9VxN/xoWGlJtH2N5Qv0p5iG8XP3Sd0qWg6wag0zY5DJBqXuALodjZnaQU
         81dUGCLXaUfAeHnth5Vg236gqcQ2U4PIP5fknBUhQA+rWRtjtk4VgVKqgkCak28dbE19
         lGQ8ZdyAAf8Se4vt6u2YITzmBljalozaw+S8c8HDYITLuTgGecpgUp1oPX1raget7WcC
         thYdSn0NbrjfAzgYxT6eU6ZzxC243WsdECR3t1gTXXKDgphRm+JKaVlczKZzQpShDO29
         ccvqE6mj0GBHLZFg3IUNZHpWz0aVU4F0OFfMi0D9qH7Ux/0KPndC0xQ4Zr4zTvgw9mza
         va7w==
X-Gm-Message-State: APjAAAWhgYWXrGC+CCiUnhX3SoszQe+VGIFKA4Fg+ypEVu3Rd9gNjB2+
        4ERiZQbyWJ/NR8ef92ENF+4=
X-Google-Smtp-Source: APXvYqx/i+QboGXXc4wjqeerlV2n1HMdG0BAGgivNnLTtRN06rGzcYSj/sfFDSUNxi604qWUKGVK5A==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr22787809wml.110.1554820942152;
        Tue, 09 Apr 2019 07:42:22 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id b134sm29953397wmd.26.2019.04.09.07.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 07:42:20 -0700 (PDT)
Date:   Tue, 9 Apr 2019 16:42:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/7] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190409144219.GA29887@ulmo>
References: <20190317225211.23091-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20190317225211.23091-1-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 01:52:03AM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This patchset adds support for the Trusted Foundations firmware on
> NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
> firmware and upstream kernel can't boot on those devices without the
> firmware support. This series was tested on Nexus 7, TF300T and Ouya
> Tegra30 devices.
>=20
> Changelog:
>=20
> v10:    - Removed duplicated message about keeping L2C disabled when
>           CONFIG_TRUSTED_FOUNDATIONS=3Dn as was suggested by Micha=C5=82 =
Miros=C5=82aw
>           in the review comment to v9.
>=20
> v9:     - Rebased on recent linux-next, resolved one conflict.
>=20
> v8:     - Replaced BIT() macro with a definition provided by cache-l2x0.h
>           in the "Support L2 cache maintenance" patch as was suggested by
>           Russell King in the review comment to v7.
>=20
> v7:     - Fixed kernel booting with CONFIG_TRUSTED_FOUNDATIONS=3Dn by
>           providing a dummy L2C write_sec implementation in the
>           "Support L2 cache maintenance" patch.
>=20
>         - Minor clean up: no static variables anymore, replaced
>           white spaces with a tab in one place, etc.
>=20
>         - Added Micha=C5=82's and Robert's Tested-by/Signed-off-by to the
>           patches.
>=20
> v6:     - One patch got messed up accidentally in v5, this is fixed now.
>=20
>         - Squashed "Support L2 cache maintenance done via firmware" patch
>           into the "Add firmware calls..." patch.
>=20
>         - The l2x0_init() firmware callback is now invoked unconditionally
>           because it is always a NO-OP on T114+ and is a NO-OP on T20/30
>           if firmware node is missed in device-tree, hence there is no
>           need to check the machine's DT compatible as it was done in the
>           previous versions of the series.
>=20
> v5:     - Fixed machine hanging on disabling D-cache during suspend,
>           turned out there are slight variations in behaviour between
>           firmware version in regards to cache-management. Thanks to
>           Robert Yang for reporting the problem and helping with the
>           solution.
>=20
> v4:     - Fixed Thumb2-kernel hanging on Tegra20, turned out it was not a
>           good idea to switch CPU into Thumb2 mode right after jumping in=
to
>           the reset handler.
>=20
>         - Moved LP2-mode-set firmware call invocation to a later stage to
>           better replicate what downstream kernel does. This change was
>           suggested by Robert Yang and fixes system hang on Ouya game
>           console.
>=20
>         - Added references to the original work made by Micha=C5=82 Miros=
=C5=82aw
>           into commit messages of the relevant patches.
>=20
> v3:     - Implemented suspend-resume support.
>=20
>         - Reworked arm/firmware/trusted_foundations.c a tad. Now cache
>           is getting properly initialized, cache enabling / disabling is
>           supported.
>=20
> v2:
>         - The "Don't apply CPU erratas in insecure mode" patch got some
>           cleanup, in particular resolved the messiness in
>           __tegra_cpu_reset_handler_data.
>=20
>         - Added a comment to tf_cache_write_sec(), justifying the warning
>           message.
>=20
> Dmitry Osipenko (7):
>   ARM: trusted_foundations: Support L2 cache maintenance
>   ARM: trusted_foundations: Make prepare_idle call to take mode argument
>   ARM: trusted_foundations: Provide information about whether firmware
>     is registered
>   ARM: tegra: Set up L2 cache using Trusted Foundations firmware
>   ARM: tegra: Don't apply CPU erratas in insecure mode
>   ARM: tegra: Always boot CPU in ARM-mode
>   ARM: tegra: Add firmware calls required for suspend-resume on Tegra30
>=20
>  arch/arm/firmware/trusted_foundations.c    | 75 +++++++++++++++++++++-
>  arch/arm/include/asm/firmware.h            |  2 +-
>  arch/arm/include/asm/trusted_foundations.h | 23 +++++++
>  arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +-
>  arch/arm/mach-tegra/pm.c                   | 49 ++++++++++++++
>  arch/arm/mach-tegra/reset-handler.S        | 50 +++++++++++----
>  arch/arm/mach-tegra/reset.c                |  3 +
>  arch/arm/mach-tegra/reset.h                |  9 ++-
>  arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
>  arch/arm/mach-tegra/sleep.S                | 14 ++--
>  arch/arm/mach-tegra/tegra.c                |  2 +
>  11 files changed, 212 insertions(+), 22 deletions(-)

Hi Russell,

I've picked these up into the Tegra tree so that they can get more
exposure. Let me know if you have any objections to me carrying these in
the Tegra tree.

Thanks,
Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlysr0cACgkQ3SOs138+
s6GHBg/8DqguXtSetEPBS2EtjqywGqkQyKSlMC+yEApOObNg8im7izuGx3Ky72M6
WrOeTrUryDGV74twQ59+D5JY2/y6bfpKYYeA47/bzdOEXPpjaXv/kDTl0pBd12Q9
Vo/at/ccr7U+3nvbWOAFc6s67VWIGG9fxMDFZw7gRWBWKuc0o1B2+V0l8r/Pb+E8
7/a6ptZi67PKQ+znA/LM1JYrtFHOSZgqtLnEZF9A9tKXd7MN67oskVEUQg306u+t
nr2woCN66FTANY20k3Jbu3LiJ3z2PzgjeVheEMC427jZwwPB5LVG8A7WSvEbcjq4
MqzRq1Ku3Nu8B3bNLBOWupL7rFuQHPR45fSw906icjv48aku0CIxGc7r8M3v9sDi
IK8LOiMIwCz+vvvC8IJb9ACK5Qlmj1Klc0KYiR4Kj+jzGV0/OMmzlm3AMmiT566j
hWaFbvJAgTVnQ29EOR6tLBM0etC1oCFeI0+W6c0PMGm9AadGV8Epgy1z993BMjy/
FC1JUgy/Amf1GRZgpBvycL8GhK0gL6/t9ldLA/SpQjy8kmqZuihl3rVAvwhSLYfn
QVCq612vQdT1sHQR44qukLCBDDker2QKcoAAYQZogKGbK+WUGFvdSlXY4PiCzsYB
sr2yTykJbGbkGG7SNTRh03w1f20+M2HoVxX8n1WRNpZws0uPYIc=
=X7mn
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
