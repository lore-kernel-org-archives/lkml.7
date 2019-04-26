Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FACC206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZSg1ZD0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDZF45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:56:57 -0400
Received: from ozlabs.org ([203.11.71.1]:52353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZF45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:56:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44r3GZ31Tgz9s3Z;
        Fri, 26 Apr 2019 15:56:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556258214;
        bh=sTlU28ydKeUUf7D2W4QpaTlmK8GcHsJ6z/pnY1nZqrg=;
        h=Date:From:To:Cc:Subject:From;
        b=ZSg1ZD0hUl9utCy+OBhExTa0ZMHiXc1Zo99ZQV3VGBRAoh7Y9u4hjCPa+Bfz3MBwn
         0QHtzKaRFP86wDHsZRFkIueV2jRr6UvZapuuLIoBNON5WyzwCfhhMYaIY6JcA+h3je
         5aWVEvg9oDaTspkzP9P1rmJxVnHsuo0Rc7YjdqArnlK6b/EevHr9NJb+vSTIBW8byS
         D1IpiaihQyhFGXKT+c+mQvA+bq8FNgRYKQpXcYZX4htwy9o7zn818iPxLSxla7t1aL
         WwOVPNeV+u3Vfk+MxbNAYgiK7L6dSibY7QXEKaJaEg6aMTzWZtc0LRjVhxdpGGcXXb
         CIJGaonSiUrLA==
Date:   Fri, 26 Apr 2019 15:56:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Venture <venture@google.com>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: linux-next: build warning after merge of the char-misc tree
Message-ID: <20190426155653.2cdebc5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W0TbOCq_gCotvRMb7SYCEG5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W0TbOCq_gCotvRMb7SYCEG5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/misc/aspeed-p2a-ctrl.c: In function 'aspeed_p2a_mmap':
drivers/misc/aspeed-p2a-ctrl.c:110:2: warning: ISO C90 forbids mixed declar=
ations and code [-Wdeclaration-after-statement]
  pgprot_t prot =3D vma->vm_page_prot;
  ^~~~~~~~

Introduced by commit

  01c60dcea9f7 ("drivers/misc: Add Aspeed P2A control driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/W0TbOCq_gCotvRMb7SYCEG5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCnaUACgkQAVBC80lX
0GxQFQf9FUxeKzv+33s5DxgUQPRDlzuja9tnzazpJFYzBMUjou1nKBhMopYGe9B4
Cm8yhX1SG/REfplbsXUoxGF66Hz9a+ftPZAE6GB5vZcIvqYj0g5LAHB92RV1Xmyf
259iV/vcYcLh1Q81Q8NBWMctrS0Ev1jFm+9pM9+mYHe56pPxmcCjghn287CrX1nH
44LQgMwUkNFtNWck+j4nLvRWWUpbjy3Kv4RNEq++u9MsFpk1MIvY28LZC2BkYgKl
F4gJV6qTeRAI0QuW6mwZwT+WpiHOtNP8gyn+xBD9e9sKatbOYI8xEApytnoJe3fV
f8DvR33D8xrIacmzRKX7Cx5rn8DoyQ==
=+7Fz
-----END PGP SIGNATURE-----

--Sig_/W0TbOCq_gCotvRMb7SYCEG5--
