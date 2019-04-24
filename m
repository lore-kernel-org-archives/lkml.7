Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2595C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819DB218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gm7ZFFdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfDXDMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:12:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfDXDMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:12:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44plk31kmfz9s47;
        Wed, 24 Apr 2019 13:12:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556075564;
        bh=Pef4uz0152MX4CcOjtSGFDRkpz/wudSxiVW/2mNvbss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gm7ZFFdmzWcTIh8AnZoZGK9ddaUVgqe7e7zZ/eeQCe00PinfNroUZ/IWnANCWS5bl
         kNqSWoyTpr89Sqejxr6C0cJQAldK+A4//TJoKvOsha9pKvh56iIutXsQOWWZkO+OQ+
         bd0j2Gke9JeEZhzFAvodQVaKcfEa63xl0CmP0Huzans1E0KBva6LKvQPMS5uTohcNv
         Q0jcp6HSTcjVVFoMTaPg5zM2kTtKfoL9cfKI6JMi65ZYTLB9d9p5n1t5XPoEJOCzdN
         hV8rVHQtcLGHZHaoMLfOzzoafjjabXE+3cUsLorLHTvYNfaXJnM/SvKAoGzlzFZnGd
         xv/vSKjAhpfUA==
Date:   Wed, 24 Apr 2019 13:12:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Poirier <bpoirier@suse.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20190424131240.765178fa@canb.auug.org.au>
In-Reply-To: <20190417110856.54b4ac1c@canb.auug.org.au>
References: <20190417110856.54b4ac1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hg7Bz6yWY11NDvAbpdPlECU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hg7Bz6yWY11NDvAbpdPlECU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 17 Apr 2019 11:08:56 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>=20
>   tools/bpf/bpftool/map.c
>=20
> between commit:
>=20
>   e0665239e07f ("bpftool: Fix errno variable usage")
>=20
> from the bpf tree and commit:
>=20
>   0478c3bf8124 ("bpftool: Use print_entry_error() in case of ENOENT when =
dumping")
>=20
> from the bpf-next tree.
>=20
> diff --cc tools/bpf/bpftool/map.c
> index 1744bf61a0b8,44b192e87708..000000000000
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@@ -722,11 -715,16 +715,16 @@@ static int dump_map_elem(int fd, void *
>   		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
>   		jsonw_end_object(json_wtr);
>   	} else {
> + 		const char *msg =3D NULL;
> +=20
>  -		if (errno =3D=3D ENOENT)
>  +		if (lookup_errno =3D=3D ENOENT)
> - 			print_entry_plain(map_info, key, NULL);
> - 		else
> - 			print_entry_error(map_info, key,
> - 					  strerror(lookup_errno));
> + 			msg =3D "<no entry>";
> + 		else if (lookup_errno =3D=3D ENOSPC &&
> + 			 map_info->type =3D=3D BPF_MAP_TYPE_REUSEPORT_SOCKARRAY)
> + 			msg =3D "<cannot read>";
> +=20
> + 		print_entry_error(map_info, key,
> + 				  msg ? : strerror(lookup_errno));
>   	}
>  =20
>   	return 0;

This is now a conflict between the net-next and bpf trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/hg7Bz6yWY11NDvAbpdPlECU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/1CkACgkQAVBC80lX
0GwexAf/elm7U5ewo/HASPberAvkBUVACmF2FVFV9Y2kc5/P5lTUdiNdRVETtE2T
7EHmwCU9S5ZGoFo0ya+1R3l+bXLlVpA82qOO3eGl/l3ledV22MBcDpBDHcC8vjvv
p9YIWZecbXrHyxsqiSSUWQuoe8tEwvg3ycloy4r3K8EwEl0OVpofYzanl8zuMpob
HYniNf1EUQGI2UW/JvarFduSLrggbuT2OY/e6ISIm7vsMAAXmmXuZ1tUfZLtRsqt
OOdgA51qhg6TDOt04SuGJPSSw6vPLRSSrRl7dIkWJJ/x/5uN7UKXtE43zSbL4awJ
z5bHehxyzrrd33ORggzR98D0/VfNSQ==
=4QhK
-----END PGP SIGNATURE-----

--Sig_/hg7Bz6yWY11NDvAbpdPlECU--
