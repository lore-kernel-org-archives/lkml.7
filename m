Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39FC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452A2206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mOA8h2YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfG3DwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:52:21 -0400
Received: from ozlabs.org ([203.11.71.1]:52099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfG3DwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:52:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yN0x37Bgz9s00;
        Tue, 30 Jul 2019 13:52:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564458737;
        bh=dWBzTOstxnGf0i1iA4cytgbhW712K6RXIKTK2bgne5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mOA8h2YErFyu7VBfA3ctEJKG8aP8YRArOZurTaoqt7ttxwPL0DOU/F8YZeDNvYBtd
         Dsup+WEGEu3PP2DvpQMQ1l+cOr4b4ZZ7iHtWmfR79uCK/QLoXrWhoQvJ1hNTrnjzIh
         fvWpCcLSNw2hg7x6TFYUJlRuWrwYJblG9XFAbdK6/5VE/ayRj+9hVK4SO0Z1PlHAD8
         nW/wFTxa0QxEFMIaeuvwpJcxY5j57TRG71D7DcElWiWrNttPb4DK52sv69nHS5Rojq
         O3QEQlu8XG2H7PbsgZGgb+g1KysW/DUaxdB+hAy0m2kWlOiGbPsurl5sWAAsT4PFHr
         1Gz0VliKwRMjQ==
Date:   Tue, 30 Jul 2019 13:52:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org
Subject: Re: linux-next: build warnings after merge of the keys tree
Message-ID: <20190730135216.377a16d5@canb.auug.org.au>
In-Reply-To: <20190730034704.GA1966@sol.localdomain>
References: <20190730123042.1f17cdd4@canb.auug.org.au>
        <20190730034704.GA1966@sol.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pz/0EQPg5Bro5FDVtffXc5m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pz/0EQPg5Bro5FDVtffXc5m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Mon, 29 Jul 2019 20:47:04 -0700 Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jul 30, 2019 at 12:30:42PM +1000, Stephen Rothwell wrote:
> > +static struct key_acl fsverity_acl =3D {
> > +	.usage	=3D REFCOUNT_INIT(1),
> > +	.possessor_viewable =3D true, =20
>=20
> I don't think .possessor_viewable should be set here, since there's no
> KEY_POSSESSOR_ACE(KEY_ACE_VIEW) in the ACL.  David, this bool is supposed=
 to
> mean such an entry is present, right?  Is it really necessary, since it's
> redundant with the ACL itself?

OK, I can take that out of the patch for tomorrow.

> Otherwise this looks good, thanks Stephen.  I'll want to remove a few of =
these
> permissions in a separate patch later, but for now we can just keep it
> equivalent to the original code as you've done.

Thanks for the review.

> We'll have the same problem in fs/crypto/ in a week or two if/when I apply
> another patch series.  For that one I'll send you a merge resolution so y=
ou
> don't have to do it yourself...

That will be great, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/pz/0EQPg5Bro5FDVtffXc5m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/vvAACgkQAVBC80lX
0Gxv3wf+OkCUtz8STSIUcFmQ7bpkopnYRpQOOUQfrUv48mAsFvT1y18ykC1U/dRh
Ukfl0lLZvqQgwWKBTSOjPj1KSgemYTqa54L7I41N6M1FAd7QVex3R0aAu89FLByp
jY69OpZjtiEFjst2zO/FO0jIAbt5bWrINwLJ75J/pwFLqN4ZifDwkBm4Z3kNntKc
7LgyWXZ9EnoUapU1j+eP/TlpZSp7E63itvOrXdvmpKzVDOwgt8HjYPJQqVIGx7iF
4xr/pJYJo8rskEByhC9SQk8mJRGJmGnnSM4NN/Bvv55w7oJKLxXTfK9XMj+hGvNn
o1e8IX8TWHJGL4xYkacHch5Qys7JgA==
=lCUr
-----END PGP SIGNATURE-----

--Sig_/pz/0EQPg5Bro5FDVtffXc5m--
