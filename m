Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2144C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758F62075C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VLhVfkZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKJWJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 17:09:34 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfKJWJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 17:09:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47B7TR20Kgz9sPc;
        Mon, 11 Nov 2019 09:09:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573423771;
        bh=Cv6z+i429pmCjXeqpUNY4ZeWKmN6N+qlc45P2WoyOWU=;
        h=Date:From:To:Cc:Subject:From;
        b=VLhVfkZs7Eff6ZEjFo/mHKqqIh5Zbc/VwQyJWYdkMQsVLo1NktLrJyf+8PGuh3/nj
         q86z9Xn34RQEJ6ooFM0LPJcY37QU5ltrI1x03YJjpYrQJfL/+XDXFpF7SB9uOD13sL
         XAvdFDzrA80PX3e5ZNZx74zn7SPQWQOIIc3HUSfDRGqlc43324rY6IVqO5tWWxWdQQ
         cDfPx1Ky5SqgPwwAGtg+1Y4uDPuaVdcq8GulL3Io9DajonmCQ8HK0MEB3GS7kiqmYb
         5rZue05VzG1Knu8vgojz6lWoKT92FCDalik5bQGfyNJD9VrMvMLOWaSRnj+Xjf8B5U
         Vr3reKF5dvKMA==
Date:   Mon, 11 Nov 2019 09:09:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the vfs-fixes tree
Message-ID: <20191111090917.0203cb82@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kJsyl2GzuYj7XNgOOmgIbP.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kJsyl2GzuYj7XNgOOmgIbP.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bcf0d9d4b769 ("ecryptfs: fix unlink and rmdir in face of underlying fs mo=
difications")

Fixes tag

  Fixes: 74dd7c97ea2 "ecryptfs_rename(): verify that lower dentries are sti=
ll OK after lock_rename()"

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/kJsyl2GzuYj7XNgOOmgIbP.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3Iio0ACgkQAVBC80lX
0GyAIQf+ODtJOklQGHdIbk2I33vNr9uuYoT+GNpqjJlI1yTi+EgeZiRf71e+AJt6
ik0dnr6gdjPBAPo2u8CQVYncJgxHHre748zWvwj8xNlnYUhu/nfSDNUI/MRAhM6Q
SxWh27Cs/ixpucWioJRO67lM4J8xoBIdb3pMgoXcoFTFznMT5ZzReglexhT+EGZr
AMihw4YQPtcaTaiUPx35aDcXWSM8kmfXhOG3lyZGLtv8015KsYzbobIqvwihwpB9
3/q85fq5nSZN0uwM4o5u4B89IPz7BlWdaM6cFDfwsjG8POM3PeWzXM5MjJ6PbBY2
Oi4ONw2ARk4sjsXjadqjd6Evx6oFGw==
=gbwi
-----END PGP SIGNATURE-----

--Sig_/kJsyl2GzuYj7XNgOOmgIbP.--
