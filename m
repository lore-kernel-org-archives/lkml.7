Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53CFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB1620836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="ApEVEy0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCIQra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 11:47:30 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:62345 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfCIQr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 11:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ulGqVDSUycX/BoqmH9Fe4QsVBAuubtWT/nsBLs94zsM=; b=ApEVEy0nOrrJ1Lmpwtx/8cwEmJ
        OjLwX+hK8hZFfXZGGREEAG8UxHcbuiJjHtdIUywtKVQHcKx0U4xQWEZN/dkubfawNz9UZAErT2G37
        D4TKrWAGhI0wB33S1AGFhjn+VA/XgQTz1I/G8Zlda67P42ty2cgCc5/9KWxJFyyoDTuRF9fAzdPX7
        ZiJzbnS3haHSIr6SvC08OBn8n+5rgXcxcpNgTbeOcGrJyiH1PamRCAQdAmmhzpKSP7PI6ieE6kjQF
        q2nLsBxwgxnLpccDZWxNynB0VgTB5Y53LP1suoDpZzWBDl/BmY9Bc0lYCjuiAOpCb5VBDyYzlXWlm
        aOc4h3aQ==;
Received: from [37.204.119.143] (port=57438 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h2f83-0007gt-AC; Sat, 09 Mar 2019 19:47:19 +0300
Date:   Sat, 9 Mar 2019 19:47:18 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Message-ID: <20190309164718.GD25561@cello>
References: <20190309154307.23039-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20190309154307.23039-1-ar@cs.msu.ru>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH v2 1/3] scripts/package/Makefile: put proper config in
 source tarball
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2019 at 06:43:05PM +0300, Arseny Maslennikov wrote:
> It is widely known that one can build a kernel without a .config in the
> source tree by setting KCONFIG_CONFIG equal to the actual configuration
> file path.
>=20
> When making a *-pkg target, make(1) prepares a source tarball and tries
> to pack `.config' in there regardless of the value of KCONFIG_CONFIG,
> failing spectacularly if .config is absent and packing the wrong config
> if it exists.
> Let's fix that by including whatever KCONFIG_CONFIG points to in the
> archive under the traditional name `.config'.
>=20
> We have to pass --absolute-names to tar, since it seems to trim the
> paths of archive members first and only then consider --transform, which
> breaks KCONFIG_CONFIG=3D../../some.config, as well as absolute paths.

One way to avoid --absolute-names here is to do the dance below:

>=20
> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---
>  scripts/package/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/package/Makefile b/scripts/package/Makefile
> index 2c6de21e5152..134cefee068d 100644
> --- a/scripts/package/Makefile
> +++ b/scripts/package/Makefile
> @@ -27,7 +27,7 @@ KDEB_SOURCENAME ?=3D linux-$(KERNELRELEASE)
>  KBUILD_PKG_ROOTCMD ?=3D"fakeroot -u"
>  export KDEB_SOURCENAME
>  # Include only those top-level files that are needed by make, plus the G=
PL copy
> -TAR_CONTENT :=3D $(KBUILD_ALLDIRS) .config .scmversion Makefile \
> +TAR_CONTENT :=3D $(KBUILD_ALLDIRS) $(KCONFIG_CONFIG) .scmversion Makefil=
e \
>                 Kbuild Kconfig COPYING $(wildcard localversion*)
>  MKSPEC     :=3D $(srctree)/scripts/package/mkspec
> =20
> @@ -44,6 +44,7 @@ if test "$(objtree)" !=3D "$(srctree)"; then \
>  fi ; \
>  $(srctree)/scripts/setlocalversion --save-scmversion; \
  +cp $(KCONFIG_CONFIG) .tmp.config-tarball
>  tar -cz $(RCS_TAR_IGNORE) -f $(2).tar.gz \
  +	--absolute-names --transform 's:^.tmp.config-tarball$$:.config:S' \
>  	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
  +rm -f .tmp.config-tarball
>  rm -f $(objtree)/.scmversion
> =20
> --=20
> 2.20.1
>=20

I'm not sure if this is strictly better.

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAlyD7g8ACgkQ9dQjyAYL
01DmLw/9FlAX3xDu+dLPStFypBfPNicW8tAAi1ivnlj+izOPUEcG+lxVmJsyXK+N
WtwSL77RO3ARvABRWiVAikbEjx3dVxdqwXHPpcUgqgGON7FeNb86u0h9LkgWwdtY
/wK2Ksyt4D8JZKnyeFk6UUvgn4egXt83dLzO6N2b6yAyWWDP4Kj8+WBoX5K+jN/8
3DryL1PUz7NGsUbvntrAUNPhTiHzR1CA8kYLtvj7z38VMCuy5GEbGwwVbhvHUFaK
LN93H0TDu93cm5TpPDxsfwDmHe3SU9LTyzbema2FU/LeTTB1cfeqY5EqBhul517o
FiudifGkrrKcO+o0NyxuNT94rQiADrAPcvkl53NMEAs6R1hU+6RY/n8jiEi8ZfQX
uCxQgQmzGyX+zLMzxf10goD1neGri2jqjTGe9PSXqlzCt+xYMmA/J9Oy2exT0w/s
wSTHK5ukCelqrBfNX9sUVdDmTYEOpnyZbB8ndus+HgVi80eR3eCCEKbSMUH/vkSh
b2eaTlJY3r71ouz16MViA03SXM7Necst9IeAdKjlnDtk8od657DJt9fYIHmgkvHo
MMlhKgUzYg/YpJDsNOHEkdtcJSDUxqi2GHudSl3xyb9lXxuCpCz/D5BrDskP4K6w
JV9SHRQeU9/U8tYpDXq34DWTA8Ilht42f5ZKgSdOMb1cDSIdZsE=
=qdIx
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
