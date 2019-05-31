Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B69C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8767426F71
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="jvPgk2ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEaVq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:46:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35720 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:46:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id t1so1212690pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=oLThzkzBE2yZ99mGcWuJK1ZVpwpz5C/kqr251y2sc5U=;
        b=jvPgk2ZIUMRQExsCU/xVThBINbgLItegNCTr14Bwj9bXzZTd+sxBkOBlHeZ1pqF6h3
         Rgn7FhhnTPMikxXNXimI3e5sb9DeJgJ7+da/ClkBc1Uw4n1W+rpToIeN+8EQVND+Stwg
         FoFM6+ffKSxOiNRuliKxzTQXyKR2md5yF8gz8uyGcX7tPyzVjgdOIEpXNa4DPV3in126
         1bv21pd82SYzX5WmrOEeVE/sSHKnWq0eIXWt1a+hHa4UCQTKtGnRGKDS9F+dpN9VAxW4
         vFr5ZzTTGZmobDrHpDS7piT2f3jqv6id8KCJMX+a5ldeIu2On9UGHn4bj8dC+kzNcAxI
         y7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=oLThzkzBE2yZ99mGcWuJK1ZVpwpz5C/kqr251y2sc5U=;
        b=lR2PCGUS50DaUUka+OkHqirHqziwla6bhGGjcwhKbY9HTFSuuHOmu9ySHriwgZXbxy
         JM2/MXMivqVKho8aqHEFpIgpfbZMo1qilFf5rxydi/vPyy8cOQJuIS5SMKF13J01qCgQ
         EI5sULNYljKwBSjqV2+UvNi3G/dVc+gIPnCJtsl4mnM66jqZ8c1YP2GkYK8KkHXPoFm4
         XbKDXAvjyHob8inyxxTKyCZMiydfwMXA2SHiVvzp8x/sm53XdAI6ETfsry3Lr9sTW/Kv
         L6INqvAnRVZ2zXG8DW0k2LvBfWhltYQzY3CiwIXluEp0stbHH/WdWzsmsLa7+kr/ozam
         5Z3A==
X-Gm-Message-State: APjAAAWEEi+8yxYaE/8XojJm4JZvAHd5Gak7e7sLPJAtcxaY3QC8bzv2
        3r2/pnZV3EcNFs4J0ErZO0WATd61Qto=
X-Google-Smtp-Source: APXvYqze/KHV5sj0rVoXVCpynupdbutBmIihHj//q8lnOWHCXog0QcdlmYHafD9Qj0+l/cbmhDknhg==
X-Received: by 2002:aa7:9212:: with SMTP id 18mr12976936pfo.120.1559339216612;
        Fri, 31 May 2019 14:46:56 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c9sm6166899pje.3.2019.05.31.14.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:46:55 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <01FB1966-0466-4AB2-913B-F53E8CA816BE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_16DD8B08-042F-434D-9811-EE0461B6A933";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: remove unnecessary gotos in ext4_xattr_set_entry
Date:   Fri, 31 May 2019 15:46:54 -0600
In-Reply-To: <20190531121016.11727-1-ptikhomirov@virtuozzo.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <20190531121016.11727-1-ptikhomirov@virtuozzo.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_16DD8B08-042F-434D-9811-EE0461B6A933
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 31, 2019, at 6:10 AM, Pavel Tikhomirov =
<ptikhomirov@virtuozzo.com> wrote:
>=20
> In the "out" label we only iput old/new_ea_inode-s, in all these =
places
> these variables are always NULL so there is no point in goto to "out".
>=20
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

I'm not a fan of changes like this, since it adds potential =
complexity/bugs
if the error handling path is changed in the future.  That is one of the =
major
benefits of the "goto out_*" model of error handling is that you only =
need to
add one new label to the end of the function when some new state is =
added that
needs to be cleaned up, compared to having to check each individual =
error to
see if something needs to be cleaned up.

Cheers, Andreas

> ---
> fs/ext4/xattr.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 491f9ee4040e..ac2ddd4446b3 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1601,8 +1601,7 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 		next =3D EXT4_XATTR_NEXT(last);
> 		if ((void *)next >=3D s->end) {
> 			EXT4_ERROR_INODE(inode, "corrupted xattr =
entries");
> -			ret =3D -EFSCORRUPTED;
> -			goto out;
> +			return -EFSCORRUPTED;
> 		}
> 		if (!last->e_value_inum && last->e_value_size) {
> 			size_t offs =3D le16_to_cpu(last->e_value_offs);
> @@ -1620,8 +1619,7 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 			free +=3D EXT4_XATTR_LEN(name_len) + old_size;
>=20
> 		if (free < EXT4_XATTR_LEN(name_len) + new_size) {
> -			ret =3D -ENOSPC;
> -			goto out;
> +			return -ENOSPC;
> 		}
>=20
> 		/*
> @@ -1634,8 +1632,7 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 		    new_size && is_block &&
> 		    (min_offs + old_size - new_size) <
> 					EXT4_XATTR_BLOCK_RESERVE(inode)) =
{
> -			ret =3D -ENOSPC;
> -			goto out;
> +			return -ENOSPC;
> 		}
> 	}
>=20
> --
> 2.20.1
>=20


Cheers, Andreas






--Apple-Mail=_16DD8B08-042F-434D-9811-EE0461B6A933
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlzxoM4ACgkQcqXauRfM
H+ANJhAAodfLf6tuPqM2yx/F5U3yyHxxq5g+PUeL+KT17j09lpJqBVlsgNNjzCDX
ENDLhPndZZugNwMlz2XxZOzH/2OIsHSeeWKU/RfH+x/5KYtMraeM6nC9yZanH2zq
xzeNQHnCQmg2IVPf9Qo7IaLiAHs3KVzKEBIGJj7SHDYHeif+Yb3m5Bw/s4NJbu36
m5DiPktWEUk0KJ0VH5cbNvSy90mR4GX6XrQVfhJj+MOwUeD07pMlUxdcpOj9iZ3a
FTWDRWETzlpYin8gAsZB3e9pgtSlCkttWj5WtGV07Wt/R3MBxa9k33F+iH2DcofC
ymZ2tvoT4yPmpZtJTDy/iojOKVenlc9CyxwJ12qJub/zXi/xCDaszGOcMtHx7pPO
kHQUHqVSkbPrHUmm+NwHRULtmvjmNpkKQCfOXdywWtZL6wBJN38rAGjBX23itbX0
ZFXDN/o/I9O2l95DliOVLRurD7c2K4c8HUkL2Q7SlcLj6TI81OiltclnxOqOYZib
Wohb+5ZmQANpfD7b5ffw3+P2uPGlXwD3Ia2RKoI1vs5c7IgXuVxO7l83cX4GNzit
OHhlSAG3olDXcLIGgs/jxOyc9A8/zjY/PK8elNoG2wScjGNw44+GJkDjuqbeJGng
XWMc8ELyzpa6xJV76EunFcoCqjzQ/dj9zhzygOXI/Q5/8bNUz3k=
=mP8+
-----END PGP SIGNATURE-----

--Apple-Mail=_16DD8B08-042F-434D-9811-EE0461B6A933--
