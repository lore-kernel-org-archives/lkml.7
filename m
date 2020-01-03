Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424DEC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0824649
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aWIqToNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgACHL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:11:57 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14551 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgACHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:11:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0ee90f0000>; Thu, 02 Jan 2020 23:11:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jan 2020 23:11:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Jan 2020 23:11:55 -0800
Received: from localhost (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 07:11:54 +0000
Date:   Fri, 3 Jan 2020 08:11:52 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Bitan Biswas <bbiswas@nvidia.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V1] nvmem: core: fix memory abort in cleanup path
Message-ID: <20200103071152.GA1933715@ulmo>
References: <1577592162-14817-1-git-send-email-bbiswas@nvidia.com>
 <20200102124445.GB1924669@ulmo>
 <7abb79c6-b497-98b3-45ff-44d751f1c781@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <7abb79c6-b497-98b3-45ff-44d751f1c781@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578035472; bh=dDxqOCI5SXc94w0Nilsi3NhZw1Rq6p2dtR3kAStLlSo=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=aWIqToNEWO2t3qBVz2zlddhONgka8mGN6N00fnpsmDrVTJokkHLgSDEms3IO+u21F
         f6m+z0adCnIxlKwz8CoTKPY09bnQ67FMeCHL4w47qnuykjBJ/ZvG1ITRre1Ht4vY+S
         9NnxjN9P4HzCHQCPliuUXDWDinvpWc+5B01HoJ0vwJW/TCCDi7Pn9muEcsprUqHmeX
         ADv/3qXavEuH+yTyPlG8sBs+tiFYKRnZMhuQ+Qmwqg4SZebev53YHZrsmE7UbBL+IX
         Y//JUQ9fBKKFXhuTko33GxJPL6UI9+qEIVj0EDKXX1FYJo+GHwTQcaYAlO9tamnvZn
         VECvaIBaKJYZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 10:51:24AM -0800, Bitan Biswas wrote:
>=20
> Hi Thierry,
>=20
> On 1/2/20 4:44 AM, Thierry Reding wrote:
> > On Sat, Dec 28, 2019 at 08:02:42PM -0800, Bitan Biswas wrote:
> > > nvmem_cell_info_to_nvmem_cell implementation has static
> > > allocation of name. nvmem_add_cells_from_of() call may
> > > return error and kfree name results in memory abort. Use
> > > kasprintf() instead of assigning pointer and prevent kfree crash.
> > >=20
> > > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > > index 9f1ee9c..0fc66e1 100644
> > > --- a/drivers/nvmem/core.c
> > > +++ b/drivers/nvmem/core.c
> > > @@ -110,7 +110,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct n=
vmem_device *nvmem,
> > >   	cell->nvmem =3D nvmem;
> > >   	cell->offset =3D info->offset;
> > >   	cell->bytes =3D info->bytes;
> > > -	cell->name =3D info->name;
> > > +	cell->name =3D kasprintf(GFP_KERNEL, "%s", info->name);
>=20
> >=20
> > kstrdup() seems more appropriate here.
> Thanks. I shall update the patch as suggested.
>=20
> >=20
> > A slightly more efficient way to do this would be to use a combination
> > of kstrdup_const() and kfree_const(), which would allow read-only
> > strings to be replicated by simple assignment rather than duplication.
> > Note that in that case you'd need to carefully replace all kfree() calls
> > on cell->name by a kfree_const() to ensure they do the right thing.
> kfree(cell->name) is also called for allocations in function
> nvmem_add_cells_from_of() through below call
> kasprintf(GFP_KERNEL, "%pOFn", child);
>=20
> My understanding is kfree_const may not work for above allocation.

kfree_const() checks the location that the pointer passed to it points
to. If it points to the kernel's .rodata section, it returns and only
calls kfree() otherwise. Similarily, kstrdup_const() returns its
argument if it points to the .rodata section and duplicates the string
otherwise. On the other hand, pointers returned by kasprintf() will
never point to the .rodata section, so kfree_const() will result in
kfree() getting called.

That said, the savings here are fairly minimal, so I don't feel very
strongly about this. Feel free to go with the kstrdup() variant.

Thierry

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4O6TUACgkQ3SOs138+
s6E0jw/8CoVoVoq1+1ebZgh9ZytThxOsUneAIhUDUL+Pgo/+PXpTcI5KmbrTmi7d
DfIEQ4/j6xOs3+F/5YiVaAZFcrTr9jyXXaG3hujn4XTK37XjnhDhsujWsQGT7i/A
HHTGC0OozN1rXLDFORUF/AhLWj6J1nps4pE2Yiukwu+0AZ8cdCj9+MFMXZbj40Y/
zwi19vgzAzxcIzl4Ewj8lYDrEgaN7/Kh3zlFmpVQKRz1iWAauwTI2CLQqNuJyRM5
SlVTebZHh5QovL+mK8y3+JwtDcC16wwKzJ2p+XiYIKD+qyj/nA/20sLxDvUkE8dE
V3RdgV+9Jb9472y1Hrz+fgVduMEjP/XESsciQvMoXSSfyDVeKhBgAgfj+qyvpvKE
wxigmBpS+hm3ZKxJTIvNcEFYB8/YVtY8tZA/Il73gcm8sg0vC69Zk5Pjjw+WCv6y
UzxAxXj75sR9O5u04u5t0Rp2nnkgHGjzEvZfuQ9w1pCaBb8aufhWtX3vvaxxfCqz
hTzxefGwNGPo4t5O+SHaPO9/MbZxecwz4YhwZOjML/UMY6jjGWhavZQ8Z0EVO6HX
7+nTh9cwmzA1W8/P2IWgiIxGSrJzcYMfhkDh/NdPic2675WZNa7WfIgKobVmRQgd
GtReHw/esIq8zY6a4kP2ddKUeM/2OZhOi/7zzZQqFPIHl3+LkQo=
=l1Lr
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
