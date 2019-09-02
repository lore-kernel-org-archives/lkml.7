Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E75C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1392217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vJRTmlvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfIBXpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 19:45:20 -0400
Received: from ozlabs.org ([203.11.71.1]:33459 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfIBXpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:45:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Mmsh4xy8z9sDB;
        Tue,  3 Sep 2019 09:45:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567467912;
        bh=gh6SHKoQKgF1kZ2bFjHV1PqXJnljJDMJacna8gmLJCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vJRTmlvDoDFVmjeuP6A3wCP3r8S8ey9qn+bbGs+EDrRLsxmstUiEhU4N7POEGJl+n
         dY221zhN8pfi/sIfjH3jUamaA3BLTnYZnEqlsrEpeGifsM8k9oRKBeRigsDAscVnas
         sErH45+5cPXG9GP2K3biVR7246HQmaoydglwPPv1bE+dGJGWxfUY6zB0ryzlrC6Aat
         uKV0ldg6xBNm47mBffgdkw7wxzDnRtHnrN7J0P6iY4lzInBOnQ9EJpNxcrgleHNKfU
         TB7pmoJrCtklVRh+ZrPiA+QalQIHhOvWoN+2TqBWORdRR7FbZt2YWfSgg+3qtaN0qq
         4RTMbCnToBSJA==
Date:   Tue, 3 Sep 2019 09:45:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the hmm tree
Message-ID: <20190903094511.2704484a@canb.auug.org.au>
In-Reply-To: <20190902105137.GC20@mellanox.com>
References: <20190902205017.3eca5b70@canb.auug.org.au>
        <20190902105137.GC20@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=y_+vcbrUjS6AcrKSV=+lmQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=y_+vcbrUjS6AcrKSV=+lmQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, 2 Sep 2019 10:51:41 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Sep 02, 2019 at 08:50:17PM +1000, Stephen Rothwell wrote:
> > Hi all, =20
>=20
> > ERROR: "nd_region_provider_data" [drivers/acpi/nfit/nfit.ko] undefined!
> > ERROR: "to_nd_blk_region" [drivers/acpi/nfit/nfit.ko] undefined!
> > ERROR: "nvdimm_region_notify" [drivers/acpi/nfit/nfit.ko] undefined!
> > ERROR: "nvdimm_blk_region_create" [drivers/acpi/nfit/nfit.ko] undefined!
> >=20
> > Caused by commit
> >=20
> >   126470c8a58b ("libnvdimm: Enable unit test infrastructure compile che=
cks")
> >=20
> > I have reverted that commit for today.
>=20
> Looks like more kconfig trouble, can you send Dan your kconfig? I'll
> drop this patch again
>

Thanks.  It was just an x86_64 allmodconfig build.  I don't actually
have the .config file (it gets cleaned up, sorry).
--=20
Cheers,
Stephen Rothwell

--Sig_/=y_+vcbrUjS6AcrKSV=+lmQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1tqYcACgkQAVBC80lX
0GwaPAf9GnKq/UFMCw7HbG27ds+lw90Nz/JmLxF42c+uIxIvFF6f44xBsKQBTRCd
KuUcNBMFt1XHuuT8bxnNFQ9Wc/vLCiDqmpWyR8OJt1MyrY3YRML6dx9c3DX1/oW6
OCdnxfr6Rd7/8tO1QggUSKeJ8L1NvE7ikJxspFTIUwQSn7mVMtlHX3U6f9p3IDty
ftaaY00+ni2L1koeZs3YX71Cwj54tdJKke4CSqtfOFQUlmMDA14xwpwjd4xPYbo1
0iNrFSDIU3Q1wsSvu4TNOeClgNQLvN1P91DriDzkfnaIRUToSKyPG0odUQM0JN2f
eXt/7WxQeOzkOsDk7l0Iag/pwit03w==
=x6n8
-----END PGP SIGNATURE-----

--Sig_/=y_+vcbrUjS6AcrKSV=+lmQ--
