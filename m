Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F489C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EE923F9F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VjGPoJuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfEaBhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:37:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56425 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaBhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:37:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FRry1SPdz9sBr;
        Fri, 31 May 2019 11:37:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559266642;
        bh=S0ENzl/Ee55wERjVPiHzUWaptttCKuyFophDewYeipw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VjGPoJuwIlkoKno7ryVKpuo70oDy30++9jyRH491yiA8B31LyHh+uHXavh45qd+Kl
         wJMr9zuhqL08bFGY0KHGP2sKv4pwaTniI4ApUqvfSiS5A5lJ9Cf/GvncpZ2O07buXs
         nvC4P8i/tLXHmMMZYlnoJzWH/OF3R/LZ3DoHkfv7xLJ5LcSYhfCj2bwFZhHyQq5OFj
         XraYQ6RGNY5hM49nGlyEdiiZnAHJEf+7Mpz4Ej+z1he7Ax2yf3sUVz0BHJd3PIUzL5
         eaUm3B79Kzt4dKR0Co5GSokuF+XGFOA/v3ymy5AZuPUzeJ+GK7LRZTmB8eZE5VNL0K
         2+iP3vbN+jPJQ==
Date:   Fri, 31 May 2019 11:37:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] firmware_loader: fix build without sysctl
Message-ID: <20190531113721.5057ce05@canb.auug.org.au>
In-Reply-To: <20190531012649.31797-1-mcroce@redhat.com>
References: <20190531012649.31797-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YyaG.RCnm+UzpDnp7pcS2.k"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YyaG.RCnm+UzpDnp7pcS2.k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

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

I have added this to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/YyaG.RCnm+UzpDnp7pcS2.k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwhVEACgkQAVBC80lX
0GwXtAf/S0gkgBJMzuh2Ig4QUVdg74lBXrsaAPi3F20gk7QSZnVwk+UQa8GE0prZ
ULNovrs71Kuf7/ITaDF1fT6RCzMA7wU3GV9I1z+mXJOEYC1ZnccNorh5P6nmWCk8
seXGo/UnYsNq1ysN9HYWr6rJySXrX0A4Ad7/iLX9FaVH3P3r7f8iSDVWxGmSkzoV
VOhnc7OKhnvvoLn9xAkjvh2yIFZnU47ZdOaTx/KwAu8rWHjXMMPzwpV8t445Q6UF
cxKnHqkz9sFDcdwc2KgHOgv3ZtqSL8ZPOBcAiD6F9JweUSLEkA9K02LSHma8cblO
2njQcBgiDA+TGAr4Ot9NTYLWVktQFg==
=W7pE
-----END PGP SIGNATURE-----

--Sig_/YyaG.RCnm+UzpDnp7pcS2.k--
