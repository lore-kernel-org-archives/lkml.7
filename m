Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D910C606D3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169D121707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s7hgE7gK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGIAUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:20:03 -0400
Received: from ozlabs.org ([203.11.71.1]:58565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfGIAUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:20:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jNHf4X1Bz9s7T;
        Tue,  9 Jul 2019 10:19:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631599;
        bh=dusa3RXVTpEbZcDOiiyVIrnKm0/u3OzZ1mDbwAvHEWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s7hgE7gKtrEolCPaKKyMuFTkkUa/4Qb2Nt8i/GWgV8rn45faaGRorT+xNwBXiI5lL
         Zomkmw88lgjhuzBp88hTEwxZ9A7LnVJ1Nxbg67ILQ/qcZOtrma5wcESTwWyw6zUAIk
         F5R3D/QjV4qtgezOCaGSvZG07sUkmMDsCHQwUwOgosaCxH/vJ3dW/iZF+S4VjWqeX0
         ReqLJOoe4cBAeRa7CLFzcn371i0QTdKpqVyHlY9XEzerqJef8Nr2uw0asXhI1dLyq9
         pQJQJOlKuHitqmTjr0VdOD2v+iE2nYC20WpWjpX7glvjMya0hKr+ejmslizVIyDCzu
         36+umG9Rgnu1g==
Date:   Tue, 9 Jul 2019 10:19:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190709101957.529cbb33@canb.auug.org.au>
In-Reply-To: <20190701203513.2ee7785b@canb.auug.org.au>
References: <20190701203513.2ee7785b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B=U9S0nRRiVtLx+D0JSUq4X"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B=U9S0nRRiVtLx+D0JSUq4X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 1 Jul 2019 20:35:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the pidfd tree got a conflict in:
>=20
>   kernel/fork.c
>=20
> between commits:
>=20
>   9014143bab2f ("fork: don't check parent_tidptr with CLONE_PIDFD")
>   6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
>=20
> from Linus' tree and commit:
>=20
>   7f192e3cd316 ("fork: add clone3")
>=20
> from the pidfd tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc kernel/fork.c
> index 947bc0161f9c,4114a044822c..000000000000
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@@ -1755,7 -1794,7 +1776,8 @@@ static __latent_entropy struct task_str
>   	int pidfd =3D -1, retval;
>   	struct task_struct *p;
>   	struct multiprocess_signals delayed;
>  +	struct file *pidfile =3D NULL;
> + 	u64 clone_flags =3D args->flags;
>  =20
>   	/*
>   	 * Don't allow sharing the root directory with processes in a different
> @@@ -2030,16 -2070,7 +2050,16 @@@
>   			goto bad_fork_free_pid;
>  =20
>   		pidfd =3D retval;
>  +
>  +		pidfile =3D anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
>  +					      O_RDWR | O_CLOEXEC);
>  +		if (IS_ERR(pidfile)) {
>  +			put_unused_fd(pidfd);
>  +			goto bad_fork_free_pid;
>  +		}
>  +		get_pid(pid);	/* held by pidfile now */
>  +
> - 		retval =3D put_user(pidfd, parent_tidptr);
> + 		retval =3D put_user(pidfd, args->pidfd);
>   		if (retval)
>   			goto bad_fork_put_pidfd;
>   	}

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/B=U9S0nRRiVtLx+D0JSUq4X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j3a0ACgkQAVBC80lX
0GwYlQf7BOl86RmnsF4tRs4cXakSwBlsYA2yUV8iVwl6bXZujLBzANINl5CCHVeh
03JrAXmcL+7y6XD/HJItC3QVoE5ZsIzBgO4fvyPrzzQhwOjo6ZABK7NzowdNim3C
OUKXIkzSpJ8lblNKKsemKiayHqq1bFQ9c2SrQrdE2fDpNJuYjfq4NS40rgJFdiOK
esxZ1+Hpl2cLJLiRSdnzXD7Oa+31JRPOWeL1nBOS/hrSdDwQXZWnkhBGdjQGnDjj
72UNinCp2+yLk7InIL5KQrv6PzLBX0r9HM0l19KZm8Bf5IiaoEGpEFaVsWidbQVv
SLNcuP+FD7A+dvFLnomJP+VL/unfzQ==
=pHrD
-----END PGP SIGNATURE-----

--Sig_/B=U9S0nRRiVtLx+D0JSUq4X--
