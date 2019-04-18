Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B16C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D82621850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLPiTePc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfDRJhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:37:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43510 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388044AbfDRJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:37:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so2093127wrx.10;
        Thu, 18 Apr 2019 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K1yKs3xjyvTm0JerwEZ0w+2J5kLt5F3EWz+1Zn1GS9U=;
        b=DLPiTePczeDe0uJkU+NxFf5mURLKzHUWXCMeJaZlMlb9zU5yFe9fiF39cFkLOqD0sd
         IK40CqfcXmHky4O2AGgjd6tas0azZqGa/5513KkwJNyeHNdY5WpCBZXSZ98GPhzAb36a
         dm8iFs5sEGrjc5WMWj3oWiQqRzPEe1hgLszPdx/u2ExBdoH9A8kkv1yu8GxbdzB6OWOi
         BJC3n6SjgHR0edISbaxT/SLkHEJIHuUjn8qmOvRDCcWCiJVug5wJsALK41X7jCZ4vwe8
         ihE4uXGCXhLIURp7SiitIIg5YXBeH7ad9MO6+vcDSCCeX3JayzRM15olYOIgy0J5C8a/
         xEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K1yKs3xjyvTm0JerwEZ0w+2J5kLt5F3EWz+1Zn1GS9U=;
        b=LbGzQ2+Y01Y2c4xPL2PNYEAJD7lZMjoyUu6RJc5LDR1jfnFYVgVrryuV0a2Bxvbw9d
         vlX+TbjO8JzVYeA9spY9IsRN/UkiQoRxsZ/DTsGw+l6xRlrPTohYA/Bp5Io9OjOWnQx7
         qWI4fF38V0OrTLmSyJ4MZC77xLs/htLNba5coCJzH/1hi1ecqM6RhDsVd7U/sNpVvN3s
         EaDMzMvcCFu/InjEiqVH/L1pU4lJZqOA5oL8NqYlhdF7VOgABFhgqZdxX8NOAOLOWXs5
         YJ+AI1cMI9ck1umy/c5pja5KDRNSuVX5WFDUYsst2niLOcpzJoqXBvq56BnVcab+2F1r
         hAPg==
X-Gm-Message-State: APjAAAWMDdAHTv8xb5FqIlsM5ByhaGRcLgqzjBHYgTPvWVwLWi/SRrVq
        +CafpCYi+ipl9ou/TxsZ8Yc=
X-Google-Smtp-Source: APXvYqzqAYzev5XGqzda79un5BnDvgl/dW5mRF0S6RdhZeUTVbqxW/aQlEwqQd/mNCK18m7Wt0uxNA==
X-Received: by 2002:adf:82c9:: with SMTP id 67mr40412362wrc.261.1555580226550;
        Thu, 18 Apr 2019 02:37:06 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id j2sm1602515wrq.30.2019.04.18.02.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 02:37:05 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:37:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] memory: tegra: Fix memory arbitration programming
Message-ID: <20190418093704.GB26909@ulmo>
References: <20190411221250.23233-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <20190411221250.23233-1-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 01:12:46AM +0300, Dmitry Osipenko wrote:
> Hello, this series properly addresses the bugged memory arbitration
> programming and in result the previous suspend-resume workaround change
> is reverted as it was not entirely correct.
>=20
> Dmitry Osipenko (4):
>   memory: tegra: Fix missed registers values latching
>   memory: tegra: Fix integer overflow on tick value calculation
>   memory: tegra: Replace readl-writel with mc_readl-mc_writel
>   Revert "ARM: tegra: Restore memory arbitration on resume from LP1 on
>     Tegra30+"
>=20
>  arch/arm/mach-tegra/iomap.h         |  9 ---------
>  arch/arm/mach-tegra/sleep-tegra30.S | 21 ---------------------
>  drivers/memory/tegra/mc.c           | 16 +++++++++++-----
>  3 files changed, 11 insertions(+), 35 deletions(-)

Applied to for-5.2/memory, thanks.

Thierry

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly4RUAACgkQ3SOs138+
s6HFZxAAv1SMNkMMV10CUV/I1oKABugaKaYp/1uUuCYsUcUkFT/E7xHgOdpWCX8r
PPnT9v8MDwkmHqcoTtQs4e/D956pDRVE7BnVp/F1dgtCgksLUAwrsqjGPEUUd8C/
9HbmhmvHA8NxasQhbXXOno+7N/gHGXxjWDEo+slcfVe15qX8jm479qJKS6sTPUBz
eLYnSqfj7A38kLc+vx6aergOexRjMXkJR3SlqVG02PkeRzDnWjgoS0dNRgBojP0P
L3lZd18LadDPwCe0/tGpXoAA7xSw4XCKJ5v/BgwjFdpxddU52xJGXiWBIBrXXCa6
vlRJdZ1FbMJgJRYRAWgr/xe+zG80dplK0laTNcMtA+owiDOFAv3yshY/Xtp3xzVs
a86AczPAJIb/YdY5XBfVYGJvvgYm0M0ucLnoaK5lucMrdCcse4FLnRbyig4mwB/Z
1XfgyMrxtsjK0BxwkB4plNfd6dZuFY9U64VoVLXGlYatw2/0jnBFLMnld9Y/Ucnm
eWGe4DnZmfowY6fF05bhAee43Q9FoF32oyLRuzsgUl/C5JXBaVvTmNXK1phngrLm
DFin7iYow8kFEuwVh4ArMxQS/igAcscDgTBAOWZvCbx5TvA8HUCsRZezfZiTxn+R
kSHf8C0y6EDiUVU2NiTcrX1x5Fs82UePh/cFoyRxvgivgBvVO3M=
=lgmQ
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
