Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE55C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9950521882
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rtCZuTiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfEaBcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:32:21 -0400
Received: from ozlabs.org ([203.11.71.1]:39451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaBcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:32:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FRl51mj3z9sCJ;
        Fri, 31 May 2019 11:32:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559266338;
        bh=ENrMprAgC7Pqmh5Zpsocx65Enrzzgtplf0cUUx2IBkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rtCZuTiIc25EynzMguFPWOC1VDMJr/7ioblJT/MQPe/wokGzLTMvWYeKbI4NtxRh6
         ZxPdHIdWxlnMiA+A3tC6vkjiI87Bu7Pmuw7haK21fLpdg5gse7kw68vvtuQFeTCAJI
         XsslUFC48qw2xa625nM79vRiPWhidTIKp8eH2fDY+3ChWY2gIfa463ZopZRhYlrfW4
         1h2/ETlF3UIuym8WL6FLuIG6vh20FnQhYYN7PSbKgSQXa/xBC5xoddeUs889GqcDu6
         9MUTbB+6ib3CIdneewBKDk+s3mowWOtJPid/5LIcMl44hrYVqvUDilI/m4azivW3kP
         z3pR1ImGtJL8Q==
Date:   Fri, 31 May 2019 11:32:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] firmware_loader: fix build without sysctl
Message-ID: <20190531113216.796bb933@canb.auug.org.au>
In-Reply-To: <20190531012649.31797-1-mcroce@redhat.com>
References: <20190531012649.31797-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TPqHE_Oa=ZmOD5cJXg/Xd=E"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TPqHE_Oa=ZmOD5cJXg/Xd=E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Just cc'ing Andrew who is currently carrying the patch that this fixes.]

On Fri, 31 May 2019 03:26:49 +0200 Matteo Croce <mcroce@redhat.com> wrote:
>
> firmware_config_table has references to the sysctl code which
> triggers a build failure when CONFIG_PROC_SYSCTL is not set:
>=20
>     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x30): undef=
ined reference to `sysctl_vals'
>     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x38): undef=
ined reference to `sysctl_vals'
>     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x70): undef=
ined reference to `sysctl_vals'
>     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x78): undef=
ined reference to `sysctl_vals'
>=20
> Put the firmware_config_table struct under #ifdef CONFIG_PROC_SYSCTL.
>=20
> Fixes: 6a33853c5773 ("proc/sysctl: add shared variables for range check")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  drivers/base/firmware_loader/fallback_table.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base=
/firmware_loader/fallback_table.c
> index 58d4a1263480..18d646777fb9 100644
> --- a/drivers/base/firmware_loader/fallback_table.c
> +++ b/drivers/base/firmware_loader/fallback_table.c
> @@ -23,6 +23,8 @@ struct firmware_fallback_config fw_fallback_config =3D {
>  };
>  EXPORT_SYMBOL_GPL(fw_fallback_config);
> =20
> +#ifdef CONFIG_PROC_SYSCTL
> +
>  struct ctl_table firmware_config_table[] =3D {
>  	{
>  		.procname	=3D "force_sysfs_fallback",
> @@ -45,3 +47,5 @@ struct ctl_table firmware_config_table[] =3D {
>  	{ }
>  };
>  EXPORT_SYMBOL_GPL(firmware_config_table);
> +
> +#endif
> --=20
> 2.21.0
>=20

--=20
Cheers,
Stephen Rothwell

--Sig_/TPqHE_Oa=ZmOD5cJXg/Xd=E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwhCAACgkQAVBC80lX
0Gw0qQf/evM65VBHkhgx3KVeMRBmdSccZ9FHYEeofJFXMPJwh2vm4AEAws/PYLRH
RL529NygtdmzuK6f/+GKNvbRVXWR2KA2/iBxPFvQOq1aAQDeomLVGrgIXTApy/5D
44ddPNZaVDLToM894A+DKetLxq8p1+ir9KAa+ZEM5EbZbd34vWJkC8u0HtMscmFW
zyvpA8d2YBZ+okjdI89AHFbhYnD7x81+ukkNxTkU3Xiy6syyuit5c/JIjHDzTP4a
nlHygjsJjVXusYBJVHS+HU2hN6s6+NCVtFCaLeIdp8SJvki/OXsvJuZPMZuxVbgk
pzZDpKGs3wSJxfyOqvyZET0wdWNyOg==
=MEoS
-----END PGP SIGNATURE-----

--Sig_/TPqHE_Oa=ZmOD5cJXg/Xd=E--
