Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9724CC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 01:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423B52070B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 01:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ev6GUJFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfHaBjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 21:39:51 -0400
Received: from ozlabs.org ([203.11.71.1]:49471 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfHaBjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 21:39:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46KzYH4cyfz9s7T;
        Sat, 31 Aug 2019 11:39:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567215588;
        bh=ZhE2ziaWsxtBRLV18oDgQjAR/idM0NB15SZof0s+yak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ev6GUJFUv7K96uKxLmIRZoFsM9n6t5PTx/XTPevcFVwCMbNwgrmBl21MoYy0CD1pj
         NHmIEDAmKraQPunZSnxHnYQG/AtgH4+N+1AONHBCC0OTMFRqTflyZLXxWltOnWB5jS
         sTf0I1IAqwEdMBgYVxJyl6OmQQo9Glkwulo7BhRBfrTPYS8/1qpOY3kZeC4XPsEuT6
         J84R6pmy360fWWThWvuQJyzF8LH2P/SSPbKQTw8/fI/eRfzw4tM15ZTH0+66oDs0Kh
         FQdo1z24dofMNQAafeN5ruNhZ7fROGJjAy5w9dSFJ9xc1XznJLTXkme2yWzp2wqAoz
         mNu53EG0EOzPQ==
Date:   Sat, 31 Aug 2019 11:39:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Validate Fixes: tag using 'commit' checks
Message-ID: <20190831113939.7c2dad32@canb.auug.org.au>
In-Reply-To: <20190830163658.17043-1-sean.j.christopherson@intel.com>
References: <20190830163658.17043-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BfsFABxAuYqPx22dGr.rg2u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BfsFABxAuYqPx22dGr.rg2u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Fri, 30 Aug 2019 09:36:58 -0700 Sean Christopherson <sean.j.christophers=
on@intel.com> wrote:
>
> @@ -2803,10 +2805,15 @@ sub process {
>  			($id, $description) =3D git_commit_info($orig_commit,
>  							      $id, $orig_desc);
> =20
> -			if (defined($id) &&
> -			   ($short || $long || $space || $case || ($orig_desc ne $description=
) || !$hasparens)) {
> +
> +			if (!defined($id)) {
> +				if ($init_tag =3D~ /fixes:/i) {
> +					ERROR("GIT_COMMIT_ID",
> +					      "Target SHA1 '$orig_commit' does not exist\n" . $herecurr);
> +				}

Unfortunately, git_commit_info() just returns the passed in $id (which
is explicitly set earlier) if git is not available or you are not in a
git repository (and that latter check is not entirely correct anyway).

Also, what you really need to test is if the specified commit is an
ancestor of the place in the maintainer's tree where this patch is to
be applied.  The commit may well exist in the developer's tree, but not
be in the maintainer's tree :-(

This will, however, catch the cases where the SHA1 has been mistyped,
but we should encourage people not to type them anyway, instead
generating them using "git log".

--=20
Cheers,
Stephen Rothwell

--Sig_/BfsFABxAuYqPx22dGr.rg2u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1pz9sACgkQAVBC80lX
0Gzvhwf+Oi6TfTlPo9D7flbI4W1OngUci3Ex4xDH1v+g4Q+h7eXUqkrRjQWrDcll
fVhcG4DwCAW9LWYwZ8PkixKPblt37v/jkBo5fLNUr1pg5B9ADhk2J14P2o5D2mx3
Tiy8LkFBPyMmHSv9XcMXESqOws/HTqm8Y44XclLXwpRXtRq9JmbWVN9ssBefgHPt
gPyMESOy5NjJ29qEn1P+1TP7zvplNuJMWJ2d0Dcfm8OFpSnxMeuPjBRZci7u4sWH
7gZSzGnJPrl54duopG1Izqz3sVGHdNm/XF8yQtgP+VJfcBqJBb7Oaey62Hbrlxx7
TYk/mgI6e0aU3YtkE0942nYfejmbnA==
=urhi
-----END PGP SIGNATURE-----

--Sig_/BfsFABxAuYqPx22dGr.rg2u--
