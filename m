Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA1C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 18:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C8F2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wm99k6CR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfG1SGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 14:06:19 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60311 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfG1SGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 14:06:18 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4C10C1DBD;
        Sun, 28 Jul 2019 14:06:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 28 Jul 2019 14:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Wuh+r/
        apknyXeChjuNouckyB6vMRP+244QZYYcOsnlc=; b=wm99k6CR/Q7pt9kdCvdLey
        W/Zd5DFzUtxNhd3HX++suyBzz7TK2G0RL0mJVxzqWORxcoNWAl+nkwRp2ZPrggdC
        efeLioNTIdDu0vkrqnJTdRczhzg2bZRl7b/ZElpgAEGSwzK98cYlgyoXOXDyCzpq
        Op2JcVA1skR2DjpkAsEaXT3UXHsHNTriy7bXq0i5+HPhBD2mnynXOZuFM3JqktPy
        Uxl+pCEZ+f96B307DWmYV7hireznWPHSPS0tchWNI2UB5dnpgwLxaWr0++dWv14c
        DFXD7Ov6bd7XJphdbktpQc3ieyZm8MjGQjgSq3tcvZ1O1qHkip/AXSXrxmxj1PBQ
        ==
X-ME-Sender: <xms:GOQ9XYg31LapBor6tf4MObxmE89H-o2CUI8W0pgKiFx0KigB4lGJKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeelgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehgtd
    erredtreejnecuhfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgv
    tghkihcuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucfkphepledurdeihedrfeegrdeffeenucfrrghrrghmpehmrghilhhfrhhomhep
    mhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:GOQ9XSrcaLktICNydOWNWTRHHdUDgu7W2dZsDXFXaB0e6pw72zCe7A>
    <xmx:GOQ9XUJf7fCHDk0tnWornb7vSjPyJubEEiD74GEL-P75HnWZRvpTYg>
    <xmx:GOQ9XfuBkKs-3neqKbzaoBAgUYJndeiknA6EDwPHU_S6rQj0NyDlAA>
    <xmx:GeQ9XV5IMTOtxrd0_fuHDmmOYrrYsTGaD0IqCuSbnFGHMABzlWugFA>
Received: from mail-itl (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id D197D80059;
        Sun, 28 Jul 2019 14:06:14 -0400 (EDT)
Date:   Sun, 28 Jul 2019 20:06:11 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Xen-devel] [PATCH v4 8/9] xen/gntdev.c: Convert to use
 vm_map_pages()
Message-ID: <20190728180611.GA20589@mail-itl>
References: <20190215024830.GA26477@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20190215024830.GA26477@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.12+29 (a621eaed) (2019-06-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 08:18:31AM +0530, Souptick Joarder wrote:
> Convert to use vm_map_pages() to map range of kernel
> memory to user vma.
>=20
> map->count is passed to vm_map_pages() and internal API
> verify map->count against count ( count =3D vma_pages(vma))
> for page array boundary overrun condition.

This commit breaks gntdev driver. If vma->vm_pgoff > 0, vm_map_pages
will:
 - use map->pages starting at vma->vm_pgoff instead of 0
 - verify map->count against vma_pages()+vma->vm_pgoff instead of just
   vma_pages().

In practice, this breaks using a single gntdev FD for mapping multiple
grants.

It looks like vm_map_pages() is not a good fit for this code and IMO it
should be reverted.

> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>  drivers/xen/gntdev.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index 5efc5ee..5d64262 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, struct vm=
_area_struct *vma)
>  	int index =3D vma->vm_pgoff;
>  	int count =3D vma_pages(vma);
>  	struct gntdev_grant_map *map;
> -	int i, err =3D -EINVAL;
> +	int err =3D -EINVAL;
> =20
>  	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
>  		return -EINVAL;
> @@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip, struct v=
m_area_struct *vma)
>  		goto out_put_map;
> =20
>  	if (!use_ptemod) {
> -		for (i =3D 0; i < count; i++) {
> -			err =3D vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
> -				map->pages[i]);
> -			if (err)
> -				goto out_put_map;
> -		}
> +		err =3D vm_map_pages(vma, map->pages, map->count);
> +		if (err)
> +			goto out_put_map;
>  	} else {
>  #ifdef CONFIG_X86
>  		/*

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl095BIACgkQ24/THMrX
1yziIAf/exzcYKVSO+KS0CX9O2QdFSocXv52LbbEaeXP7AvIDXtfXcdbvxrkBwyA
dM4LYJgnMPbjYusQKNqWNDwi16zSJJgNfM0F4g+B4Ch2wkPXqCsobfHILsV8/x96
uYVr05q30FJ5goCzeMvQMNdPwDHv6+xGalM5Zhl56Xj+BGUQNmKo5sw2dAvarOM2
vdJUiQvbaZSBYSLZnufgbaEoZsXKQpDJftX7uM2gt6qmW3OwcEyhhGVI9loMCyJ5
jCWaVsXNj3EW/pZpwSX2nJgygQEp0C0x6xIZrG9rPNt/mZClap556QsmZzUkZDN7
92r6MMVJJLYyM0f880I5KEOKsIGNaQ==
=PmYG
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
