Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DBB21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBDmZpF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfC1QOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:14:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52836 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfC1QOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so4198187wma.2;
        Thu, 28 Mar 2019 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PwLP4GHnY7t3ILf3RUqHf/6mqNVCKol4vS1jhfznyc8=;
        b=tBDmZpF7gZOh4mbtgFSvDXBq+twOkd85QGHgnhhcYs0QIIcMVhk2osdtmggN+UXRI+
         G69R+fYTuobjqRnRCc+yrhXHCuwOE0l7qvlKrTKuSBjEKSqB1UUbTng44sKzVM0ShaWa
         VBQ98P2xVWH9D+8P6CsEyivSdDEmbjPZHLhj+QH3ojTRnMVUyg9qrgAUrhtPGyRMIEeE
         8DreyscYOJBhKPa0NQq4M0ozzXHQ8FwxKIEuXeefBC0t1EAI4YCFMVCAhiS59eIJlalr
         H0ed/LPzjaY2uheMV8idcWHr/GZzE8EgP8wdRnaSMUIvZKCTQwELkuKUtxpeVT5TqfW4
         R7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PwLP4GHnY7t3ILf3RUqHf/6mqNVCKol4vS1jhfznyc8=;
        b=R3cK33FkwmorrAB5l2WQ051izRHJEt4DZHzEtiSdVxdo+eZJJS2fDZUjiltfOk6F0n
         KMoXDobDfshsAPvyPU1LaiM94nbkcUK+lc2boDJgSxXdHFJCrm+W4/X/8+KHVnZFST9X
         Ty8yj7P+FG8nNe+/ALU5vPWfl7+uT6IPNq3MiGLmGUkiHfgNYA8Zso1fzA0JdJNjHnpr
         zU5FjiR0OHkfk/DqEURGuR3s+Do3cL7G5nwDOX1u3dYDw9eNFZ+XihiF+eJ2O5qoRM5n
         MJGCqoz7SBaqG5+/0X1Ib/xA0A7wEeqfCjIKXO8GZTA4y5wKYCiUYvT1QJvDVfR5uFtt
         vIUw==
X-Gm-Message-State: APjAAAUYExd1qW9DENpHpp2zL+HvqcpVY2Tv3av8HSy5oYb/4Neey9N5
        VLUKxU7pIXbV6sE7kMUzalw=
X-Google-Smtp-Source: APXvYqyHnmzsr+mw6eztpiFX2SxY13B5l84UVRw3FcRLQ9K3DJX0sHA6S8z/+xBh+VpZZ5Smr3ptnw==
X-Received: by 2002:a1c:3543:: with SMTP id c64mr535323wma.75.1553789679088;
        Thu, 28 Mar 2019 09:14:39 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id z20sm3373891wma.48.2019.03.28.09.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:14:38 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:14:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     linux@armlinux.org.uk, digetx@gmail.com, jhogan@kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] ARM: tegra: enforce PM requirement
Message-ID: <20190328161437.GE5518@ulmo>
References: <1551255628-4794-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <1551255628-4794-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 01:50:28PM +0530, Sameer Pujar wrote:
> Currently runtime PM is enabled for Tegra HDA driver. One of the concern
> raised was about handling !PM case in HDA driver. In this case, there is
> a need to manage clocks and power explicitly in the driver and reviewers
> were not really convinced about this. The consensus at the end was to
> enforce PM requirement to keep things simple, rather driver mentioning a
> dependency on PM. This is how it is done for ARM 64-bit Tegra platforms
> and the same can be done for 32-bit Tegra platforms too.
>=20
> Finally the objective is to remove dependency on PM availability for all
> Tegra drivers. The detailed discussion can be found in following patch,
> https://patchwork.ozlabs.org/patch/1031007/
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/mach-tegra/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-5.2/arm/soc, thanks.

Thierry

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyc8u0ACgkQ3SOs138+
s6EdjhAAk1+0yhpb2a8qaFvS5uO1yjOA6wkkw/sTEkZDvfAA01N5/Lg4nn6i+Obr
4zTcz12Q/uk15Gb6zrAMSnztYlqIwCdzRRSCgFxa47Ob+So6b3PXAVNV4l3y9cXA
QMlcw8Ua3bztPstydBzqP9VxdNjtQF9KW1ZZp7GglkpnBBLCguJwLpsr2I9BgWm8
UqAOnSjT1o7gauQXE2dhifNsv7ZV+sL5PqKUs+cQAUo2RdGgDAtipEhJzosK0q4s
Dtrw8JKVKjxWkJF5F3AxlkGp5zjqk4Wcgzlw0Wb+OciFX3b8bcLtCO0Zrm4Kf5Lc
vDgWmv9KbNu0rWpc2TGBTr2kv62j2u2Ea1IB455NPuXw1itMt/+d2nPkNh+AJ+xZ
+CnEEknhOUjLyub7XW3mDERvTtV3kDIRGmj6az/ivma4Codyg6Xzf9Rh8LMNO539
VWR+bpxcrelQw5aWA7M7dGOOU9II49iaEmHec7rJeuHPGo7kWxIRHpEWEn4xAoHN
ozvo8+Qv7jR3BPNHM5Z7e1PjVRF2znIbY4LMhbILBmEjUGlnhUnUJ7FRjp72bKTz
kXaj6Kd5PSYz+BbgNjdv0SLRIGkjEb7iiZcMlimPYEvIiHOyZp6U5mGjMgCmsitT
NuP4s3b5ZPCJarWUBAvBeEewlpC1x33pAx89U38E/9oT+Kj2vm8=
=WZZP
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
